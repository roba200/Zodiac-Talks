import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zodiac_talks/components/blog_post_home.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:zodiac_talks/components/next_button.dart';

import '../components/blog_post.dart';
import '../components/bottom_nav_bar.dart';
import '../components/my_drawer.dart';
import '../components/sign_tile.dart';
import '../data.dart';
import 'article_page.dart';

class MoreBlogPage extends StatefulWidget {
  const MoreBlogPage({super.key});

  @override
  State<MoreBlogPage> createState() => _MoreBlogPageState();
}

class _MoreBlogPageState extends State<MoreBlogPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String sign = "aries";
  int page = 1;
  List<Article> articles = [];
  Future getWebsiteData() async {
    final url =
        Uri.parse('https://zodiactalks.com/category/${sign}/page/$page/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final titles = html
        .querySelectorAll(
            'div.latest-post-block-content.has-featured-blog > h3 > a')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urlImages = html
        .querySelectorAll("div.latest-post-thumbnail-wrap > a > img")
        .map((element) => element.attributes['src']!)
        .toList();
    final urls = html
        .querySelectorAll(
            "div.latest-post-block-content.has-featured-blog > h3 > a")
        .map((element) => element.attributes['href']!)
        .toList();

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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWebsiteData();
    print(Data.get());
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 32, 31, 31),
        title: RichText(
            text: TextSpan(children: [
          TextSpan(
            text: "Zodiac ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          TextSpan(
            text: "Talks",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color.fromARGB(255, 239, 105, 184)),
          ),
        ])),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlogPostHome(),
            SizedBox(
              height: 49,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  SignTile(
                    text: "ARIES",
                    imageUrl: "assets/aries_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "aries";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "TAURUS",
                    imageUrl: "assets/TAURUS_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "taurus";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "GEMINI",
                    imageUrl: "assets/GEMINI_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "gemini";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "CANCER",
                    imageUrl: "assets/CANCER_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "cancer";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "LEO",
                    imageUrl: "assets/LEO_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "leo";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "VIRGO",
                    imageUrl: "assets/VIRGO_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "virgo";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "LIBRA",
                    imageUrl: "assets/LIBRA_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "libra";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "SCORPIO",
                    imageUrl: "assets/SCORPIO_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "scorpio";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "SAGITTARIUS",
                    imageUrl: "assets/SAGITTARIUS_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "sagittarius";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "CAPRICORN",
                    imageUrl: "assets/CAPRICORN_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "capricorn";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "AQUARIUS",
                    imageUrl: "assets/AQUARIUS_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "aquarius";
                      });
                      getWebsiteData();
                    },
                  ),
                  SignTile(
                    text: "PISCES",
                    imageUrl: "assets/PISCES_icon.png",
                    onPressed: () {
                      setState(() {
                        sign = "pisces";
                      });
                      getWebsiteData();
                    },
                  ),
                ],
              ),
            ),
            Container(
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ArticlePage(url: article.url)));
                        },
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
                    ),
                  );
                },
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  page = 2;
                  getWebsiteData();
                });
              },
              child: NextButton(),
            ),
          ],
        ),
      ),
    );
  }
}
