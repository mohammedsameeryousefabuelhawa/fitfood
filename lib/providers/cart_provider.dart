import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/general.dart';
import 'package:ecommerce/model/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class CartProvider extends ChangeNotifier {
  List<CartModel> listCart = [];
  double totalPrice = 0;

  getCart() async {
    listCart = [];
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}getCart.php"),
      body: {
        "Id_users": await General.getPrefString(ConstantValue.Id, ""),
      },
    );

    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var cart = jsonBody["cart"];
      for (Map i in cart) {
        listCart.add(CartModel.fromJson(i));
      }
    }
    calTotalPrice();
  }

  calTotalPrice() {
    totalPrice = 0;
    for (CartModel cartModel in listCart) {
      totalPrice = totalPrice + (cartModel.Count * cartModel.Price);
    }
    notifyListeners();
  }

  addToCart({required String idItem}) async {
    await http.post(
      Uri.parse("${ConstantValue.BASE_URL}addToCart.php"),
      body: {
        "Id_users": await General.getPrefString(ConstantValue.Id, ""),
        "Id_items": idItem,
        "Count": "1",
      },
    );
  }

  updateCart({required String id, required String Count}) async {
    await http.post(
      Uri.parse("${ConstantValue.BASE_URL}updateCart.php"),
      body: {
        "Id": id,
        "Count": Count,
      },
    );
    calTotalPrice();
  }

  deleteFromCart({required int index}) async {
    await http.post(
      Uri.parse("${ConstantValue.BASE_URL}deleteFromCart.php"),
      body: {
        "Id": listCart[index].Id,
      },
    );
    listCart.removeAt(index);
    calTotalPrice();
  }
}
