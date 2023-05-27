import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.house), label: 'Home'),
      BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.clockRotateLeft), label: 'Home'),
      BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.house), label: 'Home')
    ]);
  }
}
