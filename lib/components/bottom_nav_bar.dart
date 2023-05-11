import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 64,
          color: Color.fromARGB(255, 4, 4, 4),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.home_filled,
                        color: Colors.white,
                        size: 36,
                      ),
                    ),
                    Icon(
                      Icons.newspaper_rounded,
                      color: Colors.white,
                      size: 36,
                    ),
                  ]),
            ),
          ),
        ),
        Positioned(
          top: -35,
          left: (width / 2) - 40,
          child: Container(
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 80,
                    width: 80,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(69),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        215,
                        19,
                        135,
                      ),
                    ),
                    height: 69,
                    width: 69,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'assets/yt.png',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
