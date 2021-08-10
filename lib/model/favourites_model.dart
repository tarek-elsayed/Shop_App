class FavouritesModel{
  String message;
  bool status;

  FavouritesModel.fromJson(Map<String,dynamic> json){
    status=json['status'];
    message=json['message'];
  }
}