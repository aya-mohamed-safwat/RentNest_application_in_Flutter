import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../about.dart';
import '../contact.dart';

import 'HomeSumm.dart';
import 'ProfileSumm.dart';
import 'SearchScreen_Summ.dart';

class bottomnavbarSumm extends StatelessWidget {
  const bottomnavbarSumm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        PersistentTabView(
          backgroundColor: Colors.white60,

          tabs: [
            PersistentTabConfig(
              screen: HomeSumm(),
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
              screen:SearchScreenSumm() ,
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
              screen: ProfileSumm(),
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

