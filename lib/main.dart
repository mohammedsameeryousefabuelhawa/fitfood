import 'package:ecommerce/providers/banner_images_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/item_provider.dart';
import 'package:ecommerce/providers/shop_provider.dart';
import 'package:ecommerce/view/screens/login_screen.dart';
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
        initialRoute: '/',
        routes: {
          '/orders': (context) => Text("orders"),
          '/QR': (context) => Text("ScanQR"),
          '/aboutUs': (context) => Text("aboutUs"),
          '/pp': (context) => Text("Privacy Policy"),
          '/login': (context) => LoginScreen(),
          // Add routes for other pages
        },

        title: 'FitFood',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange).copyWith(background: Colors.orange),

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
        home: const LoginScreen(),
      ),
    );
  }
}
