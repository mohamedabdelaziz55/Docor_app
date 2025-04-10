import 'package:doctor_app/models/models_patient/model_date_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class CustomQuestions extends StatefulWidget {
  const CustomQuestions({super.key, required this.modelAsk});

  final Data modelAsk;

  @override
  _CustomQuestionsState createState() => _CustomQuestionsState();
}

class _CustomQuestionsState extends State<CustomQuestions> {
  String timeAgo(String dateTime) {
    DateTime postDate = DateTime.parse(dateTime);
    final Duration difference = DateTime.now().difference(postDate);

    if (difference.inSeconds < 60) {
      return "منذ ثوانٍ";
    } else if (difference.inMinutes < 60) {
      return "منذ ${difference.inMinutes} دقيقة";
    } else if (difference.inHours < 24) {
      return "منذ ${difference.inHours} ساعة";
    } else if (difference.inDays < 7) {
      return "منذ ${difference.inDays} يوم";
    } else if (difference.inDays < 30) {
      return "منذ ${difference.inDays ~/ 7} أسبوع";
    } else if (difference.inDays < 365) {
      return "منذ ${difference.inDays ~/ 30} شهر";
    } else {
      return "منذ ${difference.inDays ~/ 365} سنة";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 247, 247, 247),
          borderRadius: BorderRadius.circular(20),
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                        timeAgo(widget.modelAsk.postDate ?? 'Unknown date'),
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
                  widget.modelAsk.questionsText ?? 'No question available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Divider(
                color: Colors.grey,
                thickness: .8,
                endIndent: 15,
                indent: 15,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      // int questionIndex = dummyQuestions.indexOf(modelQuestions);
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          // child: AnserQuestionsScreen(
                          //   // modelQuestions: modelAsk,
                          //   // modelAnswer: dummyAnswer[questionIndex],
                          // ),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.back,
                          color: Color.fromARGB(255, 3, 190, 150),
                        ),
                        Text(
                          '  doctor\'s answer',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 3, 190, 150),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Column(
                    children: [
                      Text(
                        'The Answer',
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        'Dr:Mohamed Elsafty',
                        style: TextStyle(
                          color: Color.fromARGB(255, 3, 190, 150),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        children: [
                          Icon(CupertinoIcons.time, size: 10),
                          Text(
                            ' 8h',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/icons/male-doctor.png',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
