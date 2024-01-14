import 'dart:convert';
import 'package:ecommerce/Admin/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../const_values.dart';
import '../providers/StatusTypeProvider.dart';
import '../providers/categories_provider.dart';
import '../providers/selectedShopprovider.dart';

class EditRestaurantScreen extends StatefulWidget {
  final String restaurantId;
  EditRestaurantScreen({required this.restaurantId});
  @override
  _EditRestaurantScreenState createState() => _EditRestaurantScreenState();
}

class _EditRestaurantScreenState extends State<EditRestaurantScreen> {

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
    await Provider.of<CategoriesProvider>(context, listen: false)
        .getCategories(lang: "en");
    await Provider.of<StatusType>(context, listen: false)
        .getstatus();
    await Provider.of<selectedShopProvider>(context, listen: false)
        .getallShops(idshop: widget.restaurantId.toString());

    final selectedShopProviderData = Provider.of<selectedShopProvider>(context, listen: false);
    imageUrlController.text = selectedShopProviderData.list.first.ImageURL;
    nameController.text = selectedShopProviderData.list.first.Name;
    nameArController.text = selectedShopProviderData.list.first.NameAr; // Update with the actual data from your provider
    descriptionController.text = selectedShopProviderData.list.first.description; // Update with the actual data from your provider with the actual data from your provider
    idCategoriesController.text = selectedShopProviderData.list.first.Id_categories; // Update with the actual data from your provider with the actual data from your provider
    selectedStatusType=selectedShopProviderData.list.first.Id_statustypes;
    selectedCategory=selectedShopProviderData.list.first.Id_categories;
    setState(() {

    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Restaurant'),
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
                      add();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminHomeScreenPage(),));
                    }
                  },
                  child: Text('Edit Restaurant'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusTypeDropDown() {
    return Consumer<StatusType>(
      builder: (BuildContext context, StatusType value, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField<String>(
            value: selectedStatusType,
            decoration: InputDecoration(
              labelText: 'Status Type',
              prefixIcon: Icon(Icons.check_circle),
              border: OutlineInputBorder(),
            ),
            items: value.list
                .map((statusType) => DropdownMenuItem<String>(
              value: statusType.Id,
              child: Text(statusType.Name),
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
      },
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
                value: category.Id,
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
      child: Consumer<selectedShopProvider>(
        builder: (context, shopProvider, child) {
          // Initialize the controller with data from the provider
          // controller.text = shopProvider.list.first.Name; // Update with the actual data from your provider
          return TextFormField(
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
          );
        },
      ),
    );
  }

  add() async {
    print(widget.restaurantId);
    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}update_shop.php",
      ),
      body: {

        "shop_id": widget.restaurantId.toString(),
        "Name": nameController.text,
        "NameAr": nameArController.text,
        "Id_categories": selectedCategory.toString(),
        "Longitude": "31",
        "Latitude": "35",
        "Id_statustypes": selectedStatusType.toString(),
        "description": descriptionController.text,
        "ImageURL": imageUrlController.text,
        "lang": "en"
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
    }
  }}
