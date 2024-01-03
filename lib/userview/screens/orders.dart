import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../const_values.dart';
import '../../general.dart';
import '../../providers/orderprovier.dart';
import '../../providers/orderstatusprovider.dart';
import '../widget/custom_category.dart';

class orderscreen extends StatefulWidget {
  const orderscreen({super.key});

  @override
  State<orderscreen> createState() => _orderscreenState();
}

class _orderscreenState extends State<orderscreen> {
  Size? size;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  getData() async {
    await Provider.of<orderstatusProvider>(context, listen: false)
        .getorderstatus(
      lang: "en",
    );
    await Provider.of<OrderProvider>(context, listen: false).getOrders(
      Id_orderstatus:
          Provider.of<orderstatusProvider>(context, listen: false).list[0].Id, Id_users: await General.getPrefString(ConstantValue.Id,"") ?? 'N/A',
    );
    print("object");
    print(await General.getPrefString(ConstantValue.Id,"") ?? 'N/A');
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("orders screen"),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size!.width,
          height: size!.height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: size!.height * .05,
                  child: Consumer<orderstatusProvider>(
                    builder: (context, value, child) {
                      return ListView.builder(
                        itemCount: value.list.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CustomCategory(
                            text: value.list[index].Name,
                            onTap: () async {
                              value.changeSelected(index);
                              Provider.of<OrderProvider>(context, listen: false)
                                  .getOrders(
                                Id_orderstatus: value.list[index].Id,
                                Id_users: await General.getPrefString(ConstantValue.Id,"") ?? 'N/A',
                              );
                            },
                            color: value.list[index].selected
                                ? const Color(0xffe09f29)
                                : const Color.fromRGBO(200, 200, 200, 1),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size!.height * .7,
                child: Consumer<OrderProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         ItemScreen(idShop: value.list[index].Id),
                            //   ),
                            // );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid,),borderRadius: BorderRadius.circular(25)),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Image.network("${value.list[index].ImageURL}"),
                                      Column(
                                        children: [
                                          Text(
                                              "order number :${value.list[index].order_id}"),
                                          Text(
                                              "notes :${value.list[index].Notes}"),
                                          Text(
                                              "total price :${value.list[index].totalPrice.toString()}"),
                                          Text(
                                              "restaurant name :${value.list[index].shop_name.toString()}"),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10)
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
