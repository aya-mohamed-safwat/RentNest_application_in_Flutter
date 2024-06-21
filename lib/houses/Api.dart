import 'dart:convert';

import 'package:http/http.dart' as http;

class Api{
  Future<List<Map<dynamic, dynamic>>> viewAllHouses() async {
    List<Map<dynamic, dynamic>> gridMap =[];
    try {
      final response = await http.get(
        Uri.parse('https://rentnestapi.onrender.com/rentNest/api/getAllHouses'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        if (response.headers['content-type']!.toLowerCase().contains(
            'application/json')) {
          List<dynamic> decodedResponse = jsonDecode(response.body);
          gridMap = decodedResponse.map((dynamic item) {
            if (item is Map<dynamic, dynamic>) {
              return item;
            } else {
              return {};
            }
          }).toList();
        }
      }
    } catch (e) {
      print(e.toString());
    }
    return gridMap;
  }

  //============================================================================

  Future<List<Map<dynamic, dynamic>>> getUserHouses(int userId)async{
    List<Map<dynamic, dynamic>> userHouses =[{}];
    try {
      final response = await http.get(
        Uri.parse('https://rentnestapi.onrender.com/rentNest/api/getUserHouse/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {

        if (response.headers['content-type']!.toLowerCase().contains(
            'application/json')) {
          List<dynamic> decodedResponse = jsonDecode(response.body);

          userHouses = decodedResponse.map((dynamic item) {
            if (item is Map<dynamic, dynamic>) {
              return item;
            } else {
              return {};
            }
          }).toList();
        }

      }
      else{
        print(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
    }
    return userHouses;
  }

  //============================================================================

  Future<String> deleteItem(int houseId) async {
    String responseBody = "";
    try {
      final response = await http.delete(
        Uri.parse('https://rentnestapi.onrender.com/rentNest/api/deleteHouse/$houseId'),
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