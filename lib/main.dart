import 'package:ecommerce/providers/banner_images_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/item_provider.dart';
import 'package:ecommerce/providers/shop_provider.dart';
import 'package:ecommerce/view/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BannerProvider>(
          create: (context) => BannerProvider(),
        ),
        ChangeNotifierProvider<CategoriesProvider>(
          create: (context) => CategoriesProvider(),
        ),
        ChangeNotifierProvider<ShopProvider>(
          create: (context) => ShopProvider(),
        ),
        ChangeNotifierProvider<ItemProvider>(
          create: (context) => ItemProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'FitFood',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen).copyWith(background: Colors.orange),

        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('ar'),
        ],
        home: const SplashScreen(),
      ),
    );
  }
}
