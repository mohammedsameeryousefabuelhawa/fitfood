import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/general.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/orderdetailsmodel.dart';

class OrderDetailsProvider extends ChangeNotifier {
  List<PendingOrderModel> listOrders = [];

  getOrdersDetails() async {
    listOrders = [];
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}orderdetails.php"),
      body: {
        "Id_users": await General.getPrefString(ConstantValue.Id, ""),
      },
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var orders = jsonBody["orders"];
      for (Map<String, dynamic> i in orders) {
        listOrders.add(PendingOrderModel.fromJson(i));
      }
    }
  }


}
