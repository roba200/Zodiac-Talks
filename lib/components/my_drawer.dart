import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:zodiac_talks/components/morphism_card.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width * 0.85,
      height: height,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            width: width * 0.85,
            height: 140,
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Color.fromARGB(255, 31, 31, 31),
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(30))),
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 19),
                    child: Container(
                      height: 70,
                      width: 70,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fill,
                      ),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 239, 237, 237),
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Zodiac ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          TextSpan(
                            text: "Talks",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 239, 105, 184)),
                          ),
                        ])),
                        Text(
                          "version 1.0",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MyCard(
            icon: Icons.star_border_purple500,
            text: "RATE US",
          ),
          SizedBox(
            height: 30,
          ),
          MyCard(
            icon: Icons.info,
            text: "ABOUT",
          ),
          SizedBox(
            height: 30,
          ),
          MyCard(
            icon: Icons.privacy_tip,
            text: "PRIVACY POLICY",
          ),
        ],
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final IconData icon;
  final String text;
  MyCard({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Container(
        height: 59,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 254, 254),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 7,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Icon(
              icon,
              size: 30,
            ),
            SizedBox(width: 30),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )
          ],
        )),
      ),
    );
  }
}
