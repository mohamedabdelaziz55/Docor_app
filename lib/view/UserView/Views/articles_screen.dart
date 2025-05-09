import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../../../Controller/ControllerUser/Views/articles_screen.dart';
import '../Widgets/custom_card_articles.dart';
import 'Homepage.dart';

Uint8List kTransparentImage = Uint8List.fromList([
  137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 68, 65, 84, 8,
  99, 0, 0, 0, 1, 0, 0, 0, 1, 208, 1, 109, 64, 0, 0, 0, 0, 73,
  69, 78, 68, 174, 66, 96, 130,
]);


class ArticlesUserScreen extends StatelessWidget {
  const ArticlesUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticlesController controller = Get.put(ArticlesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Articles Pages",
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.errorMessage.isNotEmpty) {
          return Center(child: Text('Error: ${controller.errorMessage}'));
        } else if (controller.articles.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          return RefreshIndicator(
            onRefresh: controller.fetchArticles,
            child: ListView.builder(
              itemCount: controller.articles.length,
              itemBuilder: (context, index) {
                var noteData = controller.articles[index];
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: CustomCardArticles(dataM: noteData),
                );
              },
            ),
          );
        }
      }),
    );
  }
}
