import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constet.dart';
import '../../doctor/ViewsDoc/HomepageDoc.dart';
import '../../doctor/ViewsDoc/articles_doc_screen.dart';
import '../../doctor/ViewsDoc/edit_articles.dart';
import '../../models/models_patient/model_doctors.dart';
import '../../utils.dart';
import '../../crud.dart';
import '../ViewsDoc/artcles.dart';

class CustomCardArticlesDoc extends StatelessWidget {
  CustomCardArticlesDoc({Key? key, required this.dataM}) : super(key: key);

  final DataArtices dataM;
  final Crud _crud = Crud();

  final RxString currentUserId = ''.obs;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getCurrentUserId(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data == null) {
          return const SizedBox();
        }

        final isOwner = dataM.docId == snapshot.data;

        return GestureDetector(
          onTap: () {
            Get.off(() => ArticleDetailsDocScreen(dataArtices: dataM));
          },
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
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
                    height: 250,
                  ),
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
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
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (isOwner)
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert, color: Colors.white),
                            color: Colors.white,
                            onSelected: (value) async {
                              if (value == 'edit') {
                                Get.off(() => EditArticles(article: dataM));
                              } else if (value == 'delete') {
                                _showDeleteConfirmation();
                              }
                            },
                            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'edit',
                                child: Text('Edit Article'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'delete',
                                child: Text('Delete Article'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation() {
    Get.defaultDialog(
      title: 'Delete Article',
      middleText: 'Are you sure you want to delete this article?',
      textCancel: 'No',
      textConfirm: 'Yes',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await deleteArticle(dataM.id.toString(), dataM.imageArticles ?? '');
        Get.off(() => HomepageDoc());
      },
    );
  }

  Future<void> deleteArticle(String articleId, String imageName) async {
    await _crud.postRequest(linkDeleteArtices, {
      "id": articleId,
      "image_articles": imageName,
    });
  }

  Future<String?> _getCurrentUserId() async {
    final sp = await Get.putAsync(() async => await SharedPreferences.getInstance());
    return sp.getString('id');
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
        Icon(icon, color: Colors.white, size: 16),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
