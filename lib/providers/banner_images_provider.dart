import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/model/banner_images_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class BannerProvider extends ChangeNotifier {
  List<BannerImagesModel> list = [];

  getBannerImages() async {
    final response = await http.get(
      Uri.parse("${ConstantValue.BASE_URL}getBannerImages.php"),
    );
print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var bannerImage = jsonBody['bannerImage'];
      for (Map i in bannerImage) {
        list.add(BannerImagesModel.fromJson(i));
      }
      notifyListeners();
    }
  }
}
