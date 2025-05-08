import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_app/doctor/ViewsDoc/HomepageDoc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';

class AddArticlesController extends GetxController {
  var myfile = Rx<File?>(null);
  var isloading = false.obs;
  var title = TextEditingController();
  var subtitle = TextEditingController();
  final Crud _crud = Crud();

  addArticles() async {
    if (myfile.value == null) {
      AwesomeDialog(
        context: Get.context!,
        title: 'Important',
        body: Text("Please add an image for the article."),
      )..show();
      return;
    }

    isloading.value = true;

    if (title.text.isEmpty || subtitle.text.isEmpty) {
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("Please fill in all fields."),
      )..show();
      isloading.value = false;
      return;
    }

    var docId = sp.getString("id");
    if (docId == null) {
      isloading.value = false;
      AwesomeDialog(
        context: Get.context!,
        title: 'Error',
        body: Text("Doctor ID not found."),
      )..show();
      return;
    }

    var response = await _crud.postRequestWithFile(linkAddArtices, {
      "title_articles": title.text,
      "article_text": subtitle.text,
      "writer_name": sp.getString("username") ?? "Unknown",
      "doc_id": docId,
    }, myfile.value!);

    if (response["status"] == "success") {
      Get.to(() => HomepageDoc());
    } else {
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text('Error adding the article')),
      );
    }

    isloading.value = false;
  }
}

class AddArticles extends StatelessWidget {
  const AddArticles({super.key});

  @override
  Widget build(BuildContext context) {
    final AddArticlesController controller = Get.put(AddArticlesController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Articles",
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
                                controller.myfile.value = File(xfile.path);
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
                                controller.myfile.value = File(xfile.path);
                              }
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Obx(
                      () => Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: controller.myfile.value == null
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
                      child: Image.file(
                        controller.myfile.value!,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              buildCustomTextFormField(
                controller: controller.title,
                labelText: "Title",
                validationMessage: 'Please enter a title.',
              ),
              SizedBox(height: 20),
              buildCustomTextFormField(
                controller: controller.subtitle,
                labelText: "Content",
                validationMessage: 'Please enter content.',
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  onPressed: controller.addArticles,
                  color: Color.fromARGB(255, 3, 190, 150),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minWidth: double.infinity,
                  child: Obx(
                        () => controller.isloading.value
                        ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      "Add",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
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
