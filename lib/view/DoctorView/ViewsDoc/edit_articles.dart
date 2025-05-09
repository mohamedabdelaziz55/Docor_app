import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../../Controller/ControllerDoctor/ViewsController/edit_articles.dart';
import '../../../constet.dart';
import '../../../models/models_patient/model_doctors.dart';


class EditArticles extends StatelessWidget {
  final DataArtices article;

  const EditArticles({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final EditArticlesController controller = Get.put(EditArticlesController());
    controller.init(article.titleArticles ?? '', article.articleText ?? '');

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Article",
          style: TextStyle(color: Color.fromARGB(255, 3, 190, 150)),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: 120,
                      width: double.infinity,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.photo),
                            title: Text("Gallery"),
                            onTap: () async {
                              XFile? xfile = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                              );
                              if (xfile != null) {
                                controller.myFile.value = File(xfile.path);
                              }
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.camera),
                            title: Text("Camera"),
                            onTap: () async {
                              XFile? xfile = await ImagePicker().pickImage(
                                source: ImageSource.camera,
                              );
                              if (xfile != null) {
                                controller.myFile.value = File(xfile.path);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(() {
                    return controller.myFile.value == null
                        ? (article.imageArticles == null
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add_a_photo,
                            size: 40,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Upload Image",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        "$imageRoot/${article.imageArticles}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ))
                        : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.file(
                        controller.myFile.value!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 15),
              buildCustomTextFormField(
                controller: controller.titleController,
                labelText: "Title",
                validationMessage: 'Please enter a title.',
              ),
              SizedBox(height: 20),
              buildCustomTextFormField(
                controller: controller.subtitleController,
                labelText: "Content",
                validationMessage: 'Please enter content.',
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  onPressed: () async {
                    await controller.editArticle(article);
                  },
                  color: Color.fromARGB(255, 3, 190, 150),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minWidth: double.infinity,
                  child: Obx(() {
                    return controller.isLoading.value
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      "Save Changes",
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCustomTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String validationMessage,
  }) {
    const borderColor = Color.fromARGB(255, 3, 190, 150);

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: borderColor),
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
    );
  }
}
