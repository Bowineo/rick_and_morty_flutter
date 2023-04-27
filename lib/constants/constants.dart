import 'package:flutter/material.dart';
import '../model/location.dart';

String pathBasicApi = 'https://rickandmortyapi.com/api';

String pathApi(String value) {
  return pathBasicApi + '/' + value;
}

Color greenDefault = const Color.fromARGB(255, 30, 157, 34);

String getEpisodeName(String url) {
  List<String> urlParts = url.split('/');
  String episodeNumber = urlParts[urlParts.length - 1];
  return 'Episode $episodeNumber';
}

String getEpisode(String url) {
  List<String> urlParts = url.split('/');
  String episodeNumber = urlParts[urlParts.length - 1];
  return episodeNumber;
}

int getIndexLocation(String locationName, List<Location> locations) {
  for (int i = 0; i < locations.length; i++) {
    if (locations[i].name == locationName) {
      return i;
    }
  }
  return -1;
}
