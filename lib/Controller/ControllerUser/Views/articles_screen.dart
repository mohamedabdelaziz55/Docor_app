import 'package:get/get.dart';
import '../../../constet.dart';
import '../../../crud.dart';
import '../../../main.dart';
import '../../../models/models_patient/model_doctors.dart';




class ArticlesController extends GetxController {
  final Crud _crud = Crud();
  var articles = <DataArtices>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchArticles();
    super.onInit();
  }

  Future<void> fetchArticles() async {
    try {
      isLoading(true);
      var response = await _crud.postRequest(linkViewArtices, {
        "id": sp.getString("id"),
      });
      var data = ArticesModel.fromJson(response);
      if (data.data != null) {
        articles.value = data.data!;
      } else {
        articles.clear();
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading(false);
    }
  }
}
