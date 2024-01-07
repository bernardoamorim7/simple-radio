import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/radio_model.dart';
import '../utilities/config.dart';

class RadioService {
  Future<List<RadioModel>> fetchRadios() async {
    final response = await http.get(Uri.parse(Config.apiUrl));

    if (response.statusCode == HttpStatus.ok) {
      final List jsonResponse = json.decode(response.body);
      // ignore: unnecessary_lambdas
      return jsonResponse.map((radio) => RadioModel.fromJson(radio)).toList();
    } else {
      throw Exception('Failed to load radios');
    }
  }
}
