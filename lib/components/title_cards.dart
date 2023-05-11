import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class RightClipTitle extends StatelessWidget {
  final String title;
  final Color? color;
  RightClipTitle({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RightTitleClipper(),
      child: Container(
        color: color,
        height: 31,
        //width: 147.5,
        child: Padding(
          padding: const EdgeInsets.only(top: 3, left: 5, right: 25),
          child: Text(
            title,
            style: GoogleFonts.teko(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class LeftClipTitle extends StatelessWidget {
  final String title;
  const LeftClipTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LeftTitleClipper(),
      child: Container(
        alignment: Alignment.centerRight,
        color: Color.fromARGB(255, 215, 19, 135),
        height: 31,
        width: 129,
        child: Padding(
          padding: const EdgeInsets.only(top: 3, right: 40),
          child: Text(
            title,
            style: GoogleFonts.teko(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class RightTitleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width - 20, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(RightTitleClipper oldClipper) => false;
}

class LeftTitleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(20, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(LeftTitleClipper oldClipper) => false;
}
