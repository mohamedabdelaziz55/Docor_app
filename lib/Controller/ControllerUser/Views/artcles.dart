import 'package:get/get.dart';
import '../../../models/models_patient/model_doctors.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ArticleDetailsController extends GetxController {
  Rx<DataArtices> dataArtices = Rx<DataArtices>(DataArtices());
  RxDouble fontSize = 18.0.obs;

  final FlutterTts flutterTts = FlutterTts();

  void setArticle(DataArtices article) {
    dataArtices.value = article;
  }

  void speakArticle() async {
    await flutterTts.setLanguage("ar-SA"); // استخدم "en-US" لو المقالة إنجليزي
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(dataArtices.value.articleText ?? 'لا يوجد محتوى');
  }

  void increaseFontSize() {
    fontSize.value += 2;
  }

  void decreaseFontSize() {
    if (fontSize.value > 10) fontSize.value -= 2;
  }

  void resetFontSize() {
    fontSize.value = 18.0;
  }
}
