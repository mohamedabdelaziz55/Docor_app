import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/ControllerUser/Views/artcles.dart';
import '../../../constet.dart';
import '../../../models/models_patient/model_doctors.dart';
import '../../../utils.dart';
import 'articles_screen.dart';


class ArticleDetailsUserScreen extends StatelessWidget {
  final ArticleDetailsController controller = Get.put(ArticleDetailsController());

  ArticleDetailsUserScreen({Key? key, required DataArtices dataArtices}) : super(key: key) {
    controller.setArticle(dataArtices);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.to(() => ArticlesUserScreen(), transition: Transition.rightToLeft);
          },
          icon: Icon(CupertinoIcons.back),
        ),
        title: Obx(() {
          return Text(controller.dataArtices.value.titleArticles ?? 'Article');
        }),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage("$imageRoot/${controller.dataArtices.value.imageArticles}"),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 250,
              );
            }),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(() {
                    return Text(
                      controller.dataArtices.value.titleArticles ?? '',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  Obx(() {
                    return Row(
                      children: [
                        Icon(Icons.schedule, size: 18, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          timeAgo(controller.dataArtices.value.articleDate ?? '2023-01-01T00:00:00'),
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.volume_up),
                        onPressed: controller.speakArticle,
                      ),
                      IconButton(
                        icon: Icon(Icons.text_decrease),
                        onPressed: controller.decreaseFontSize,
                      ),
                      IconButton(
                        icon: Icon(Icons.text_fields),
                        onPressed: controller.resetFontSize,
                      ),
                      IconButton(
                        icon: Icon(Icons.text_increase),
                        onPressed: controller.increaseFontSize,
                      ),
                    ],
                  ),
                  Obx(() {
                    return Text(
                      controller.dataArtices.value.articleText ?? 'No content available.',
                      style: TextStyle(fontSize: controller.fontSize.value, height: 1.6),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
