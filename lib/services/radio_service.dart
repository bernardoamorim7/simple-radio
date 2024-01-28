import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../models/radio_model.dart';
import '../utilities/config.dart';

class RadioService {
  Future<List<RadioModel>> fetchRadios() async {
    final response = await http.get(
      Uri.parse(Config.apiUrl),
      headers: {
        HttpHeaders.acceptCharsetHeader: 'utf-8',
        HttpHeaders.acceptHeader: 'application/json',
        HttpHeaders.contentEncodingHeader: 'utf-8',
        HttpHeaders.acceptEncodingHeader: 'gzip',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final List jsonResponse = json.decode(response.body);
      // ignore: unnecessary_lambdas
      return jsonResponse.map((radio) => RadioModel.fromJson(radio)).toList();
    } else {
      throw Exception('Failed to load radios');
    }
  }
}
