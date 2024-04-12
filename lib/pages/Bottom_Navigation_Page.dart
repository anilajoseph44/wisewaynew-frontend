import 'package:flutter/material.dart';
import 'package:google_maps_yt/pages/Plan/plan_home.dart';
import 'package:google_maps_yt/pages/User_Profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Widget> pages=[       //creating a list to load pages according to index
    AccountSettings(),
    CreatePlan(),
    AccountSettings(),
    AccountSettings()
  ];

  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(backgroundColor: Colors.black,),
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index)
          {
            print(index);
            setState(() {
              currentIndex=index;      //while clicking the menu,currentIndexvalue will change.
            });

          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.group,color: Colors.grey,size: 34,),
                label: "Plans"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.home,color: Colors.grey,size: 34,),
                label: "Explore"
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,color: Colors.grey,size: 34,),
                label: "Search"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings,color: Colors.grey,size: 34,),
                label: "Account"
            ),
          ],
        ),
      ),
    );
  }
}