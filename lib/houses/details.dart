import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rent_nest_flutter/houses/Home.dart';

import '../ImageAPI.dart';


ImageAPI imageApi =new ImageAPI();


Map<dynamic , dynamic> data={};
Map<dynamic , dynamic> userInfo={};
void getData(Map<dynamic , dynamic> getData){
  data =getData ;
  userInfo=data['user'];
  print("data= $userInfo");
}


class details extends StatefulWidget {
  const details({super.key});

  @override
  State<details> createState() => _detailsState();
}

class _detailsState extends State<details> {

  String bathroom =data['bathroomsNum'].toString();
  String bedroom =data['bedroomsNum'].toString();
  String size =data['size'].toString();
  String price =data['price'].toString();

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
  bool isSwitched = true;
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
  }



  @override
  Widget build(BuildContext context) {

   return Scaffold(body: SingleChildScrollView(
   controller: _scrollController,
   child: Column(
       children: [
         Padding(
           padding: const EdgeInsets.only(right: 340,
           top: 20),
             child: IconButton(
               icon: Icon(Icons.arrow_back,color: Colors.brown,size: 30,),
               onPressed: () {
                 Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Home()));
               },
             ),
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
    child: Image.network(fetchedImages[index],
    fit: BoxFit.fitWidth,

    ) ,
    ),);

    },
    itemCount: fetchedImages.length,
    ),
    ),
    const SizedBox(
    height: 15.0,),
         Padding(
          padding: EdgeInsets.only(right: 50,top: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Description',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
              ),
               Text(data['description'],style: TextStyle(fontSize: 18)),
            ],
          ),
        ),
         Divider(),
        Padding(
           padding: EdgeInsets.only(right:150,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Bedrooms',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(bathroom,style: TextStyle(fontSize: 18)),
             ],
           ),
         ),
         Divider(),
          Padding(
           padding: EdgeInsets.only(right: 150,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Bathrooms',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(bedroom,style: TextStyle(fontSize: 18)),
             ],
           ),
         ),
         Divider(),
         Padding(
           padding: EdgeInsets.only(right:80,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Location',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(data['location'],style: TextStyle(fontSize: 18)),
             ]
           ),
         ),
         Divider(),

          Padding(
           padding: EdgeInsets.only(right:290,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Area',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(size,style: TextStyle(fontSize: 18)),
             ],
           ),
         ),
         Divider(),
          Padding(
           padding: EdgeInsets.only(right:250,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Price',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(price,style: TextStyle(fontSize: 18)),
             ],
           ),
         ),

         Divider(),
          Padding(
           padding: EdgeInsets.only(right:200,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Owend by',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(userInfo['name'],style: TextStyle(fontSize: 18)),
             ],
           ),
         ),
         Divider(),
         Padding(
           padding: EdgeInsets.only(right:200,top: 30),
           child: Column(
             children: [
               Align(
                 alignment: Alignment.centerLeft,
                 child: Text('Phone number',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               ),
               Text(userInfo['number'].toString(),style: TextStyle(fontSize: 18)),
             ],
           ),
         ),
         Divider(),
         Padding(
           padding: const EdgeInsets.only(right: 220,top: 30),
           child: Column(
             children: [
               Text('Availability',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.brown,),),
               Switch(
                 value: isSwitched,
                 onChanged: (value) {
                   setState(() {
                     isSwitched = value;
                     // Perform actions based on switch state change
                   });
                 },
                 activeColor: Colors.brown,
               ),
             ],
           ),
         ),
         Divider(),
         Divider(),
         Divider(),
         Divider(),


   ])));
  }
}
