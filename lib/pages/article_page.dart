import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticlePage extends StatefulWidget {
  final String url;
  ArticlePage({super.key, required this.url});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
        ),
      ),
    );
  }
}
