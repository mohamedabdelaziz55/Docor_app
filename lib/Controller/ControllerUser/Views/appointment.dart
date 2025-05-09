import 'package:get/get.dart';
import '../../../models/models_patient/model_doctors.dart';

class AppointmentController extends GetxController {
  Rx<ModelsDoctors> doctor = ModelsDoctors(
    about: 'About the doctor...',
    supText: 'Specialization text...',
    name: 'Doctor Name',
    image: 'path_to_image',
    id: 123,
    address: 'Doctor\'s address',
    star: 4.5,
  ).obs; // Rx variable for doctor data
  RxString appointmentDate = 'Wednesday, Jun 23, 2021 | 10:00 AM'.obs; // Rx variable for date
  RxString reason = 'Chest pain'.obs; // Rx variable for reason
  RxDouble consultationFee = 60.0.obs;
  RxDouble adminFee = 1.0.obs;
  RxDouble totalFee = 61.0.obs;
  RxString paymentMethod = 'Visa'.obs;
}

