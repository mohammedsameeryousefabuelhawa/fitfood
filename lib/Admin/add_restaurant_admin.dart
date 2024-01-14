import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../providers/categories_provider.dart';
import 'all_restaurant_screen.dart';

class AddRestaurantadminScreen extends StatefulWidget {
  var idShop;
  AddRestaurantadminScreen({required String idShop}) : idShop = idShop;

  @override
  State<AddRestaurantadminScreen> createState() =>  _AddRestaurantadminScreenState();

}

class _AddRestaurantadminScreenState extends State<AddRestaurantadminScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? selectedCategory;
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Restaurant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextFieldWithIcon(
                  controller: email,
                  label: 'Email',
                  icon: Icons.image,
                ),
                _buildTextFieldWithIcon(
                  controller: password,
                  label: 'password',
                  icon: Icons.restaurant,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      add();
                    }
                  },
                  child: Text('Add Restaurant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  add() async {
    if (widget.idShop == null) {
      print("Error: idShop is null");
      return;
    }

    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}AddAdminShop.php",
      ),
      body: {
        'Admin_Password': password.text,
        'Email': email.text,
        'Shop_Id': widget.idShop.toString(),
      },
    );

    print(widget.idShop.toString());
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['result'] == true) {
        // Request successful, handle accordingly
        Navigator.push(context, MaterialPageRoute(builder: (context) => AllrestaurantScreen(),));
      } else {
        // Request failed, display an error message
        String errorMsg = data['msg'] != null ? data['msg'].toString() : "Unknown error";
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error: $errorMsg"),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      // Handle other status codes if needed
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error: ${response.statusCode}"),
        backgroundColor: Colors.red,
      ));
    }
  }
}
