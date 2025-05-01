class ModelDateJson {
  String? status;
  List<Data>? data;

  ModelDateJson({this.status, this.data});

  ModelDateJson.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Data {
  String? questionsId;
  String? questionsText;
  String? id;
  String? postDate;
  List<Comment>? comments;

  Data({
    this.questionsId,
    this.questionsText,
    this.id,
    this.postDate,
    this.comments,
  });

  Data.fromJson(Map<String, dynamic> json) {
    // تأكد من اسم المفتاح الصحيح هنا:
    questionsId = json['question_id'] ?? json['questions_id'];
    questionsText = json['questions_text'];
    id = json['id'];
    postDate = json['post_date'];

    if (json['comments'] != null) {
      comments = <Comment>[];
      json['comments'].forEach((v) {
        comments!.add(Comment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['question_id'] = this.questionsId;
    data['questions_text'] = this.questionsText;
    data['id'] = this.id;
    data['post_date'] = this.postDate;

    if (comments != null) {
      data['comments'] = comments!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}
class Comment {
  String? id;
  String? questionId;
  String? commentText;
  String? doctorName;
  String? doctorImage;
  String? createdAt;

  Comment({
    this.id,
    this.questionId,
    this.commentText,
    this.doctorName,
    this.doctorImage,
    this.createdAt,
  });

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionId = json['question_id'];
    commentText = json['comment'];
    doctorName = json['doctor_name'];
    doctorImage = json['doctor_image'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['question_id'] = this.questionId;
    data['comment'] = this.commentText;
    data['doctor_name'] = this.doctorName;
    data['doctor_image'] = this.doctorImage;
    data['created_at'] = this.createdAt;
    return data;
  }
}