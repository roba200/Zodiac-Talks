import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<Article> articles = [];
  @override
  void initState() {
    super.initState();
    getWebsiteData();
  }

  Future getWebsiteData() async {
    final url = Uri.parse('https://zodiactalks.com/');
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    print(response.body);

    final titles = html
        .querySelectorAll('h3 > a')
        .map((element) => element.innerHtml.trim())
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
          urlImage: "",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          //final article = articles[index];
          return ListTile(
            title: Text(articles[index].title),
            leading: Image.network(
              articles[index].urlImage,
              width: 50,
              fit: BoxFit.fitHeight,
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
