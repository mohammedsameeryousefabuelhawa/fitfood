import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/model/categories_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CategoriesProvider extends ChangeNotifier {
  List<CategoriesModel> list = [];
  List<CategoriesModel> listSearch = [];
  CategoriesModel? categoriesModel;

  getCategories({required String lang}) async {
    final response = await http.get(
      Uri.parse("${ConstantValue.BASE_URL}getCategories.php?lang=$lang"),
    );
    print(response.body);
    if (response.statusCode == 200) {
      list.clear();
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['categories'];
      for (Map i in categories) {
        list.add(CategoriesModel.fromJson(i));
        listSearch.add(CategoriesModel.fromJson(i));
      }
      list[0].selected = true;
      categoriesModel = list[0];
      notifyListeners();
    }
  }

  changeSelected(int index) {
    for (int i = 0; i < list.length; i++) {
      list[i].selected = false;
    }
    list[index].selected = true;
    categoriesModel = list[index];
    notifyListeners();
  }

  search(String text) {
    listSearch=[];
    list.forEach((categoryModel) {
      if (categoryModel.Name.contains(text)) {
        listSearch.add(categoryModel);
      }
    });
    notifyListeners();
  }
}
