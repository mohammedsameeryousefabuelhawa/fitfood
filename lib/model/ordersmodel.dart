class ordersModel {
  String order_id;
  String Notes;
  String totalPrice;
  String shop_id;
  String shop_name;
  String description;
  String ImageURL;

  ordersModel({
    required this.order_id,
    required this.Notes,
    required this.totalPrice,
    required this.shop_id,
    required this.shop_name,
    required this.description,
    required this.ImageURL,
  });

  factory ordersModel.fromJson(var json) {
    return ordersModel(
      order_id: json['order_id'],
      Notes: json['Notes'],
      totalPrice: json['totalPrice'],
      shop_id: json['shop_id'],
      shop_name: json['shop_name'],
      description: json['description'],
      ImageURL: json['ImageURL'],
    );
  }
}
