import 'package:doctor_app/models/models_patient/model_date_json.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../../utils.dart';
import '../Views/anser_questions_screen.dart';




class CustomQuestions extends StatelessWidget {
  const CustomQuestions({super.key, required this.modelAsk, this.onTapEdit, this.onTapDelete});

  final Data modelAsk;
  final void Function()? onTapEdit;
  final void Function()? onTapDelete;

  @override
  Widget build(BuildContext context) {
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
                title: const Text('Edit'),
                onTap: onTapEdit,
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: onTapDelete,
              ),
            ],
          );
        },
      );
    }

    final questionText = modelAsk.questionsText ?? 'No content available';
    final postDate = modelAsk.postDate ?? '2023-01-01T00:00:00';

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

            Text(
              questionText,
              maxLines: isExpanded ? null : 3,
              overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              textAlign: TextAlign.right,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),

            if (questionText.length > 100)
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    isExpanded = !isExpanded;
                  },
                  child: Text(
                    isExpanded ? 'Show Less' : 'Read More',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                ),
              ),

            const SizedBox(height: 10),
            const Divider(thickness: 0.6),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    // TODO: Share functionality
                  },
                  icon: const Icon(Icons.share, size: 18, color: Color.fromARGB(255, 3, 190, 150)),
                  label: const Text(
                    'Share',
                    style: TextStyle(color: Color.fromARGB(255, 3, 190, 150)),
                  ),
                ),

                TextButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: AnserQuestionsScreen(modelAsk: modelAsk),
                      ),
                    );
                  },
                  icon: const Icon(CupertinoIcons.chat_bubble_text, size: 18, color: Color.fromARGB(255, 3, 190, 150)),
                  label: const Text(
                    'Comments',
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
