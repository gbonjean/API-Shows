class Show {
  final int id;
  final String title;
  final String year;
  final String director;
  final int duration;
  final int rate;
  final String type;
  final String description;
  final String thumbUrl;
  final String bannerUrl;
  bool isFavorite = false;

  Show({
    required this.id,
    required this.title,
    required this.year,
    required this.director,
    required this.duration,
    required this.rate,
    required this.type,
    required this.description,
    required this.thumbUrl,
    required this.bannerUrl,
    bool? isFavorite,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      id: json['id'] as int,
      title: json['title'] as String,
      year: json['year'] as String,
      director: json['director'] as String,
      duration: json['duration'] as int,
      rate: json['rate'] as int,
      type: json['type'] as String,
      description: json['description'] as String,
      thumbUrl: json['thumb_url'] as String,
      bannerUrl: json['banner_url'] as String,
    );
  }

}
