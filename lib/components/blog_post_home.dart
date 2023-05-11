import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../pages/home_page.dart';
import 'blog_slider.dart';

class BlogPostHome extends StatefulWidget {
  const BlogPostHome({super.key});

  @override
  State<BlogPostHome> createState() => _BlogPostHomeState();
}

class _BlogPostHomeState extends State<BlogPostHome> {
  List<Article> articles = [];
  late Future dataFuture;
  @override
  void initState() {
    super.initState();
    dataFuture = getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://zodiactalks.com/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll('div.post-grid-content-one > h3 > a')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urlImages = html
        .querySelectorAll("div.grid-thumbnail-one-wrap > a > img")
        .map((element) => element.attributes['src']!)
        .toList();

    final urls = html
        .querySelectorAll("div.post-grid-content-one > h3 > a")
        .map((element) => element.attributes['href']!)
        .toList();

    print('Count: ${titles.length}');
    for (final url in urls) {
      debugPrint(url);
    }

    setState(() {
      articles = List.generate(
        titles.length,
        (index) => Article(
          title: titles[index],
          url: urls[index],
          urlImage: urlImages[index],
        ),
      );
    });
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SizedBox(
        height: 200,
        child: FutureBuilder(
            future: dataFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    final article = articles[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => YoutubePlayerWidget(id: ids[index]),
                        //     ));
                      },
                      child: BlogSlider(
                        title: article.title,
                        imageUrl: article.urlImage,
                        url: article.url,
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
