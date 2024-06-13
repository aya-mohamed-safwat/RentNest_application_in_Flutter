
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import '../ImageAPI.dart';
import 'HomeUni.dart';
import 'detailsUni.dart';

String imageBytes="";
int countSearch =1;

List<Map<dynamic, dynamic>> searchResultUni =[];
void getSearchResultUni(List<Map<dynamic, dynamic>> x){
  searchResultUni =x ;
}


class SearchResultUni extends StatefulWidget {
  @override
  State<SearchResultUni> createState() => _SearchResultUniState();
}

class _SearchResultUniState extends State<SearchResultUni> {

  @override
  void initState() {
    super.initState();
    fetchlength();
  }
  List<Map<dynamic, dynamic>> gridSearch =[];
  ImageAPI imageapi =new ImageAPI();

  List<Map<String, dynamic>> housesImages =[];

  List<Map<dynamic, dynamic>> length =[];
  //=====================================================================
//=====================================================================
  Future<void> fetchHousesImageById() async {
    for(int i = 1 ; i <= length.length ; i++) {
      try {
        List<dynamic> fetchedImages = await imageapi.fetchImageById(countSearch, "UNIVERSAL_HOUSE");
        while(fetchedImages.isEmpty){
          countSearch++;
          fetchedImages = await imageapi.fetchImageById(countSearch, "UNIVERSAL_HOUSE");
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
      countSearch++;
    }
    gridSearch =length;
    countSearch =1;
  }
//=====================================================================
//=====================================================================
  Future<void> fetchlength() async {
    try {
      setState(() {
        length =searchResultUni;
        fetchHousesImageById();

      });
    } catch (e) {
      print(e.toString());
    }
  }
  //=================================================================
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 310,
        ),
        itemCount: gridSearch.length,
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
                          "${gridSearch.elementAt(index)['description']}",
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
                          "${gridSearch.elementAt(index)['price']}",
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
                                fetchedImagesUni = await imageApiUni.fetchImageById(gridSearch.elementAt(index)['universalHouseId'], "UNIVERSAL_HOUSE");
                                getDataUni(gridSearch.elementAt(index));
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
    );
  }
}
