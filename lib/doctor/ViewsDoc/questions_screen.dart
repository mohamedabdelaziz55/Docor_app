import 'package:doctor_app/Screens/Views/edit_ask_screen.dart';
import 'package:doctor_app/doctor/ViewsDoc/HomepageDoc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';
import '../../models/models_patient/model_date_json.dart';
import '../Widgets/custom_questions.dart';

class QuestionsScreenDoc extends StatefulWidget {
  const QuestionsScreenDoc({super.key});

  @override
  State<QuestionsScreenDoc> createState() => _QuestionsScreenDocState();
}

class _QuestionsScreenDocState extends State<QuestionsScreenDoc> {
  Crud _crud = Crud();

  Future<ModelDateJson> getView() async {
    var response = await _crud.postRequest(linkView, {
      "id":  sp.getString("id"),
    });
    return ModelDateJson.fromJson(response);
  }

  Future<void> deleteNote(String noteId) async {
    var response = await _crud.postRequest(linkDelete, {"questions_id": noteId});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => HomepageDoc(),));}, icon: Icon(CupertinoIcons.back)),
        centerTitle: true,
        title: Text("Questions"),),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [
                // const CustomCon(),
                FutureBuilder<ModelDateJson>(
                  future: getView(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData && snapshot.data?.data != null) {
                      var ask = snapshot.data!.data!;
                      if (ask.isEmpty) {
                        return const Center(
                          child: Text('No posts available', style: TextStyle(fontSize: 16)),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: ask.length,
                        itemBuilder: (context, index) {
                          Data noteData = ask[index];
                          return CustomQuestionsDoc(
                            onTapEdit: () {
                              Navigator.pushReplacement(
                                context,
                                PageTransition(
                                  type: PageTransitionType.rightToLeft,
                                  child: EditAskScreen(post: noteData.toJson()),
                                ),
                              );
                            },
                            modelAsk: noteData,
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No data available'));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class CustomCon extends StatelessWidget {
//   const CustomCon({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 270,
//       color: const Color.fromARGB(255, 3, 190, 150),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           IconButton(
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 PageTransition(
//                   type: PageTransitionType.rightToLeft,
//                   child: Homepage(),
//                 ),
//               );
//             },
//             icon: const Icon(CupertinoIcons.back, color: Colors.white, size: 24),
//           ),
//           const SizedBox(height: 22),
//           Row(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Image.asset('assets/images/doctor2.png', height: 200),
//               ),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     'Do you have a medical\n question?',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         PageTransition(
//                           type: PageTransitionType.leftToRight,
//                           child: const AskScreen(),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'Enter your question now',
//                       style: TextStyle(color: Colors.black, fontSize: 18),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
