import 'package:abotoapp/dashboard/about.dart';
import 'package:abotoapp/dashboard/favourite.dart';
import 'package:flutter/material.dart';
import 'package:abotoapp/dashboard/dashboard.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late PageController _pageController;
  late Widget currentScreen;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            MainScroll(action: () {
              setState(() {
                _index = 1;
              });
              onChange(1);
            }),
            AllLectures(),
            FavouriteLectures(),
            About()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                  gap: 8,
                  activeColor: Theme.of(context).primaryColor,
                  iconSize: 24,
                  selectedIndex: _index,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: const Duration(milliseconds: 400),
                  tabBackgroundColor: Colors.blueGrey[50]!,
                  color: Colors.black.withOpacity(.5),
                  onTabChange: (index) => onChange(index),
                  tabs: const [
                    GButton(icon: FontAwesomeIcons.house, text: 'Home'),
                    GButton(icon: FontAwesomeIcons.music, text: 'Lectures'),
                    GButton(
                        icon: FontAwesomeIcons.solidHeart, text: 'Favourite'),
                    GButton(icon: FontAwesomeIcons.info, text: 'About')
                  ]),
            ),
          ),
        ));
  }

  void onChange(index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 50),
        curve: Curves.fastLinearToSlowEaseIn);
    setState(() {
      _index = index;
    });
  }
}
