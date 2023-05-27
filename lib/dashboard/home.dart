import 'dart:ffi';

import 'package:abotoapp/components.dart';
import 'package:flutter/material.dart';
import 'package:abotoapp/shared/BottomNavigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MainScroll(),
      bottomNavigationBar: BottomNav(),
    );
  }
}

//   Column(
// crossAxisAlignment: CrossAxisAlignment.stretch,
// children: [
//   const TopHeader(),
//   MainScroll()
//   // const Biography(),
//   // Lectures(
//   //   title: "All Lectures",
//   //   action: () => {},
//   // ),
//   // Lectures(
//   //   title: "Recently Played",
//   //   action: () => {},
//   // )
// ],)

class MainScroll extends StatefulWidget {
  const MainScroll({super.key});

  @override
  State<MainScroll> createState() => _MainScrollState();
}

class _MainScrollState extends State<MainScroll> {
  ScrollController _scrollController = ScrollController();
  double opacity = 1.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TopHeader(animOpacity: opacity),
        TopHeaderMedium(
            animOpacity: 1.0 - opacity), //on scroll alternative onscroll
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            // print();
            setState(() {
              opacity = 1.0 -
                  ((notification.extent - 0.8) / (0.9 - 0.8)) * (1.0 - 0.0);
            });

            return true;
          },
          child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              maxChildSize: 0.9,
              minChildSize: 0.8,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                _scrollController = scrollController;

                return Container(
                    color: Colors.white,
                    child:
                        // homePageComponent(context)
                        ListView(
                      controller: _scrollController,
                      children: <Widget>[
                        const Biography(),
                        Lectures(
                          title: "All Lectures",
                          action: () => {},
                          isAction: true,
                        ),
                        Lectures(
                            title: "Recently Played",
                            action: () => {},
                            isAction: false)
                      ],
                    )

                    // ListView.builder(
                    //   controller: _scrollController,
                    //   itemCount: 25,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return ListTile(title: Text('Item $index'));
                    //   },
                    // ),
                    );
              }),
        )
      ],
    );
  }
}

class Lectures extends StatelessWidget {
  final String title;
  final Function action;
  final bool isAction;

  const Lectures(
      {super.key,
      required this.title,
      required this.action,
      required this.isAction});

  Widget checkAction(BuildContext context) {
    if (isAction == true) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
            onPressed: () => action,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              backgroundColor: Theme.of(context).colorScheme.secondary,
            ),
            child: Text("View All Lecture",
                style: Theme.of(context).textTheme.bodyMedium)),
      );
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: Theme.of(context).textTheme.displayLarge),
                    const Text("More >",
                        style: TextStyle(color: Colors.black54, fontSize: 16))
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                LectureUI(
                  title: "Ifaseyin Ilekewu Ati Majemu",
                  timing: "2hr 4sec",
                ),
                LectureUI(title: "Titobi Olohun", timing: "2hr 4sec")
              ],
            ),
            checkAction(context)
          ],
        ));
  }
}

class Biography extends StatelessWidget {
  const Biography({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(children: [
            const Padding(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Image(
                  image: AssetImage('images/logo.webp'),
                  height: 110,
                  // fit: BoxFit.contain
                )),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("Sheikh Alhaji AbdulGaniyy Aboto",
                    style: Theme.of(context).textTheme.bodyLarge),
                const Text(
                  "DHUL NURAYN",
                  style: TextStyle(
                    color: Colors.white60,
                  ),
                ),
                const Text("(LIFE & DEATH)"),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () => {print('ddd')},
                        child: Text("View Profile",
                            style: Theme.of(context).textTheme.bodyMedium)))
              ],
            ))
          ]),
        ));
  }
}

class TopHeaderMedium extends StatelessWidget {
  final double animOpacity;

  const TopHeaderMedium({super.key, required this.animOpacity});

  @override
  Widget build(BuildContext context) {
    return HeaderTemplate(
        widget: SafeArea(
            child: AnimatedOpacity(
      opacity: animOpacity,
      duration: Duration.zero,
      child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: mainHeaderSearch(context, listWidget(context))),
    )));
  }

  List<Widget> listWidget(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Hi Member!", style: Theme.of(context).textTheme.bodyMedium),
          Icon(FontAwesomeIcons.gear,
              color: Theme.of(context).colorScheme.onBackground, size: 20)
        ],
      ),
    ];
  }
}

class TopHeader extends StatelessWidget {
  final double animOpacity;

  const TopHeader({super.key, required this.animOpacity});
  @override
  Widget build(BuildContext context) {
    return HeaderTemplate(
        widget: Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.background,
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: AnimatedOpacity(
              opacity: animOpacity,
              duration: Duration.zero,
              child: SafeArea(
                  child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: mainHeaderSearch(context, listWidget(context)),
              )),
            )));
  }

  List<Widget> listWidget(BuildContext context) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Salam Alaykum!", style: Theme.of(context).textTheme.bodyMedium),
          Icon(FontAwesomeIcons.gear,
              color: Theme.of(context).colorScheme.onBackground, size: 20)
        ],
      ),
      const SearchBar()
    ];
  }

  // Container headerSearch(BuildContext context) {
  //   return ;
  // }
}

List<Widget> homePageComponent(BuildContext context) {
  return [];
}

Column mainHeaderSearch(BuildContext context, List<Widget> defaultHeader) {
  return Column(children: defaultHeader);
}

List<Widget> onScrollHeader(BuildContext context) {
  return [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Hi User!", style: Theme.of(context).textTheme.bodyMedium),
        Icon(FontAwesomeIcons.gear,
            color: Theme.of(context).colorScheme.onBackground, size: 20)
      ],
    )
  ];
}

class HeaderTemplate extends StatelessWidget {
  final Widget widget;

  const HeaderTemplate({super.key, required this.widget});
  @override
  Widget build(BuildContext context) {
    return widget;
  }

  Column mainHeaderSearch(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Salam Alaykum!",
                style: Theme.of(context).textTheme.bodyMedium),
            Icon(FontAwesomeIcons.gear,
                color: Theme.of(context).colorScheme.onBackground, size: 20)
          ],
        ),
        const SearchBar()
      ],
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 13),
      child: const TextField(
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
