import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Controller/ControllerDoctor/auth/register2_doc.dart';



class RegisterDoctorStep2 extends StatelessWidget {
  final String docName, docAge, docEmail, docPassword, docPhone, gender, docAddress;

  const RegisterDoctorStep2({
    super.key,
    required this.docName,
    required this.docAge,
    required this.docEmail,
    required this.docPassword,
    required this.docPhone,
    required this.gender,
    required this.docAddress,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterDoctorStep2Controller>(
      init: RegisterDoctorStep2Controller()
        ..setData(
          name: docName,
          age: docAge,
          email: docEmail,
          password: docPassword,
          phone: docPhone,
          g: gender,
          address: docAddress,
        ),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Doctor Registration - Step 2')),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              children: [
                TextFormField(
                  controller: controller.specialtyController,
                  decoration: const InputDecoration(labelText: 'Specialty'),
                ),
                TextFormField(
                  controller: controller.aboutController,
                  decoration: const InputDecoration(labelText: 'About You'),
                  maxLines: 4,
                ),
                TextFormField(
                  controller: controller.clinicPhoneController,
                  decoration: const InputDecoration(labelText: 'Clinic Phone'),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.showImageSourceActionSheet(true, context),
                        icon: const Icon(Icons.person),
                        label: const Text("Profile Image"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => controller.showImageSourceActionSheet(false, context),
                        icon: const Icon(Icons.credit_card),
                        label: const Text("License Card"),
                      ),
                    ),
                  ],
                ),
                if (controller.profileImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(controller.profileImage!, height: 100),
                  ),
                if (controller.licenseImage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(controller.licenseImage!, height: 100),
                  ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: controller.isLoading ? null : () => controller.registerDoctor(context),
                    child: controller.isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Complete Registration"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF03BE96),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

