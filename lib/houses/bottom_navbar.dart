import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../about.dart';
import '../contact.dart';
import 'Home.dart';
import 'Profile.dart';
import 'SearchScreen.dart';

class bottomnavbar extends StatelessWidget {
  const bottomnavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        PersistentTabView(
          backgroundColor: Colors.white60,

          tabs: [
            PersistentTabConfig(
              screen: Home(),
              item: ItemConfig(
                icon: Icon(Icons.home),
                title: "Home",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
            PersistentTabConfig(
              screen:about(),
              item: ItemConfig(
                icon: Icon(Icons.error_outline_rounded),
                title: "About us",
                activeColorSecondary:Color(0xFF90604C),
                activeForegroundColor:Colors.white ,
              ),
            ),
            PersistentTabConfig(
              screen:SearchScreen() ,
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
              screen: Profile(),
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

