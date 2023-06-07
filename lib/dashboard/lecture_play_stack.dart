import 'package:abotoapp/components.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:abotoapp/shared/audio_provider.dart';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;
final PlayListManager _playerControl = getIt<PlayListManager>();
final _audioForStream = getIt<AudioProviderService>();

class LecturePlaying extends StatelessWidget {
  const LecturePlaying({super.key});

  @override
  Widget build(BuildContext context) {
    final args = (ModalRoute.of(context)!.settings.arguments ??
        <String, String>{'title': 'No music'}) as Map;

    return Scaffold(
        body: SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topLeft, colors: [
          Theme.of(context).colorScheme.primary,
          Theme.of(context).colorScheme.secondary,
        ])),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0, right: 8.0, left: 8.0),
          child: ValueListenableBuilder(
            valueListenable: _playerControl.currentSongTitleNotifier,
            builder: (context, value, _) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                customAppBar(
                  context,
                  value.title,
                ),
                Expanded(
                  child: ImageMusicDetail(title: value.title),
                ),
                Favourite(id: value.id, title: value.title)
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

class ImageMusicDetail extends StatefulWidget {
  final String title;

  const ImageMusicDetail({super.key, required this.title});

  @override
  State<ImageMusicDetail> createState() => _ImageMusicDetailState();
}

class _ImageMusicDetailState extends State<ImageMusicDetail> {
  // late final Animation<double> _animation;
  late List<double> scaleAnim = [200, 100];

  @override
  void initState() {
    super.initState();

    // _playerControl.skipToIndex(widget.args['id']);
    //stream
    // _audioForStream.player.playerStateStream.listen((state) {
    //   if (state.playing) {
    //     setState(() {
    //       scaleAnim = [250, 150];
    //     });
    //   } else {
    //     setState(() {
    //       scaleAnim = [200, 100];
    //     });
    //   }
    // });
    // if (_playerControl.isPlaying()) {
    //   print("ddd");
    // } else
    //   (print('ddd'));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _playerControl.currentSongTitleNotifier,
      builder: (context, value, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: _playerControl.isPlayingNotifier,
            builder: (context, value, _) => AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: value ? 250 : 150,
              height: value ? 200 : 100,
              child: const Align(
                alignment: Alignment.center,
                child: Image(
                  image: AssetImage('images/logo.webp'),
                  // height: 400,
                ),
              ),
            ),
          ),
          Column(
            children: [
              Text(
                value.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              const Text(
                "Sheikh Abdul Ganiyy Aboto",
                style: TextStyle(height: 2.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget customAppBar(BuildContext context, text) {
  return Row(
    children: [
      InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white)),
      Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            '$text',
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      )
    ],
  );
}

class Favourite extends StatefulWidget {
  final String id;
  final String title;
  const Favourite({super.key, required this.id, required this.title});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));

  late final Animation<double> _animation;

  ValueNotifier<bool> userControl = ValueNotifier(false);
  int progBar = 10;
  late bool isLiked = false;
  late FlutterSecureStorage storage;

//  final options = IOSOptions(accessibility: .first_unlock);

  @override
  void initState() {
    super.initState();
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
    storage = getIt<FlutterSecureStorage>();
  }

  @override
  void dispose() {
    getIt<PlayListManager>().dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: _playerControl.currentSongTitleNotifier,
          builder: (context, value, child) {
            return InkWell(
                onTap: () async {
                  if (isLiked) {
                    await storage
                        .delete(key: value.id)
                        .then((value) => addedToFavourite());
                    setState(() {
                      isLiked = false;
                    });
                  } else {
                    await storage
                        .write(key: value.id, value: value.title)
                        .then((value) => addedToFavourite());

                    setState(() {
                      isLiked = true;
                    });
                  }
                  _controller.reset();
                  _controller.forward();
                },
                child: likeTransition(isLiked, storage, value.id));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 25.0),
          child: ValueListenableBuilder(
              valueListenable: _playerControl.progressNotifier,
              builder: ((context, value, child) => SliderTheme(
                  data: const SliderThemeData(
                      trackHeight: 10,
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 12)),
                  child: Slider(
                      min: 0,
                      max: _playerControl
                              .getTotalDurationStream()
                              .value
                              .inSeconds
                              .toDouble() +
                          1,
                      value: value.current.inSeconds.toDouble(),
                      onChangeEnd: (value) {
                        if (userControl.value) _playerControl.play();
                        userControl.value = false;
                      },
                      onChangeStart: (value) {
                        if (_playerControl.isPlaying()) {
                          userControl.value = true;
                        }
                        _playerControl.pause();
                      },
                      onChanged: (value) {
                        final newDuration = Duration(seconds: value.toInt());
                        _playerControl.seek(newDuration);
                      })))),
        ),
        Padding(
            padding: const EdgeInsets.only(bottom: 25.0, right: 10, left: 10),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: _playerControl.progressNotifier,
                      builder: (context, value, child) {
                        return Text(value.current.toString().split('.')[0],
                            style: Theme.of(context).textTheme.bodySmall);
                      }),
                  ValueListenableBuilder(
                      valueListenable: _playerControl.getTotalDurationStream(),
                      builder: (context, value, child) {
                        return Text(value.toString().split('.')[0],
                            style: Theme.of(context).textTheme.bodySmall);
                      })
                ])),
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ValueListenableBuilder(
                valueListenable: _playerControl.repeatMode,
                builder: (context, value, child) => InkWell(
                  onTap: () => _playerControl.repeat(),
                  child: Icon(
                    FontAwesomeIcons.repeat,
                    color: value ? Colors.grey : Colors.white,
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _playerControl.isFirstSongNotifier,
                builder: (context, value, _) => InkWell(
                  onTap: () => _playerControl.previous(),
                  child: Icon(
                    FontAwesomeIcons.backward,
                    color: value ? Colors.white38 : Colors.white,
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _playerControl.isPlayingNotifier,
                builder: (context, value, _) => InkWell(
                  onTap: () {
                    // setState(() => _isPlay = !_isPlay);
                    _playerControl.play();
                  },
                  highlightColor: Colors.white70,
                  splashColor: Colors.white70,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Icon(
                      value ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: _playerControl.isLastSongNotifier,
                builder: (context, value, _) => InkWell(
                  onTap: () => _playerControl.next(),
                  child: Icon(
                    FontAwesomeIcons.forward,
                    color: value ? Colors.white38 : Colors.white,
                  ),
                ),
              ),
              const FavouriteModal(),
            ],
          ),
        )
      ],
    );
  }

  ScaleTransition likeTransition(bool isLike, storage, String value) {
    storage.containsKey(key: value).then((isContained) {
      if (isContained) {
        setState(() {
          isLiked = isContained;
        });
      } else {
        setState(() {
          isLiked = isContained;
        });
      }
    });

    return ScaleTransition(
      scale: _animation,
      child: Icon(
        isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: isLiked ? Colors.red : Colors.white,
        size: 50,
      ),
    );
  }
}

addedToFavourite() {
  late FlutterSecureStorage storage = getIt<FlutterSecureStorage>();
  storage.readAll().then((favLecture) =>
      _playerControl.isAddedToFavouriteList.value = Map.fromEntries(favLecture
          .entries
          .where((element) => !element.key.startsWith('rpdb'))));
}

class FavouriteModal extends StatefulWidget {
  const FavouriteModal({
    super.key,
  });

  @override
  State<FavouriteModal> createState() => _FavouriteModalState();
}

class _FavouriteModalState extends State<FavouriteModal> {
  Map<String, String> favouriteLecture = {};

  @override
  void initState() {
    super.initState();
    addedToFavourite();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {showModalFavouriteLecture(context, favouriteLecture)},
      child: const Icon(
        FontAwesomeIcons.solidHeart,
        color: Colors.white,
      ),
    );
  }
}

showModalFavouriteLecture(BuildContext context, favouriteLecture) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Stack(
            children: [
              Row(children: [
                Icon(
                  FontAwesomeIcons.chevronDown,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Text(
                      'Favourite List',
                      style: Theme.of(context).primaryTextTheme.displayLarge,
                    ),
                  ),
                ),
              ]),
              Container(
                margin: const EdgeInsets.only(top: 25),
                child: ValueListenableBuilder(
                    valueListenable: _playerControl.isAddedToFavouriteList,
                    builder: (context, value, _) => LectureListTemplate(
                        allLectures: value, isDeletable: false)),
              ),
            ],
          ),
        );
      });
}
