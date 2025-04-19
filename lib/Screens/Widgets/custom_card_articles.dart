import 'package:flutter/material.dart';

import '../Views/articles_screen.dart';

class CustomCardArticles extends StatelessWidget {
  const CustomCardArticles({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 20,
      child: InkWell(
        // onTap:()=>onSelectedMeal(meal),
        splashColor: Colors.blue,
        child: Stack(
          children: [
            FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg/800px-Spaghetti_Bolognese_mit_Parmesan_oder_Grana_Padano.jpg")),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                color: Colors.black87,
                child: Column(
                  children: [
                    Text(
                      "meal.title",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RowItem(
                          icon: Icons.schedule,
                          text: ' 55  min',
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class RowItem extends StatelessWidget {
  const RowItem({super.key, required this.text, required this.icon});

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white,),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
