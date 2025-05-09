
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../main.dart';

class ProfileController extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxString number = "".obs;
  RxString age = "".obs;
  RxString address = "".obs;
  RxString gender = "".obs;
  RxString profileImage = "".obs;

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  void loadProfileData() {
    name.value = sp.getString("name") ?? "Unknown Name";
    email.value = sp.getString("email") ?? "";
    number.value = sp.getString("number") ?? "";
    age.value = sp.getString("age") ?? "";
    address.value = sp.getString("address") ?? "";
    gender.value = sp.getString("gender") ?? "";
    profileImage.value = sp.getString("profile_image") ?? "";
  }
}

