class SelectedShopModel {
  String shop_id;
  String Name;
  String ImageURL;
  String description;
  String NameAr;
  String Id_categories;
  String Id_statustypes;

  SelectedShopModel({
    required this.shop_id,
    required this.description,
    required this.Name,
    required this.ImageURL,
    required this.NameAr,
    required this.Id_categories,
    required this.Id_statustypes,
  });

  factory SelectedShopModel.fromJson(var json) {
    return SelectedShopModel(
      shop_id: json['shop_id'],
      Name: json['Name'],
      ImageURL: json['ImageURL'],
      description: json['description'],
      NameAr: json['NameAr'],
      Id_categories: json['Id_categories'],
      Id_statustypes: json['Id_statustypes'],
    );
  }
}
