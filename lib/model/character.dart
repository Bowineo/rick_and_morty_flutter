class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String originName;
  final String originUrl;
  final String locationName;
  final String locationUrl;
  final List<String> episode;
  final String created;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.originName,
    required this.originUrl,
    required this.locationName,
    required this.locationUrl,
    required this.episode,
    required this.created,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    List<String> episodeList = [];
    json['episode'].forEach((episode) {
      episodeList.add(episode);
    });

    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      type: json['type'],
      gender: json['gender'],
      image: json['image'],
      originName: json['origin']['name'],
      originUrl: json['origin']['url'],
      locationName: json['location']['name'],
      locationUrl: json['location']['url'],
      episode: episodeList,
      created: json['created'],
    );
  }
}
