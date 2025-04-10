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
  bool isExpanded = false;

  String timeAgo(String dateTime) {
    try {
      DateTime postDate = DateTime.parse(dateTime);
      final Duration difference = DateTime.now().difference(postDate);

      if (difference.inSeconds < 60) {
        return "Just now";
      } else if (difference.inMinutes < 60) {
        return " ${difference.inMinutes} minute(s)";
      } else if (difference.inHours < 24) {
        return "${difference.inHours} hour(s)";
      } else if (difference.inDays < 7) {
        return "${difference.inDays} day(s)";
      } else if (difference.inDays < 30) {
        return "${difference.inDays ~/ 7} week(s)";
      } else if (difference.inDays < 365) {
        return "${difference.inDays ~/ 30} month(s)";
      } else {
        return ""
            " ${difference.inDays ~/ 365} year(s)";
      }
    } catch (_) {
      return "Unknown time";
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.modelAsk.questionsText ?? 'No question available';
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 247, 247, 247),
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
                      Icon(CupertinoIcons.time, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        timeAgo(widget.modelAsk.postDate ?? '2023-01-01T00:00:00'),
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
              const Divider(
                color: Colors.grey,
                thickness: .4,
                endIndent: 15,
                indent: 15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    questionText,
                    maxLines: isExpanded ? null : 3,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
              if (questionText.length > 100)
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? 'إظهار أقل' : 'اقرأ المزيد',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 3, 190, 150),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 15),
              const Divider(
                color: Colors.grey,
                thickness: .8,
                endIndent: 15,
                indent: 15,
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const Placeholder(), // Replace with real screen
                        ),
                      );
                    },
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.back,
                          color: Color.fromARGB(255, 3, 190, 150),
                        ),
                        SizedBox(width: 4),
                        Text(
                          'doctor\'s answer',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color.fromARGB(255, 3, 190, 150),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
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
                          SizedBox(width: 4),
                          Text(
                            '8h',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/icons/male-doctor.png'),
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

//
//
// ---------------------------------------------
// import 'package:doctor_app/models/models_patient/model_date_json.dart';
// import 'package:flutter/material.dart';
//
// class CustomQuestions extends StatefulWidget {
//   const CustomQuestions({super.key, required this.modelAsk});
//   final Data modelAsk;
//   @override
//   State<CustomQuestions> createState() => _CustomQuestionsState();
// }
//
// class _CustomQuestionsState extends State<CustomQuestions> {
//   bool isExpanded = false; // ← لتوسيع أو تقليص النص
//
//   String timeAgo(String dateTime) {
//     DateTime postDate = DateTime.parse(dateTime);
//     final Duration difference = DateTime.now().difference(postDate);
//
//     if (difference.inSeconds < 60) {
//       return "Just now";
//     } else if (difference.inMinutes < 60) {
//       return "Since ${difference.inMinutes} minute(s)";
//     } else if (difference.inHours < 24) {
//       return "Since ${difference.inHours} hour(s)";
//     } else if (difference.inDays < 7) {
//       return "Since ${difference.inDays} day(s)";
//     } else if (difference.inDays < 30) {
//       return "Since ${difference.inDays ~/ 7} week(s)";
//     } else if (difference.inDays < 365) {
//       return "Since ${difference.inDays ~/ 30} month(s)";
//     } else {
//       return "Since ${difference.inDays ~/ 365} year(s)";
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final questionText = widget.modelAsk.questionsText ?? 'No question available';
//
//     return Padding(
//       padding: const EdgeInsets.all(12.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color.fromARGB(255, 247, 247, 247),
//           borderRadius: BorderRadius.circular(20),
//         ),
//         width: double.infinity,
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               // ... باقي العناصر زي ما هي
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: [
//                     Text(
//                       questionText,
//                       textAlign: TextAlign.center,
//                       maxLines: isExpanded ? null : 3, // ← عرض 3 أسطر فقط
//                       overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                       ),
//                     ),
//                     if (questionText.length > 100) // ← لو النص طويل
//                       TextButton(
//                         onPressed: () {
//                           setState(() {
//                             isExpanded = !isExpanded;
//                           });
//                         },
//                         child: Text(
//                           isExpanded ? 'إظهار أقل' : 'اقرأ المزيد',
//                           style: TextStyle(
//                             color: Color.fromARGB(255, 3, 190, 150),
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                   ],
//                 ),
//               ),
//               // ... باقي الكود زي ما هو
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
