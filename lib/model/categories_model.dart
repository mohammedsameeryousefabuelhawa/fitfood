class CategoriesModel {
  String Id;
  String ImageURL;
  String Name;
  bool selected = false;

  CategoriesModel({
    required this.Id,
    required this.ImageURL,
    required this.Name,
  });

  factory CategoriesModel.fromJson(var json) {
    return CategoriesModel(
      Id: json['Id'],
      ImageURL: json['ImageURL'],
      Name: json['Name'],
    );
  }
}
