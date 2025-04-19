import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:flutter/material.dart';

// استيراد المكتبة إذا كنت تستخدمها
// import 'package:flutter_image/flutter_image.dart';
import 'dart:typed_data';

import '../Widgets/custom_card_articles.dart';
import 'Dashboard_screen.dart';

Uint8List kTransparentImage = Uint8List.fromList([
  137,
  80,
  78,
  71,
  13,
  10,
  26,
  10,
  0,
  0,
  0,
  13,
  73,
  68,
  65,
  84,
  8,
  99,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  1,
  208,
  1,
  109,
  64,
  0,
  0,
  0,
  0,
  73,
  69,
  78,
  68,
  174,
  66,
  96,
  130,
]);

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Articles Page",
          style: TextStyle(color: const Color.fromARGB(255, 3, 190, 150)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SearchTextField(text: 'Search for an article'),
            Divider(
              endIndent: 40,
              indent: 40,
              height: 40,
              color: Colors.grey,
              thickness: .5,
            ),
            CustomCardArticles(),
          ],
        ),
      ),
    );
  }
}


