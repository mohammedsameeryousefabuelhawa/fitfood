import 'dart:convert';

import 'package:ecommerce/view/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;

import '../../const_values.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool showPassword = false;
  bool showConfirmPassword = false;
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController confirmpasswordTextEditingController =
      TextEditingController();
  double? height;
  double? width;
  bool agreeTerms = false;
  String countryCode = "+962";

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "assets/images/background.png",
              width: width,
              height: height,
              fit: BoxFit.fill,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              width: width,
              margin: EdgeInsets.only(
                top: height! * .10,
              ),
              padding: const EdgeInsets.all(
                20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.create_new_account,
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
                        .hello_we_are_glad_you_have_joined_our_family,
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
                      controller: nameTextEditingController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: AppLocalizations.of(context)!.full_name,
                        hintText: AppLocalizations.of(context)!.enter_your_name,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            31.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
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
                          borderRadius: BorderRadius.circular(
                            31.5,
                          ),
                        ),
                      ),
                      initialCountryCode: 'JO',
                      onChanged: (phone) {
                        countryCode = phone.countryCode;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: emailTextEditingController,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: AppLocalizations.of(context)!.email,
                        hintText: "demo@demo.com",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                            31.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 20,
                    ),
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
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: TextField(
                      controller: confirmpasswordTextEditingController,
                      obscureText: !showConfirmPassword,
                      decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText:
                            AppLocalizations.of(context)!.confirm_password,
                        suffixIcon: IconButton(
                          icon: Icon(
                            showConfirmPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              showConfirmPassword = !showConfirmPassword;
                            });
                          },
                        ),
                        hintText: AppLocalizations.of(context)!
                            .re_enter_your_password,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(31.5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: Colors.black,
                          value: agreeTerms,
                          onChanged: (val) {
                            setState(() {
                              agreeTerms = val!;
                            });
                          }),
                      Text(
                        AppLocalizations.of(context)!.i_agree_to,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context)!
                            .terms_of_service_and_privacy_policy,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.blue,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomButton(
                    text: AppLocalizations.of(context)!.continue_,
                    onTap: () {
                      signUp();
                    },
                  ),
                  Row(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.already_have_an_account,
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
                          Navigator.pop(context);
                        },
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.purple[400],
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  signUp() async {
    final response = await http.post(
      Uri.parse(
        "${ConstantValue.BASE_URL}SignUp.php",
      ),
      body: {
        "Name": nameTextEditingController.text,
        "Password": passwordTextEditingController.text,
        "Email": emailTextEditingController.text,
        "ConCode": countryCode,
        "Phone": phoneTextEditingController.text,
        "lang": "ar"
      },
    );
    if (response.statusCode == 200) {
      var jsonBody = jsonDecode(response.body);
      var result = jsonBody["result"];
      if (result) {
        // ignore: use_build_context_synchronously
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25.0),
            ),
          ),
          backgroundColor: Colors.white,
          builder: (context) {
            return SizedBox(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  Image.asset("assets/images/like.png"),
                  const SizedBox(
                    height: 26,
                  ),
                  Text(
                    AppLocalizations.of(context)!.registration_completed,
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 40),
                    child: CustomButton(
                      text: AppLocalizations.of(context)!.got_it,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            );
          },
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
