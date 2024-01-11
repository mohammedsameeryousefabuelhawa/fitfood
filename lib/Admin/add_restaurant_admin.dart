import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../providers/categories_provider.dart';

class AddRestaurantadminScreen extends StatefulWidget {
  @override
  _AddRestaurantadminScreenState createState() =>
      _AddRestaurantadminScreenState();
}

class _AddRestaurantadminScreenState extends State<AddRestaurantadminScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController idCategoriesController = TextEditingController();
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
                _buildCategoriesDropDown(),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // add();
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

  Widget _buildCategoriesDropDown() {
    return Consumer<CategoriesProvider>(
      builder: (BuildContext context, CategoriesProvider value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: selectedCategory,
            decoration: InputDecoration(
              labelText: 'Categories',
              prefixIcon: Icon(Icons.check_circle),
              border: OutlineInputBorder(),
            ),
            items: value.list.map((category) {
              return DropdownMenuItem<String>(
                value: category.Name,
                child: Text(category.Name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a Category';
              }
              return null;
            },
          ),
        );
      },
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

// add() async {
//   final response = await http.post(
//     Uri.parse(
//       "${ConstantValue.BASE_URL}addshop.php",
//     ),
//     body: {
//       "Name": nameController.text,
//       "NameAr": nameArController.text,
//       "Id_categories": "4",
//       "Longitude": "31",
//       "Latitude": "35",
//       "Id_statustypes": "1",
//       "description": descriptionController.text,
//       "ImageURL": imageUrlController.text,
//       "lang": "en"
//     },
//   );
//   print(response.body);
//   Navigator.push(context, MaterialPageRoute(builder: (context) => Text("Add User"),));
// }
}
