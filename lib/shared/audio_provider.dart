import 'dart:io';
import 'package:abotoapp/shared/page_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

import 'package:audio_service/audio_service.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:get_it/get_it.dart';

Future<AudioProviderService> initAudioHandler() async {
  return await AudioService.init(
    builder: () => AudioProviderService(),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'bboinnovate.islam.abotoap',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    ),
  );
}

GetIt getIt = GetIt.instance;

class AudioProviderService extends BaseAudioHandler {
  final player = AudioPlayer();

  // final mediaItems = playlist.map()
  late ConcatenatingAudioSource playList;

  AudioProviderService() {
    playbackState.add(playbackState.value.copyWith(
      controls: [MediaControl.play],
      processingState: AudioProcessingState.loading,
    ));

    _notifyAudioHandlerAboutPlaybackEvents();
    _listenForDurationChanges();
    _listenForCurrentSongIndexChanges();
  }

  @override
  Future<void> addQueueItems(List<MediaItem> mediaItems) async {
    const String prePath = 'assets/lectures/';

    final directory = await getApplicationDocumentsDirectory();
    List<AudioSource> audioSources = [];
    ByteData content;
    File file;
    for (var element in mediaItems) {
      content = await rootBundle.load("$prePath${element.extras!['path']}.mp3");
      file = File("${directory.path}/${element.extras!['path']}.mp3");
      file.writeAsBytesSync(content.buffer.asUint8List());
      // Retrieve the duration of the audio file

      audioSources.add(AudioSource.file(file.path, tag: mediaItems));
    }

    playList = ConcatenatingAudioSource(
        children: audioSources, useLazyPreparation: true);

    try {
      await player.setAudioSource(playList,
          initialIndex: 0, initialPosition: Duration.zero);
    } catch (e) {
      return;
    }

    // notify system
    final newQueueList = queue.value..addAll(mediaItems);

    queue.add(newQueueList);
  }

  void _notifyAudioHandlerAboutPlaybackEvents() {
    player.playbackEventStream.listen((PlaybackEvent event) {
      final playing = player.playing;
      playbackState.add(playbackState.value.copyWith(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.stop,
          MediaControl.skipToNext,
        ],
        systemActions: const {
          MediaAction.seek,
        },
        androidCompactActionIndices: const [0, 1, 3],
        processingState: const {
          ProcessingState.idle: AudioProcessingState.idle,
          ProcessingState.loading: AudioProcessingState.loading,
          ProcessingState.buffering: AudioProcessingState.buffering,
          ProcessingState.ready: AudioProcessingState.ready,
          ProcessingState.completed: AudioProcessingState.completed,
        }[player.processingState]!,
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: event.currentIndex,
      ));
    });
  }

  ValueNotifier<Duration> durationStream = ValueNotifier(Duration.zero);

  void _listenForDurationChanges() {
    player.durationStream.listen((duration) {
      var index = player.currentIndex;
      if (duration != null) {
        durationStream.value = duration!;
        // final index = player.currentIndex;
        final newQueue = queue.value;
        if (index == null || newQueue.isEmpty) return;
        if (player.shuffleModeEnabled) {
          index = player.shuffleIndices!.indexOf(index);
        }
        final oldMediaItem = newQueue[index];
        final newMediaItem = oldMediaItem.copyWith(duration: duration);
        newQueue[index] = newMediaItem;
        queue.add(newQueue);
        mediaItem.add(newMediaItem);
      }
    });
  }

  void _listenForCurrentSongIndexChanges() {
    player.currentIndexStream.listen((index) {
      final playlist = queue.value;
      if (index == null || playlist.isEmpty) return;
      if (player.shuffleModeEnabled) {
        index = player.shuffleIndices!.indexOf(index);
      }
      mediaItem.add(playlist[index]);
    });
  }

  void onShuffleButtonPressed() async {
    final enable = !player.shuffleModeEnabled;
    if (enable) {
      await player.shuffle();
    }
    await player.setShuffleModeEnabled(enable);
  }

  Future<void> playLecture() async {
    playbackState.add(playbackState.value.copyWith(
      playing: player.playing,
      controls: player.playing ? [MediaControl.pause] : [MediaControl.play],
    ));

    if (player.playing) return await player.pause();
    return await player.play();
  }

  @override
  Future<void> seek(Duration position) => player.seek(position);
  Future<void> pauseLecture() async {
    return await player.pause();
  }

  nextLecture() {
    player.seekToNext();
  }

  previousLecture() {
    player.seekToPrevious();
  }

  stopLecture() {
    player.stop();
  }

  repeatLecture(state) {
    if (state) return player.setLoopMode(LoopMode.one);
    return player.setLoopMode(LoopMode.off);
  }

  // Future<void> shuffleOrder() async {
  //   return await player.setShuffleModeEnabled(true);
  // }
}
