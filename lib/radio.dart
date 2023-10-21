import 'dart:convert';
import 'package:just_audio/just_audio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Radio {
  final String name;
  final String url;
  final String favicon;

  Radio({
    required this.name,
    required this.url,
    required this.favicon,
  });

  factory Radio.fromJson(Map<String, dynamic> json) {
    return Radio(
      name: json['name'],
      url: json['url'],
      favicon: json['favicon'],
    );
  }
}

List<Radio> radios = [];

Future<bool> getRadios() async {
  String apiURL =
      "https://de1.api.radio-browser.info/json/stations/bycountry/Portugal";

  final response = await http.get(Uri.parse(apiURL));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    for (var element in jsonData) {
      Radio radio = Radio(
        name: element['name'],
        url: element['url'],
        favicon: element['favicon'],
      );
      radios.add(radio);
    }
    return true;
  } else {
    return false;
  }
}

class RadioTile extends StatelessWidget {
  final String name;
  final String url;
  final String favicon;

  const RadioTile({
    Key? key,
    required this.name,
    required this.url,
    required this.favicon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final player = AudioPlayer();
    player.setUrl(url);
    return ExpansionTile(
      title: ListTile(
        leading: Image.network(
          favicon,
          width: 50,
          height: 50,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.radio, size: 50,); // Display an icon as a fallback
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress != null) {
              return const CircularProgressIndicator(); // Display a loading indicator while the image is loading.
            }
            return child; // If the image has loaded successfully, display it.
          },
        ),
        title: Text(name),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow),
              onPressed: () {
                player.play();
              },
            ),
            IconButton(
              icon: const Icon(Icons.pause),
              onPressed: () {
                player.pause();
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop),
              onPressed: () {
                player.stop();
              },
            ),
          ],
        ),
      ],
    );
  }
}
