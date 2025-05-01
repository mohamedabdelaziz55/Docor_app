import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterStep2 extends StatefulWidget {
  final Map<String, dynamic> previousData;

  RegisterStep2({required this.previousData});

  @override
  _RegisterStep2State createState() => _RegisterStep2State();
}

class _RegisterStep2State extends State<RegisterStep2> {
  TextEditingController specialtyController = TextEditingController();
  TextEditingController clinicPhoneController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController aboutController = TextEditingController();

  bool isLoading = false;

  Future<void> completeRegistration() async {
    setState(() {
      isLoading = true;
    });

    // تجهيز البيانات كلها
    Map<String, dynamic> requestData = {
      ...widget.previousData,
      "specialty": specialtyController.text.trim(),
      "clinic_phone": clinicPhoneController.text.trim(),
      "rate": rateController.text.trim(),
      "about": aboutController.text.trim(),
    };

    var url = Uri.parse('https://yourserver.com/signup.php'); // عدل اللينك هنا
    var response = await http.post(url, body: requestData);

    setState(() {
      isLoading = false;
    });

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      if (responseData['status'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('تم التسجيل بنجاح')),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseData['message'] ?? 'حدث خطأ')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('خطأ في الاتصال بالسيرفر')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('بيانات العيادة')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: specialtyController,
              decoration: InputDecoration(labelText: 'التخصص'),
            ),
            TextField(
              controller: clinicPhoneController,
              decoration: InputDecoration(labelText: 'رقم تليفون العيادة'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: rateController,
              decoration: InputDecoration(labelText: 'التقييم'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: aboutController,
              decoration: InputDecoration(labelText: 'نبذة عنك'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: completeRegistration,
              child: Text('تسجيل'),
            ),
          ],
        ),
      ),
    );
  }
}
