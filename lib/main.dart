import 'package:flutter/material.dart';
import 'package:rent_nest_flutter/welcomePage/WelcomePage2.dart';


void main() {

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {

  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:WelcomePage2(),
     // home:Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

