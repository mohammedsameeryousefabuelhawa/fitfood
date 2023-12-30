import 'dart:convert';
import 'package:ecommerce/const_values.dart';
import 'package:ecommerce/general.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../widget/custom_button.dart';
import 'main_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  String countryCode = "+962";
  double? height;
  double? width;
  TextEditingController phoneTextEditingController = TextEditingController();
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
                    child: IntlPhoneField(
                      controller: phoneTextEditingController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "786983720",
                        labelText: AppLocalizations.of(context)!.phone_number,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(31.5)),
                      ),
                      initialCountryCode: "JO",
                      onChanged: (phone) {
                        countryCode = phone.countryCode;
                      },
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
                        AppLocalizations.of(context)!.dont_have_an_account,
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
                              builder: (context) => const SignupScreen(),
                            ),
                          );
                        },
                        child: Text(
                          AppLocalizations.of(context)!.register_now,
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
        "${ConstantValue.BASE_URL}login.php",
      ),
      body: {
        "Phone": phoneTextEditingController.text,
        "Password": passwordTextEditingController.text,
        "ConCode": countryCode,
        "lang": "ar"
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody["result"];
      if (result) {
        await General.savePrefString(ConstantValue.Id, jsonBody["Id"]);
        await General.savePrefString(ConstantValue.Name, jsonBody["Name"]);
        await General.savePrefString(ConstantValue.Phone, jsonBody["Phone"]);
        await General.savePrefString(
            ConstantValue.ConCode, jsonBody["ConCode"]);
        await General.savePrefString(
            ConstantValue.Id_usertype, jsonBody["Id_usertype"]);
        await General.savePrefString(
            ConstantValue.Password, passwordTextEditingController.text);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainScreen(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              margin: const EdgeInsets.all(20),
              width: width,
              height: height! * .30,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.warning,
                    size: 50,
                  ),
                  Text(
                    jsonBody["msg"],
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.ok,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }
    }
  }
}
