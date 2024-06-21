import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import '../LOGIN.dart';
import '../text form.dart';
import 'package:http/http.dart' as http;

import 'ProfileCap.dart';

Map <String,dynamic> houseResponseCap ={'location': "", 'size': 0.0, 'bedroomsNum': 0,
  'bathroomsNum': 0, 'price': 0.0, 'availability': true, 'description':"" , 'houseId': 0};

class ImagePickerDemoCap extends StatefulWidget {
  @override
  _ImagePickerDemoState createState() => _ImagePickerDemoState();
}

class _ImagePickerDemoState extends State<ImagePickerDemoCap> {

  List<String> locations = [ 'Sharm El Sheik', 'Ras El Bar', 'Dahb', 'Alex', 'paltem', 'Marina delta'];
  String? selectedLocation = 'Sharm El Sheik';
  bool _lights = true;

  final TextEditingController _price = TextEditingController();
  final TextEditingController _size = TextEditingController();
  final TextEditingController _description = TextEditingController();

  int bedRoom =0;
  int bathRoom =0;
  int userId =userMap['id'];
  Map<String, dynamic> responseBody={};


  final picker = ImagePicker();
  List<XFile>? images ;
  bool showSpinner = false ;


  Future<void> openImages() async {
    try {
      var pickedfiles = await picker.pickMultiImage();
      if (pickedfiles != null) {
        images = pickedfiles;
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("Error while picking files: $e");
    }
  }
  //==========================================================================

  Future addItem(String? location , double size , double price ,int bathRoom
      , int bedRoom ,String description , int userId ,BuildContext context ) async {
    try {
      final response = await http.post(
        Uri.parse('https://rentnestapi.onrender.com/rentNest/api/addCapitalHouse/$userId'),
        body: jsonEncode(<String, dynamic>{
          "location": location,
          "size": size,
          "bedroomsNum": bedRoom,
          "bathroomsNum": bathRoom,
          "price": price,
          "availability": _lights,
          "description": description
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        if (response.headers['content-type']!.toLowerCase().contains(
            'application/json')) {
          responseBody = jsonDecode(response.body);
          print(" Response body: JSON: $responseBody");
        }

          houseResponseCap =responseBody;


        return houseResponseCap['capitalHouseId'];
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
    return houseResponseCap['capitalHouseId'];
  }
//===============================================================================

  Future<dynamic> postImage(List<XFile>? images,String imageId, String userId) async {

    List<Uint8List> bytes=[] ;
    List<dynamic> name=[] ;
    for(XFile image in images!){
      bytes.add(await image.readAsBytes());
      name.add(image.name);
    }
    for(int i = 0; i < bytes.length; i++){
      Uint8List byte = bytes[i];
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://rentnestapi.onrender.com/image'),);

      var multipartRequest = http.MultipartFile(
          'image',
          http.ByteStream.fromBytes(byte),
          byte.length,
          filename:name[i],
          contentType: MediaType('image', 'jpeg')
      );

      request.files.add(multipartRequest);
      request.fields['userId'] = userId;
      request.fields['entity_type'] = "CAPITAL_HOUSE";
      request.fields['entity_id'] = imageId;

      var response = await request.send();

      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileCap(),
          ),
        );
        print('Image uploaded successfully');

      } else {
        print('Image upload failed with status: ${response.statusCode}');
      }
    }

  }

//================================================================
  @override
  Widget build(BuildContext context) {

return SafeArea(
  child: Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          images != null
              ? Wrap(
            children: images!.map((imageone) {
              return Container(
                child: Card(
                  child: Container(
                    height: 100,
                    width: 100,
                    child: images == null
                        ? Center(child: const Text('No image selected' ))
                        : Image.file(File(imageone.path)!),
                    // child: Image.file(File(imageone.path)),
                  ),
                ),
              );
            }).toList(),
          )
              : Container(),

          const SizedBox(
            height: 10.0,
          ),
          Container(
            width: 300,
            height: 40,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  value: selectedLocation,
                  icon: const Icon(Icons.arrow_drop_down), // Dropdown icon
                  iconSize: 25,
                  elevation: 10,
                  underline: const SizedBox(), // Remove the default underline
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedLocation = newValue;
                    });
                  },
                  items: locations.map<DropdownMenuItem<String>>((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Padding(
                padding: EdgeInsets.only(left:20  ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bedrooms',style: TextStyle(color: Color(0xFF90604C),fontWeight: FontWeight.bold,fontSize: 20),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      ],
                    )
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bedRoom=1;
                      },
                      style: ElevatedButton.styleFrom
                        (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                          , minimumSize: const Size(20, 10),
                          fixedSize: const Size(60, 30),
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      child: const Text('1BR'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bedRoom=2;
                      },style: ElevatedButton.styleFrom
                      (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        minimumSize: const Size(20, 10),
                        fixedSize: const Size(60, 30),
                        textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      child: const Text('2BR'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bedRoom=3;
                      },
                      style: ElevatedButton.styleFrom
                        (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                          , minimumSize: const Size(20, 10),
                          fixedSize: const Size(60, 30),
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      child: const Text('3BR'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bedRoom=4;
                      },
                      style: ElevatedButton.styleFrom
                        (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(20, 10),
                          fixedSize: const Size(60, 30),
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
                      ),
                      child: const Text('4BR'),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(left:20 ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bathrooms',style: TextStyle(color: Color(0xFF90604C),fontWeight: FontWeight.bold,fontSize: 20),),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      ],
                    )
                  ],
                )
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20 , right: 20),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bathRoom =1;
                      },style: ElevatedButton.styleFrom
                      (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                        minimumSize: const Size(20, 10),
                        fixedSize: const Size(60, 30),
                        textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      child: const Text('1BR'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bathRoom =2;
                      },
                      style: ElevatedButton.styleFrom
                        (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                          , minimumSize: const Size(20, 10),
                          fixedSize: const Size(60, 30),
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      child: const Text('2BR'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bathRoom =3;
                      },
                      style: ElevatedButton.styleFrom
                        (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(20, 10),
                          fixedSize: const Size(60, 30),
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
                      ),
                      child: const Text('3BR'),
                    ),
                  ),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        bathRoom =4;
                      },
                      style: ElevatedButton.styleFrom
                        (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(20, 10),
                          fixedSize: const Size(60, 30)
                          ,
                          textStyle: const TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                      child: const Text('4BR'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15.0,
            ),
            SizedBox(
              width: 300,
              height: 50,
            child: MyTextForm(
              controller: _size,
              style: const TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14.47,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0),
              title: "Area",
              keyboard: TextInputType.number,
              x: Icons.home_filled,
              validation: (value) {
                if (value?.isEmpty ??false) {
                  return " you must write the area of your property!";
                }
                return null;
              },
              onChanged: (value) {
                print(value);
              },
              obscure: false,
            ),),
                 const SizedBox(
                  height: 15.0,
                ),
            SizedBox(
              width: 300,
              height: 50,
              child: MyTextForm(
                controller: _price,
              style: const TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14.47,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0),
              title: "Price",
              keyboard: TextInputType.number,
              x: Icons.monetization_on,
              validation: (value) {
                if (value?.isEmpty ??false) {
                  return " must not be empty";
                }
                return null;
              },
              onChanged: (value) {
                print(value);
              },
              obscure: false,
            ),),
               const SizedBox(
                height: 15.0,
              ),
            SizedBox(
              width: 300,
              height: 50,
              child: MyTextForm(
                controller: _description,
              style: const TextStyle(
                  color: Color(0xFFE6E6E6),
                  fontSize: 14.47,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  height: 0
              ),
              title: "Description",
              keyboard: TextInputType.name,
              x: Icons.info,
              validation: (value) {
                if (value?.isEmpty ??false) {
                  return " must not be empty";
                }
                return null;
              },
              onChanged: (value) {
                print(value);
              },
              obscure: false,
            ),),
            const SizedBox(
              height: 15.0,
            ),
            const Text("availability",
              style: TextStyle(
                  color: Color(0xFF90604C),
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
            CupertinoSwitch(
                value: _lights,
                onChanged: (bool value){
                  setState(() {
                    _lights = value;
                  });
                }
            ),
            const SizedBox(
              height: 15.0,
            ),
           Container(
              decoration: BoxDecoration(
                color: Color(0xFF90604C),
                borderRadius: BorderRadius.circular(80),
              ),
              width: 200,
              child: MaterialButton(
                onPressed: () async {
                  try {
                    var houseId = await addItem(
                      selectedLocation,
                      double.parse(_size.text),
                      double.parse(_price.text),
                      bathRoom,
                      bedRoom,
                      _description.text.toString(),
                      userId,
                      context,
                    );
                    print(houseId);

                    if (houseId != null) {
                      postImage(images, houseId.toString(),userId.toString());
                      print("House added with ID: $houseId");
                    } else {
                      print("addItem returned null");
                    }
                  } catch (e) {
                    print("Error: $e");
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: openImages,
          tooltip: 'Pick Image',
          backgroundColor: Colors.white,
          child: Icon(
            Icons.add_a_photo,
            color: Colors.brown,
            size: 30,
          ),
        ),
      ),
    );
  }
}