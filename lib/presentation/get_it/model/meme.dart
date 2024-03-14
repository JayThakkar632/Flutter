/// id : 12
/// image : "https://i.some-random-api.ml/07jjUxQKNf.png"
/// caption : "Ooof"
/// category : "random"

class Meme {
  Meme({
      num? id, 
      String? image, 
      String? caption, 
      String? category,}){
    _id = id;
    _image = image;
    _caption = caption;
    _category = category;
}

  Meme.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _caption = json['caption'];
    _category = json['category'];
  }
  num? _id;
  String? _image;
  String? _caption;
  String? _category;
Meme copyWith({  num? id,
  String? image,
  String? caption,
  String? category,
}) => Meme(  id: id ?? _id,
  image: image ?? _image,
  caption: caption ?? _caption,
  category: category ?? _category,
);
  num? get id => _id;
  String? get image => _image;
  String? get caption => _caption;
  String? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['caption'] = _caption;
    map['category'] = _category;
    return map;
  }

}