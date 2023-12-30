// contact_us_screen.dart
import 'package:flutter/material.dart';

class ContactUsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> contactUsers = [
    {
      'name': 'AWS',
      'email': 'AWS@Gmail.com',
      'phone': '+962 790000000',
    },
    {
      'name': 'mosa',
      'email': 'mosa@example.com',
      'phone': '+962 780000000',
    },
    {
      'name': 'yaqoob',
      'email': 'yaqoob@example.com',
      'phone': '+962 770000000',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
      ),
      body: ListView.builder(
        itemCount: contactUsers.length,
        itemBuilder: (context, index) {
          final user = contactUsers[index];
          return Card(
            margin: EdgeInsets.all(16),
            child: ListTile(
              title: Text(user['name']),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Email: ${user['email']}'),
                  Text('Phone: ${user['phone']}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
