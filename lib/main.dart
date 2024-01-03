import 'package:ecommerce/providers/banner_images_provider.dart';
import 'package:ecommerce/providers/cart_provider.dart';
import 'package:ecommerce/providers/categories_provider.dart';
import 'package:ecommerce/providers/item_provider.dart';
import 'package:ecommerce/providers/orderprovier.dart';
import 'package:ecommerce/providers/orderstatusprovider.dart';
import 'package:ecommerce/providers/shop_provider.dart';
import 'package:ecommerce/resAdmin/AdminDashboard.dart';
import 'package:ecommerce/userview/screens/orders.dart';
import 'package:ecommerce/userview/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import 'userview/screens/About_Us_Screen.dart';
import 'userview/screens/Contact_Us.dart';
import 'userview/screens/ScanQR.dart';
import 'userview/screens/login_screen.dart';
import 'userview/screens/privacy policies.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OrderProvider>(
          create: (context) => OrderProvider(),
        ),
        ChangeNotifierProvider<orderstatusProvider>(
          create: (context) => orderstatusProvider(),
        ),
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
          '/orders': (context) => orderscreen(),
          '/QR': (context) => QRCodePage(),
          '/aboutUs': (context) => AboutUsScreen(),
          '/pp': (context) => PrivacyPolicyScreen(),
          '/login': (context) => LoginScreen(),
          '/CU': (context) => ContactUsScreen(),
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
        home:  SplashScreen(),
      ),
    );
  }
}
