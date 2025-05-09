import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../UserView/Views/Homepage.dart';

class PuzzleScreen extends StatefulWidget {
  const PuzzleScreen({super.key});

  @override
  State<PuzzleScreen> createState() => _PuzzleScreenState();
}

class _PuzzleScreenState extends State<PuzzleScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(
            Uri.parse('https://ashishbeck.github.io/slide_puzzle/#/'),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Slide Puzzle Game'),
        leading: IconButton(
          onPressed: () {
            Get.off(() => Homepage());
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
