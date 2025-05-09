import 'package:get/get.dart';
import '../../../main.dart';




class ProfileController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var number = ''.obs;
  var age = ''.obs;
  var address = ''.obs;
  var gender = ''.obs;
  var profileImage = ''.obs;

  void loadProfileData() {
    name.value = sp.getString("name") ?? '';
    email.value = sp.getString("email") ?? '';
    number.value = sp.getString("number") ?? '';
    age.value = sp.getString("age") ?? '';
    address.value = sp.getString("address") ?? '';
    gender.value = sp.getString("gender") ?? '';
    profileImage.value = sp.getString("profile_image") ?? '';
  }

  void clearProfile() async {
    await sp.clear();
  }

  @override
  void onInit() {
    loadProfileData();
    super.onInit();
  }
}

