import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class YoutubeSlider extends StatefulWidget {
  final String imageUrl;
  final String title;
  YoutubeSlider({super.key, required this.imageUrl, required this.title});

  @override
  State<YoutubeSlider> createState() => _YoutubeSliderState();
}

class _YoutubeSliderState extends State<YoutubeSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 215, 19, 135).withOpacity(0.7),
              blurRadius: 7,
              offset: Offset(2, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                width: 320,
                height: 180,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Icon(
                Icons.play_circle_fill,
                size: 60,
                color: Color.fromARGB(255, 215, 19, 135).withOpacity(0.8),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  alignment: Alignment.center,
                  width: 320,
                  height: 60,
                  child: Text(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      widget.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.teko(
                          height: 1,
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  color: Colors.white.withOpacity(0.6),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
