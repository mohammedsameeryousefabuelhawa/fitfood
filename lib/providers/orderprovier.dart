import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../model/ordersmodel.dart';

class OrderProvider extends ChangeNotifier {
  List<ordersModel> list = [];

  getOrders({required String Id_orderstatus, required String Id_users}) async {
    list = [];
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}getpendingOrders.php"),
      body: {
        "Id_orderstatus": Id_orderstatus,
        "Id_users": Id_users,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody["orders"];
      for (Map i in shops) {
        list.add(ordersModel.fromJson(i));
      }
      notifyListeners();
    }
  }
}
