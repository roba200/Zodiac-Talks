import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:zodiac_talks/components/banner_ad.dart';
import 'package:zodiac_talks/components/native_ad.dart';
import 'package:zodiac_talks/components/next_button.dart';

import '../components/bottom_nav_bar.dart';
import '../components/my_drawer.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

import '../components/youtube_player.dart';
import '../components/youtube_slider.dart';
import '../main.dart';
import 'home_page.dart';

String CHANNEL_ID = 'UCbr3KcqMmqnevfI-2kauzCg';
//String API_KEY = 'AIzaSyBXFM069441eodmkVWFdncIHLDgcWJGw3o';

class MoreVideoPage extends StatefulWidget {
  const MoreVideoPage({super.key});

  @override
  State<MoreVideoPage> createState() => _MoreVideoPageState();
}

class _MoreVideoPageState extends State<MoreVideoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List thumbnails = [];
  List titles = [];
  List newTitles = [];
  List ids = [];
  List newThumbnails = [];
  List newIds = [];
  String _nextPageToken = "CAUQAA";

  Future getYoutubeData() async {
    String apiRequestUrl =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$CHANNEL_ID&maxResults=5&order=date&type=video&key=$API_KEY";
    final response = await http.get(Uri.parse(apiRequestUrl));
    final jsonResponse = json.decode(response.body);
    _nextPageToken = jsonResponse["nextPageToken"];
    final items = jsonResponse['items'];

    setState(() {
      for (var item in items) {
        thumbnails.add(item['snippet']['thumbnails']["medium"]["url"]);
        ids.add(item['id']['videoId']);
        titles.add(item['snippet']['title']);
      }
    });
  }

  Future getYoutubeDataMore() async {
    String apiRequestUrl =
        "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$CHANNEL_ID&maxResults=5&order=date&pageToken=$_nextPageToken&type=video&key=$API_KEY";
    final response = await http.get(Uri.parse(apiRequestUrl));
    final jsonResponse = json.decode(response.body);
    _nextPageToken = jsonResponse["nextPageToken"];
    final items = jsonResponse['items'];

    newThumbnails.clear();
    newIds.clear();
    newTitles.clear();
    setState(() {
      for (var item in items) {
        newThumbnails.add(item['snippet']['thumbnails']["medium"]["url"]);
        newIds.add(item['id']['videoId']);
        newTitles.add(item['snippet']['title']);
      }
    });
  }

  @override
  void initState() {
    super.initState();

    getYoutubeData();

    getYoutubeDataMore();
  }

  @override
  Widget build(BuildContext context) {
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
        child: Column(children: [
          BannerA(),
          SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 200,
              child: ListView.builder(
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
                      title: titles[index],
                    ),
                  );
                },
              )),
          SizedBox(
            height: 20,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: newThumbnails.length,
            itemBuilder: (context, index) {
              if (index == 2) {
                return ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    NativeA(),
                    Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        YoutubePlayerWidget(id: newIds[index]),
                                  ));
                            },
                            child: YoutubeSlider(
                              imageUrl: newThumbnails[index],
                              title: newTitles[index],
                            )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )
                  ],
                );
              }
              return Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  YoutubePlayerWidget(id: newIds[index]),
                            ));
                      },
                      child: YoutubeSlider(
                        imageUrl: newThumbnails[index],
                        title: newTitles[index],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                getYoutubeDataMore();
              },
              child: NextButton()),
          SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }
}
