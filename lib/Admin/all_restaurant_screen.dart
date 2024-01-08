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
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<AllShopProvider>(
          builder: (context, value, child) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .20,
                    width: MediaQuery.of(context).size.width,
                    child: TextField(
                      onChanged: (text) {
                        value.search(text);
                      },
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .75,
                    child: GridView.builder(
                      itemCount: value.listSearch.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return Container(
                          child: Stack(
                            children: [
                              Container(
                                color: Colors.black,
                                child: Image.network(value.listSearch[index].ImageURL),
                              ),
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  value.listSearch[index].Name,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
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
