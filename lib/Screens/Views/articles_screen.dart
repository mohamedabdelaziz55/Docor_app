import 'package:doctor_app/Screens/Views/Homepage.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import '../../constet.dart';
import '../../crud.dart';
import '../../main.dart';
import '../../models/models_patient/model_doctors.dart';
import '../Widgets/custom_card_articles.dart';

Uint8List kTransparentImage = Uint8List.fromList([
  137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 68, 65, 84, 8,
  99, 0, 0, 0, 1, 0, 0, 0, 1, 208, 1, 109, 64, 0, 0, 0, 0, 73,
  69, 78, 68, 174, 66, 96, 130,
]);

class ArticlesScreen extends StatefulWidget {
  const ArticlesScreen({Key? key}) : super(key: key);

  @override
  State<ArticlesScreen> createState() => _ArticlesScreenState();
}

class _ArticlesScreenState extends State<ArticlesScreen> {
  Crud _crud = Crud();

  Future<ArticesModel> getView() async {
    var response = await _crud.postRequest(linkViewArtices, {
      "id":  sp.getString("id"),
    });
    return ArticesModel.fromJson(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Articles Page",
          style: TextStyle(color: const Color.fromARGB(255, 3, 190, 150)),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            );
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async{ setState(() {

        }); },
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
