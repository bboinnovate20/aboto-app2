import 'package:flutter/material.dart';

class ProgressNotifier extends ValueNotifier<ProgressBarState> {
  ProgressNotifier()
      : super(const ProgressBarState(
            current: Duration.zero,
            buffered: Duration.zero,
            total: Duration.zero));
}

class ButtonDecisionNotifier extends ValueNotifier<ButtonDecisionState> {
  ButtonDecisionNotifier()
      : super(const ButtonDecisionState(title: '', idle: true));
}

class SongMediaNotifier extends ValueNotifier<SongMediaState> {
  SongMediaNotifier()
      : super(const SongMediaState(title: '', id: '', isPlaying: false));
}

class ProgressBarState {
  const ProgressBarState(
      {required this.current, required this.buffered, required this.total});

  final Duration current;
  final Duration buffered;
  final Duration total;
}

class ButtonDecisionState {
  const ButtonDecisionState({required this.title, required this.idle});

  final String title;
  final bool idle;
}

class SongMediaState {
  const SongMediaState(
      {required this.title, required this.id, required this.isPlaying});
  final String title;
  final bool isPlaying;
  final String id;
}
