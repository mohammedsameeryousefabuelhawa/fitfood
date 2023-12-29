// item_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/item_provider.dart';

import '../../providers/cart_provider.dart';
import 'cart_screen.dart';

class ItemDetailsScreen extends StatelessWidget {
  final String itemId;

  ItemDetailsScreen({required this.itemId});

  @override
  Widget build(BuildContext context) {
    var item = Provider.of<ItemProvider>(context, listen: false).getItemById(itemId);

    return Scaffold(
      appBar: AppBar(
        title: Text(item.Name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.ImageURL,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              item.Name,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              "Price: ${item.Price.toString()}",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 16),
            Text(
              "Description: ${item.Description.toString()}",
              style: TextStyle(fontSize: 16, color: Colors.red),
            ),
            SizedBox(height: 16),
            // Add more details about the item as needed
            // You can use item.Description or other properties here
            ElevatedButton(
              onPressed: () async {
                await Provider.of<CartProvider>(context, listen: false)
                    .addToCart(idItem: item.Id);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
