import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}
class GridB extends StatefulWidget {
  const GridB({Key? key}) : super(key: key);

  @override
  State<GridB> createState() => _GridBState();
}

class _GridBState extends State<GridB> {
  final List<Map<String, dynamic>> gridMap = [
    {
      "title": "sea view beach house in north cost",
      "price": "\$5000",
      "images":
      "https://images.unsplash.com/photo-1522759531475-b05ba50ae2b7?q=80&w=1965&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "هو دا بيتك يسطا ؟ امال بيقول انه بتاعك ليه",
      "price": "\$10000",
      "images":
      "https://images.unsplash.com/photo-1523217582562-09d0def993a6?q=80&w=1780&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "اجره و على ضمانتي",
      "price": "\$7000",
      "images":
      "https://images.unsplash.com/photo-1512917774080-9991f1c4c750?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "بيت مزة فشخ تبيع كليتك عشانه من غير ما تحس",
      "price": "\$25000",
      "images":
      "https://images.unsplash.com/photo-1600047509358-9dc75507daeb?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "بيت رخيص بس حلو على قد فلوسك",
      "price": "\$4000",
      "images":
      "https://images.unsplash.com/photo-1605146769289-440113cc3d00?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    },
    {
      "title": "بيت غالي فشخ بس الغالي للغالي",
      "price": "\$30000",
      "images":
      "https://images.unsplash.com/photo-1600047509807-ba8f99d2cdde?q=80&w=1892&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
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
                child: Image.network(
                  "${gridMap.elementAt(index)['images']}",
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
                      "${gridMap.elementAt(index)['title']}",
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
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
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
    );
  }
}