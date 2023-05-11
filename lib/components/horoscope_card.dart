import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zodiac_talks/components/sign_circle.dart';
import 'package:zodiac_talks/data.dart';
import 'package:zodiac_talks/pages/daily_horoscope_page.dart';
import 'package:zodiac_talks/pages/first_page.dart';

import '../main.dart';
import '../services/database.dart';

class HoroscopeCard extends StatefulWidget {
  final String name;
  HoroscopeCard({super.key, required this.name});

  @override
  State<HoroscopeCard> createState() => _HoroscopeCardState();
}

class _HoroscopeCardState extends State<HoroscopeCard> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 248, 248, 248),
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 215, 19, 135).withOpacity(0.7),
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 45, top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  textScaleFactor: 1.0,
                  todayDate.toString(),
                  style: GoogleFonts.teko(
                      height: 1.0,
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 103, 98, 101)),
                ),
                Row(
                  children: [
                    Text(
                      textScaleFactor: 1.0,
                      "${widget.name.toUpperCase()} HOROSCOPE",
                      style: GoogleFonts.teko(
                          height: 1.0,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 215, 19, 135)),
                    ),
                  ],
                ),
                Text(
                  textScaleFactor: 1.0,
                  getSignDate(widget.name).toString(),
                  style: GoogleFonts.teko(
                      height: 1.0,
                      fontSize: 26,
                      fontWeight: FontWeight.w300,
                      color: Color.fromARGB(255, 103, 98, 101)),
                ),
              ],
            ),
          ),
        ),
        Positioned(
            top: 30,
            right: 40,
            child: SignCircle(url: "assets/${widget.name}.png")),
        Positioned(bottom: -25, left: (width * 0.5) - 22.5, child: GoButton()),
        IconButton(
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => FirstPage()));
            },
            icon: Icon(Icons.arrow_back))
      ],
    );
  }
}

class GoButton extends StatefulWidget {
  const GoButton({super.key});

  @override
  State<GoButton> createState() => _GoButtonState();
}

class _GoButtonState extends State<GoButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DailyHoroscopePage()));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(55),
        child: Container(
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 239, 239, 239),
              borderRadius: BorderRadius.circular(55),
              border: Border.all(color: Color.fromARGB(255, 215, 19, 135))),
          height: 55,
          width: 55,
          child: Center(
              child: Text(
            "GO",
            style: GoogleFonts.teko(
                fontSize: 27,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 215, 19, 135)),
          )),
        ),
      ),
    );
  }
}
