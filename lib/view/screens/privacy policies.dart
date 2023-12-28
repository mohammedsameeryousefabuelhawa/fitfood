// privacy_policy_screen.dart
import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your App Privacy Policy',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'This is where you can provide details about your app\'s privacy policy. Explain how you collect, use, and protect user data.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Here are some points you may want to cover:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '- What information you collect',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- How you use the collected information',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- How you protect user information',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              '- Whether you share user information with third parties',
              style: TextStyle(fontSize: 16),
            ),
            // Add more details about your privacy policy as needed
          ],
        ),
      ),
    );
  }
}
