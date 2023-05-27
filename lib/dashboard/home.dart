import 'package:flutter/material.dart';
import 'package:abotoapp/shared/bottom_navigation.dart';
import 'package:abotoapp/dashboard/dashboard.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _index = 1;
  Widget currentScreen = MainScroll();

  onTap(Widget widget, value) {
    setState(() {
      currentScreen = widget;
      _index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.house), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.music), label: 'Lectures'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.solidHeart), label: 'Favourite'),
          BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.info), label: 'About'),
        ],
        elevation: 100,
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        currentIndex: 2,
        enableFeedback: true,
        onTap: (value) {
          switch (value) {
            case 1:
              onTap(const AllLectures(), value);
              // _onNavigateRoute(context, '/lectures', value);
              break;
            case 2:
              print('eeee');
              break;
            case 3:
              break;

            default:
              onTap(const MainScroll(), value);
              break;
          }
        },
      ),
    );
  }
}
