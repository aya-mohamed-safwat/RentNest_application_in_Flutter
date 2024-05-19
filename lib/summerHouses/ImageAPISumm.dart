
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';
class ImageAPISumm {

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
      request.fields['entity_type'] = "SUMMER_HOUSE";
      request.fields['entity_id'] = "1";

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image uploaded successfully');

      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
      }

  }

  //
  // Future<void> fetchImage(String name) async {
  //   try {
  //
  //     String apiUrl = 'https://rentnest.onrender.com/image/$name';
  //
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //
  //       final Uint8List bytes = response.bodyBytes;
  //
  //       setState(() {
  //         imageBytes = bytes;
  //       });
  //     } else {
  //
  //       print('Failed to fetch image. Status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //
  //     print('Error: $error');
  //   }
  // }



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

}