import 'package:abotoapp/shared/notifier.dart';
import 'package:flutter/foundation.dart';
// import 'notifiers/play_button_notifier.dart';
// import 'notifiers/progress_notifier.dart';
// import 'notifiers/repeat_button_notifier.dart';
// import 'services/playlist_repository.dart';
import 'package:abotoapp/shared/audio_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:audio_service/audio_service.dart';
import 'package:abotoapp/services/repository_list.dart';
import 'package:just_audio/just_audio.dart';

GetIt getIt = GetIt.instance;

class PlayListManager {
  // Listeners: Updates going to the UI
  final currentSongTitleNotifier = SongMediaNotifier();
  final playlistNotifier = ValueNotifier<Map<String, String>>({});
  final recentPrefix = 'rpdb';
  final allRecent = ValueNotifier({});
  final progressNotifier = ProgressNotifier();
  final recentPlayedNotifier = ValueNotifier<Map<String, String>>({});
  final bottomStateNotifier = ButtonDecisionNotifier();
  final lectureName = 'Alhaji AbdulGaniyy Aboto';
  final isBuffered = ValueNotifier(false);
  // final repeatButtonNotifier = RepeatButtonNotifier();
  final isPlayingNotifier = ValueNotifier<bool>(false);
  final isFirstSongNotifier = ValueNotifier<bool>(true);
  final playButtonNotifier = ValueNotifier<bool>(false);

  final isLastSongNotifier = ValueNotifier<bool>(true);
  final currentPlayingIndex = ValueNotifier<int>(0);
  final isShuffleModeEnabledNotifier =
      ValueNotifier<bool>(false); //implement later
  final repeatMode = ValueNotifier<bool>(false);
  final selectToRemoveFav = ValueNotifier<List<int>>([]);
  final _audioHandler = getIt<AudioProviderService>();

  final isAddedToFavouriteList = ValueNotifier<Map<String, String>>({});
  late FlutterSecureStorage storage;

  // Events: Calls coming from the UI
  void init() async {
    final playListings = Playlist();
    final mediaItems = playListings
        .showList()
        .map(
          (lecture) => MediaItem(
              id: lecture['id'] ?? '',
              title: lecture['title'] ?? '',
              displayTitle: lecture['title'] ?? '',
              extras: {'path': lecture['name'] ?? ''},
              displaySubtitle: 'Alhaji Aboto Lecture'),
        )
        .toList();

    await _audioHandler.addQueueItems(mediaItems);

    storage = getIt<FlutterSecureStorage>();
    _listenToTotalDuration();
    listenToChangesInPlaylist((list) => {});
    _listenToPlaybackState();
    _listenToCurrentPosition();
    _listenToPositionBuffered();
    _listenToChangesInSong();
    _listenToSequenceState();
    _listenToPlayingStream();
    recentlyPlaying(currentPlayingIndex.value);
  }

  void _listenToPositionBuffered() {
    _audioHandler.playbackState.listen((value) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: value.bufferedPosition,
          total: oldState.total);
    });
  }

  ValueNotifier<Duration> getTotalDurationStream() {
    return _audioHandler.durationStream;
  }

  void _listenToPlayingStream() {
    _audioHandler.player.playerStateStream.listen((state) {
      if (state.playing) {
        bottomStateNotifier.value = ButtonDecisionState(
            title: _audioHandler.player.sequenceState!.currentSource!
                .tag[currentPlayingIndex.value].title,
            idle: false);
        currentPlayingIndex.value = _audioHandler.player.currentIndex!;
        isPlayingNotifier.value = true;
        playButtonNotifier.value = true;
        final title = _audioHandler.player.sequenceState!.currentSource!
            .tag[currentPlayingIndex.value].title;
        currentSongTitleNotifier.value = SongMediaState(
            title: title,
            id: _audioHandler.player.currentIndex!.toString(),
            isPlaying: true);

        recentlyPlaying(currentPlayingIndex.value);
      } else {
        final oldSongNotifier = currentSongTitleNotifier.value;
        currentSongTitleNotifier.value = SongMediaState(
            title: oldSongNotifier.title,
            id: oldSongNotifier.id,
            isPlaying: false);

        isPlayingNotifier.value = false;
      }

      switch (state.processingState) {
        case ProcessingState.idle:
          final oldState = bottomStateNotifier.value;
          bottomStateNotifier.value =
              ButtonDecisionState(title: oldState.title, idle: true);
          break;
        case ProcessingState.loading:
          break;
        case ProcessingState.buffering:
          break;
        case ProcessingState.ready:
          _updateSkipButtons();
          isBuffered.value = true;
          break;
        case ProcessingState.completed:
          break;
      }
    });
  }

  void _listenToTotalDuration() {
    _audioHandler.mediaItem.listen((value) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: value?.duration ?? Duration.zero,
      );
    });
  }

  Future<void> recentlyPlaying(int value) async {
    final allStorage = await storage.readAll();
    if (value.toString().isNotEmpty) {
      final favourite = allStorage.entries
          .where((entry) => entry.key.startsWith(recentPrefix))
          .toList();

      if (favourite.length > 4) {
        for (var i = 0; i < favourite.length - 2; i++) {
          await storage.delete(key: favourite[i].key);
        }
      } else {
        storage.write(
            key: '${recentPrefix}_$value',
            value: currentSongTitleNotifier.value.title);
      }
    }
    allRecent.value = Map.fromEntries(allStorage.entries
        .where((entry) => entry.key.startsWith(recentPrefix)));
  }

  void listenToChangesInPlaylist(Function func) {
    _audioHandler.queue.listen((playlist) {
      if (playlist.isEmpty) return;
      Map<String, String> list = {};

      for (var element in playlist) {
        list[element.id] = element.title;
      }

      func(list);
      playlistNotifier.value = list;
      // print(newList['id']);
    });
  }

  void play() async {
    await _audioHandler.playLecture();
  }

  void stop() async {
    await _audioHandler.stopLecture();
  }

  void pause() async {
    await _audioHandler.pauseLecture();
  }

  bool isPlaying() {
    return _audioHandler.player.playing;
  }

  void _listenToPlaybackState() {
    _audioHandler.playbackState.listen((playbackState) {
      _updateSkipButtons();

      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;
      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        // playButtonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        // playButtonNotifier.value = ButtonState.paused;
      } else if (processingState != AudioProcessingState.completed) {
        // playButtonNotifier.value = ButtonState.playing;
      } else {
        _audioHandler.seek(Duration.zero);
        _audioHandler.pause();
      }
    });
  }

  void _listenToCurrentPosition() {
    AudioService.position.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });
  }

  void _listenToChangesInSong() {
    _audioHandler.mediaItem.listen((mediaItem) {
      final oldSongState = currentSongTitleNotifier.value;
      currentSongTitleNotifier.value = SongMediaState(
          title: mediaItem?.title ?? '',
          id: oldSongState.id,
          isPlaying: oldSongState.isPlaying);

      _updateSkipButtons();
    });
  }

  void _updateSkipButtons() {
    final mediaItem = _audioHandler.mediaItem.value;
    final playlist = _audioHandler.queue.value;

    if (playlist.length < 2) {
      isFirstSongNotifier.value = true;
      isLastSongNotifier.value = true;
    } else {
      isFirstSongNotifier.value = playlist.first == mediaItem;
      isLastSongNotifier.value = playlist.last == mediaItem;
    }
  }

  void _listenToSequenceState() {
    _audioHandler.player.sequenceStateStream.listen((state) {
      if (state == null) return;

      isShuffleModeEnabledNotifier.value = state.shuffleModeEnabled;
    });
  }

  void seek(Duration position) => _audioHandler.seek(position);
  void previous() => _audioHandler.previousLecture();
  void next() => _audioHandler.nextLecture();
  void repeat() {
    _audioHandler.repeatLecture(!repeatMode.value);
    repeatMode.value = !repeatMode.value;
  }

  void shuffle() {
    _audioHandler.onShuffleButtonPressed();
  }

  void skipToIndex(int newIndex) async {
    // _audioHandler.seek(Duration.zero, index: newIndex);

    await _audioHandler.player.seek(Duration.zero, index: newIndex);

    // await _audioHandler.playLecture();
    final oldState = currentSongTitleNotifier.value;
    currentSongTitleNotifier.value = SongMediaState(
        title: oldState.title, id: oldState.id, isPlaying: oldState.isPlaying);
    await _audioHandler.player.play();
  }

  void add() {}
  void remove() {}
  void dispose() {}
}
