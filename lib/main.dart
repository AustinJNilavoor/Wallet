import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:wallet/Pages/homepage.dart';
import 'package:wallet/Pages/menupage.dart';
import 'package:wallet/Pages/settingspage.dart';

import 'Pages/history.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Wallet',
        theme: ThemeData(
          // brightness: Brightness.light,
          primarySwatch: Colors.blue,
        ),
        home: const MainWid());
  }
}

class MainWid extends StatefulWidget {
  const MainWid({Key? key}) : super(key: key);

  @override
  State<MainWid> createState() => _MainWidState();
}

class _MainWidState extends State<MainWid> {
  int index = 0;
  final pages = const[ HomePage(), HistoryPage(), MenuPage(),SettingsPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      appBar: AppBar(
        backgroundColor: const Color(0x00000000),
        elevation: 0.0,
        title: const Text(
          'My Wallet',
        ),
        centerTitle: true,
      ),
      body: pages[index],
      bottomNavigationBar: Container(
        color: Colors.grey.shade900,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          child: GNav(
              onTabChange: (index) => setState(() {
                    this.index = index;
                  }),
              // iconSize: 21,
              gap: 8,
              
              tabBackgroundColor: const Color(0xff121212),
              activeColor: Colors.white70,
              color: Colors.white70,
              backgroundColor: Colors.grey.shade900,
              tabBorderRadius: 25,
              padding: const EdgeInsets.all(16),
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: "Home",
                ),
                GButton(
                  icon: Icons.history,
                  text: 'History',
                ),
                GButton(
                  icon: Icons.analytics_outlined,
                  text: 'More',
                ),
                GButton(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                )
              ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //       backgroundColor: const Color(0xccc33764),
      //       onPressed: ((() {
              
      //       })),
      //       child: const Icon(Icons.add, color: Colors.white),
      //     ),
    );
  }
}
