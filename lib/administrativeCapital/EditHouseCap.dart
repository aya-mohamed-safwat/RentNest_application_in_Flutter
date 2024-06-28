import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../text form.dart';
import 'package:http/http.dart' as http;
import '../ImageAPI.dart';
import 'ProfileCap.dart';

ImageAPI imageapiCap =new ImageAPI();

Map<dynamic , dynamic> dataCap={};
void getHouseToUpdateCap(Map<dynamic , dynamic> getData){
  dataCap =getData ;
}

String bathroom =dataCap['bathroomsNum'].toString();
String bedroom =dataCap['bedroomsNum'].toString();
String location =dataCap['location'].toString();
int houseId =dataCap['capitalHouseId'];


class EditHouseCap extends StatefulWidget {
  @override
  _EditHouseCapState createState() => _EditHouseCapState();
}

class _EditHouseCapState extends State<EditHouseCap> {


  late final PageController pageController;
  final ScrollController _scrollController = ScrollController();
  int pageNo = 0;

  Timer? carasouelTmer;

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 2), (timer) {
      if (pageNo == 5) {
        pageNo = 0;
      }
      pageController.animateToPage(
        pageNo,
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOutCirc,
      );
      pageNo++;
    });
  }

  List<String> locations = [  'R1', ' R2', ' R3', ' R4','R5', 'R6', 'R7', 'R8'];
  String? selectedLocation = location;
  bool _lights = true;

  final TextEditingController _price = TextEditingController();
  final TextEditingController _size = TextEditingController();
  final TextEditingController _description = TextEditingController();

  @override
  void initState() {
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {});
      } else {
        setState(() {});
      }
    });

    super.initState();
    _size.text = dataCap['size'].toString();
    _price.text = dataCap['price'].toString();
    _description.text = dataCap['description'].toString();
    selectedLocation = dataCap['location'].toString();
    bedRoom = int.parse(dataCap['bedroomsNum'].toString());
    bathRoom = int.parse(dataCap['bathroomsNum'].toString());
    _lights =bool.parse(dataCap['availability'].toString());
  }

  int bedRoom =int.parse(bedroom);
  int bathRoom =int.parse(bathroom);

  Map<String, dynamic> responseBody={};

  //==========================================================================

  void editItem(String? location , double size , double price ,int bathRoom
      , int bedRoom ,String description , int houseId ,BuildContext context ) async {
    try {
      final response = await http.put(
        Uri.parse('https://rentnestapi.onrender.com/rentNest/api/updateCapitalHouse/$houseId'),
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileCap(),
          ),
        );
      } else {
        print("HTTP Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print(e.toString());
    }
  }
//===============================================================================

  @override
  Widget build(BuildContext context) {

return SafeArea(
  child: Scaffold(
    body: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          const SizedBox(
            height: 2.0,
          ),

          SizedBox(
            height: 200,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                pageNo = index;
                setState(() {});

              },
              itemBuilder: (_, index) {

                return AnimatedBuilder(
                  animation: pageController,
                  builder: (ctx, child) {
                    return child!;
                  },

                  child: Container(
                    margin: const EdgeInsets.only(
                      right: 8, left: 8, top: 18, ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey.shade300,
                    ),
                    child: Image.network(ImagesForEditingCap[index],
                      fit: BoxFit.fitWidth,

                    ) ,
                  ),);

              },
              itemCount: ImagesForEditingCap.length,
            ),
          ),
          const SizedBox(
            height: 20.0,
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
                onPressed:(){
                  editItem(
                    selectedLocation,
                    double.parse(_size.text),
                    double.parse(_price.text),
                    bathRoom,
                    bedRoom,
                    _description.text.toString(),
                    houseId,
                    context,
                  );
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
      ),
    );
  }
}