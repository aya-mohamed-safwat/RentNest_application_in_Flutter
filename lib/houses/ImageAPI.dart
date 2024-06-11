
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
class ImageAPI {

  String responseViewHouse="";
  dynamic responseBody = "";

  String generateUniqueFileName(XFile file) {
    var fileName = file.path.split('/').last;
    var timestamp = DateTime.now().millisecondsSinceEpoch;
    var uniqueFileName = '$timestamp$fileName';
    return uniqueFileName;
  }

  Future<dynamic> postImage(String file, List<XFile>? images) async {

    List<Uint8List> bytes=[] ;
    for(XFile image in images!){
      bytes.add(await image.readAsBytes());
    }

    for(int i = 0; i < bytes.length; i++){
      Uint8List byte = bytes[i];
      //images!.name[i];
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://rentnest.onrender.com/image'),);

      var multipartRequest = http.MultipartFile(
          'image',
          http.ByteStream.fromBytes(byte),
          byte.length,
        filename:file,
          contentType: MediaType('image', 'jpeg')
    );

      request.files.add(multipartRequest);
      request.fields['entity_type'] = "HOUSE";
      request.fields['entity_id'] = "1";

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');

      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
      }

  }


Future<List<dynamic>> fetchImageById(int entityId,String entityType) async {
  List<dynamic> images=[];
  try {
    String apiUrl = 'https://rentnest.onrender.com/image/viewByEntityId/$entityId/$entityType';

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
        Uri.parse('https://rentnest.onrender.com/image/deleteImage/$imageName'),
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