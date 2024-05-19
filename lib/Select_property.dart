import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rent_nest_flutter/summerHouses/bottom_navbar_Summ.dart';
import 'package:rent_nest_flutter/universalHousing/bottom_navbar_Uni.dart';
import 'administrativeCapital/bottom_navbar_Cap.dart';
import 'houses/bottom_navbar.dart';

class SelectProperty extends StatefulWidget {
  const SelectProperty({Key? key}) : super(key: key);

  @override
  _SelectPropertyState createState() => _SelectPropertyState();
}

class _SelectPropertyState extends State<SelectProperty> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
        child: Padding(
        padding: const EdgeInsets.all(35.0),
    child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Select Property",
                style: TextStyle(
                    color:Colors.brown,
                    fontSize: 38.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 80),

             Container(
               child: ElevatedButton(
                 onPressed: () {
                   Navigator.push(
                       context,
                       MaterialPageRoute(
                       builder: (context) => bottomnavbarCap(),
                       ),
                   );
                 },
                 child: Text('Administrative Capital', style:TextStyle(fontSize: 20, color: Colors.white)),
                 style: ElevatedButton.styleFrom(
                     minimumSize: Size(240, 50), backgroundColor: Color(0xFF90604C),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(40),
                     )
                 ),
               ),
             ),
             SizedBox(height: 50),
          Container(
          child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => bottomnavbar(),
              ),
            );
           },
          child: Text('Houses' , style:TextStyle(fontSize: 23, color: Colors.white)),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(240, 50), backgroundColor: Color(0xFF90604C),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),

          )
    ),
    ),
          ),
             SizedBox(height: 50),

             Container(
               child: ElevatedButton(
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => bottomnavbarSumm(),
                     ),
                   );
                 },
                 child: Text('Summer Houses', style:TextStyle(fontSize: 20, color: Colors.white)),
                 style: ElevatedButton.styleFrom(
                     minimumSize: Size(240, 50), backgroundColor: Color(0xFF90604C),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(40),
                     )
                 ),
               ),
             ),
             SizedBox(height: 50),

             Container(
               child: ElevatedButton(
                 onPressed: () {
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => bottomnavbarUni(),
                     ),
                   );
                 },
                 child: Text('Universal Housing', style:TextStyle(fontSize: 20 , color: Colors.white)),
                 style: ElevatedButton.styleFrom(
                     minimumSize: Size(240, 50), backgroundColor: Color(0xFF90604C),
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(40),
                     )
                 ),
               ),
             ),
    ],
    ),
        ),
    ),
        ),
    );
  }
}

