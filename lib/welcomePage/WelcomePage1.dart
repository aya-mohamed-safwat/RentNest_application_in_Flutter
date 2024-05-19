import 'package:flutter/material.dart';
import 'package:rent_nest_flutter/LOGIN.dart';

class WelcomePage1 extends StatefulWidget {
  const WelcomePage1({Key? key}) : super(key: key);

  @override
  State<WelcomePage1> createState() => _WelcomePage1();
}

class _WelcomePage1 extends State<WelcomePage1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF90604C),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Photos/photo4.jpg"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Positioned(
            left: 115,
            bottom: 50,
            child: SizedBox(
              width: 130,
              height: 35,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                      builder: (context) => const login(),
                  ));
                },
                child: Text('Next', style: TextStyle(fontSize: 20,color:Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF90604C),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
            ),
          ),

    Positioned(
    top: 35,
    left:  280,
    child: TextButton(
    onPressed: () {  Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const login(),
        ));
    },
    child: Text('Skip',style: TextStyle(fontSize: 18)),
    style: TextButton.styleFrom(
    foregroundColor: Colors.white,
    ),
    ),
    ),
        ],
      ),
    );
  }
}
