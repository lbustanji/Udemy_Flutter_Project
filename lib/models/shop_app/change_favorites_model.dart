class ChangeFavoritesModel{
  bool status=false;
  String message='';

  ChangeFavoritesModel.fromJson(Map<String,dynamic> json){
status=json['status'];
message=json['message'];

  }
}