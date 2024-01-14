import 'package:flutter/material.dart';

import 'add_restaurant.dart';
import 'all_restaurant_screen.dart';


class AdminHomeScreenPage extends StatelessWidget {
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
            _buildEventCard(context, 'add restaurant', Icons.restaurant_menu),
            _buildEventCard(context, 'edit restaurant', Icons.edit),
            // _buildEventCard(context, 'delete restaurant', Icons.delete),
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
      case 'add restaurant':
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddRestaurantScreen()));
        break;
      case 'edit restaurant':
        Navigator.push(context, MaterialPageRoute(builder: (context) => AllrestaurantScreen()));
        break;
      case 'delete restaurant':
        Navigator.push(context, MaterialPageRoute(builder: (context) => Text("orders")));
        break;
    // Add more cases for other events/pages if needed
      default:
      // Handle unknown event name or navigate to a default page
        break;
    }
  }

}