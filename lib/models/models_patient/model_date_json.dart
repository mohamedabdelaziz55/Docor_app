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

  Data({this.questionsId, this.questionsText, this.id, this.postDate});

  Data.fromJson(Map<String, dynamic> json) {
    questionsId = json['questions_id'];
    questionsText = json['questions_text'];
    id = json['id'];
    postDate = json['post_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['questions_id'] = this.questionsId;
    data['questions_text'] = this.questionsText;
    data['id'] = this.id;
    data['post_date'] = this.postDate;
    return data;
  }
}