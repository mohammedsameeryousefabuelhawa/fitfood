import 'package:flutter/material.dart';

class QRCodePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://timber.mhmcdn.com/site/feature/qr/QRPage1.webp', // Replace with the path to your image asset
              width: 200.0,
              height: 200.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'share by scan qr code',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
