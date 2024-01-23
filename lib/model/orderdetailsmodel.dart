class PendingOrderModel {
  int order_id;
  String Notes;
  int totalPrice;
  int shop_id;
  String shop_name;
  String shop_image;
  String description;
  itemsModel items;

  PendingOrderModel(
      {required this.order_id,
      required this.Notes,
      required this.totalPrice,
      required this.shop_id,
      required this.shop_name,
      required this.shop_image,
      required this.description,
      required this.items});

  factory PendingOrderModel.fromJson(Map<String, dynamic> json) {
    return PendingOrderModel(
      order_id: json['order_id'],
      Notes: json['Notes'],
      totalPrice: json['totalPrice'],
      shop_id: json['shop_id'],
      shop_name: json['shop_name'],
      shop_image: json['shop_image'],
      description: json['description'],
      items: json['items'] != null
          ? itemsModel.fromJson(json['product'])
          : itemsModel(
        item_id: 0,
        item_name: 'N/A',
        item_price: '',
        item_image: '',
        count: 0,
            ),
    );
  }
}

class itemsModel {
  int item_id;
  String item_name;
  String item_price;
  String item_image;
  int count;


  itemsModel({
    required this.item_id,
    required this.item_name,
    required this.item_image,
    required this.item_price,
    required this.count,
  });

  factory itemsModel.fromJson(Map<String, dynamic> json) {
    return itemsModel(
      item_id: json['item_id'] ?? 0,
      item_name: json['item_name'] ?? 'N/A',
      item_image: json['item_image'] ?? '',
      item_price: json['item_price'] ?? '',
      count: json['count'] ?? '',
     );
  }
}
