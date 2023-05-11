import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignCircle extends StatelessWidget {
  final String url;
  SignCircle({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(45),
          child: Container(
            width: 90,
            height: 90,
            color: Color.fromARGB(255, 54, 54, 54),
          ),
        ),
        Positioned(
          top: 18,
          left: 14,
          child: Image.asset(
            url,
            height: 60,
          ),
        ),
      ],
    );
  }
}
