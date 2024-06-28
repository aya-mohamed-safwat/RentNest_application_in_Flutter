
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'SearchResultSumm.dart';

class SearchScreenSumm extends StatefulWidget {
  @override
  State<SearchScreenSumm> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreenSumm> {
  List<Map<dynamic, dynamic>> searchHouses =[];

  List<String> locations = [ 'Sharm El Sheik','new mansoura','marsa matrouh','north cost','Ras El Bar', 'Dahb', 'Alex', 'paltem', 'Marina delta'];
  String? selectedLocation = 'Sharm El Sheik';

  double size = 0.0 ;
  double price =0.0;
  int bedRoom =0;
  int bathRoom =0;
  List<Map<dynamic, dynamic>> responseBody=[];

  double _currentValue = 20;
  double _currentValue2 = 20;

  @override
  Widget build (BuildContext context){

    Future<List<Map<dynamic, dynamic>>> search(String? location , double size , double price ,int bathRoom , int bedRoom ,BuildContext context ) async {
          try {
            final response = await http.get(
              Uri.parse('https://rentnestapi.onrender.com/rentNest/api/searchSummerHousesByFilter?'
                  'location=$location'
                  '&size=$size'
                  '&price=$price'
                  '&bedroomsNum=$bedRoom'
                  '&bathroomsNum=$bathRoom'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
            );

            if (response.statusCode == 200) {
              if (response.headers['content-type']!.toLowerCase().contains(
                  'application/json')) {
                List<dynamic> decodedResponse = jsonDecode(response.body);
                searchHouses = decodedResponse.map((dynamic item) {
                  if (item is Map<dynamic, dynamic>) {
                    return item;
                  } else {
                    return {};
                  }
                }).toList();
              }
            } else {
              print("HTTP Error ${response.statusCode}: ${response.body}");
            }
          } catch (e) {
            print(e.toString());
      }
      print(searchHouses);
          return searchHouses;
    }


return Scaffold(
  body:SingleChildScrollView(

    child: Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
    child: Column(

      mainAxisAlignment: MainAxisAlignment.start ,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(onPressed: (){}, child: Text('Cancel',style: TextStyle(color: Colors.brown),)),
            Text('Search',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
            TextButton(onPressed: (){}, child: Text('Reset',style: TextStyle(color: Colors.brown)))
          ],
        ),
        const SizedBox(
          height: 20.0,
        ),

        Padding(
            padding: const EdgeInsets.symmetric(horizontal:5 ,vertical:10 ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Choose City',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

                )
              ],
            )
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
              icon: Icon(Icons.arrow_drop_down), // Dropdown icon
              iconSize: 25,
              elevation: 10,
              underline: SizedBox(), // Remove the default underline
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
          height:15.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:5 ,vertical:10 ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text('Budget',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0.0'),
                Text('30000')
              ],
            )
          ],
          )
        ),

        Slider(
            activeColor: Colors.brown,
            value: _currentValue,
          max: 30000,
          divisions: 20,
          label: _currentValue.round().toString(),
          onChanged: (double value){
          setState(() {
            _currentValue = value;
            price=value ;
          });
          }
  ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal:5 ,vertical:10 ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bedrooms',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ],
                )
              ],
            )
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bedRoom = 15 ;
                },
                child: Text('Any'),
style: ElevatedButton.styleFrom
  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
, minimumSize: Size(20, 10),
    fixedSize: Size(60, 30),
    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bedRoom=1;
                },
                child: Text(' 1 BR'),style: ElevatedButton.styleFrom
                (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(20, 10),
                  fixedSize: Size(60, 30),
                  textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bedRoom=2;
                },
                child: Text(' 2 BR'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                , minimumSize: Size(20, 10),
                    fixedSize: Size(60, 30),
                    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bedRoom=3;
                },
                child: Text(' 3 BR'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(20, 10),
                  fixedSize: Size(60, 30),
    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
                ),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bedRoom=4;
                },
                child: Text(' 4 BR'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: Size(20, 10),
                    fixedSize: Size(60, 30)
                ,
                textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
              ),
            ),

          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal:5 ,vertical:10 ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bathrooms',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ],
                )
              ],
            )
        ),
        Row(
          children: [

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bathRoom=15;
                },
                child: Text('Any'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    , minimumSize: Size(20, 10),
                    fixedSize: Size(60, 30),
                    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bathRoom=1;
                },
                child: Text(' 1 BR'),style: ElevatedButton.styleFrom
                (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  minimumSize: Size(20, 10),
                  fixedSize: Size(60, 30),
                  textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)
              ),
              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bathRoom=2;
                },
                child: Text(' 2 BR'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
                    , minimumSize: Size(20, 10),
                    fixedSize: Size(60, 30),
    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),

              ),
            ),

            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  bathRoom=3;
                },
                child: Text(' 3 BR'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: Size(20, 10),
                    fixedSize: Size(60, 30),
               textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
                ),
              ),


            Expanded(
              child: ElevatedButton(
                onPressed: () {
                 bathRoom=4;
                },
                child: Text(' 4 BR'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.black, backgroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: Size(20, 10),
                    fixedSize: Size(60, 30)
                    ,
                    textStyle: TextStyle(fontSize: 12,fontWeight: FontWeight.bold)),
              ),
            ),

          ],
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal:5 ,vertical:10 ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Size',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0.0'),
                    Text('1000')
                  ],
                )
              ],
            )
        ),
        Slider(activeColor: Colors.brown,
            value: _currentValue2,
            max: 1000,
            divisions: 20,
            label: _currentValue2.round().toString(),
            onChanged: (double value){
              setState(() {
                _currentValue2 = value;
                size=value;
              });
            }
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
          child: Row( crossAxisAlignment: CrossAxisAlignment.center,
            children: [ Expanded(
              child: ElevatedButton(
                onPressed: () {
                  search(selectedLocation, size, price, bathRoom, bedRoom, context);
                  getSearchResultSumm(searchHouses);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchResultSumm()));
                },
                child: Text('Search'),
                style: ElevatedButton.styleFrom
                  (foregroundColor: Colors.white, backgroundColor: Colors.brown, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    minimumSize: Size(70, 10),
                    fixedSize: Size(70, 50),
                    textStyle: TextStyle(fontSize: 15,fontWeight: FontWeight.bold)

                ),
              ),
            ),
            ],
          ),
        )

      ],

    ),


  ),
  )
);

}
}
