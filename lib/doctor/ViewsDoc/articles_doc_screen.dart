import 'package:doctor_app/doctor/ViewsDoc/add_articles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:get/get.dart';
import 'dart:typed_data';
import '../../Screens/Widgets/custom_card_articles.dart';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';
import '../../models/models_patient/model_doctors.dart';

Uint8List kTransparentImage = Uint8List.fromList([
  137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 68, 65, 84, 8,
  99, 0, 0, 0, 1, 0, 0, 0, 1, 208, 1, 109, 64, 0, 0, 0, 0, 73,
  69, 78, 68, 174, 66, 96, 130,
]);

class ArticlesDocScreen extends StatefulWidget {
  const ArticlesDocScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesDocScreen> createState() => _ArticlesDocScreenState();
}

class _ArticlesDocScreenState extends State<ArticlesDocScreen> {
  final Crud _crud = Crud();

  Future<ArticesModel> getView() async {
    var response = await _crud.postRequest(linkViewArtices, {
      "id": sp.getString("id"),
    });
    return ArticesModel.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "Articles Page",
          style: TextStyle(color: Color.fromARGB(255, 3, 190, 150)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddArticles());
        },
        child: Icon(CupertinoIcons.plus),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: FutureBuilder<ArticesModel>(
          future: getView(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData && snapshot.data!.data != null) {
              var notes = snapshot.data!.data!;
              return ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  var noteData = notes[index];
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: CustomCardArticles(dataM: noteData),
                  );
                },
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
