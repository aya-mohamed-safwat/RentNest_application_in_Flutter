import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../about.dart';
import '../contact.dart';
import 'HomeCap.dart';
import 'ProfileCap.dart';
import 'SearchScreen_Cap.dart';

class bottomnavbarCap extends StatelessWidget {
  const bottomnavbarCap({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        PersistentTabView(
          backgroundColor: Colors.white60,

          tabs: [
            PersistentTabConfig(
              screen: HomeCap(),
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
              screen:SearchScreenCap() ,
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
              screen: ProfileCap(),
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

