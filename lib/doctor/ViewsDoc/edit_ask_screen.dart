import 'package:doctor_app/Screens/Views/questions_screen.dart';
import 'package:doctor_app/crud.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import '../../constet.dart';
import '../../main.dart';

class EditAskScreen extends StatefulWidget {
  const EditAskScreen({super.key, this.post});
  final dynamic post; // Ensure the type is correct

  @override
  State<EditAskScreen> createState() => _EditAskScreenState();
}

class _EditAskScreenState extends State<EditAskScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController text = TextEditingController();
  final Crud _crud = Crud();

  Future<void> editPost() async {
    final userId =  sp.getString("id");
    final postId = widget.post != null ? widget.post['questions_id'].toString() : null;
    print("User ID: $userId | Post ID: $postId");

    if (userId == null || text.text.trim().isEmpty || postId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a question and log in first.")),
      );
      return;
    }

    try {
      var response = await _crud.postRequest(linkEdit, {
        "questions_id": widget.post['questions_id'].toString(),
        "questions_text": text.text,
      });

      if (response != null && response["status"] == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Question edited successfully")),
        );
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: QuestionsScreen(),
          ),
        );
        text.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Edit failed. Please try again.")),
        );
      }
    } catch (e) {
      print("Error parsing response: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("There was an error connecting to the server.")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    // Set question text when screen starts
    if (widget.post != null) {
      text.text = widget.post['questions_text'] ?? ''; // Using questions_text
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: QuestionsScreen(),
              ),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Ask Your Question',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 3, 190, 150),
                ),
              ),
              SizedBox(height: 15),
              Text(
                'Please provide as much detail as possible to help us assist you better.',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                maxLines: 6,
                decoration: InputDecoration(
                  hintText: 'Type your question here...',
                  labelText: 'Your Question',
                  labelStyle: TextStyle(color: Colors.black54),
                  contentPadding: EdgeInsets.all(20),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 190, 150),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 3, 190, 150),
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      await editPost();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 3, 190, 150),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 15,
                    ),
                    child: Text(
                      'Publish Question',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromARGB(255, 247, 247, 247),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
