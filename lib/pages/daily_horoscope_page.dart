import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zodiac_talks/components/banner_ad.dart';
import 'package:zodiac_talks/components/info_card.dart';
import 'package:zodiac_talks/components/native_ad.dart';
import 'package:zodiac_talks/components/specific_card.dart';
import 'package:zodiac_talks/main.dart';

import '../ad_mob_service.dart';
import '../components/bottom_nav_bar.dart';
import '../components/my_drawer.dart';

class DailyHoroscopePage extends StatefulWidget {
  const DailyHoroscopePage({super.key});

  @override
  State<DailyHoroscopePage> createState() => _DailyHoroscopePageState();
}

class _DailyHoroscopePageState extends State<DailyHoroscopePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 31, 31),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Zodiac ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextSpan(
            text: "Talks",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 239, 105, 184)),
          ),
        ])),
        centerTitle: true,
      ),
      body: ListView(children: [
        BannerA(),
        SizedBox(
          height: 20,
        ),
        InfoCard(
          text: selectedHoroscope.toString(),
          date: todayDate.toString(),
        ),
        SizedBox(
          height: 20,
        ),
        SpecificCard(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SizedBox(
                          //   height: 50,
                          // ),
                          // NativeA(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "TODAY FAVOURITE COLOR",
                              style: GoogleFonts.teko(
                                  height: 1,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 239, 105, 184)),
                            ),
                          ),
                          Text(
                            selectedColor,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.teko(
                                height: 1,
                                fontSize: 80,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          )
                        ]),
                  ),
                );
              },
            );
          },
          title: 'FAVOURITE COLOR',
        ),
        SpecificCard(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: SingleChildScrollView(
                    child: Column(children: [
                      // SizedBox(
                      //   height: 50,
                      // ),
                      // NativeA(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "TODAY COMPATIBILITY",
                          style: GoogleFonts.teko(
                              height: 1,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 239, 105, 184)),
                        ),
                      ),
                      Text(
                        selectedCompatibility,
                        textAlign: TextAlign.justify,
                        style: GoogleFonts.teko(
                            height: 1,
                            fontSize: 80,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ]),
                  ),
                );
              },
            );
          },
          title: 'COMPATIBILITY',
        ),
        SpecificCard(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  content: SingleChildScrollView(
                    child: Column(children: [
                      // NativeA(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "TODAY LUCKY NUMBER",
                          style: GoogleFonts.teko(
                              height: 1,
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 239, 105, 184)),
                        ),
                      ),
                      Text(
                        selectedNumber,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.teko(
                            height: 1,
                            fontSize: 90,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ]),
                  ),
                );
              },
            );
          },
          title: 'LUCKY NUMBER',
        ),
        SizedBox(
          height: 20,
        ),
        // NativeA()
      ]),
    );
  }
}
