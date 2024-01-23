// order_details_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/getorderdetails.dart';

class OrderDetailsScreen extends StatefulWidget {
  final String orderNumber;
  final String shopId;

  OrderDetailsScreen({
    required this.orderNumber,
    required this.shopId,
  });

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  getData() async {
    await Provider.of<OrderDetailsProvider>(context, listen: false)
        .getOrdersDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .6,
              child: Consumer<OrderDetailsProvider>(
                builder: (context, value, child) {
                  return ListView.builder(
                    itemCount: value.listOrders.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Image.network(
                            value.listOrders[index].items.item_image,
                            width: 150,
                            height: 150,
                          ),
                          Column(
                            children: [
                              Text(value.listOrders[index].items.item_name),
                              Text(
                                value.listOrders[index].items.count.toString(),
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
          ],
        ),
      ),
    );
  }
}
