import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/selectedItem_model.dart';

class selectedItemProvider extends ChangeNotifier {
  List<SelectedItemModel> list = [];
  SelectedItemModel? SelectedItemModels;

  getItem({required String Id }) async {
    list = [];
    final response = await http.post(
        Uri.parse("${ConstantValue.BASE_URL}getselecteditem.php"),
        body: {
          "Id": Id,
        }
    );

    print(response.body);
    if (response.statusCode == 200) {
      list.clear();
      var jsonBody = jsonDecode(response.body);
      var shops = jsonBody["items"];
      for (Map i in shops) {
        list.add(SelectedItemModel.fromJson(i));
      }
      notifyListeners();
    }
  }

}
