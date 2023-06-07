import 'dart:math';

import 'package:abotoapp/components.dart';
import 'package:abotoapp/shared/audio_provider.dart';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

GetIt getIt = GetIt.instance;
final PlayListManager _playerControl = getIt<PlayListManager>();

class MainScroll extends StatefulWidget {
  final Function action;
  final ScrollController controller;
  const MainScroll({super.key, required this.action, required this.controller});

  @override
  State<MainScroll> createState() => _MainScrollState();
}

class _MainScrollState extends State<MainScroll> {
  late ScrollController _scrollController;
  double opacity = 1.0;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mainPlayLecture(context);
    return Stack(
      children: [
        TopHeader(
          animOpacity: opacity,
          action: () => widget.action(),
        ),
        TopHeaderMedium(
            animOpacity: 1.0 - opacity), //on scroll alternative on scroll
        NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            setState(() {
              opacity = 1.0 -
                  ((notification.extent - 0.82) / (0.9 - 0.82)) * (1.0 - 0.0);
            });
            return true;
          },
          child: DraggableScrollableSheet(
              initialChildSize: 0.82,
              maxChildSize: 0.9,
              minChildSize: 0.82,
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
                            action: () => widget.action(),
                            isAction: true,
                            isDb: false),
                        Lectures(
                            title: "Recently Played",
                            action: () => {},
                            isAction: false,
                            isDb: true)
                      ],
                    ));
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
  final bool isDb;

  const Lectures(
      {super.key,
      required this.title,
      required this.action,
      required this.isAction,
      required this.isDb});

  Widget checkAction(BuildContext context) {
    if (isAction == true) {
      return Container(
        margin: const EdgeInsets.only(top: 10),
        child: ElevatedButton(
            onPressed: () => action(),
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
    var uniqueNum = -1;
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
                  ],
                )),
            isDb
                ? const RecentlyPlayed()
                : ValueListenableBuilder(
                    valueListenable: _playerControl.isBuffered,
                    builder: (context, value, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _playerControl.playlistNotifier.value.isEmpty
                            ? []
                            : List.generate(2, (index) {
                                Random randomValue = Random();
                                int randInt = randomValue.nextInt(_playerControl
                                    .playlistNotifier.value.length);
                                if (uniqueNum >= 0) {
                                  do {
                                    randInt = randomValue.nextInt(_playerControl
                                        .playlistNotifier.value.length);
                                  } while (randInt == uniqueNum);
                                }
                                uniqueNum = randInt;
                                // var lecture = value[randInt];

                                // Modify the element or perform some computation
                                // int modifiedElement = element * 2;
                                return LectureUIMain(
                                    title:
                                        '${_playerControl.playlistNotifier.value[uniqueNum.toString()]}',
                                    lecturer: 'Alhaji AbdulGaniyy Aboto',
                                    routeName: '/lecturePlay',
                                    index: uniqueNum);
                              })),
                  ),
            checkAction(context)
          ],
        ));
  }
}

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  late final Map<String, String> allFavourite;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    late FlutterSecureStorage storage = getIt<FlutterSecureStorage>();

    storage.readAll().then((favLecture) => setState(() {
          allFavourite = Map.fromEntries(favLecture.entries.where((element) =>
              element.key.startsWith(_playerControl.recentPrefix)));
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _playerControl.allRecent,
      builder: (context, value, _) => Wrap(
        spacing: 7,
        children: value.isNotEmpty
            ? value.entries.map((entry) {
                return LectureUIMain(
                    title: entry.value,
                    lecturer: 'Alhaji AbdulGaniyy Aboto',
                    routeName: '/lecturePlay',
                    index: int.parse(entry.key.toString().split('_')[1]));
              }).toList()
            : [
                const Text(
                  "Your Recently played music will appear here",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
      ),
    );
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
                    style: Theme.of(context).textTheme.bodyMedium),
                const Text(
                  "DHUL NURAYN",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                  ),
                ),
                Text("(LIFE & DEATH)",
                    style: Theme.of(context).textTheme.bodySmall),
                Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: ElevatedButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/profile')},
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
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Alhaji AbdulGaniyy App",
            //     style: Theme.of(context).textTheme.bodyMedium),
            // Icon(FontAwesomeIcons.gear,
            //     color: Theme.of(context).colorScheme.onBackground, size: 20)
          )
        ],
      ),
    ];
  }
}

class TopHeader extends StatelessWidget {
  final double animOpacity;
  final Function action;

  const TopHeader({super.key, required this.animOpacity, required this.action});
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
                child: Container(
                    child:
                        mainHeaderSearch(context, listWidget(context, action))),
              )),
            )));
  }

  List<Widget> listWidget(BuildContext context, Function action) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Salam Alaykum!", style: Theme.of(context).textTheme.bodyMedium),
          // Icon(FontAwesomeIcons.gear,
          //     color: Theme.of(context).colorScheme.onBackground, size: 20)
        ],
      ),
      InkWell(
        onTap: () => action(),
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(FontAwesomeIcons.magnifyingGlass,
                      color: Theme.of(context).colorScheme.primary),
                ),
                const Text("Search for Lecture",
                    style: TextStyle(color: Colors.grey))
              ],
            ),
          ),
        ),
      )
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
        Text("Sheikh Aboto AbdulGaniyy ",
            style: Theme.of(context).textTheme.bodyMedium),
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
          ],
        ),
        // const SearchBarNav()
      ],
    );
  }
}

class CurrentPlayingDialogue extends StatelessWidget {
  const CurrentPlayingDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

void mainPlayLecture(BuildContext context) async {
  // final lectureAudioProvider = Provider.of<AudioProvider>(context);
  // await lectureAudioProvider.loadAllLectures();
  // lectureAudioProvider.playLecture();
}
