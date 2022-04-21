class PostModel {
  String name = '';
  String uId = '';
  String image = '';
  String dateTime = '';
  String postImage = '';
  String text = '';

  PostModel({
    required this.name,
    this.uId = '',
    required this.image,
    required this.dateTime,
    required this.postImage,
    required this.text,
  });

  PostModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    postImage = json['postImage'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'postImage': postImage,
      'text': text,
    };
  }
}
