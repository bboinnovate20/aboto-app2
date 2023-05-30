import 'package:flutter/material.dart';
import 'package:abotoapp/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllLectures extends StatefulWidget {
  const AllLectures({super.key});

  @override
  State<AllLectures> createState() => _AllLecturesState();
}

class _AllLecturesState extends State<AllLectures> {
  late Map<int, String> lectures;

  @override
  void initState() {
    super.initState();

    setState(() {
      lectures = {1: 'Lecture', 2: 'Our Lecture'};
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Align(
                alignment: Alignment.centerLeft, child: Text("All Lectures")),
            leading: null,
            backgroundColor: Theme.of(context).colorScheme.background),
        body: Stack(
          children: [
            Padding(
                padding: EdgeInsets.only(right: 8.0, left: 8.0),
                child: Container(
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 15,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 15),
                  child: TextField(
                    onChanged: (value) {
                      print(value);
                    },
                    style: const TextStyle(fontSize: 19),
                    decoration: const InputDecoration(
                        // icon: Icon(FontAwesomeIcons.magnifyingGlass),
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixIcon:
                            Icon(FontAwesomeIcons.magnifyingGlass, size: 20),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        hintText: 'Search for lecture',
                        fillColor: Colors.white),
                  ),
                )),
            Container(
              margin: const EdgeInsets.only(top: 100, right: 10, left: 10),
              // child: ListView.separated(
              //   itemCount: listOfLectures(context).length,
              //   separatorBuilder: (context, index) {
              //     return Divider(
              //       color: Theme.of(context).primaryColor,
              //     );
              //   },
              //   itemBuilder: (context, index) {
              //     return listOfLectures(context)[index];
              //   },
              // ),
            ),
          ],
        ));
  }
}

List<Widget> listOfLectures(BuildContext context, lists) {
  List<Widget> accList = [];

  for (var element in lists) {
    accList.add(lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']));
  }
  return [
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
    lectureUIComponent(
        context, '/lecturePlay', ['Awon Iwo Musulimu', '1hr 2sec']),
    lectureUIComponent(
        context, '/lecturePlay', ['Kinni Ola Albarika Eda', '1hr 2sec']),
    lectureUIComponent(
        context, '/lecturePlay', ['Tani o ni igberega', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['Oro Anobi Ki oto ku ati ife sile re', '1hr 2sec']),
    lectureUIComponent(context, '/lecturePlay',
        ['New Light new Light Upon Light', '1hr 2sec']),
  ];
}
