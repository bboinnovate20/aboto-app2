import 'package:abotoapp/shared/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abotoapp/components.dart';

class AllLectures extends StatelessWidget {
  const AllLectures({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNav(index: 1),
      appBar: AppBar(
          title: const Text("All Lectures"),
          backgroundColor: Theme.of(context).colorScheme.background),
      body: Stack(
        children: [
          const SearchBar(),
          Container(
            margin: EdgeInsets.only(top: 70, right: 10, left: 10),
            child: ListView(
              children: [
                lectureUIComponent(context),
                lectureUIComponent(context),
                lectureUIComponent(context),
                lectureUIComponent(context),
                lectureUIComponent(context),
                lectureUIComponent(context)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget lectureUIComponent(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 28),
    child: Row(
      children: [
        const Icon(FontAwesomeIcons.play, color: Colors.black54, size: 25),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('New Light new Light Coarse New Light',
                    maxLines: 1,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold)),
                Text(
                  '1hr 2sec',
                  style: TextStyle(color: Colors.black54, fontSize: 18),
                )
              ],
            ),
          ),
        ),
        const Icon(FontAwesomeIcons.chevronRight)
      ],
    ),
  );
}
