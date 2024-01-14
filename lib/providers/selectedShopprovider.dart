import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/model/shop_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/selectedshopmodel.dart';

class selectedShopProvider extends ChangeNotifier {
  List<SelectedShopModel> list = [];
  SelectedShopModel? SelectedShopModels;

  getallShops({required String idshop }) async {
    list = [];
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}getselectedshop.php"),
      body: {
        "shop_id": idshop,
      }
    );

    print(response.body);
    if (response.statusCode == 200) {
      list.clear();
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody["shops"];
      for (Map i in shops) {
        list.add(SelectedShopModel.fromJson(i));
      }
      notifyListeners();
    }
  }

}
