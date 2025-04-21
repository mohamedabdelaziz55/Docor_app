import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../constet.dart';
import '../../models/models_patient/model_doctors.dart';
import '../../utils.dart';
import '../Views/artcles.dart';
import '../Views/articles_screen.dart';

class CustomCardArticles extends StatelessWidget {
  const CustomCardArticles({Key? key, required this.dataM}) : super(key: key);

  final DataArtices dataM;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: ArticleDetailsScreen(dataArtices: dataM),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage("$imageRoot/${dataM.imageArticles}"),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 250, // تم التعديل هنا
          ),
          Container(
            height: 250, // تم التعديل هنا كمان
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            right: 16,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dataM.titleArticles ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                RowItem(
                  icon: Icons.schedule,
                  text: timeAgo(dataM.articleDate ?? '2023-01-01T00:00:00'),
                ),
              ],
            ),
          ),
        ],
      ),
    ),

      ),
    );
  }
}

class RowItem extends StatelessWidget {
  const RowItem({Key? key, required this.text, required this.icon}) : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}