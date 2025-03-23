import 'dart:convert';
import 'package:http/http.dart' as http; // عشان تحول من json => dart
class Crud {
 getRequest(String uri)async{
   try{
     var response = await http.get(Uri.parse(uri));
if(response.statusCode ==200){
  var responseBody = jsonDecode(response.body); // عشان افك ال json
  return responseBody;
}else{
  print("err ${response.statusCode}");
}

   }catch (e){
     print("errCatch${e}");
   }
 }

 postRequest(String uri , Map data)async{
   try{
     var response = await http.post(Uri.parse(uri),body: data);
     if(response.statusCode ==200){
       var responseBody = jsonDecode(response.body); // عشان افك ال json
       return responseBody;
     }else{
       print("err ${response.statusCode}");
     }

   }catch (e){
     print("errCatch${e}");
   }
 }
}