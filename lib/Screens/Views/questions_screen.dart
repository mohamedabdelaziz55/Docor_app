import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:doctor_app/date/dummy_questions&&anser.dart';
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

  Future<ModelDateJson> getView() async {
    var response = await _crud.postRequest(linkView, {
      "id": sp.getString("id"),
    });
    return ModelDateJson.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: FutureBuilder<ModelDateJson>(
        future: getView(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData && snapshot.data?.data != null) {
            var ask = snapshot.data!.data!;
            return SingleChildScrollView(
              child: Column(
                children: [
                  CustomCon(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: ask.length,
                    itemBuilder: (context, index) {
                      var noteData = ask[index];
                      return CustomQuestions(modelAsk: noteData);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
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

// class CustomQuestions extends StatelessWidget {
//   final Data modelAsk;
//
//   const CustomQuestions({Key? key, required this.modelAsk}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             modelAsk.questionsText ?? 'No question available',
//             style: TextStyle(fontSize: 16),
//           ),
//           SizedBox(height: 5),
//           Text(
//             'Posted on: ${modelAsk.postDate ?? 'Unknown date'}',
//             style: TextStyle(color: Colors.grey),
//           ),
//         ],
//       ),
//     );
//   }
// }

