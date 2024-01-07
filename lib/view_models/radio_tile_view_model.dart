import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

final radioTileViewModelProvider = Provider((ref) => RadioTileViewModel());

class RadioTileViewModel {
  final AudioPlayer _player = AudioPlayer();

  Future play(String url) async {
    await _player.setUrl(url);
    await _player.setPreferredPeakBitRate(90000);
    await _player.play();
  }

  Future pause() async {
    await _player.pause();
  }

  Future stop() async {
    await _player.stop();
  }
}
