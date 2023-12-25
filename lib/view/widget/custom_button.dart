import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  String text;
  GestureTapCallback onTap;
  CustomButton({super.key, required this.text, required, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: MediaQuery.of(context).size.width * 1,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(38), color: Colors.purple[300]),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
