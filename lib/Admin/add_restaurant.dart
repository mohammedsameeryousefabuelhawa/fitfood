import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/categories_provider.dart';

class AddRestaurantScreen extends StatefulWidget {
  @override
  _AddRestaurantScreenState createState() => _AddRestaurantScreenState();
}

class _AddRestaurantScreenState extends State<AddRestaurantScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController imageUrlController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController idCategoriesController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedStatusType;
  String? selectedCategory;

  @override
   initState()  {
    // TODO: implement initState
    super.initState();
    initData();
  }
  void initData() async {
    await Provider.of<CategoriesProvider>(context, listen: false).getCategories(lang: "en");
  }

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
                  controller: imageUrlController,
                  label: 'Image URL',
                  icon: Icons.image,
                ),
                _buildTextFieldWithIcon(
                  controller: nameController,
                  label: 'Name',
                  icon: Icons.restaurant,
                ),
                _buildTextFieldWithIcon(
                  controller: nameArController,
                  label: 'Name (Arabic)',
                  icon: Icons.restaurant_menu,
                ),
                _buildCategoriesDropDown(),
                _buildStatusTypeDropDown(),
                _buildTextFieldWithIcon(
                  controller: descriptionController,
                  label: 'Description',
                  icon: Icons.description,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // The form is valid, implement your logic to save the restaurant data
                      // You can access the entered values using the controllers
                      // For example: imageUrlController.text, nameController.text, etc.
                      // Implement your logic to save the data to your database or perform any other actions.
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

  Widget _buildStatusTypeDropDown() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        value: selectedStatusType,
        decoration: InputDecoration(
          labelText: 'Status Type',
          prefixIcon: Icon(Icons.check_circle),
          border: OutlineInputBorder(),
        ),
        items: ['active', 'not active']
            .map((statusType) => DropdownMenuItem<String>(
          value: statusType,
          child: Text(statusType),
        ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedStatusType = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a Status Type';
          }
          return null;
        },
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
}
