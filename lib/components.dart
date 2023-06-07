import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:abotoapp/components.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
final PlayListManager _playerControl = getIt<PlayListManager>();

// ignore: must_be_immutable
class LectureUIMain extends StatefulWidget {
  String title;
  String lecturer;
  String routeName;
  int index;

  LectureUIMain(
      {super.key,
      required this.title,
      required this.lecturer,
      required this.routeName,
      required this.index});

  @override
  State<LectureUIMain> createState() => _LectureUIMainState();
}

// valueListenable: _playerControl.currentSongTitleNotifier,
//       builder: (context, notifier, _) => InkWell(
//         onTap: () {
//           // if (notifier.isPlaying) {
//           //   if (notifier.id != widget.index.toString()) {
//           //     _playerControl.skipToIndex(widget.index);
//           //   }
//           // } else {
//           //   _playerControl.play();
//           // }

//           // Navigator.pushNamed(context, '/lecturePlay');
//         },
// if (widget.index.toString() != isPlay.id.toString()) {
//                       _playerControl.skipToIndex(widget.index);
//                       _playerControl.play();
//                     } else if (isPlay.isPlaying) {
//                       _playerControl.pause();
//                     } else {
//                       _playerControl.play();
//                     }
class _LectureUIMainState extends State<LectureUIMain> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _playerControl.currentSongTitleNotifier,
        builder: (context, notifier, _) {
          return InkWell(
            onTap: () {
              if (notifier.isPlaying) {
                if (notifier.id != widget.index.toString()) {
                  _playerControl.skipToIndex(widget.index);
                }
              } else {
                _playerControl.play();
              }

              Navigator.pushNamed(context, '/lecturePlay');
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 7),
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
                          // height: 50,
                          child: Text(
                            widget.title,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 1,
                          )),
                      Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 7),
                          child: Text(
                            widget.lecturer,
                            style: Theme.of(context).textTheme.bodySmall,
                          )),
                      ValueListenableBuilder(
                          valueListenable:
                              _playerControl.currentSongTitleNotifier,
                          builder: (context, isPlay, child) {
                            return InkWell(
                              onTap: () {
                                if (widget.index.toString() !=
                                    isPlay.id.toString()) {
                                  _playerControl.skipToIndex(widget.index);
                                  _playerControl.play();
                                } else if (isPlay.isPlaying) {
                                  _playerControl.pause();
                                } else {
                                  _playerControl.play();
                                }
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        (isPlay.id == widget.index.toString() &&
                                                isPlay.isPlaying)
                                            ? Icon(FontAwesomeIcons.pause,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20)
                                            : Icon(FontAwesomeIcons.play,
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .secondary,
                                                size: 20),
                                        Text(
                                          (isPlay.id.trim() ==
                                                      widget.index.toString() &&
                                                  isPlay.isPlaying)
                                              ? "PLAYING"
                                              : "PLAY NOW",
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15),
                                        ),
                                      ]),
                                ),
                              ),
                            );
                          })
                    ],
                  )),
            ),
          );
        });
  }
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

class SearchBarNav extends StatefulWidget {
  final Function action;
  const SearchBarNav({super.key, required this.action});

  @override
  State<SearchBarNav> createState() => _SearchBarNavState();
}

class _SearchBarNavState extends State<SearchBarNav> {
  @override
  Widget build(BuildContext context) {
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
      margin: const EdgeInsets.only(top: 13),
      child: InkWell(
        onTap: () => widget.action(),
        child: TextField(
          enabled: false,
          onChanged: (value) {
            return;
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
      ),
    );
  }
}

Widget lectureUIComponent(BuildContext context, String action,
    List<String> content, bool isModalList, var icon, int currentLecture) {
  return Column(
    children: [
      Row(
        children: [
          if (icon != null)
            icon
          else
            ValueListenableBuilder(
                valueListenable: _playerControl.currentSongTitleNotifier,
                builder: ((context, value, child) =>
                    (value.id == currentLecture.toString())
                        ? GestureDetector(
                            onTap: () {
                              if (value.isPlaying) {
                                _playerControl.pause();
                              } else {
                                _playerControl.play();
                              }
                            },
                            child: Icon(
                                _playerControl.isPlaying()
                                    ? FontAwesomeIcons.pause
                                    : FontAwesomeIcons.play,
                                color: Theme.of(context).colorScheme.primary,
                                size: 25),
                          )
                        : GestureDetector(
                            onTap: () {
                              _playerControl.skipToIndex(currentLecture);
                              _playerControl.pause();
                              _playerControl.play();
                            },
                            child: const Icon(FontAwesomeIcons.play,
                                color: Colors.black54, size: 25),
                          ))),
          Expanded(
            flex: 1,
            child: ValueListenableBuilder(
              valueListenable: _playerControl.currentSongTitleNotifier,
              builder: (context, value, _) => InkWell(
                onTap: () {
                  if (value.id.isNotEmpty) {
                    if (int.parse(value.id) != int.parse(content[2])) {
                      _playerControl.skipToIndex(int.parse(content[2]));
                    }
                  } else {
                    _playerControl.skipToIndex(int.parse(content[2]));
                  }

                  Navigator.pushNamed(context, action);
                },
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
                    if (!isModalList) const Icon(FontAwesomeIcons.chevronRight)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: const Divider(
          thickness: 0.5,
          height: 2.0,
          color: Colors.black26,
        ),
      ),
    ],
  );
}
