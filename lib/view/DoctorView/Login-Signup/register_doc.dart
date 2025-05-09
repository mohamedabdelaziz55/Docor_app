import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controller/ControllerDoctor/auth/register_doc.dart';
import '../Widgets/Auth_text_field.dart';


class RegisterDoctorStep1 extends StatelessWidget {
  const RegisterDoctorStep1({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterDoctorController());

    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Registration - Step 1')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              Auth_text_field(
                controller: controller.nameController,
                text: 'Enter your name',
                icon: "assets/icons/person.png",
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              Auth_text_field(
                controller: controller.emailController,
                text: 'Enter your Email',
                icon: "assets/icons/email.png",
                validator: (value) => value!.isEmpty ? 'Enter your email' : null,
              ),
              Auth_text_field(
                controller: controller.passwordController,
                text: 'Enter your password',
                icon: "assets/icons/lock.png",
                validator: (value) => value!.isEmpty ? 'Enter your password' : null,
              ),
              Auth_text_field(
                controller: controller.ageController,
                text: 'Enter your age',
                icon: "assets/icons/calendar.png",
                validator: (value) => value!.isEmpty ? 'Enter your age' : null,
              ),
              Auth_text_field(
                controller: controller.phoneController,
                text: 'Enter your phone number',
                icon: "assets/icons/call.png",
                validator: (value) => value!.isEmpty ? 'Enter your phone number' : null,
              ),
              Auth_text_field(
                controller: controller.addressController,
                text: 'Enter your address',
                icon: "assets/icons/location.png",
                validator: (value) => value!.isEmpty ? 'Enter your address' : null,
              ),
              const SizedBox(height: 10),
              Obx(
                    () => DropdownButtonFormField<String>(
                  value: controller.gender.value,
                  items: ['Male', 'Female']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (val) => controller.gender.value = val!,
                  decoration: const InputDecoration(labelText: 'Gender'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: controller.goToNextStep,
                child: const Text('Next'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF03BE96),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
