import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/view/screens/add_order_creen.dart';
import 'package:ecommerce/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .6,
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                  itemCount: value.listCart.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Image.network(
                          value.listCart[index].ImageURL,
                          width: 150,
                          height: 150,
                        ),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await value.deleteFromCart(index: index);
                              },
                              icon: Icon(Icons.delete),
                            ),
                            Text(value.listCart[index].Name),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    value.listCart[index].Count =
                                        value.listCart[index].Count + 1;
                                    value.updateCart(
                                      id: value.listCart[index].Id,
                                      Count: (value.listCart[index].Count)
                                          .toString(),
                                    );
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                Text(
                                  value.listCart[index].Count.toString(),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    if (value.listCart[index].Count != 1) {
                                      value.listCart[index].Count =
                                          value.listCart[index].Count - 1;
                                      value.updateCart(
                                        id: value.listCart[index].Id,
                                        Count: (value.listCart[index].Count)
                                            .toString(),
                                      );
                                    } else {
                                      await value.deleteFromCart(index: index);
                                    }
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .2,
            child: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Total Price  = ${value.totalPrice}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomButton(
        text: "Next",
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddOrderScreen(),
              ));
        },
      ),
    );
  }
}
