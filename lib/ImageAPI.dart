
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImageAPI {

  String responseViewHouse="";
  dynamic responseBody = "";

  String generateUniqueFileName(XFile file) {
    var fileName = file.path.split('/').last;
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var uniqueFileName = '$timestamp$fileName';
    return uniqueFileName;
  }


Future<List<dynamic>> fetchImageById(int entityId,String entityType) async {
  List<dynamic> images=[];
  try {
    String apiUrl = 'https://rentnestapi.onrender.com/image/viewByEntityId/$entityId/$entityType';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
       images = jsonDecode(response.body);

    } else {

      print('Failed to fetch image. Status code: ${response.statusCode}');
    }
  } catch (error) {

    print('Error: $error');
  }
  return images;
}

  Future<List<dynamic>> fetchImageByEntityIdAndUserId(int entityId,String entityType, int userId) async {
    List<dynamic> images=[];
    try {
      String apiUrl = 'https://rentnestapi.onrender.com/image/viewByEntityIdAndUserId/$entityId/$entityType/$userId';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        images = jsonDecode(response.body);

      } else {

        print('Failed to fetch image. Status code: ${response.statusCode}');
      }
    } catch (error) {

      print('Error: $error');
    }
    return images;
  }

  Future<String> deleteImages(String imageName) async {
    String responseBody = "";
    try {
      final response = await http.delete(
        Uri.parse('https://rentnestapi.onrender.com/image/deleteImage/$imageName'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        if (response.headers['content-type']!.toLowerCase().contains('application/json')) {
          responseBody = jsonDecode(response.body);
          print("Response body: JSON: $responseBody");
        }
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print("Exception occurred: $e");
    }
    return ("Response body: JSON: $responseBody");
  }

}