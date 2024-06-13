import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rent_nest_flutter/houses/Api.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../ImageAPI.dart';
import '../houses/details.dart';
import 'ApiUni.dart';
import 'detailsUni.dart';

List<String> picsList=[ "https://i.imgur.com/eGE1PDD.png"
  ,"https://images.unsplash.com/photo-1584719866406-c76ddee48493?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  "https://dar.com/CMS/Content/ResizedImages/1287x10000xi/190206101948048~hero-image.jpg",
  "https://i.pinimg.com/564x/5f/18/8b/5f188b0422a893200157bc4b4e872ef3.jpg",
  "https://i.pinimg.com/564x/35/c6/ef/35c6efaa7acdc481757721f7f6b5e409.jpg",
  "https://i.pinimg.com/564x/c1/19/06/c119066eb3b4c2a79977e5abe3a685d3.jpg",
"https://ecss.com.eg/wp-content/uploads/2023/11/4.jpg"];
List<String> texts = ["RentNest",
  "Medinet Habu in Luxor",
  "New Administrative capital",
  "New Alamein city",
  "Galala city",
  "Nubian Village in Aawan",
];

List<dynamic> fetchedImagesUni=[];
class HomeUni extends StatefulWidget {
  const HomeUni({Key? key}) : super(key: key);

  @override
  State<HomeUni> createState() => _HomeState();
}

class _HomeState extends State<HomeUni> {
  int countUni =1;

  ApiUni api =new ApiUni();
  List<Map<dynamic, dynamic>> gridMap =[];


  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
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
  @override
  void initState() {
    fetchData();
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

    List<String> picsList=[ "https://i.imgur.com/eGE1PDD.png",
    "https://images.unsplash.com/photo-1584719866406-c76ddee48493?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "https://dar.com/CMS/Content/ResizedImages/1287x10000xi/190206101948048~hero-image.jpg",
      "https://i.pinimg.com/564x/5f/18/8b/5f188b0422a893200157bc4b4e872ef3.jpg",
      "https://i.pinimg.com/564x/35/c6/ef/35c6efaa7acdc481757721f7f6b5e409.jpg",
      "https://i.pinimg.com/564x/c1/19/06/c119066eb3b4c2a79977e5abe3a685d3.jpg",
    "https://ecss.com.eg/wp-content/uploads/2023/11/4.jpg"];
  }
  List<Map<dynamic, dynamic>> length =[];
  List<Map<String, dynamic>> housesImages =[];
  ImageAPI imageapi =new ImageAPI();


  Future<void> fetchHousesImageById() async {

    for(int i = 1 ; i <= length.length ; i++) {
      try {
        List<dynamic> fetchedImages = await imageapi.fetchImageById(countUni, "UNIVERSAL_HOUSE");
        print(fetchedImages);
        while(fetchedImages.isEmpty){
          countUni++;
          fetchedImages = await imageapi.fetchImageById(countUni, "UNIVERSAL_HOUSE");
        }
        String firstImage = fetchedImages.first;
        Map<String, String> map = {"image": firstImage};
        setState(() {
          housesImages.add(map);
          // userHouses =length;
        });
      }
      catch (e) {
        print(e.toString());
      }
      countUni++;
    }
    gridMap =length;
    countUni =1;
  }


  Future<void> fetchData() async {
    try {
      List<Map<dynamic, dynamic>> fetchedUserHouses = await api.viewAllUniHouses();
      setState(() {
        length =fetchedUserHouses;
        fetchHousesImageById();

      });
    } catch (e) {
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              const SizedBox(
                height: 36.0,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 100,bottom: 10),
                child: Text(
                  "Welcome to RentNset , have a good day",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                      child: GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                              Text(texts[index]),
                            ),
                          );
                        },
                        onPanDown: (d) {
                          carasouelTmer?.cancel();
                          carasouelTmer = null;
                        },
                        onPanCancel: () {
                          carasouelTmer = getTimer();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                              right: 8, left: 8, top: 24, bottom: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color: Colors.grey.shade300,
                          ),
                          child: Image.network(picsList[index],
                            fit: BoxFit.fitWidth,

                          ) ,
                        ),

                      ),
                    );
                  },
                  itemCount: 7,
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),

              const Padding(
                padding: EdgeInsets.all(24.0),
              ),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  mainAxisExtent: 310,
                ),
                itemCount: gridMap.length,
                itemBuilder: (_, index) {
                  return SingleChildScrollView(
                    child: Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          16.0,
                        ),
                        color: Colors.grey.shade400,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: "${housesImages.elementAt(index)['image']}",
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                              height: 170,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${gridMap.elementAt(index)['description']}",
                                  style: Theme.of(context).textTheme.subtitle1!.merge(
                                    const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8.0,
                                ),
                                Text(
                                  "${gridMap.elementAt(index)['price']}",
                                  style: Theme.of(context).textTheme.subtitle2!.merge(
                                    TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                ),
                            const SizedBox(
                              height: 8.0,
                            ),
                                Row(
                                  children: [
                                    IconButton(

                                      onPressed: () async {
                                        fetchedImagesUni = await imageApi.fetchImageById(gridMap.elementAt(index)['universalHouseId'], "UNIVERSAL_HOUSE");
                                        getDataUni(gridMap.elementAt(index));
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => detailsUni(),
                                          ),
                                        );
                                      },
                                      icon: Icon(
                                        CupertinoIcons.ellipsis_circle,
                                      ),
                                    ),
                                  ],
                                ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
            ],
          ),
        ),
      ),
    );
  }
}
