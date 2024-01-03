import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/orderstatusmodel.dart';

class orderstatusProvider extends ChangeNotifier {
  List<orderstatusmodel> list = [];
  List<orderstatusmodel> listSearch = [];
  orderstatusmodel? ordersstatusmodel;

  getorderstatus({required String lang}) async {
    final response = await http.get(
      Uri.parse("${ConstantValue.BASE_URL}getorderstatus.php?lang=$lang"),
    );
    print(response.body);
    list.clear();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['orderstatus'];
      for (Map i in categories) {
        list.add(orderstatusmodel.fromJson(i));
        listSearch.add(orderstatusmodel.fromJson(i));
      }
      list[0].selected = true;
      ordersstatusmodel = list[0];
      notifyListeners();
    }
  }

  changeSelected(int index) {
    for (int i = 0; i < list.length; i++) {
      list[i].selected = false;
    }
    list[index].selected = true;
    ordersstatusmodel = list[index];
    notifyListeners();
  }

  search(String text) {
    listSearch=[];
    list.forEach((orderstatusmodel) {
      if (orderstatusmodel.Name.contains(text)) {
        listSearch.add(orderstatusmodel);
      }
    });
    notifyListeners();
  }
}
