import 'package:ecommerce/resAdmin/menuscreen.dart';
import 'package:flutter/material.dart';

import 'add_items.dart';

class AdminPage extends StatefulWidget {
  String idShop;
  AdminPage({required this.idShop});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 1,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: [
            _buildEventCard(context, 'menu', Icons.restaurant_menu),
            _buildEventCard(context, 'add items', Icons.add),
            _buildEventCard(context, 'orders', Icons.fastfood),
            // _buildEventCard(context, 'Event 4', Icons.event),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard(BuildContext context, String eventName, IconData iconData) {
    return GestureDetector(
      onTap: () {
        _navigateToPage(context, eventName);
      },
      child: Card(
        elevation: 3.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 56.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(height: 8.0),
            Text(
              eventName,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPage(BuildContext context, String eventName) {
    switch (eventName.toLowerCase()) {
      case 'menu':
        Navigator.push(context, MaterialPageRoute(builder: (context) => MenuScreen(idShop: widget.idShop,)));
        break;
      case 'add items':
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddItemPage()));
        break;
      case 'orders':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Text("orders")));
        break;
    // Add more cases for other events/pages if needed
      default:
      // Handle unknown event name or navigate to a default page
        break;
    }
  }
}