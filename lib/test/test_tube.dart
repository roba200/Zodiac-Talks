import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:youtube_api/youtube_api.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

String CHANNEL_ID = 'UCbr3KcqMmqnevfI-2kauzCg';
String API_KEY = 'AIzaSyBUnS4RD87mFe4bG7goKL8yt8TlQBudZF4';

class TestTube extends StatefulWidget {
  const TestTube({super.key});

  @override
  State<TestTube> createState() => _TestTubeState();
}

class _TestTubeState extends State<TestTube> {
  List thumbnails = [];
  List titles = ["Loading....."];
  String apiRequestUrl =
      "https://www.googleapis.com/youtube/v3/search?part=snippet&channelId=$CHANNEL_ID&maxResults=5&order=date&type=video&key=$API_KEY";

  Future getYoutubeData() async {
    final response = await http.get(Uri.parse(apiRequestUrl));
    final jsonResponse = json.decode(response.body);
    final items = jsonResponse['items'];
    titles.clear();
    setState(() {
      for (var item in items) {
        titles.add(item['snippet']['title']);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getYoutubeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Text(titles[index]);
          },
        ),
      ),
    );
  }
}
