import 'dart:convert';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../const_values.dart';
import '../../general.dart';
import '../widget/custom_button.dart';
import 'main_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  TextEditingController note = TextEditingController();
  @override
  void initState() {
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 100,
              child: TextField(
                controller: note,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  label: Text("Note"),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CustomButton(
        text: "Done",
        onTap: () {
          addOrder();
        },
      ),
    );
  }
  addOrder() async {
    final response = await http.post(
      Uri.parse("${ConstantValue.BASE_URL}addOrder.php"),
      body: {
        "Id_user": await General.getPrefString(ConstantValue.Id, ""),
        "totalPrice": Provider.of<CartProvider>(context, listen: false)
            .totalPrice
            .toString(),
        "Notes": note.text,
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      if (jsonBody["result"]) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
      }
    }
  }

}
