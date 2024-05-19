import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rent_nest_flutter/Select_property.dart';
import 'houses/Api.dart';
import 'Sign.dart';
import 'text form.dart';


Map<String, dynamic> userMap ={'id': 0, 'name': 'example' ,'email': 'example', 'number': '000' , 'nationalId': '000','password': '000'};

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => LoginState();

}

 class LoginState extends State<login> {


  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Map<String, dynamic> map1 = {'msg': "", 'user': ""};


  dynamic responseBody="";

  void updateText(String newValue) {
    setState(() {
      responseBody = newValue;
    });
  }

  var formKey = GlobalKey<FormState>();
  bool isPassword=true;

  void login(String email, String password ,BuildContext context) async {
    if (formKey.currentState?.validate() != null) {
      if (formKey.currentState!.validate()) {
        try {
          final response = await http.post(
            Uri.parse('https://rentnest.onrender.com/rentNest/api/login'),
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
          );

          if (response.statusCode == 200) {
            if (response.headers['content-type']!.toLowerCase().contains(
                'application/json')) {

               map1= jsonDecode(response.body);
                updateText(map1['msg']);


            }
            if (map1['msg'] == "Login Success") {
              userMap =map1['user'];
              print(userMap);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectProperty(),

              ),
              );
              responseBody = map1['msg'];
              print(map1['msg']);
            }
            else {
              updateText(map1['msg']);
              print(map1['msg']);
              }
          } else {
            updateText(map1['msg']);
           print("HTTP Error ${response.statusCode}: $map1");
          }
        } catch (e) {
          print(e.toString());
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const Text(
                    "Welcome Back",
                    style: TextStyle(
                      color:Colors.black,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "please login to your account",
                    style: TextStyle(
                        color:Colors.brown,
                        fontSize: 10.0,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                  const SizedBox(
                    height:30.0,
                  ),
              MyTextForm(
                controller: _usernameController,
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
                        return "Rentnest@gmail.com";
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
                          return "you should enter your password";
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                      }),
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

                        login(_usernameController.text.toString(),
                          _passwordController.text.toString(),
                          context,);
                      },
                      child: const Text(
                        "LOGIN",
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
                  Row(  mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                     const Text('Don’t have an account ?',
                        style: TextStyle(color: Colors.black ,fontSize: 12.0,),
                      ),
                      const SizedBox(width: 4),
                      TextButton(
                        style: TextButton.styleFrom(textStyle: const TextStyle(color: Color(0xFF90604C), fontSize: 15),),
                          onPressed:(){ Navigator.push(
                              context,
                               MaterialPageRoute(
                                  builder: (context) => const sign()));}
                          , child: const Text('sign up.'))
                       ],
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
