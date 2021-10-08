class ChangeFavouritesModel{
  String message;
  bool status;

  ChangeFavouritesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}