import 'package:rick_and_morty/model/episode.dart';

class EpisodeData {
  List<Episode> episodes = [];
  
  static final EpisodeData _instance = EpisodeData._internal();
  factory EpisodeData() => _instance;
  EpisodeData._internal();
}
