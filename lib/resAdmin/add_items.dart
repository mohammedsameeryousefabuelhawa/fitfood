import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ecommerce/resAdmin/AdminDashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../const_values.dart';
import '../general.dart';
import '../providers/StatusTypeProvider.dart';

class AddItemPage extends StatefulWidget {
  String idShop;
  AddItemPage({required this.idShop});
  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {


  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameArController = TextEditingController();
  final TextEditingController _nameEnController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? selectedStatusType;
  // File? _image;



  initState()  {
    // TODO: implement initState
    super.initState();
    initData();
  }
  void initData() async {
    await Provider.of<StatusType>(context, listen: false)
        .getstatus();

  }
  @override
  void dispose() {
    _nameArController.dispose();
    _nameEnController.dispose();
    _priceController.dispose();
    _imageUrlController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  String? _validateNonEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter the $fieldName';
    }
    return null;
  }

  // Future<void> _getImage() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = File(pickedFile.path);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildFormField('Image url', _imageUrlController),
              _buildFormField('Name', _nameEnController),
              _buildFormField('Price', _priceController, keyboardType: TextInputType.numberWithOptions(decimal: true)),
              _buildStatusTypeDropDown(),
              // _imagePreview(),
              // ElevatedButton(
              //   onPressed: () {
              //     _getImage(); // Open image picker
              //   },
              //   child: Text('Select Image'),
              // ),
              _buildFormField('Description', _descriptionController, maxLines: 3),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _addItem();
                  }
                },
                child: Text('Add Item'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _imagePreview() {
  //   return _image != null
  //       ? Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       SizedBox(height: 16.0),
  //       Text('Image Preview', style: TextStyle(fontWeight: FontWeight.bold)),
  //       SizedBox(height: 8.0),
  //       Image.file(
  //         _image!,
  //         height: 100,
  //         width: 100,
  //         fit: BoxFit.cover,
  //       ),
  //     ],
  //   )
  //       : Container();
  // }

  Widget _buildFormField(String label, TextEditingController controller, {int maxLines = 1, TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          TextFormField(
            controller: controller,
            maxLines: maxLines,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
            validator: (value) => _validateNonEmpty(value, label),
            keyboardType: keyboardType,
          ),
        ],
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

  Future<void> _addItem() async {
    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}addNewItems.php",
      ),
      body: {
        "Name": _nameEnController.text,
        "Description": _descriptionController.text,
        "ImageURL": _imageUrlController.text,
        "Price": _priceController.text,
        "Id_statustypes": selectedStatusType.toString(),
        "Id_shops": widget.idShop,
        "NameAr": "NameAr",
        "DescriptionAr": "DescriptionAr",
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody["result"];
      var ShopAdminId= jsonBody["Id_shops"].toString();
      print(ShopAdminId);
      Navigator.push(context, MaterialPageRoute(builder: (context) => AdminPage(idShop: widget.idShop),));

    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Item added successfully!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
