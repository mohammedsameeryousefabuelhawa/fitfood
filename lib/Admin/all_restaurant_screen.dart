import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/allshopprovider.dart';

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
                        return Container(

                          child: Column(
                            children: [
                              Container(
                                color: Colors.black,
                                child: Image.network(value.listSearch[index].ImageURL,fit: BoxFit.fill,width: MediaQuery.of(context).size.width*.8,),
                              ),
                              SizedBox(height: 10,),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  value.listSearch[index].Name,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 25),
                                ),
                              )
                            ],
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
