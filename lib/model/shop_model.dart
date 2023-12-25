class ShopModel {
  String Id;
  String Name;
  String ImageURL;
  double Longitude;
  double Latitude;
  String description;

  ShopModel({
    required this.Id,
    required this.description,
    required this.Name,
    required this.ImageURL,
    required this.Longitude,
    required this.Latitude,
  });

  factory ShopModel.fromJson(var json) {
    return ShopModel(
      Id: json['Id'],
      Name: json['Name'],
      ImageURL: json['ImageURL'],
      Longitude: json['Longitude'],
      Latitude: json['Latitude'],
      description: json['description'],
    );
  }
}
