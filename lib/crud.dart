import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

String _basicAuth = 'Basic ' +
    base64Encode(utf8.encode('elsafty:mohamed55'));

Map<String, String> myheaders = {
  'authorization': _basicAuth
};

class Crud {

  // Get Request
  Future<dynamic> getRequest(String uri) async {
    try {
      var response = await http.get(Uri.parse(uri), headers: myheaders);
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        return responseBody;
      } else {
        print("Error ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Catch Error: $e");
      return null;
    }
  }

  // Post Request without file
  Future<dynamic> postRequest(String uri, Map data) async {
    try {
      var response = await http.post(
        Uri.parse(uri),
        body: data,
        headers: myheaders,
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        if (response.headers['content-type'] != null &&
            response.headers['content-type']!.contains('application/json')) {
          var responseBody = jsonDecode(response.body);
          return responseBody;
        } else {
          print("Unexpected content-type: ${response.headers['content-type']}");
          return null;
        }
      } else {
        print("Error: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Catch Error: $e");
      return null;
    }
  }

  // Post Request with one file
  Future<dynamic> postRequestWithFile(String url, Map data, File file) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      var length = await file.length();
      var stream = http.ByteStream(file.openRead());

      var multipartFile = http.MultipartFile(
        "file",
        stream,
        length,
        filename: basename(file.path),
      );

      request.headers.addAll(myheaders);
      request.files.add(multipartFile);

      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);

      if (myrequest.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${myrequest.statusCode}");
        return null;
      }
    } catch (e) {
      print("Catch Error: $e");
      return null;
    }
  }

  // Post Request with two files (Profile + Card)
  Future<dynamic> postRequestWithTwoFiles(
      String url,
      Map data,
      File? file1,
      File? file2,
      String fieldName1,
      String fieldName2,
      ) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse(url));
      request.headers.addAll(myheaders);

      if (file1 != null) {
        var length1 = await file1.length();
        var stream1 = http.ByteStream(file1.openRead());
        var multipartFile1 = http.MultipartFile(
          fieldName1,
          stream1,
          length1,
          filename: basename(file1.path),
        );
        request.files.add(multipartFile1);
      }

      if (file2 != null) {
        var length2 = await file2.length();
        var stream2 = http.ByteStream(file2.openRead());
        var multipartFile2 = http.MultipartFile(
          fieldName2,
          stream2,
          length2,
          filename: basename(file2.path),
        );
        request.files.add(multipartFile2);
      }

      data.forEach((key, value) {
        request.fields[key] = value;
      });

      var myrequest = await request.send();
      var response = await http.Response.fromStream(myrequest);

      if (myrequest.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print("Error ${myrequest.statusCode}");
        return null;
      }
    } catch (e) {
      print("Catch Error: $e");
      return null;
    }
  }
}
