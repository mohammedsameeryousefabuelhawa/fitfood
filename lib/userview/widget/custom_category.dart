import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCategory extends StatelessWidget {
  String text;
  GestureTapCallback onTap;
  Color color;

  CustomCategory(
      {super.key,
      required this.text,
      required this.onTap,
      required this.color});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(

          left: 10,
        ),
        padding: EdgeInsets.all(
          1,
        ),
        height: size.height ,
        width: size.width*0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(38),
          color: color,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
