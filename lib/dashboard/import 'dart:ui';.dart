import 'dart:ui';
import 'package:flutter_advanced_seekbar/flutter_advanced_seekbar.dart';
import 'package:abotoapp/dashboard/lectures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:abotoapp/shared/audio_provider.dart';

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              customAppBar(
                context,
                args['title'],
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 85, bottom: 20),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage('images/logo.webp'),
                          height: 200,
                          // fit: BoxFit.contain
                        ),
                      ),
                    ),
                    Text(
                      args['title'],
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
              ),
              const Favourite()
            ],
          ),
        ),
      ),
    ));
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
  const Favourite({super.key});

  @override
  State<Favourite> createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _animation;

  bool _isPlay = false;
  bool _isLoaded = false;

  ValueNotifier<String> totalDuration = ValueNotifier("0:00:00");
  // ValueNotifier<int> progressDuration = ValueNotifier(0);
  int progBar = 10;

  late bool isLike;
  @override
  void initState() {
    super.initState();
    _animation =
        // CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
        Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
    isLike = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final lectureAudioProvider =
    //     Provider.of<AudioProvider>(context, listen: true);

    // if (_isLoaded == false) {
    //   lectureAudioProvider.loadAllLectures();
    //   print(lectureAudioProvider.skipPlayer(111));
    //   // lectureAudioProvider.player.seek(Duration.zero, index: 2);
    //   setState(() {
    //     _isLoaded = true;
    //   });

    //   lectureAudioProvider.player.positionStream.listen((event) {
    //     // progressDuration.value = event.inSeconds;
    //     setState(() {
    //       progBar++;
    //       print(progBar);
    //     });
    //     if (lectureAudioProvider.player.duration != null) {
          // var posDiv = progressDuration.value /
          //     lectureAudioProvider.player.duration!.inSeconds;

          // progressDuration.value = posDiv.toInt() * 100;

          // progressDuration.value = (progressDuration.value /
          //         lectureAudioProvider.player.duration!.inMilliseconds) *
          //     100;
        // }
      // });

      // lectureAudioProvider.player.playerStateStream.listen((state) async {
      //   switch (state.processingState) {
      //     case ProcessingState.ready:
      //     case ProcessingState.idle:
      //       null;
      //       break;
      //     case ProcessingState.loading:
      //       null;
      //       break;
      //     case ProcessingState.buffering:
      //       var durationTime = lectureAudioProvider.player.duration;
      //       totalDuration.value = durationTime.toString().split('.')[0];
      //       break;
      //     case ProcessingState.completed:
      //       null;
      //       break;
      //   }
        // if (state.playing) {
        //   print('playing');
        // } else {
        //   print('pause');
        // }
      // });
    }
    // lectureAudioProvider.player.duration;
    // lectureAudioProvider.player.durationStream.listen((position) {
    //   // final pos = counter;
    //   print(lectureAudioProvider.player.duration);
    // });

    // playLecture(BuildContext context, isPlay) async {
    //   if (lectureAudioProvider.player.playing) {
    //     await lectureAudioProvider.player.pause();
    //   } else {
    //     lectureAudioProvider.player.play();
    //     // await lectureAudioProvider.player
    //     //     .seek(lectureAudioProvider.player.position);
    //   }
    // }

    // skipTo(context, 1);
    // lectureAudioProvider.player.playerStateStream.listen((state) async {
    //   switch (state.processingState) {
    //     case ProcessingState.buffering:
    //       print(lectureAudioProvider.player.bufferedPosition);

    //       break;
    //     default:
    //       print('d');
    //     // case ProcessingState.idle: ...
    //     // case ProcessingState.loading: ...
    //     // case ProcessingState.ready: ...
    //     // case ProcessingState.completed: ...
    //   }
    // });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(onTap: () => onTap(), child: likeTransition(isLike)),
          Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: StreamBuilder(builder: (context, snapshot) {
                return AdvancedSeekBar(Colors.blue.shade100, 15,
                    Theme.of(context).colorScheme.primary,
                    fillProgress: true,
                    seekBarProgress: (value) => {print('ddd$value')});
              })),

          // Padding(
          //     padding: const EdgeInsets.only(bottom: 25.0),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         // ValueListenableBuilder(
          //         //     valueListenable: progressDuration,
          //         //     builder: ((context, value, child) => Text(
          //         //         value.toString().split('.')[0],
          //         //         style: Theme.of(context).textTheme.bodySmall))),
          //         // ValueListenableBuilder(
          //         //     valueListenable: totalDuration,
          //         //     builder: ((context, value, child) => Text(value,
          //         //         style: Theme.of(context).textTheme.bodySmall)))
          //       ],
          //     )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => {},
                child: const Icon(
                  FontAwesomeIcons.shuffle,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () => {},
                child: const Icon(
                  FontAwesomeIcons.backward,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _isPlay = !_isPlay;
                  });
                  playLecture(context, _isPlay);
                },
                highlightColor: Colors.white70,
                splashColor: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Icon(
                    _isPlay ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: () => {},
                child: const Icon(
                  FontAwesomeIcons.forward,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () => {},
                child: const Icon(
                  FontAwesomeIcons.solidHeart,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  onTap() {
    setState(() {
      isLike = !isLike;
      _controller.reset();
      _controller.forward();
    });
  }

  ScaleTransition likeTransition(bool isLike) {
    return ScaleTransition(
      scale: _animation,
      child: Icon(
        isLike ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
        color: isLike ? Colors.red : Colors.white,
        size: 50,
      ),
    );
  }
}

skipTo(BuildContext context, int index) {
  Provider.of<AudioProvider>(context).skipPlayer(index);
}
