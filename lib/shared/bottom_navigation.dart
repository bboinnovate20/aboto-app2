import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget {
  final int index;
  const BottomNav({super.key, required this.index});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  _onNavigateRoute(BuildContext context, routeName, index) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: widget.index,
      enableFeedback: true,
      onTap: (value) {
        switch (value) {
          case 1:
            _onNavigateRoute(context, '/lectures', value);

            break;
          case 2:
            print('eeee');
            break;
          case 3:
            break;

          default:
            _onNavigateRoute(context, '/', 0);
            break;
        }
      },
    );
  }
}
