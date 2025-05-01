class ModelsDoctors {
  final String name;
  final String image;
  final int id;
  final String address;
  final double star;
  final String supText;
  final String about;
  // final List<String> categorise;

  ModelsDoctors({
    // required this.categorise,
    required this.about,
    required this.supText,
    required this.name,
    required this.image,
    required this.id,
    required this.address,
    required this.star,
  });
}

class ArticesModel {
  String? status;
  List<DataArtices>? data;

  ArticesModel({this.status, this.data});

  ArticesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <DataArtices>[];
      json['data'].forEach((v) {
        data!.add(DataArtices.fromJson(v));
      });
    }
  }
}
class DataArtices {
  String? id;
  String? docId; // ← doc_id الجديد
  String? writerName;
  String? titleArticles;
  String? articleText;
  String? articleDate;
  String? imageArticles;

  DataArtices({
    this.id,
    this.docId,
    this.writerName,
    this.titleArticles,
    this.articleText,
    this.articleDate,
    this.imageArticles,
  });

  DataArtices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    docId = json['doc_id']; // ← لازم تكون مطابقة لاسم الحقل في الـ JSON
    writerName = json['writer_name'];
    titleArticles = json['title_articles'];
    articleText = json['article_text'];
    articleDate = json['article_date'];
    imageArticles = json['image_articles'];
  }
}
class CommentModel {
  final String comId;
  final String comText;
  final String comDate;
  final String docId;
  final String docName;
  final String docProfile;
  final String askId;

  CommentModel({
    required this.comId,
    required this.comText,
    required this.comDate,
    required this.docId,
    required this.docName,
    required this.docProfile,
    required this.askId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      comId: json['com_id'],
      comText: json['com_text'],
      comDate: json['com_date'],
      docId: json['doc_id'],
      docName: json['doc_name'],
      docProfile: json['doc_profile'],
      askId: json['ask_id'],
    );
  }
}
