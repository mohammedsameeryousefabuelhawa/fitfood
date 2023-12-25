import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/item_provider.dart';
import 'package:ecommerce/view/screens/cart_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemScreen extends StatefulWidget {
  String idShop;

  ItemScreen({required this.idShop});

  @override
  State<ItemScreen> createState() => _ItemScreenState();
}

class _ItemScreenState extends State<ItemScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ItemProvider>(context, listen: false).getItems(
      idShop: widget.idShop,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<ItemProvider>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.list.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Column(
                  children: [
                    Image.network(
                      value.list[index].ImageURL,
                    ),
                    Text(
                      value.list[index].Name,
                    ),
                    Text(
                      value.list[index].Price.toString(),
                    ),
                  ],
                ),
                onTap: () async {
                  await Provider.of<CartProvider>(context, listen: false)
                      .addToCart(idItem: value.list[index].Id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
