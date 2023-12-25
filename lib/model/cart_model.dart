class CartModel {
  String Id;
  String ImageURL;
  String Name;
  String NameAr;
  double Price;
  String Id_items;
  int Count;

  CartModel({
    required this.Id,
    required this.ImageURL,
    required this.Name,
    required this.NameAr,
    required this.Price,
    required this.Count,
    required this.Id_items,
  });

  factory CartModel.fromJson(var json) {
    return CartModel(
      Id: json['Id'],
      ImageURL: json['ImageURL'],
      Name: json['Name'],
      NameAr: json['NameAr'],
      Price: json['Price'],
      Count: json['Count'],
      Id_items: json['Id_items'],
    );
  }
}
