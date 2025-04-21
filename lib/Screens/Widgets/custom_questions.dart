import 'package:doctor_app/Screens/Views/anser_questions_screen.dart';
import 'package:doctor_app/models/models_patient/model_date_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../../utils.dart';

class CustomQuestions extends StatefulWidget {
  const CustomQuestions({super.key, required this.modelAsk, this.onTapEdit, this.onTapDelete});

  final Data modelAsk;
final void Function()? onTapEdit;
final void Function()? onTapDelete;
  @override
  _CustomQuestionsState createState() => _CustomQuestionsState();
}

class _CustomQuestionsState extends State<CustomQuestions> {
  bool isExpanded = false;

  void _showMenuOptions() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (_) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text('تعديل'),
              onTap: widget.onTapEdit,
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('حذف'),
              onTap:  widget.onTapDelete
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionText = widget.modelAsk.questionsText ?? 'لا يوجد محتوى';
    final postDate = widget.modelAsk.postDate ?? '2023-01-01T00:00:00';

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row (Time + Menu)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(CupertinoIcons.time, color: Colors.grey.shade600, size: 18),
                    const SizedBox(width: 4),
                    Text(
                      timeAgo(postDate),
                      style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                    ),
                  ],
                ),
                InkWell(
                  onTap: _showMenuOptions,
                  child: const Icon(Icons.more_vert, size: 20),
                )
              ],
            ),

            const SizedBox(height: 10),

            /// Question Text
            Text(
              questionText,
              maxLines: isExpanded ? null : 3,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),

            /// Read More
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
                      fontSize: 13,
                      color: Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 10),
            const Divider(thickness: 0.6),

            /// Bottom Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// Share
                TextButton.icon(
                  onPressed: () {
                    // TODO: Share functionality
                  },
                  icon: const Icon(Icons.share, size: 18, color: Color.fromARGB(255, 3, 190, 150)),
                  label: const Text(
                    'مشاركة',
                    style: TextStyle(color: Color.fromARGB(255, 3, 190, 150)),
                  ),
                ),

                /// Comments
                TextButton.icon(
                  onPressed: () {
                    // TODO: Navigate to comments section
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:  AnserQuestionsScreen(modelAsk: widget.modelAsk,), // Replace with comment screen
                      ),
                    );
                  },
                  icon: const Icon(CupertinoIcons.chat_bubble_text, size: 18, color: Color.fromARGB(255, 3, 190, 150)),
                  label: const Text(
                    'تعليقات',
                    style: TextStyle(color: Color.fromARGB(255, 3, 190, 150)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
