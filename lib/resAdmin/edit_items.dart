import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/resAdmin/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const_values.dart';
import '../providers/StatusTypeProvider.dart';
import '../providers/selecteditemprovider.dart';

class EditItemPage extends StatefulWidget {
  String Id_Item;
  String id;
  EditItemPage({ required this.Id_Item,required this.id});
  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {

  final _formKey = GlobalKey<FormState>();

  TextEditingController imageUrlController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController nameArController = TextEditingController();
  TextEditingController PriceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? selectedStatusType;

  @override
  initState()  {
    // TODO: implement initState
    super.initState();
    initData();
  }
  void initData() async {
    await Provider.of<StatusType>(context, listen: false).getstatus();
    await Provider.of<selectedItemProvider>(context, listen: false).getItem(Id: widget.Id_Item);

    final selectedShopProviderData = Provider.of<selectedItemProvider>(context, listen: false);
    imageUrlController.text = selectedShopProviderData.list.first.ImageURL;
    nameController.text = selectedShopProviderData.list.first.Name;
    descriptionController.text = selectedShopProviderData.list.first.Description;
    PriceController.text = selectedShopProviderData.list.first.Price;
    selectedStatusType = selectedShopProviderData.list.first.Id_statustypes;

    setState(() {});
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
                _buildTextFieldNumberWithIcon(controller: PriceController, label: "price", icon: Icons.monetization_on),
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
                      Edit();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminPage(idShop: widget.id),));
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

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<selectedItemProvider>(
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
  Widget _buildTextFieldNumberWithIcon({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Consumer<selectedItemProvider>(
        builder: (context, shopProvider, child) {
          // Initialize the controller with data from the provider
          // controller.text = shopProvider.list.first.Name; // Update with the actual data from your provider
          return TextFormField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
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

  Edit() async {
    print(widget.Id_Item);
    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}Update_Item.php",
      ),
      body: {

        "Id": widget.id.toString(),
        "Name": nameController.text,
        "Price": PriceController.text,
        "Id_statustypes": selectedStatusType.toString(),
        "Description": descriptionController.text,
        "ImageURL": imageUrlController.text,
        "Id_shops":widget.id,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      print(jsonBody);
    }
  }}
