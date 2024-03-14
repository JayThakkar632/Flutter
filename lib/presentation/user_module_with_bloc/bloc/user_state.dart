import '../../../model/user_details.dart';

class UserState{}

class UserLoadingState extends UserState{}

class UserSuccessState extends UserState{
  final List<UserDetails> userDetailsList;
  UserSuccessState({required this.userDetailsList});
}
class UserErrorState extends UserState{
  String error;
  UserErrorState({required this.error});
}
class InternetLostState extends UserState{}
