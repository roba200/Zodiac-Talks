import 'package:flutter/material.dart';

class MorphismCard extends StatelessWidget {
  final double elevation;
  final double borderRadius;
  final EdgeInsets padding;
  final Widget child;
  final double height;
  final double width;

  MorphismCard({
    this.elevation = 8.0,
    this.borderRadius = 16.0,
    this.padding = const EdgeInsets.all(16.0),
    required this.child,
    this.height = 100,
    this.width = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
