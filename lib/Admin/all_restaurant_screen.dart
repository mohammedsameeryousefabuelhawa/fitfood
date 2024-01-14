import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/allshopprovider.dart';
import 'edit_shop.dart';

class AllrestaurantScreen extends StatefulWidget {
  const AllrestaurantScreen({super.key});

  @override
  State<AllrestaurantScreen> createState() => _AllrestaurantScreenState();
}

class _AllrestaurantScreenState extends State<AllrestaurantScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<AllShopProvider>(context, listen: false).getallShops();

  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<AllShopProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .1,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      decoration: InputDecoration(labelText: 'Search Restaurants'),
                      onChanged: (text) {
                        value.search(text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: GridView.builder(
                      itemCount: value.listSearch.length,
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
                                    child: Image.network(value.listSearch[index].ImageURL,fit: BoxFit.fill,width: MediaQuery.of(context).size.width*.8,height: MediaQuery.of(context).size.height*.15,),
                                  ),
                                  SizedBox(height: 10,),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      value.listSearch[index].Name,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 25),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditRestaurantScreen(
                                             restaurantId:  value.listSearch[index].shop_id.toString(),
                                            ),
                                          ),
                                        );
                                        print(value.listSearch[index].shop_id);
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
      ),
    );
  }
}
