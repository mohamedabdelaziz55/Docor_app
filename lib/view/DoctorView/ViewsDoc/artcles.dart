import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constet.dart';
import '../../../models/models_patient/model_doctors.dart';

import '../../../utils.dart';
import 'HomepageDoc.dart';
import 'articles_doc_screen.dart';

class ArticleDetailsDocScreen extends StatelessWidget {
  final DataArtices dataArtices;

  const ArticleDetailsDocScreen({Key? key, required this.dataArtices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.off(HomepageDoc());
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Text(dataArtices.titleArticles ?? 'Article'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage("$imageRoot/${dataArtices.imageArticles}"),
              fit: BoxFit.cover,
              width: double.infinity,
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataArtices.titleArticles ?? '',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 18, color: Colors.grey[600]),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(dataArtices.articleDate ?? '2023-01-01T00:00:00'),
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                dataArtices.articleText ?? 'No content.',
                style: const TextStyle(fontSize: 18, height: 1.6),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
