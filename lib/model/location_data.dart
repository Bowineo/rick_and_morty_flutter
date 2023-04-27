import 'package:rick_and_morty/model/location.dart';

class LocationData {
  List<Location> locations = [];
  
  static final LocationData _instance = LocationData._internal();
  factory LocationData() => _instance;
  LocationData._internal();
}
