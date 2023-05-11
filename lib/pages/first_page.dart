import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zodiac_talks/pages/home_page.dart';

import '../components/sign_circle.dart';
import '../data.dart';
import '../main.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  void _goToHome(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isIntroShown', true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Home()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 32, 31, 31),
        title: Text(
          "SELECT YOUR ZODIAC SIGN",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: 78,
        decoration: BoxDecoration(color: Color.fromARGB(255, 32, 31, 31)),
        child: Center(
          child: Text(
            "GETTING STARTED",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.pink.shade200],
          ),
        ),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Data.set('aries');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/aries.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('taurus');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/taurus.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('gemini');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/gemini.png",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Data.set('cancer');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/cancer.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('leo');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/leo.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('virgo');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/virgo.png",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Data.set('libra');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/libra.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('scorpio');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/scorpio.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('sagittarius');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/sagittarius.png",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    Data.set('capricon');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/capricon.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('aquarius');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/aquarius.png",
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Data.set('pisces');
                    _goToHome(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home()));
                  },
                  child: SignCircle(
                    url: "assets/pisces.png",
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
