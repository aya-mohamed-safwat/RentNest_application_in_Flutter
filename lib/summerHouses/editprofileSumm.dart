import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rent_nest_flutter/LOGIN.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;

import 'ProfileSumm.dart';

class editprofileSumm extends StatefulWidget {
  @override
  State<editprofileSumm> createState() => _editprofileSummState();
}

class _editprofileSummState extends State<editprofileSumm> {

  Uint8List? image;
  XFile? file;

  Future<Uint8List?> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
     file = await _imagePicker.pickImage(source: source);
    if (file != null) {
      return await file?.readAsBytes();
    }
    print('No Image Selected');
    return null;
  }

  void openImages() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = img;
      });
    }
  }


  Future<dynamic> postImage(Uint8List? byte,String userId,XFile? file) async {

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://rentnestapi.onrender.com/image'),);

    var multipartRequest = http.MultipartFile(
        'image',
        http.ByteStream.fromBytes(byte!),
        byte.length,
        filename:file?.name,
        contentType: MediaType('image', 'jpeg')
    );

    request.files.add(multipartRequest);
    request.fields['userId'] = userId;
    request.fields['entity_type'] = "USER_AVATAR";
    request.fields['entity_id'] = userId;

    var response = await request.send();

    if (response.statusCode == 200) {
     String data = await response.stream.bytesToString();

      print('Image uploaded successfully $data');

       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => ProfileSumm(),
         ),
       );

    } else {
      print('Image upload failed with status: ${response.statusCode}');
    }
  }

  //=============================================================================================

  TextEditingController _nameController = TextEditingController();
   TextEditingController _passwordController = TextEditingController();
   TextEditingController _emailController = TextEditingController();
   TextEditingController _phoneController = TextEditingController();

    int userId = userMap['id'];

  String responseBody = "";

  @override
   void initState() {
     super.initState();
     _nameController.text = userMap['name'];
     _emailController.text = userMap['email'];
     _phoneController.text = userMap['number'];
     _passwordController.text =userMap['password'];
   }

void editProfile(String name , String email,  String number ,String password ,dynamic userId, BuildContext context) async {
    try {
       final response = await http.put(
         Uri.parse('https://rentnestapi.onrender.com/rentNest/api/updateUser/'
             '$userId'),
         body: jsonEncode(<String, String>{
           "name": name,
           "email": email,
           "number": number,
           "password":password ,
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
         if (response.body == "done") {
           userMap['name']=name;
           userMap['email']=email;
           userMap['number']=number;

           print(" Response body: JSON: ${response.body}");


         }
         else {
           print(" Response body: JSON: ${response.body}");
         }
       }
     } catch (e) {
       print(e.toString());
     }
  }

//=====================================================================================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 220,
                      width: 500,
                      color: Colors.brown,
                      child:  Center(
                        child: Text(
                          userMap['name'],
                          style: TextStyle(
                            fontSize: 20.0, // Font size
                            color: Colors.white, // Text color
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
                    ),
                    child: IconButton(onPressed: (){},
                      icon: const Icon(Icons.arrow_back),
                      iconSize: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 140,
                      left: 140,
                      right: 140,
                    ),
                    child: Stack(
                      children: [
                        image != null ?
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: MemoryImage(image!),
                        )
                            :
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: imageBytesSumm.isEmpty
                              ? AssetImage('Photos/profilelogo.png')as ImageProvider<Object>
                              : NetworkImage(imageBytesSumm),

                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              openImages();
                            },
                            icon: const Icon(Icons.add_a_photo),
                            iconSize: 24, // Adjust icon size as needed
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'username',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    // Text above the TextField
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
              // Repeat the Padding widget for the next three TextFields
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Email',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextFormField(
                      controller: _emailController,
                    //  initialValue: email,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'password',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0, horizontal: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Phone',
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextFormField(
                      controller: _phoneController,
                //      initialValue: number,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          postImage(image ,userId.toString(),file);

                          editProfile(_nameController.text.toString() ,_emailController.text.toString() ,
                            _phoneController.text.toString(), _passwordController.text.toString(),userMap['id'], context,);


                        },
                        child: const Text('Save'),
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.brown,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            minimumSize: const Size(70, 10),
                            fixedSize: const Size(70, 50),
                            textStyle: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )

      // The rest of your scaffold body
    );
  }
}

