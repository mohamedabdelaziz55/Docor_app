import 'package:doctor_app/doctor/Login-Signup/register2_doc.dart';
import 'package:flutter/material.dart';

import '../../Screens/Widgets/Auth_text_field.dart';

class RegisterDoctorStep1 extends StatefulWidget {
  const RegisterDoctorStep1({super.key});

  @override
  State<RegisterDoctorStep1> createState() => _RegisterDoctorStep1State();
}

class _RegisterDoctorStep1State extends State<RegisterDoctorStep1> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String gender = "Male";

  final _formKey = GlobalKey<FormState>();

  void goToNextStep() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              RegisterDoctorStep2(
                docName: nameController.text,
                docAge: ageController.text,
                docEmail: emailController.text,
                docPassword: passwordController.text,
                docPhone: phoneController.text,
                gender: gender,
                docAddress: addressController.text,
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Doctor Registration - Step 1')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Auth_text_field(
                controller: nameController,
                text: 'Enter your name',
                icon: "assets/icons/person.png",
                validator: (value) =>
                value!.isEmpty
                    ? 'Enter your name'
                    : null,)
              ,
              // TextFormField(
              //   controller: nameController,
              //   decoration: const InputDecoration(labelText: 'Name'),
              //   validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              // ),

              // TextFormField(
              //   controller: ageController,
              //   decoration: const InputDecoration(labelText: 'Age'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) => value!.isEmpty ? 'Enter your age' : null,
              // ),
              Auth_text_field(
                controller: emailController,
                text: 'Enter your Email',
                icon: "assets/icons/email.png",
                validator: (value) =>
                value!.isEmpty
                    ? 'Enter your email'
                    : null,              ),
              // TextFormField(
              //   controller: emailController,
              //   decoration: const InputDecoration(labelText: 'Email'),
              //   keyboardType: TextInputType.emailAddress,
              //   validator: (value) =>
              //   value!.isEmpty
              //       ? 'Enter your email'
              //       : null,
              // ),
              Auth_text_field(
                controller: passwordController,
                text: 'Enter your password',
                icon: "assets/icons/lock.png",
                validator: (value) =>
          value!.isEmpty
          ? 'Enter your password'
              : null,         ),
              Auth_text_field(
                controller: ageController,
                text: 'Enter your age',
                icon: "assets/icons/calendar.png",
                validator: (value) => value!.isEmpty ? 'Enter your age' : null,
              ),
              // TextFormField(
              //   controller: passwordController,
              //   decoration: const InputDecoration(labelText: 'Password'),
              //   obscureText: true,
              //   validator: (value) =>
              //   value!.isEmpty
              //       ? 'Enter your password'
              //       : null,
              // ),
              Auth_text_field(
                controller: phoneController,
                text: 'Enter your phone number',
                icon: "assets/icons/call.png",
                validator: (value) =>
                value!.isEmpty
                    ? 'Enter your phone number'
                    : null,         ),
              // TextFormField(
              //   controller: phoneController,
              //   decoration: const InputDecoration(labelText: 'Phone Number'),
              //   keyboardType: TextInputType.phone,
              //   validator: (value) =>
              //   value!.isEmpty
              //       ? 'Enter your phone number'
              //       : null,
              // ),
              Auth_text_field(
                controller: addressController,
                text: 'Enter your address',
                icon: "assets/icons/location.png",
                validator: (value) =>
                value!.isEmpty
                    ? 'Enter your address'
                    : null,        ),
              // TextFormField(
              //   controller: addressController,
              //   decoration: const InputDecoration(labelText: 'Address'),
              //   validator: (value) =>
              //   value!.isEmpty
              //       ? 'Enter your address'
              //       : null,
              // ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: gender,
                items: ['Male', 'Female']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (val) => setState(() => gender = val!),
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: goToNextStep,
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
