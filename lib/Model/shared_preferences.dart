class SharedPreferencesModel {
  String? name;
  String? email;
  String? password;
  String? confirmPassword;
  String? phoneNumber;
  String? dob;
  String? country;
  String? state;
  String? city;
  String? profile;
  List<String>? hobby;


  SharedPreferencesModel({
    this.name,
    this.email,
    this.password,
    this.confirmPassword,
    this.phoneNumber,
    this.dob,
    this.country,
    this.state,
    this.city,
    this.profile,
    this.hobby,
  });

  // Convert SharedPreferencesModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'country': country,
      'state': state,
      'city': city,
      'profile': profile,
      'hobby': hobby,
    };
  }

  // Create a factory method to create SharedPreferencesModel object from JSON
  factory SharedPreferencesModel.fromJson(Map<String, dynamic> json) {
    return SharedPreferencesModel(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      phoneNumber: json['phoneNumber'],
      dob: json['dob'],
      country: json['country'],
      state: json['state'],
      city: json['city'],
      profile: json['profile'],
      hobby: List<String>.from(json['hobby']),
    );
  }
}