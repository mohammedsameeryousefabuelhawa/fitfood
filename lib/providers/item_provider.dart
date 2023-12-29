import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ItemProvider extends ChangeNotifier {
  List<ItemModel> list = [];

  ItemModel getItemById(String itemId) {
    var item = list.firstWhere((item) => item.Id == itemId,
        orElse: () => ItemModel(
              Id: '',
              ImageURL: '',
              Name: '',
              NameAr: '',
              Price: 0.0,
              Description: '',
              DescriptionAr: '',
            ));

    return item;
  }

  getItems({required String idShop}) async {
    list = [];
    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}getItems.php",
      ),
      body: {
        "Id_shops": idShop,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var items = jsonBody["items"];
      for (Map i in items) {
        list.add(ItemModel.fromJson(i));
      }
    }
    notifyListeners();
  }
}
