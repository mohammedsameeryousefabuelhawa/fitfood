import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/statustypemodel.dart';

class StatusType extends ChangeNotifier {
  List<statusTypemodel> list = [];
  statusTypemodel? StatusTypeModel;

  getstatus() async {
    final response = await http.get(
      Uri.parse("${ConstantValue.BASE_URL}getstatus.php"),
    );
    print(response.body);
    list.clear();
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var categories = jsonBody['statustypes'];
      for (Map i in categories) {
        list.add(statusTypemodel.fromJson(i));
      }
      notifyListeners();
    }
  }
}
