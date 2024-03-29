import 'dart:convert';

import 'package:ecommerce/userview/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/Admin/HomeScreen.dart';
import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/general.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../userview/widget/custom_button.dart';
import 'AdminDashboard.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  bool showPassword = false;
  double? height;
  double? width;
  TextEditingController EmailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: width,
              height: height! * .3,
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/background.png",
                    width: width,
                    height: height! * .3,
                    fit: BoxFit.fill,
                  ),
                  Center(
                    child: Image.asset(
                      "assets/images/AppleLogo.png",
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width,
              height: height! * .71,
              padding: const EdgeInsets.all(
                20,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.login,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    AppLocalizations.of(context)!
                        .welcome_log_in_with_your_phone_number,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        color: Color.fromARGB(255, 66, 63, 63),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: EmailTextEditingController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "john@meu.com",
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(31.5)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: passwordTextEditingController,
                      obscureText: !showPassword,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: AppLocalizations.of(context)!.password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                        hintText:
                            AppLocalizations.of(context)!.enter_your_password,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            31.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppLocalizations.of(context)!.forgot_password,
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 63, 63),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.login,
                    onTap: () {
                      login();
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "if you are user or admin",
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Color.fromARGB(255, 66, 63, 63),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Color(0xffe09f29),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  login() async {
    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}adminLogin.php",
      ),
      body: {
        "Email": EmailTextEditingController.text,
        "Admin_Password": passwordTextEditingController.text,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody["result"];
      if (result) {
        await General.savePrefString(ConstantValue.Email, jsonBody["Email"]);
        await General.savePrefString(ConstantValue.Id, jsonBody["Admin_Id"]);
        await General.savePrefString(
            ConstantValue.Password, jsonBody["Admin_Password"]);
        if (jsonBody["Shop_Id"] != null) {
          print(jsonBody["Shop_Id"]);
          await General.savePrefInt(
              ConstantValue.shop_id, int.parse(jsonBody["Shop_Id"]));
        }
        var shop_id = jsonBody["Shop_Id"]  ;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => AdminPage(idShop: shop_id,),
          ),
        );
      }
    }
  }
}
