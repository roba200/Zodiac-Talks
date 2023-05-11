import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class SignTile extends StatelessWidget {
  final String text;
  final String imageUrl;
  final void Function() onPressed;

  const SignTile({
    super.key,
    required this.text,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          child: Row(
            children: [
              Image.asset(
                imageUrl,
                height: 25,
              ),
              SizedBox(
                width: 10,
              ),
              Text(text),
            ],
          ),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
