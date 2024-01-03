class ShopModel {
  String shop_id;
  String Name;
  String ImageURL;
  double Longitude;
  double Latitude;
  String description;

  ShopModel({
    required this.shop_id,
    required this.description,
    required this.Name,
    required this.ImageURL,
    required this.Longitude,
    required this.Latitude,
  });

  factory ShopModel.fromJson(var json) {
    return ShopModel(
      shop_id: json['shop_id'],
      Name: json['Name'],
      ImageURL: json['ImageURL'],
      Longitude: json['Longitude'],
      Latitude: json['Latitude'],
      description: json['description'],
    );
  }
}
