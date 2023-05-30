import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class AudioProvider with ChangeNotifier {
  final player = AudioPlayer();
  late ConcatenatingAudioSource playList;
  bool isPlaying() {
    bool isPlay = false;
    player.playerStateStream
        .listen((state) => {if (state.playing) isPlay = true});

    return isPlay;
  }

  final String prePath = 'assets/lectures/';

  late List<String> allLectures = ['ebo_sise', 'shortmusic'];

  Future<void> loadAllLectures() async {
    final directory = await getApplicationDocumentsDirectory();
    List<AudioSource> audioSources = [];
    ByteData content;
    File file;
    for (var element in allLectures) {
      content = await rootBundle.load("$prePath$element.mp3");
      file = File("${directory.path}/$element.mp3");
      file.writeAsBytesSync(content.buffer.asUint8List());
      audioSources.add(AudioSource.file(file.path));
    }

    playList = ConcatenatingAudioSource(
        useLazyPreparation: true, children: audioSources);
    try {
      await player.setAudioSource(playList,
          initialIndex: 0, initialPosition: Duration.zero);
    } catch (e) {
      return;
    }
  }

  playLecture() async {
    await player.play();
  }

  skipPlayer(int index) async {
    await player.seek(Duration.zero, index: index);
  }

  shuffleOrder() async {
    await player.setShuffleModeEnabled(true);
  }
}
