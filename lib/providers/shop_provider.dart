import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/model/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ShopProvider extends ChangeNotifier {
  List<ShopModel> list = [];

  getShops({required String idCategories, required String lang}) async {
    list = [];
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}getShops.php"),
      body: {
        "Id_categories": idCategories,
        "lang": lang,
      },
    );
print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody["shops"];
      for (Map i in shops) {
        list.add(ShopModel.fromJson(i));
      }
      notifyListeners();
    }
  }
}
