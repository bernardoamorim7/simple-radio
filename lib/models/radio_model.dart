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
      name: json['name'],
      url: json['url'],
      favicon: json['favicon'],
      tags: json['tags'],
    );
  }
}
