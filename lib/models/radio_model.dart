import 'dart:convert';

class RadioModel {
  final String name;
  final String url;
  final String favicon;
  final String tags;

  RadioModel({
    required this.name,
    required this.url,
    required this.favicon,
    required this.tags,
  });

  factory RadioModel.fromJson(Map<String, dynamic> json) {
    return RadioModel(
      name: const Utf8Decoder().convert(json['name'].toString().codeUnits),
      url: json['url'].toString(),
      favicon: json['favicon'].toString(),
      tags: const Utf8Decoder().convert(json['tags'].toString().codeUnits),
    );
  }
}
