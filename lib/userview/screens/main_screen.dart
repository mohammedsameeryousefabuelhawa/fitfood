import 'package:ecommerce/providers/banner_images_provider.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/shop_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widget/Drawer.dart';
import '../widget/custom_category.dart';
import 'all_categories_screen.dart';
import 'item_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Size? size;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    await Provider.of<BannerProvider>(context, listen: false).getBannerImages();
    await Provider.of<CategoriesProvider>(context, listen: false).getCategories(
      lang: "en",
    );
    await Provider.of<ShopProvider>(context, listen: false).getShops(
      idCategories:
      Provider
          .of<CategoriesProvider>(context, listen: false)
          .list[0].Id,
      lang: "en",
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Fit Food",
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [ Image.asset("assets/images/AppleLogo.png", fit: BoxFit.cover,),],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size!.width,
          height: size!.height,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  // border: Border.all(style: BorderStyle.solid),
                  color: CupertinoColors.inactiveGray,
                  borderRadius: BorderRadius.circular(14),
                ),
                height: size!.height * .25,
                width: size!.width * 0.8,
                margin: const EdgeInsets.all(
                  20,
                ),
                child: Consumer<BannerProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            await launchUrl(Uri.parse(value.list[index].URL));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Image.network(value.list[index].ImageURL,
                                fit: BoxFit.fill, width: 320, height: 100),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Consumer<CategoriesProvider>(
                      builder: (context, value, child) {
                        return value.categoriesModel != null
                            ? Text(
                          "Categoris",
                          style: TextStyle(fontSize: 25),
                        )
                            : Text("");
                      },
                    ),
                    TextButton(
                      child: Text("see all"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return AllCategoriesScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size!.height * .05,
                child: Consumer<CategoriesProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.list.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CustomCategory(
                          text: value.list[index].Name,
                          onTap: () {
                            value.changeSelected(index);
                            Provider.of<ShopProvider>(context, listen: false)
                                .getShops(
                              idCategories: value.list[index].Id,
                              lang: "en",
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
              SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * .1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Consumer<CategoriesProvider>(
                        builder: (context, value, child) {
                          return value.categoriesModel != null
                              ? Text(
                            "${value.categoriesModel!.Name} restaurant",
                            style: TextStyle(fontSize: 25),
                          )
                              : Text("");
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: size!.height * .4,
                child: Consumer<ShopProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: value.list.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ItemScreen(idShop: value.list[index].Id),
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Image.network(
                                        value.list[index].ImageURL,
                                        width: 50,
                                        height: 50,
                                      ),
                                      Column(
                                        children: [
                                          Text(value.list[index].Name),
                                          Text(value.list[index].description
                                              .toString(), style: TextStyle(
                                              fontSize: 13, color: Colors.red)),
                                        ],
                                      ),
                                      SizedBox(width: 10,),
                                      SizedBox(width: 10,),
                                      Icon(Icons.forward),
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
