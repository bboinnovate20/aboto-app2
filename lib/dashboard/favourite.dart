import 'package:abotoapp/components.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

final PlayListManager _playerControl = getIt<PlayListManager>();

// ignore: must_be_immutable
class FavouriteLectures extends StatefulWidget {
  const FavouriteLectures({super.key});

  @override
  State<FavouriteLectures> createState() => _FavouriteLecturesState();
}

class _FavouriteLecturesState extends State<FavouriteLectures> {
  late FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  Map<String, String> allLecture = {};
  bool isDeletable = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    storage.readAll().then((favLecture) => setState(() {
          allLecture = Map.fromEntries(favLecture.entries
              .where((element) => !element.key.startsWith('rpdb')));
        }));

    // setState(() {
    //   // print(allLecture);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Favourite Lectures"),
                  InkWell(
                      onTap: () async {
                        if (isDeletable) {
                          // print()
                          for (int element
                              in _playerControl.selectToRemoveFav.value) {
                            await storage.delete(key: element.toString());
                          }
                          _playerControl.selectToRemoveFav.value = [];

                          updateFav(
                              storage,
                              (fav) => {
                                    setState(() {
                                      allLecture = Map.fromEntries(fav.entries
                                          .where((element) =>
                                              !element.key.startsWith('rpdb')));
                                    })
                                  });
                        }
                        setState(() {
                          isDeletable = !isDeletable;
                        });
                      },
                      child: isDeletable
                          ? const Icon(FontAwesomeIcons.check)
                          : const Icon(FontAwesomeIcons.circleMinus))
                ],
              ))),
      body: allLecture.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("No favourite Lecturer added yet",
                  style: TextStyle(color: Colors.grey)),
            )
          : ValueListenableBuilder(
              valueListenable: _playerControl.selectToRemoveFav,
              builder: (context, value, _) => LectureListTemplate(
                  allLectures: allLecture, isDeletable: isDeletable),
            ),
    );
  }
}

updateFav(storage, fun) async {
  final favLector = await storage.readAll();
  fun(favLector);
}
