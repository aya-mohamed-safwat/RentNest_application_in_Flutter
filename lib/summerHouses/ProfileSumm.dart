
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import '../ImageAPI.dart';
import '../LOGIN.dart';
import 'Add_itemSumm.dart';
import 'ApiSumm.dart';
import 'HomeSumm.dart';
import 'EditHouseSumm.dart';
import 'editprofileSumm.dart';

String imageBytesSumm="";

List<dynamic> ImagesForEditingSumm=[];

class ProfileSumm extends StatefulWidget {
  @override
  State<ProfileSumm> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileSumm> {
  int countSumm =1;
  ApiSumm api =new ApiSumm();
  ImageAPI imageapi =new ImageAPI();
  List<Map<dynamic, dynamic>> userHouses =[];

  List<Map<String, dynamic>> housesImages =[];

  List<Map<dynamic, dynamic>> length =[];

  @override
  void initState() {
    super.initState();
    fetchData();
    fetchProfileImageById();
  }
//=====================================================================
//=====================================================================
  Future<void> fetchImageByEntityIdAndUserId() async {
    for(int i = 1; i <= length.length ; i++) {
      try {
        List<dynamic> fetchedImages = await imageapi.fetchImageByEntityIdAndUserId(countSumm, "SUMMER_HOUSE" ,userMap['id']);
        while(fetchedImages.isEmpty){
          countSumm++;
          fetchedImages = await imageapi.fetchImageByEntityIdAndUserId(countSumm, "SUMMER_HOUSE", userMap['id']);
          print(countSumm);
        }
        String firstImage = fetchedImages.first;
        Map<String, String> map = {"image": firstImage};
        setState(() {
          housesImages.add(map);
        });
      }
      catch (e) {
        print(e.toString());
      }
      countSumm++;
    }
    userHouses =length;
    countSumm =1;
  }
//=====================================================================
//=====================================================================
  Future<void> fetchProfileImageById() async {
    try {
      List<dynamic> fetchedImages = await imageapi.fetchImageById(userMap['id'],"USER_AVATAR");
      if(fetchedImages.isNotEmpty) {
        setState(() {
          imageBytesSumm= fetchedImages.last;
        });
      }
      else{ imageBytesSumm = "";}
    } catch (e) {
      print(e.toString());
    }
  }
//=====================================================================
//=====================================================================
  Future<void> deleteHousesImage(List names) async {

    for (String item in names)  {
      try {
        await imageapi.deleteImages(item);

      } catch (e) {
        print(e.toString());
      }
    }
  }
//=====================================================================
//=====================================================================
  Future<void> fetchData() async {
    try {
      List<Map<dynamic, dynamic>> fetchedUserHouses = await api.getUserSummHouses(userMap['id']);
      setState(() {
        length =fetchedUserHouses;
        fetchImageByEntityIdAndUserId();
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
                  child: IconButton(onPressed: (){Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeSumm()));

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
                backgroundImage: imageBytesSumm.isNotEmpty
                    ? NetworkImage(imageBytesSumm)
                    : AssetImage('Photos/profilelogo.png') as ImageProvider<Object>,
              ),

            ],
          ),
            ),
        ],
      ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => editprofileSumm()));
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

                            PopupMenuButton<String>(

                              onSelected: (value) {
                                if (value == 'delete item') {
                                  String getImageFileName(String imageUrl) {
                                    Uri uri = Uri.parse(imageUrl);
                                    return uri.pathSegments.last;
                                  }
                                  Future<void> getHouseImages() async {
                                    for(int i = 1 ; i <= length.length ; i++) {
                                      try {
                                        List getImages = await imageapi.fetchImageById(userHouses.elementAt(index)['summerHouseId'], "SUMMER_HOUSE");

                                        List<String> imageFileNames = getImages.map((imageUrl) => getImageFileName(imageUrl)).toList();
                                        print(imageFileNames);

                                        await deleteHousesImage(imageFileNames);
                                      } catch (e) {
                                        print(e.toString());
                                      }
                                    }
                                  }
                                  getHouseImages();
                                  Future<void> deleteHouse() async {
                                    try {
                                      String deleteHouse = await api.deleteItem(userHouses.elementAt(index)['summerHouseId']);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => ProfileSumm()), // Navigate to the contact page
                                      );
                                    } catch (e) {
                                      print(e.toString());
                                    }
                                  }
                                  deleteHouse();
                                }

                                Future<void> handleEditItem() async {
                                  ImagesForEditingSumm = await imageapi.fetchImageById(userHouses.elementAt(index)["summerHouseId"], "SUMMER_HOUSE");
                                  getHouseToUpdateSumm(userHouses.elementAt(index));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EditHouseSumm()), // Navigate to the contact page
                                  );
                                }
                                if (value == 'edit item') {

                                  handleEditItem();
                                }
                              },
                              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                                const PopupMenuItem<String>(
                                  value: 'edit item',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(width: 8), // Adjust spacing as needed
                                      Text('edit item'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem<String>(
                                    value: 'delete item',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete),
                                        SizedBox(width: 8), // Adjust spacing as needed
                                        Text('delete item'),
                                      ],
                                    )
                                ),

                              ],
                              icon: const Icon(
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
              builder: (context) => ImagePickerDemoSumm(),
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
