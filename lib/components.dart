import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abotoapp/components.dart';

Widget lectureUIMain(
    BuildContext context, String title, String timing, String routeName) {
  return Container(
    decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(10)),

    width: MediaQuery.of(context).size.width * 0.45,

    // margin: const EdgeInsets.only(right: 10),
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
              onPressed: () => Navigator.pushNamed(context, routeName,
                  arguments: {'title': title}),
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

      width: MediaQuery.of(context).size.width * 0.45,

      // margin: const EdgeInsets.only(right: 10),
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

Widget searchBarNav() {
  return Container(
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
      style: TextStyle(fontSize: 19),
      decoration: InputDecoration(
          // icon: Icon(FontAwesomeIcons.magnifyingGlass),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            borderSide: BorderSide.none,
          ),
          filled: true,
          hintText: 'Search for lecture',
          fillColor: Colors.white),
    ),
  );
}

class SearchBarNav extends StatefulWidget {
  const SearchBarNav({super.key});

  @override
  State<SearchBarNav> createState() => _SearchBarNavState();
}

class _SearchBarNavState extends State<SearchBarNav> {
  @override
  Widget build(BuildContext context) {
    return 
    Container(
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
        style: TextStyle(fontSize: 19),
        decoration: InputDecoration(
            // icon: Icon(FontAwesomeIcons.magnifyingGlass),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              borderSide: BorderSide.none,
            ),
            filled: true,
            hintText: 'Search for lecture',
            fillColor: Colors.white),
      ),
    );
  }
}

Stack lectureUIList(BuildContext context, int noOfItem, list) {
  return Stack(
    children: [
      const Padding(
        padding: EdgeInsets.only(right: 8.0, left: 8.0),
        child: SearchBarNav(),
      ),
      Container(
        margin: const EdgeInsets.only(top: 100, right: 10, left: 10),
        child: ListView.separated(
          itemCount: noOfItem,
          separatorBuilder: (context, index) {
            return Divider(
              color: Theme.of(context).primaryColor,
            );
          },
          itemBuilder: (context, index) {
            return list[index];
          },
        ),
      ),
    ],
  );
}

Widget lectureUIComponent(
    BuildContext context, String action, List<String> content) {
  return Row(
    children: [
      const Icon(FontAwesomeIcons.play, color: Colors.black54, size: 25),
      Expanded(
        flex: 1,
        child: InkWell(
          onTap: () => Navigator.pushNamed(context, action,
              arguments: {'title': content[0], 'dur': content[1]}),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(content[0],
                          maxLines: 1,
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.bold)),
                      Text(
                        content[1],
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(FontAwesomeIcons.chevronRight)
            ],
          ),
        ),
      ),
    ],
  );
}
