import 'package:doctor_app/Screens/Views/questions_screen.dart';
import 'package:doctor_app/models/models_patient/model_questions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class AnserQuestionsScreen extends StatelessWidget {
  const AnserQuestionsScreen({
    super.key,
  });

  // final ModelQuestions modelQuestions;
  // final ModelAnswer modelAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.leftToRight,
                child: QuestionsScreen(),
              ),
            );
          },
          icon: Icon(CupertinoIcons.back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 247, 247, 247),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.time,
                                  color: Colors.grey.shade500,
                                ),
                                Text(
                                  ' 8 Hours',
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                              ],
                            ),
                            Text(
                              'From a member',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: .4,
                          endIndent: 15,
                          indent: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "dssdkf;",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(children: [Icon(CupertinoIcons.time), Text(' 8 hours')]),
                    Spacer(),
                    Column(
                      children: [
                        Text('The Answer', style: TextStyle(fontSize: 16)),
                        Text(
                          'Dr:Mohamed Elsafty',
                          style: TextStyle(
                            color: Color.fromARGB(255, 3, 190, 150),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(' Neurologist', style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    SizedBox(width: 8),
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/icons/male-doctor.png'),
                    ),
                  ],
                ),
              ),
              Text(
                "modelAnswer.answer",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 3, 190, 150),
                ),
                onPressed: () {},
                child: Text(
                  'Enter your question now',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('Do you want to talk to the Doctor?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}