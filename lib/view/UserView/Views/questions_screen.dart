import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../Controller/ControllerUser/Views/questions_screen.dart';
import '../../../models/models_patient/model_date_json.dart';
import '../Widgets/custom_questions.dart';
import 'Homepage.dart';
import 'ask_screen.dart';
import 'package:get/get.dart';

import 'edit_ask_screen.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: RefreshIndicator(
        onRefresh: () async {
          // Trigger a refresh
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                const CustomCon(),
                GetBuilder<QuestionsScreenController>(
                  init: QuestionsScreenController(),
                  builder: (controller) {
                    return FutureBuilder<ModelDateJson>(
                      future: controller.getView(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData && snapshot.data?.data != null) {
                          var ask = snapshot.data!.data!;
                          if (ask.isEmpty) {
                            return const Center(
                              child: Text('No posts available', style: TextStyle(fontSize: 16)),
                            );
                          }
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: ask.length,
                            itemBuilder: (context, index) {
                              Data noteData = ask[index];
                              return CustomQuestions(
                                onTapEdit: () {
                                  final json = noteData.toJson();
                                  print('Editing post: $json');

                                  Navigator.pushReplacement(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child:EditPostScreen(
                                        currentText: noteData.questionsText ?? '',
                                        postId: noteData.questionsId ?? '',
                                      ),
                                    ),
                                  );
                                },
                                modelAsk: noteData,
                                onTapDelete: () async {
                                  bool? confirmDelete = await showDialog<bool>(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Confirm Deletion'),
                                        content: const Text('Do you want to delete this note?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(false),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.of(context).pop(true),
                                            child: const Text('Delete'),
                                          ),
                                        ],
                                      );
                                    },
                                  );

                                  if (confirmDelete == true) {
                                    await controller.deleteNote(noteData.questionsId ?? '');
                                    Get.find<QuestionsScreenController>().update();
                                  }
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(child: Text('No data available'));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
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
