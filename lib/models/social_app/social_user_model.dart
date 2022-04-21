class SocialUserModel {
  String name = '';
  String email = '';
  String phone = '';
  String uId = '';
  String image = '';
  String cover = '';
  String bio = '';
  bool isEmailVerified = false;

  SocialUserModel({
    required this.name,
    this.email = '',
    required this.phone,
    this.uId = '',
    required this.image,
    required this.cover,
    required this.bio,
    required this.isEmailVerified,
  });

  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    name = json!['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}
