import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class SpecificCard extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  SpecificCard({super.key, required this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            height: 63,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 215, 19, 135)),
                borderRadius: BorderRadius.circular(25)),
          ),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: 63,
              width: 89,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 215, 19, 135),
                  borderRadius: BorderRadius.circular(25)),
              child: Center(
                  child: Text(
                "GET",
                style: GoogleFonts.sumana(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.only(right: 89, bottom: 13),
            child: Text(
              title,
              style: GoogleFonts.teko(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 215, 19, 135)),
            ),
          ))
        ],
      ),
    );
  }
}
