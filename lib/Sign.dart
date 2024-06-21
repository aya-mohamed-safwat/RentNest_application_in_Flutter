import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rent_nest_flutter/Select_property.dart';
import 'package:http/http.dart' as http;
import 'LOGIN.dart';
import 'text form.dart';

class sign extends StatefulWidget {
  const sign({Key? key}) : super(key: key);

  @override
  State<sign> createState() => _signState();
}

class _signState extends State<sign> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nationalController = TextEditingController();
  String responseBody="";

  void updateText(String newValue) {
    setState(() {
      responseBody = newValue;
    });
  }

  var formKey = GlobalKey<FormState>();
  bool isPassword=true;

  @override
  Widget build(BuildContext context) {



    void sign(String email, String password,String name ,String national , String number , BuildContext context) async {
      if (formKey.currentState?.validate() != null) {
        if (formKey.currentState!.validate()) {
          try {
            final response = await http.post(
              Uri.parse('https://rentnestapi.onrender.com/rentNest/api/signUp'),
              body: jsonEncode(<String, String>{
                "name": name,
                "email": email,
                "number": number,
                "nationalId": national,
                "password": password
              }),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            );
            if (response.statusCode == 200) {
              if (response.headers['content-type']!.toLowerCase().contains(
                  'application/json')) {
                responseBody = jsonDecode(response.body);
                updateText(response.body);
                print(" Response body: JSON: $responseBody");
              }
              else if (response.body == "Email is created") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const login(),
                  ),
                );
                updateText(response.body);
                print(" Response body: JSON: ${response.body}");
              }
              else {
                updateText(response.body);
                print(" Response body: JSON: ${response.body}");
              }
            } else {
              updateText(response.body);
              print("HTTP Error ${response.statusCode}: ${response.body}");
            }
          } catch (e) {
            print(e.toString());
          }
        }
      }
    }


    return Scaffold(

      backgroundColor: Colors.white,
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    'sign up',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 350.85,
                    child: Text(
                      'please enter your details',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.47,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  MyTextForm(
                    controller: _nameController,
                    style: TextStyle(
                      color: Color(0xFFE6E6E6),
                      fontSize: 14.47,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0),
                    title: "NAME",
                    keyboard: TextInputType.name,
                    x: Icons.person,
                    validation: (value) {
                      if (value?.isEmpty ??false) {
                        return " NAME must not be empty";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    obscure: false,
                  ),
                  const SizedBox(
                    height:20.0,
                  ),
                  MyTextForm(
                    controller: _emailController,
                    style: TextStyle(
                      color: Color(0xFFE6E6E6),
                      fontSize: 14.47,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0),
                    title: "Email",
                    keyboard: TextInputType.emailAddress,
                    x: Icons.email_outlined,
                    validation: (value) {
                      if (value?.isEmpty ??false) {
                        return " Rentnest@gmail.com";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    obscure: false,
                  ),

                  const SizedBox(
                    height: 20.0,
                  ),

                  MyTextForm(
                      controller: _passwordController,
                      style: TextStyle(
                          color: Color(0xFFE6E6E6),
                          fontSize: 14.47,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0),
                      title: "Password",
                      keyboard: TextInputType.visiblePassword,
                      x: Icons.lock_outline,
                      y:  isPassword? Icons.visibility:Icons.visibility_off ,
                      obscure: isPassword,
                      onPressed: (){
                        setState(() {
                          isPassword=!isPassword;
                        });
                      },
                      validation: (value) {
                        if (value?.isEmpty ??false) {
                          return " password must not be empty";
                        }
                        return null;
                      }),
                    const SizedBox(
                      height: 20.0,
                    ),

                    MyTextForm(
                        style: TextStyle(
                            color: Color(0xFFE6E6E6),
                            fontSize: 14.47,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0),
                        title: "Confirm Password",
                        keyboard: TextInputType.visiblePassword,
                        x: Icons.lock_outline,
                        y:  isPassword? Icons.visibility:Icons.visibility_off ,
                        obscure: isPassword,
                        onPressed: (){
                          setState(() {
                            isPassword=!isPassword;
                          });
                        },
                        validation: (value) {
                          if (value?.isEmpty ??false) {
                            return " password must not be empty";
                          }
                          return null;
                        },
                      onChanged: (value) {
                        print(value);
                      }),
                  const SizedBox(
                    height: 20.0,
                  ),
                  MyTextForm(
                    controller: _phoneController,
                    style: TextStyle(
                    color: Color(0xFFE6E6E6),
                    fontSize: 14.47,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    height: 0),
                title: "phone",
                keyboard: TextInputType.phone,
                x: Icons.phone,
                validation: (value) {
                  if (value?.isEmpty ??false) {
                    return " phone must not be empty";
                  }
                  return null;
                },
                onChanged: (value) {
                  print(value);
                },
                obscure: false,
              ),
              const SizedBox(
                height:20.0,
              ),
                  MyTextForm(
                    controller: _nationalController,
                    style: TextStyle(
                        color: Color(0xFFE6E6E6),
                        fontSize: 14.47,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        height: 0),
                    title: "national id",
                    keyboard: TextInputType.number,
                    x: Icons.perm_identity,
                    validation: (value) {
                      if (value?.isEmpty ??false) {
                        return " national id must not be empty";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      print(value);
                    },
                    obscure: false,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),

                  Text(
                    responseBody,
                    style: TextStyle(
                        color:Colors.brown,
                        fontSize: 13.0,
                        fontWeight: FontWeight.normal
                    ),
                  ),

                  const SizedBox(
                    height:20.0,

                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF90604C),
                      borderRadius: BorderRadius.circular(80),
                    ),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        sign(_emailController.text.toString() , _passwordController.text.toString() , _nameController.text.toString() ,
                            _nationalController.text.toString() ,_phoneController.text.toString(), context,);

                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
