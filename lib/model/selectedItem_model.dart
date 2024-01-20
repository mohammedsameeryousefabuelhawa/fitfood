class SelectedItemModel {
  String Id;
  String Name;
  String ImageURL;
  String Description;
  String Price;
  String Id_shops;
  String Id_statustypes;

  SelectedItemModel({
    required this.Id,
    required this.Name,
    required this.ImageURL,
    required this.Description,
    required this.Price,
    required this.Id_shops,
    required this.Id_statustypes,
  });

  factory SelectedItemModel.fromJson(var json) {
    return SelectedItemModel(
      Id: json['Id'],
      Name: json['Name'],
      ImageURL: json['ImageURL'],
      Description: json['Description'],
      Price: json['Price'],
      Id_shops: json['Id_shops'],
      Id_statustypes: json['Id_statustypes'],
    );
  }
}
