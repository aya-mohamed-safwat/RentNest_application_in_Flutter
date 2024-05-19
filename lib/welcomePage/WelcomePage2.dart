import 'package:flutter/material.dart';
import 'package:rent_nest_flutter/LOGIN.dart';
import 'package:rent_nest_flutter/welcomePage/WelcomePage3.dart';

class WelcomePage2 extends StatefulWidget {
  const WelcomePage2({Key? key}) : super(key: key);

  @override
  State<WelcomePage2> createState() => _WelcomePage2();
}

class _WelcomePage2 extends State<WelcomePage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Photos/photo2.jpg"),
                fit: BoxFit.cover,
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
                        builder: (context) => const WelcomePage3(),
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