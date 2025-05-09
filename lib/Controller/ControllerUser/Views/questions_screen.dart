import '../../../constet.dart';
import '../../../crud.dart';
import '../../../main.dart';
import '../../../models/models_patient/model_date_json.dart';
import 'package:get/get.dart';

class QuestionsScreenController extends GetxController {
  Crud _crud = Crud();

  Future<ModelDateJson> getView() async {
    var response = await _crud.postRequest(linkView, {
      "id": sp.getString("id"),
    });
    return ModelDateJson.fromJson(response);
  }

  Future<void> deleteNote(String noteId) async {
    var response = await _crud.postRequest(linkDelete, {"questions_id": noteId});
    return response;
  }
}

