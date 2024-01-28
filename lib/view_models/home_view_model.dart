import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/radio_model.dart';
import '../services/radio_service.dart';

final homeViewModelProvider = Provider((ref) => HomeViewModel());

class HomeViewModel extends ChangeNotifier {
  final RadioService _radioService = RadioService();
  final radios = <RadioModel>[];
  final ValueNotifier<String> searchQuery = ValueNotifier<String>('');

  Future<List<RadioModel>> fetchRadios() async {
    radios.addAll(await _radioService.fetchRadios());
    return radios;
  }
}
