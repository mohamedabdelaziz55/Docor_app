import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:doctor_app/Screens/Views/edit_ask_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';
import '../../models/models_patient/model_date_json.dart';
import '../Widgets/custom_questions.dart';
import 'ask_screen.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  Crud _crud = Crud();

  // جلب بيانات الأسئلة
  Future<ModelDateJson> getView() async {
    var response = await _crud.postRequest(linkView, {
      "id": sp.getString("id"),
    });
    return ModelDateJson.fromJson(response);
  }

  // تعديل دالة الحذف لتسليم اسم المعامل المناسب "questions_id"
  Future<void> deleteNote(String noteId) async {
    var response = await _crud.postRequest(linkDelete, {"questions_id": noteId});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomCon(),
            FutureBuilder<ModelDateJson>(
              future: getView(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data?.data != null) {
                  var ask = snapshot.data!.data!;
                  if (ask.isEmpty) {
                    return const Center(
                        child: Text('No posts available',
                            style: TextStyle(fontSize: 16)));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: ask.length,
                    itemBuilder: (context, index) {
                      Data noteData = ask[index];
                      return CustomQuestions(
                        onTapEdit: () {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: EditAskScreen(post: noteData.toJson()), // تمرير بيانات السؤال
                            ),
                          );
                        },
                        modelAsk: noteData,
                        onTapDelete: () async {
                          bool? confirmDelete = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('تأكيد الحذف'),
                                content: const Text('هل تريد حذف هذه الملاحظة؟'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('إلغاء'),
                                  ),
                                  TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('حذف'),
                                  ),
                                ],
                              );
                            },
                          );
                          if (confirmDelete == true) {
                            await deleteNote(noteData.questionsId ?? '');
                            setState(() {
                              ask.removeAt(index);
                            });
                          }
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCon extends StatelessWidget {
  const CustomCon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      color: const Color.fromARGB(255, 3, 190, 150),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: Homepage(),
                ),
              );
            },
            icon: const Icon(CupertinoIcons.back, color: Colors.white, size: 24),
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset('assets/images/doctor2.png', height: 200),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Do you have a medical\n question?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.leftToRight,
                          child: const AskScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Enter your question now',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}