class ShopModel {
  String shop_id;
  String Name;
  String ImageURL;
  String description;

  ShopModel({
    required this.shop_id,
    required this.description,
    required this.Name,
    required this.ImageURL,
  });

  factory ShopModel.fromJson(var json) {
    return ShopModel(
      shop_id: json['shop_id'],
      Name: json['Name'],
      ImageURL: json['ImageURL'],
      description: json['description'],
    );
  }
}
