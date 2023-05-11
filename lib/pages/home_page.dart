import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:zodiac_talks/components/banner_ad.dart';
import 'package:zodiac_talks/components/blog_post.dart';
import 'package:zodiac_talks/components/blog_slider.dart';
import 'package:zodiac_talks/components/bottom_nav_bar.dart';
import 'package:zodiac_talks/components/horoscope_card.dart';
import 'package:zodiac_talks/components/sign_tile.dart';
import 'package:zodiac_talks/components/title_cards.dart';
import 'package:zodiac_talks/components/youtube_player.dart';
import 'package:zodiac_talks/components/youtube_slider.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:zodiac_talks/main.dart';
import 'package:zodiac_talks/pages/article_page.dart';
import 'package:zodiac_talks/pages/blog_page.dart';
import 'package:zodiac_talks/pages/daily_horoscope_page.dart';
import 'package:zodiac_talks/pages/first_page.dart';
import 'package:zodiac_talks/pages/more_blog.dart';
import 'package:zodiac_talks/pages/more_videos.dart';
import 'package:zodiac_talks/pages/video_page.dart';
import '../components/my_drawer.dart';
import '../data.dart';

String CHANNEL_ID = 'UCbr3KcqMmqnevfI-2kauzCg';

int index = 0;

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  List thumbnails = [];
  List titles = ["Loading....."];
  List ytTitles = [];
  List ids = [];
  late Future dataFuture;
  late Future dataFuture2;
  late Future dataFuture3;
  String apiRequestUrl =
      "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$CHANNEL_ID&maxResults=5&order=date&type=video&key=$API_KEY";

  Future getYoutubeData() async {
    final response = await http.get(Uri.parse(apiRequestUrl));
    final jsonResponse = json.decode(response.body);
    final items = jsonResponse['items'];
    titles.clear();
    setState(() {
      for (var item in items) {
        thumbnails.add(item['snippet']['thumbnails']["medium"]["url"]);
        ids.add(item['id']['videoId']);
        ytTitles.add(item['snippet']['title']);
      }
    });
    return jsonResponse;
  }

  String sign = "aries";
  List<Blog> blogs = [
    Blog(
        urlImage:
            "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg?w=740&t=st=1680803409~exp=1680804009~hmac=4be839dd649eded69fc0edcbba6aac1efd3d12d20228c080ddc2baf0913681f8",
        title: "",
        url: ''),
    Blog(
        urlImage:
            "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg?w=740&t=st=1680803409~exp=1680804009~hmac=4be839dd649eded69fc0edcbba6aac1efd3d12d20228c080ddc2baf0913681f8",
        title: "",
        url: ''),
    Blog(
        urlImage:
            "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg?w=740&t=st=1680803409~exp=1680804009~hmac=4be839dd649eded69fc0edcbba6aac1efd3d12d20228c080ddc2baf0913681f8",
        title: "",
        url: ''),
    Blog(
        urlImage:
            "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg?w=740&t=st=1680803409~exp=1680804009~hmac=4be839dd649eded69fc0edcbba6aac1efd3d12d20228c080ddc2baf0913681f8",
        title: "",
        url: ''),
    Blog(
        urlImage:
            "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8189.jpg?w=740&t=st=1680803409~exp=1680804009~hmac=4be839dd649eded69fc0edcbba6aac1efd3d12d20228c080ddc2baf0913681f8",
        title: "",
        url: ''),
  ];
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();
    print("selected color: $selectedColor");
    // getWebsiteData();
    // getYoutubeData();
    dataFuture = getHomeData();
    dataFuture2 = getYoutubeData();
    dataFuture3 = getWebsiteData();
    name = Data.get()!;
  }

  Future getHomeData() async {
    final url = Uri.parse('https://zodiactalks.com/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    final urlImages = html
        .querySelectorAll("div.grid-thumbnail-one-wrap > a > img")
        .map((element) => element.attributes['src']!)
        .toList();

    final titles = html
        .querySelectorAll('h3 > a')
        .map((element) => element.innerHtml.trim())
        .toList();

    final urls = html
        .querySelectorAll("div.post-grid-content-one > h3 > a")
        .map((element) => element.attributes['href']!)
        .toList();

    setState(() {
      blogs = List.generate(
        titles.length,
        (index) => Blog(
          title: titles[index],
          urlImage: urlImages[index],
          url: urls[index],
        ),
      );
    });

    for (var element in urls) {
      print(element);
    }
    return blogs;
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://zodiactalks.com/category/${sign}/');
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
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            BannerA(),
            SizedBox(
              height: 20,
            ),
            HoroscopeCard(
              name: name,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RightClipTitle(
                  color: Color.fromARGB(255, 215, 19, 135),
                  title: "LASTEST VIDEOS",
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MoreVideoPage()));
                    },
                    child: Text(
                      "MORE",
                      style: GoogleFonts.teko(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 14, 14, 14)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: dataFuture2,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: thumbnails.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        YoutubePlayerWidget(id: ids[index]),
                                  ));
                            },
                            child: YoutubeSlider(
                              imageUrl: thumbnails[index],
                              title: ytTitles[index],
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MoreBlogPage(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "MORE",
                      style: GoogleFonts.teko(
                          fontSize: 21,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 14, 14, 14)),
                    ),
                  ),
                ),
                LeftClipTitle(
                  title: "READ",
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: dataFuture,
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return Center(child: CircularProgressIndicator());
                    // }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          final blog = blogs[index];
                          return BlogSlider(
                            imageUrl: blog.urlImage,
                            title: blog.title,
                            url: blog.url,
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                RightClipTitle(
                  title: "  More About",
                  color: Color.fromARGB(255, 215, 19, 135),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
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
              child: FutureBuilder(
                  future: dataFuture3,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(
                                                  article.urlImage))),
                                      height: 100,
                                      width: 100,
                                    ),
                                    Container(
                                      width: width * 0.5,
                                      child: Text(
                                        article.title,
                                        style: GoogleFonts.teko(
                                            fontSize: 21,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            )
          ],
        ),
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

class Blog {
  final String title;
  final String urlImage;
  final String url;
  Blog({required this.url, required this.urlImage, required this.title});
}

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  List screens = [
    HomePage(),
    VideoPage(),
    BlogPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: [
          Icon(
            Icons.home,
            size: 40,
          ),
          Icon(
            Icons.play_circle,
            size: 40,
          ),
          Icon(
            Icons.newspaper,
            size: 40,
          ),
        ],
        backgroundColor: Colors.white,
        buttonBackgroundColor: Color.fromARGB(255, 239, 105, 184),
      ),
      drawer: MyDrawer(),
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        elevation: 0,
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
      body: screens[selectedIndex],
    );
  }
}
