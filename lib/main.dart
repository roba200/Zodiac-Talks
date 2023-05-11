import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodiac_talks/pages/splash_screen.dart';
import 'package:zodiac_talks/services/database.dart';
import 'data.dart';
import 'firebase_options.dart';

dynamic initScreen = false;
dynamic selectedColor = '';
dynamic selectedCompatibility = '';
dynamic selectedNumber = '';
dynamic todayDate = '';
dynamic selectedHoroscope = '';
List words = [];

String API_KEY = '';
String bannerId = '';
String nativeId = '';
String interstitialId = '';

Future<String> getRandomColor() async {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedDate = prefs.getInt('savedColor') ?? 0;
  int savedRandomInt = prefs.getInt('savedRandomColor') ?? 0;

  if (savedDate == today.millisecondsSinceEpoch) {
    // If the random integer has already been generated for today, return it
    return colors[savedRandomInt];
  } else {
    // If the random integer has not been generated for today, generate a new one
    Random random = Random();
    int newRandomInt = random.nextInt(colors.length);

    // Save the new random integer and today's date to SharedPreferences
    await prefs.setInt('savedColor', today.millisecondsSinceEpoch);
    await prefs.setInt('savedRandomColor', newRandomInt);

    // Return the new random integer
    return colors[newRandomInt];
  }
}

Future<String> getRandomCompatibility() async {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedDate = prefs.getInt('savedCompatibility') ?? 0;
  int savedRandomInt = prefs.getInt('savedRandomCompatibility') ?? 0;

  if (savedDate == today.millisecondsSinceEpoch) {
    // If the random integer has already been generated for today, return it
    return compatibility[savedRandomInt];
  } else {
    // If the random integer has not been generated for today, generate a new one
    Random random = Random();
    int newRandomInt = random.nextInt(compatibility.length);

    // Save the new random integer and today's date to SharedPreferences
    await prefs.setInt('savedCompatibility', today.millisecondsSinceEpoch);
    await prefs.setInt('savedRandomCompatibility', newRandomInt);

    // Return the new random integer
    return compatibility[newRandomInt];
  }
}

Future<String> getRandomNumber() async {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedDate = prefs.getInt('savedDate') ?? 0;
  int savedRandomInt = prefs.getInt('savedRandomInt') ?? 0;

  if (savedDate == today.millisecondsSinceEpoch) {
    // If the random integer has already been generated for today, return it
    return savedRandomInt.toString();
  } else {
    // If the random integer has not been generated for today, generate a new one
    Random random = Random();
    int newRandomInt = random.nextInt(10);

    // Save the new random integer and today's date to SharedPreferences
    await prefs.setInt('savedDate', today.millisecondsSinceEpoch);
    await prefs.setInt('savedRandomInt', newRandomInt);

    // Return the new random integer
    return newRandomInt.toString();
  }
}

Future<String> getRandomHoroscope() async {
  DateTime now = DateTime.now();
  DateTime today = DateTime(now.year, now.month, now.day);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedDate = prefs.getInt('savedHoroscope') ?? 0;
  int savedRandomInt = prefs.getInt('savedRandomHoroscope') ?? 0;

  if (savedDate == today.millisecondsSinceEpoch) {
    // If the random integer has already been generated for today, return it
    return horoscope[savedRandomInt];
  } else {
    // If the random integer has not been generated for today, generate a new one
    Random random = Random();
    int newRandomInt = random.nextInt(horoscope.length);

    // Save the new random integer and today's date to SharedPreferences
    await prefs.setInt('savedHoroscope', today.millisecondsSinceEpoch);
    await prefs.setInt('savedRandomHoroscope', newRandomInt);

    // Return the new random integer
    return horoscope[newRandomInt];
  }
}

String getDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('MMMM dd, yyyy').format(now);
  return formattedDate;
}

bool isIntroShown = false;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();

  isIntroShown = prefs.getBool('isIntroShown') ?? false;
  MobileAds.instance.initialize();
  runApp(MyApp(isIntroShown: isIntroShown));
  await Data.init();
  selectedColor = await getRandomColor();
  selectedCompatibility = await getRandomCompatibility();
  selectedNumber = await getRandomNumber();
  todayDate = getDate();
  selectedHoroscope = await getRandomHoroscope();
  final docSnap = FirebaseFirestore.instance
      .collection('data')
      .doc('database')
      .get()
      .then((value) {
    API_KEY = value['youtube_api'];
    bannerId = value['banner_id'];
    interstitialId = value['interstitial_id'];
    nativeId = value['native_id'];
  });
}

class MyApp extends StatelessWidget {
  final bool isIntroShown;
  const MyApp({super.key, required this.isIntroShown});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zodiac Talks',
      theme: ThemeData(
          primarySwatch: Colors.pink, textTheme: GoogleFonts.interTextTheme()),
      home: SplashScreen(),
      // home: ArticlePage(),
    );
  }
}
