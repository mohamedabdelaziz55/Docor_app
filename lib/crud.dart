import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http; // عشان تحول من json => dart
import 'package:path/path.dart';


String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode(
        'elsafty:mohamed55'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};

class Crud {
  getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body); // عشان افك ال json
        return responseBody;
      } else {
        print("err ${response.statusCode}");
      }
    } catch (e) {
      print("errCatch${e}");
    }
  }

  postRequest(String uri, Map data) async {
    try {
      var response = await http.post(Uri.parse(uri), body: data , headers: myheaders);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body); // عشان افك ال json
        return responseBody;
      } else {
        print("err ${response.statusCode}");
      }
    } catch (e) {
      print("errCatch${e}");
    }
  }


  postRequestWithFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.headers.addAll(myheaders) ;
    request.files.add(multipartFile);
    data.forEach((key, value) {
      request.fields[key] = value ;
    });
    var myrequest = await request.send();

    var response = await http.Response.fromStream(myrequest) ;
    if (myrequest.statusCode == 200){
      return jsonDecode(response.body) ;
    }else {
      print("Error ${myrequest.statusCode}") ;
    }
  }
}
