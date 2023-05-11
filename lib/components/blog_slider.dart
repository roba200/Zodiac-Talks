import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zodiac_talks/pages/article_page.dart';

class BlogSlider extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String url;
  BlogSlider(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.url});

  @override
  State<BlogSlider> createState() => _BlogSliderState();
}

class _BlogSliderState extends State<BlogSlider> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlePage(
                        url: widget.url,
                      )));
        },
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
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                    width: 320,
                    height: 180,
                    child: Image.network(widget.imageUrl)),
                Container(
                  alignment: Alignment.center,
                  width: 320,
                  height: 60,
                  child: Text(widget.title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.teko(
                          height: 1,
                          fontSize: 25,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  color: Colors.white.withOpacity(0.6),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
