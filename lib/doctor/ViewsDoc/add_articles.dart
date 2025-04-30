import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:doctor_app/doctor/ViewsDoc/HomepageDoc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';

class AddArticles extends StatefulWidget {
  const AddArticles({super.key});

  @override
  State<AddArticles> createState() => _AddArticlesState();
}

class _AddArticlesState extends State<AddArticles> {
  File? myfile;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController subtitle = TextEditingController();
  final Crud _crud = Crud();
  bool isloading = false;

  addArticles() async {
    if (myfile == null) {
      return AwesomeDialog(
        context: context,
        title: 'هام',
        body: Text("الرجاء اضافه الصوره الخاصة بالمقال."),
      )..show();
    }

    setState(() {
      isloading = true;
    });

    if (formKey.currentState!.validate()) {
      var docId = sp.getString("id");  // هنا تأكد من أنك جلبت doc_id من SharedPreferences أو من المكان الصحيح.
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

      var response = await _crud.postRequestWithFile(linkAddArtices, {
        "title_articles": title.text,
        "article_text": subtitle.text,
        "writer_name": sp.getString("username") ?? "غير معروف",
        "doc_id": docId, // تأكد من إرسال doc_id هنا
      }, myfile!);

      if (response["status"] == "success") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomepageDoc()),
        );
      } else {
        // يمكنك عرض رسالة خطأ هنا إذا لزم الأمر
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('حدث خطأ أثناء إضافة المقال')),
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
          "Add Articles",
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
                    builder:
                        (context) => Container(
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
                  child:
                  myfile == null
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
                    await addArticles();
                  },
                  color: Color.fromARGB(255, 3, 190, 150),
                  textColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minWidth: double.infinity, // يجعل الزر بعرض الشاشة
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
                    "Add",
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
