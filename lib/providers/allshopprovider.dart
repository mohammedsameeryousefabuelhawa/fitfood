import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/model/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AllShopProvider extends ChangeNotifier {
  List<ShopModel> list = [];
  List<ShopModel> listSearch = [];
  ShopModel? ShopsModel;

  getallShops() async {
    list = [];
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}getAllShops.php"),
    );
    print(response.body);
    if (response.statusCode == 200) {
      list.clear();
      listSearch.clear();
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody["shopes"];
      for (Map i in shops) {
        list.add(ShopModel.fromJson(i));
        listSearch.add(ShopModel.fromJson(i));
      }
      notifyListeners();
    }
  }
  search(String text) {
    listSearch=[];
    list.forEach((ShopsModel) {
      if (ShopsModel!.Name.contains(text)) {
        listSearch.add(ShopsModel);
      }
    });
    notifyListeners();
  }

}
