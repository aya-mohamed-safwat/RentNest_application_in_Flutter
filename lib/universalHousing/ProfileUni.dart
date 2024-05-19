
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import '../LOGIN.dart';
import 'Add_itemUni.dart';
import 'ApiUni.dart';
import 'ImageAPIUni.dart';
import 'editprofileUni.dart';

String SummimageBytes="";


class ProfileUni extends StatefulWidget {
  @override
  State<ProfileUni> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileUni> {

  ApiUni api =new ApiUni();
  ImageAPIUni imageapi =new ImageAPIUni();
  List<Map<dynamic, dynamic>> userHouses =[];

  List<Map<String, dynamic>> housesImages =[];

  List<Map<dynamic, dynamic>> length =[];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchProfileImageById();
    // fetchHousesImageById();
  }
//=====================================================================
//=====================================================================
  Future<void> fetchProfileImageById() async {
    try {
      List<dynamic> fetchedImages = await imageapi.fetchImageById(userMap['id'],"USER_AVATAR");
      setState(() {
        SummimageBytes = fetchedImages.last;
      });
    } catch (e) {
      print(e.toString());
    }
  }
//=====================================================================
//=====================================================================
  Future<void> fetchHousesImageById() async {
    for(int i = 1 ; i <= length.length ; i++) {
      try {
        List<dynamic> fetchedImages = await imageapi.fetchImageById(i, "UNIVERSAL_HOUSE");
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
    }
    userHouses =length;
    print(housesImages);
    //fetchData();
  }
//=====================================================================
//=====================================================================
  Future<void> fetchData() async {
    try {
      List<Map<dynamic, dynamic>> fetchedUserHouses = await api.getUserSummHouses(userMap['id']);
      setState(() {
       // userHouses = fetchedUserHouses;
        length =fetchedUserHouses;
         fetchHousesImageById();

      });
    } catch (e) {
      print(e.toString());
    }
  }
//=====================================================================
//=====================================================================
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    height: 220,
                    width: 500,
                    color: Colors.brown,
                    child:  Center(
                      child: Text(
                        userMap['name'],
                        style: TextStyle(
                          fontSize: 20.0, // Font size
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                  ),
                  child: IconButton(onPressed: (){

                  },
                      icon: const Icon(Icons.arrow_back),
                    iconSize: 30,
                  ),
                ),
        Padding(
          padding: const EdgeInsets.only(
            top: 140,
            left: 140,
            right: 140,
          ),
          child: Stack(
            children: [
              CircleAvatar(
                radius: 64,
                backgroundImage: SummimageBytes.isEmpty
                    ? AssetImage('Photos/profilelogo.png')as ImageProvider<Object>
                    : NetworkImage(SummimageBytes),

              ),

            ],
          ),
            ),
        ],
      ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => editprofileUni()));
              },
              child: const Text(
                'edit profile',
                style: TextStyle(
                    color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
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
        itemCount: userHouses.length,
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
                          "${userHouses.elementAt(index)['description']}",
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
                          "${userHouses.elementAt(index)['price']}",
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
                              onPressed: () {
                                print('Index: $index');
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

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ImagePickerDemoUni(),
            ),
          );
        },
        backgroundColor: Colors.white,
    child: Icon(
    Icons.add_circle_outline,
    color: Colors.brown,
      size: 36,
      ),
      ),
    );
  }
}
