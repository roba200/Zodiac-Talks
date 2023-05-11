import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class BlogPost extends StatefulWidget {
  final String sign;
  BlogPost({super.key, required this.sign});

  @override
  State<BlogPost> createState() => _BlogPostState();
}

class _BlogPostState extends State<BlogPost> {
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://zodiactalks.com/category/${widget.sign}/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('h3 > a')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urlImages = html
        .querySelectorAll("div.latest-post-thumbnail-wrap > a > img")
        .map((element) => element.attributes['src']!)
        .toList();

    print('Count: ${titles.length}');
    for (final title in titles) {
      debugPrint(title);
    }

    setState(() {
      articles = List.generate(
        titles.length,
        (index) => Article(
          title: titles[index],
          url: "",
          urlImage: urlImages[index],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(article.urlImage))),
                    height: 100,
                    width: 100,
                  ),
                  Container(
                    width: width * 0.5,
                    child: Text(
                      article.title,
                      style: GoogleFonts.teko(
                          fontSize: 21, fontWeight: FontWeight.w500),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Article {
  final String title;
  final String url;
  final String urlImage;
  Article({required this.url, required this.urlImage, required this.title});
}
