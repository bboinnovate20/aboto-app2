import 'package:abotoapp/shared/audio_provider.dart';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:abotoapp/components.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
final PlayListManager _playerControl = getIt<PlayListManager>();
final _audioForStream = getIt<AudioProviderService>();

class AllLectures extends StatefulWidget {
  const AllLectures({super.key});

  @override
  State<AllLectures> createState() => _AllLecturesState();
}

class _AllLecturesState extends State<AllLectures> {
  Map<String, String> allLectures = {};
  Map<String, String> immutableLectureList = {};

  @override
  void initState() {
    super.initState();

    var listen = _playerControl.listenToChangesInPlaylist((list) => {
          setState(() {
            allLectures = list;
            immutableLectureList = list;
          })
        });
  }

  @override
  void dispose() {
    super.dispose();
    _playerControl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Align(
                alignment: Alignment.centerLeft, child: Text("All Lectures")),
            leading: null,
            backgroundColor: Theme.of(context).colorScheme.background),
        body:
            LectureListTemplate(allLectures: allLectures, isDeletable: false));
  }
}

class LectureListTemplate extends StatefulWidget {
  final Map<String, String> allLectures;
  final bool isDeletable;
  const LectureListTemplate(
      {super.key, required this.allLectures, required this.isDeletable});

  @override
  State<LectureListTemplate> createState() => _LectureListTemplateState();
}

class _LectureListTemplateState extends State<LectureListTemplate> {
  @override
  Widget build(BuildContext context) {
    Map<String, String> allLectures = widget.allLectures;
    Map<String, String> immutableLectureList = allLectures;

    return Stack(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8.0),
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
                  setState(() {
                    allLectures = Map.fromEntries(
                        immutableLectureList.entries.where((entry) {
                      var regExp = RegExp(value);
                      return regExp
                          .hasMatch(entry.value.toString().toLowerCase());
                    }));
                  });
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
        ValueListenableBuilder(
          valueListenable: _playerControl.currentSongTitleNotifier,
          builder: (context, value, _) => Container(
            margin: const EdgeInsets.only(top: 100),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: allLectures.isNotEmpty
                  ? ListView(
                      children: allLectures.entries
                          .map((entry) => lectureUIComponent(
                              context,
                              '/lecturePlay',
                              [
                                entry.value,
                                _playerControl.lectureName,
                                entry.key.toString()
                              ],
                              false,
                              widget.isDeletable
                                  ? CheckBoxMain(id: int.parse(entry.key))
                                  : null,
                              int.parse(entry.key)))
                          .toList(),
                    )
                  : Container(),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class CheckBoxMain extends StatefulWidget {
  int id;
  CheckBoxMain({super.key, required this.id});

  @override
  State<CheckBoxMain> createState() => _CheckBoxMainState();
}

class _CheckBoxMainState extends State<CheckBoxMain> {
  bool isSelected = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.grey;
    }
    return Theme.of(context).colorScheme.primary;
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isSelected,
      onChanged: (value) {
        setState(() {
          if (!isSelected) {
            _playerControl.selectToRemoveFav.value.add(widget.id);
          } else {
            _playerControl.selectToRemoveFav.value.remove(widget.id);
          }
          isSelected = !isSelected;
        });
      },
      fillColor: MaterialStateProperty.resolveWith(getColor),
    );
  }
}
