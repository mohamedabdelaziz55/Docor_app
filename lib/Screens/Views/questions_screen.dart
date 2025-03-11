import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:doctor_app/date/dummy_questions&&anser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../Widgets/custom_questions.dart';
import 'Dashboard_screen.dart';
import 'ask_screen.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomCon(),
              SearchTextField(text: "Search for a question..."),
              SizedBox(height: 20),

              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dummyQuestions.length,
                itemBuilder: (context, index) {
                  return CustomQuestions(modelQuestions: dummyQuestions[index]);
                },
              ),
            ],
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
      color: Color.fromARGB(255, 3, 190, 150),
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
            icon: Icon(CupertinoIcons.back, color: Colors.white, size: 24),
          ),
          SizedBox(height: 22),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Image.asset('assets/images/doctor2.png', height: 200),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
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
                          child: AskScreen(),
                        ),
                      );
                    },
                    child: Text(
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
