
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
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
    loadUserData();
  }

  Future<void> loadUserData() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    name.value = sp.getString("name") ?? "";
    email.value = sp.getString("email") ?? "";
    number.value = sp.getString("phone") ?? "";
    age.value = sp.getString("age") ?? "";
    address.value = sp.getString("address") ?? "";
    gender.value = sp.getString("gender") ?? "";
    profileImage.value = sp.getString("profile_image") ?? "";
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = image.path;
      final SharedPreferences sp = await SharedPreferences.getInstance();
      await sp.setString("profile_image", image.path);
    }
  }
}
