import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_provider.dart';
class MenuScreen extends StatefulWidget {
  String idShop;
  MenuScreen({required this.idShop});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    // TODO: implement initState
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
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .8,
                  child: GridView.builder(
                    itemCount: value.list.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Container(

                            decoration: BoxDecoration(border: Border.all(style: BorderStyle.solid)),
                            child: Column(
                              children: [
                                Container(

                                  color: Colors.black,
                                  child: Image.network(value.list[index].ImageURL,fit: BoxFit.fill,width: MediaQuery.of(context).size.width*.8,height: MediaQuery.of(context).size.height*.15,),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    value.list[index].Name,
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 25),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(      onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => EditRestaurantScreen(
                                      //       restaurantId:  value.listSearch[index].shop_id.toString(),
                                      //     ),
                                      //   ),
                                      // );
                                      // print(value.list[index].shop_id);
                                    },
                                      icon: Icon(Icons.edit),),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
