import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LectureUI extends StatelessWidget {
  final String title;
  final String timing;

  const LectureUI({required this.title, required this.timing, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.circular(10)),
      width: 181,
      margin: const EdgeInsets.only(right: 10),
      child: Padding(
          padding: const EdgeInsets.all(9),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  height: 50,
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
              Container(
                  margin: const EdgeInsets.only(top: 16, bottom: 7),
                  child: Text(
                    timing,
                    style: Theme.of(context).textTheme.bodySmall,
                  )),
              ElevatedButton.icon(
                onPressed: () => {},
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                icon: Icon(FontAwesomeIcons.play,
                    color: Theme.of(context).colorScheme.secondary, size: 20),
                label: Text(
                  "PLAY NOW",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              )
            ],
          )),
    );
  }
}
