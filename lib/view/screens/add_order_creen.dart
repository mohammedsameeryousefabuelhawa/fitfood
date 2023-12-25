import 'dart:convert';

import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/general.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/view/screens/main_screen.dart';
import 'package:ecommerce/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AddOrderScreen extends StatefulWidget {
  const AddOrderScreen({super.key});

  @override
  State<AddOrderScreen> createState() => _AddOrderScreenState();
}

class _AddOrderScreenState extends State<AddOrderScreen> {
  List<Marker> list = [];
  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                    target: LatLng(31.985463874326182, 35.897965087898484),
                    zoom: 14),
                onTap: (argument) {
                  if (list.isEmpty) {
                    list.add(
                      Marker(markerId: MarkerId("1"), position: argument),
                    );
                  } else {
                    list[0] =
                        Marker(markerId: MarkerId("1"), position: argument);
                  }
                  setState(() {});
                },
                markers: list.toSet(),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: TextField(
                controller: note,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  label: Text("Note"),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        text: "Done",
        onTap: () {
          addOrder();
        },
      ),
    );
  }

  addOrder() async {
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}addOrder.php"),
      body: {
        "Id_user": await General.getPrefString(ConstantValue.Id, ""),
        "totalPrice": Provider.of<CartProvider>(context, listen: false)
            .totalPrice
            .toString(),
        "Notes": note.text,
        "Longitude": list[0].position.longitude.toString(),
        "Latitude": list[0].position.latitude.toString(),
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      if (jsonBody["result"]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    }
  }
}
