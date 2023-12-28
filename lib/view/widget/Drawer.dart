import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../const_values.dart';
import '../../../general.dart';

class MyDrawer extends StatelessWidget {
  final List<Map<String, dynamic>> drawerItems = [
    {'title': 'Orders', 'icon': Icons.shopping_cart, 'route': '/orders'},
    {'title': 'Share', 'icon': Icons.share, 'route': '/orders'},
    {'title': 'Share with Scan QR', 'icon': Icons.qr_code_scanner, 'route': '/QR'},
    {'title': 'About Us', 'icon': Icons.info, 'route': '/aboutUs'},
    {'title': 'Privacy Policies', 'icon': Icons.privacy_tip, 'route': '/pp'},
    {'title': 'Contact Us', 'icon': Icons.contact_mail, 'route': '/orders'},
    {'title': 'Languages', 'icon': Icons.language, 'route': '/orders'},
    {'title': 'Delete Account', 'icon': Icons.delete, 'route': '/orders'},
    {'title': 'Log Out', 'icon': Icons.logout,},
  ]; // Add your items

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color(0xFFeF6C00), // Use the primary color from the theme
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                  '${General.getPrefString(ConstantValue.Name,"")}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: drawerItems.length,
            itemBuilder: (context, index) {
              final item = drawerItems[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                leading: Icon(item['icon'], color: Colors.black54, size: 24),
                title: Text(
                  item['title'],
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                trailing: const Icon(Icons.arrow_forward, color: Colors.black54),
                // Arrow icon as a tail
                onTap: () async {
                  if (item['route'] != null) {
                    Navigator.pushNamed(context, item['route']);
                  } else if (item['title'] == 'Log Out') {
                    await clearSharedPreferences();
                    Navigator.pushReplacementNamed(context, '/login');
                  }                },
              );
            },
          ),
          // You can add more widgets after the ListView.builder if needed
        ],
      ),
    );
  }
  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(ConstantValue.Id);
    await prefs.remove(ConstantValue.Name);
    await prefs.remove(ConstantValue.Phone);
    await prefs.remove(ConstantValue.ConCode);
    await prefs.remove(ConstantValue.Id_usertype);
    await prefs.remove(ConstantValue.Password);
  }

}
