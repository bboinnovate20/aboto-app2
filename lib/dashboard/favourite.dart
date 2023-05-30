import 'package:abotoapp/components.dart';
import 'package:flutter/material.dart';

class FavouriteLectures extends StatelessWidget {
  const FavouriteLectures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Align(
              alignment: Alignment.centerLeft,
              child: Text("Favourite Lectures"))),
      body: lectureUIList(
          context, listOfLectures(context).length, listOfLectures(context)),
    );
  }
}

List<Widget> listOfLectures(BuildContext context) {
  return [
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
  ];
}
