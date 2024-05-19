import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../about.dart';
import '../contact.dart';
import 'HomeUni.dart';
import 'ProfileUni.dart';
import 'SearchScreen_Uni.dart';

class bottomnavbarUni extends StatelessWidget {
  const bottomnavbarUni({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        PersistentTabView(
          backgroundColor: Colors.white60,

          tabs: [
            PersistentTabConfig(
              screen: HomeUni(),
              item: ItemConfig(
                icon: Icon(Icons.home),
                title: "Home",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
            PersistentTabConfig(
              screen: about(),
              item: ItemConfig(
                icon: Icon(Icons.error_outline_rounded),
                title: "About us",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
            PersistentTabConfig(
              screen:SearchScreenUni() ,
              item: ItemConfig(
                icon: Icon(Icons.search_rounded),
                title: "Search",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
            PersistentTabConfig(
              screen: contact(),
              item: ItemConfig(
                icon: Icon(Icons.call),
                title: "contact",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
            PersistentTabConfig(
              screen: ProfileUni(),
              item: ItemConfig(
                icon: Icon(Icons.person),
                title: "profile",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
          ],
          navBarBuilder: (navBarConfig) => Style8BottomNavBar(
            navBarConfig: navBarConfig,
          ),
        ),

    );
  }
}

