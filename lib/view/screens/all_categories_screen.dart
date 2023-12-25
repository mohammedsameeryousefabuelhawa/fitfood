import 'package:ecommerce/providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllCategoriesScreen extends StatefulWidget {
  const AllCategoriesScreen({super.key});

  @override
  State<AllCategoriesScreen> createState() => _AllCategoriesScreenState();
}

class _AllCategoriesScreenState extends State<AllCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<CategoriesProvider>(
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
