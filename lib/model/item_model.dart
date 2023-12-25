class ItemModel {
  String Id;
  String ImageURL;
  String Name;
  String NameAr;
  double Price;
  String Description;
  String DescriptionAr;

  ItemModel({
    required this.Id,
    required this.ImageURL,
    required this.Name,
    required this.NameAr,
    required this.Price,
    required this.Description,
    required this.DescriptionAr,
  });

  factory ItemModel.fromJson(var json) {
    return ItemModel(
      Id: json['Id'],
      ImageURL: json['ImageURL'],
      Name: json['Name'],
      NameAr: json['NameAr'],
      Price: json['Price'],
      Description: json['Description'],
      DescriptionAr: json['DescriptionAr'],
    );
  }
}
