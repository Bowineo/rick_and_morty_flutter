
class Episode {
  final int id;
  final String name;
  final String airDate;
  final String episode;
  late List<String> characters;
  final String url;
  final String created;

  Episode({
    required this.id,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
    required this.url,
    required this.created,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    List<String> characterList =
        List<String>.from(json['characters'].map((x) => x));

    return Episode(
      id: json['id'],
      name: json['name'],
      airDate: json['air_date'],
      episode: json['episode'],
      characters: characterList,
      url: json['url'],
      created: json['created'],
    );
  }
}