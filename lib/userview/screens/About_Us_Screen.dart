// about_us_screen.dart
import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 75,right: 75),
                  child: Container(decoration: BoxDecoration(color: Color(0xff212416)),child: Image.asset("assets/images/AppleLogo.png",width: 250)),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Text(
              'Welcome to our app!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'This is the About Us screen. Add your information here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
