import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final configProvider = ChangeNotifierProvider<Config>((ref) => Config());

class Config extends ChangeNotifier {
  static const String apiUrl =
      'https://de1.api.radio-browser.info/json/stations/bycountry/Portugal';

  static const String appName = 'Simple Radio';
  static const String appVersion = '0.3.0';
  static int _audioBitrate = 64000;

  Config() {
    // ignore: discarded_futures
    loadSettings();
  }

  int get audioBitrate => _audioBitrate;

  set audioBitrate(int value) {
    _audioBitrate = value;
    notifyListeners();
  }

  Future<void> loadSettings() async {
    audioBitrate = await getAudioBitrate();
  }

  Future<int> getAudioBitrate() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('audioBitrate') ?? 64000;
  }

  Future<void> setAudioBitrate(int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('audioBitrate', value);
  }
}
