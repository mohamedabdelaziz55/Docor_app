import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:get/get.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';
import '../../models/models_patient/model_doctors.dart';
import '../Widgets/custom_card_articles.dart';

Uint8List kTransparentImage = Uint8List.fromList([
  137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 68, 65, 84, 8,
  99, 0, 0, 0, 1, 0, 0, 0, 1, 208, 1, 109, 64, 0, 0, 0, 0, 73,
  69, 78, 68, 174, 66, 96, 130,
]);

class ArticlesController extends GetxController {
  final Crud _crud = Crud();
  var articles = <DataArtices>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading(true);
      var response = await _crud.postRequest(linkViewArtices, {
        "id": sp.getString("id"),
      });
      var data = ArticesModel.fromJson(response);
      if (data.data != null) {
        articles.value = data.data!;
      } else {
        articles.clear();
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ArticlesController controller = Get.put(ArticlesController());

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
