import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

import '../utilities/config.dart';

final radioTileViewModelProvider = ChangeNotifierProvider(
  (ref) => RadioTileViewModel(),
);

class RadioTileViewModel extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  final configState = Config(); 

  RadioTileViewModel() {
    _player.playerStateStream.listen(_updateState);
  }

  bool get playing => _player.playing;
  bool get paused =>
      _player.playerState.processingState == ProcessingState.ready &&
      !_player.playing;

  Future<void> play(String url) async {
    await _player.setUrl(url);
    await _player.setPreferredPeakBitRate(configState.audioBitrate.toDouble());
    await _player.play();
  }

  Future<void> resume() async {
    await _player.play();
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> stop() async {
    await _player.stop();
  }

  void _updateState(PlayerState playerState) {
    notifyListeners();
  }
}
