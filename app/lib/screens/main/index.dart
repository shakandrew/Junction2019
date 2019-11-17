import 'package:flutter/material.dart';
import 'package:greenlist/styles.dart';
import 'package:greenlist/widgets/logo.dart';

import 'pages/progress.dart';
import 'pages/list.dart';
import 'pages/history.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageController pageController;
  int currentPageIndex;
  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, keepPage: true);
    currentPageIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
              Logo(save: false, size: kToolbarHeight - 16, color: greenColor),
          centerTitle: true,
          backgroundColor: whiteColor,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: greenColor,
          unselectedItemColor: greyColor,
          currentIndex: currentPageIndex,
          onTap: (index) {
            pageController.animateToPage(index,
                curve: Curves.easeIn, duration: Duration(milliseconds: 300));
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.adjust),
              title: Text("Progress"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              title: Text("GreenList"),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              title: Text("History"),
            )
          ],
        ),
        body: SafeArea(
          top: true,
          child: PageView(
            physics: BouncingScrollPhysics(),
            onPageChanged: (index) {
              setState(() => currentPageIndex = index);
            },
            children: <Widget>[
              ProgressPage(),
              ListPage(),
              HistoryPage(),
            ],
            controller: pageController,
          ),
        ));
  }
}
