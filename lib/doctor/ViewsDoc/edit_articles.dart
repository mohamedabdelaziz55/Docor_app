import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_app/doctor/ViewsDoc/HomepageDoc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';
import '../../models/models_patient/model_doctors.dart'; // لنقل بيانات المقالة

class EditArticles extends StatefulWidget {
  final DataArtices article;

  const EditArticles({super.key, required this.article});

  @override
  State<EditArticles> createState() => _EditArticlesState();
}

class _EditArticlesState extends State<EditArticles> {
  File? myfile;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  final Crud _crud = Crud();
  bool isloading = false;

  @override
  void initState() {
    super.initState();
    title.text = widget.article.titleArticles ?? ''; // تحميل عنوان المقالة
    subtitle.text = widget.article.articleText ?? ''; // تحميل محتوى المقالة
  }
  editArticles() async {
    // إذا لم يتم اختيار صورة جديدة وكان المقال لا يحتوي على صورة قديمة
    if (myfile == null && widget.article.imageArticles == null) {
      return AwesomeDialog(
        context: context,
        title: 'هام',
        body: Text("الرجاء إضافة الصورة الخاصة بالمقال."),
      )..show();
    }

    setState(() {
      isloading = true;
    });

    if (formKey.currentState!.validate()) {
      var docId = sp.getString("id");
      if (docId == null) {
        setState(() {
          isloading = false;
        });
        return AwesomeDialog(
          context: context,
          title: 'خطأ',
          body: Text("لم يتم العثور على معرف الطبيب."),
        )..show();
      }

      var imageFile = myfile ?? File(widget.article.imageArticles ?? ''); // استخدام الصورة القديمة إذا لم تكن صورة جديدة

      // التحقق من وجود الصورة (إذا كانت صورة جديدة)
      if (myfile != null && !await imageFile.exists()) {
        setState(() {
          isloading = false;
        });
        return AwesomeDialog(
          context: context,
          title: 'خطأ',
          body: Text("الصورة المحددة غير موجودة."),
        )..show();
      }

      var response = await _crud.postRequestWithFile(linkUpdateArtices, {
        "title_articles": title.text,
        "article_text": subtitle.text,
        "writer_name": sp.getString("username") ?? "غير معروف",
        "doc_id": docId,
        "id": widget.article.id.toString(),
      }, imageFile);

      if (response == null) {
        setState(() {
          isloading = false;
        });
        return AwesomeDialog(
          context: context,
          title: 'خطأ',
          body: Text("حدث خطأ في الاتصال بالخادم."),
        )..show();
      }

      if (response["status"] == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomepageDoc()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء تعديل المقال')),
        );
      }
    }

    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
          key: formKey,
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
                                setState(() {
                                  myfile = File(xfile.path);
                                });
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
                                setState(() {
                                  myfile = File(xfile.path);
                                });
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
                  child: myfile == null
                      ? (widget.article.imageArticles == null
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
                      "$imageRoot/${widget.article.imageArticles}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ))
                      : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      myfile!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              buildCustomTextFormField(
                controller: title,
                labelText: "Title",
                validationMessage: 'يرجى إدخال عنوان.',
              ),
              SizedBox(height: 20),
              buildCustomTextFormField(
                controller: subtitle,
                labelText: "Content",
                validationMessage: 'يرجى إدخال محتوى.',
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: MaterialButton(
                  onPressed: () async {
                    await editArticles();
                  },
                  color: Color.fromARGB(255, 3, 190, 150),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minWidth: double.infinity,
                  child: isloading
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
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
