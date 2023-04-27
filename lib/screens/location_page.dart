import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/location_data.dart';
import '../components/custom_circular_progress.dart';
import '../components/custom_text.dart';
import '../constants/constants.dart';
import '../model/character.dart';
import '../model/character_data.dart';
import '../model/location.dart';
import 'datasheet_page.dart';

class LocationPage extends StatefulWidget {
  final String? location;
  const LocationPage({
    Key? key,
    this.location,
  }) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  List<Location> _locations = [];
  String _selectedLocationName = '';
  String _type = '';
  String _dimension = '';
  List<Character> _characters = [];
  final characterData = CharacterData();
  final locationData = LocationData();
  List<String> _listResidents = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedLocationName = '';
    _type = '';
    _dimension = '';
    _locations = [];
    _characters = characterData.characters;
    if (LocationData().locations.isEmpty) {
      _loadData();
    } else {
      if (widget.location == null) {
        setState(() {
          _locations = LocationData().locations;
          _selectedLocationName = _locations[0].name;
          _type = _locations[0].type;
          _dimension = _locations[0].dimension;
          _listResidents = _locations[0].residents;
        });
      } else {
        int n = getIndexLocation(
            widget.location.toString(), LocationData().locations);
        setState(() {
          _locations = LocationData().locations;
          _selectedLocationName = _locations[n].name;
          _type = _locations[n].type;
          _dimension = _locations[n].dimension;
          _listResidents = _locations[n].residents;
        });
      }
    }
  }

  Future<void> _loadData() async {
    final List<Location> locations = [];

    int page = 1;
    bool hasMorePages = true;

    while (hasMorePages) {
      final response =
          await http.get(Uri.parse(pathApi('location?page=$page')));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (final result in data['results']) {
          final location = Location.fromJson(result);
          locations.add(location);
        }

        hasMorePages = data['info']['next'] != null;
        page++;
      } else {
        throw Exception('Failed to load data');
      }
    }

    if (widget.location == null) {
      setState(() {
        _locations = locations;
        _selectedLocationName = _locations[0].name;
        _type = _locations[0].type;
        _dimension = _locations[0].dimension;
        _listResidents = _locations[0].residents;
        LocationData().locations = locations;
      });
    } else {
      int n = getIndexLocation(widget.location.toString(), locations);
      setState(() {
        _locations = locations;
        _selectedLocationName = _locations[n].name;
        _type = _locations[n].type;
        _dimension = _locations[n].dimension;
        _listResidents = _locations[n].residents;
      });
    }
  }

  void _searchLocation(String name) {
    final selectedLocation = _locations.firstWhere((e) => e.name == name);
    setState(() {
      _selectedLocationName = selectedLocation.name;
      _type = selectedLocation.type;
      _dimension = selectedLocation.dimension;
      _listResidents = selectedLocation.residents;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _fontSize_16 = MediaQuery.of(context).size.width * .04;
    double _fontSize_24 = MediaQuery.of(context).size.width * .06;
    return Scaffold(
        backgroundColor: Colors.amber.shade50,
        body: _locations.isEmpty
            ? const Center(
                child: CustomCircularProgress(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * .8,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DropdownButtonFormField<String>(
                              decoration: InputDecoration(
                                labelText: 'Select the Location',
                                labelStyle: TextStyle(
                                    fontFamily: 'Creepster',
                                    fontSize: _fontSize_16,
                                    color: Colors.black),
                                border: OutlineInputBorder(),
                              ),
                              value: _selectedLocationName,
                              onChanged: (value) => _searchLocation(value!),
                              items: _locations
                                  .map(
                                    (location) => DropdownMenuItem<String>(
                                      value: location.name,
                                      child: Text(
                                        location.name,
                                        style: TextStyle(
                                            fontFamily: 'Creepster',
                                            fontSize: 16,
                                            color: Colors.green),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 24,
                              right: 8,
                              left: 8,
                              bottom: 8,
                            ),
                            child: Row(
                              children: [
                                CustomText(
                                    text: 'Name: ',
                                    color: Colors.black,
                                    fontSize: _fontSize_16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: CustomText(
                                        text: _selectedLocationName,
                                        color: Colors.green,
                                        fontSize: _fontSize_16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CustomText(
                                    text: 'Type: ',
                                    color: Colors.black,
                                    fontSize: _fontSize_16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: CustomText(
                                        text: _type,
                                        color: Colors.green,
                                        fontSize: _fontSize_16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                CustomText(
                                    text: 'Dimension: ',
                                    color: Colors.black,
                                    fontSize: _fontSize_16),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: CustomText(
                                        text: _dimension,
                                        color: Colors.green,
                                        fontSize: _fontSize_16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 24,
                                    bottom: 8,
                                  ),
                                  child: CustomText(
                                      text:
                                          'Characters who have been last seen in the location:',
                                      color: Colors.black,
                                      fontSize: _fontSize_16),
                                ),
                                Container(
                                  color: Colors.transparent,
                                  height:
                                      MediaQuery.of(context).size.height * .45,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: _listResidents.isNotEmpty
                                      ? Scrollbar(
                                          controller: _scrollController,
                                          isAlwaysShown: true,
                                          child: GridView.builder(
                                            physics: const ScrollPhysics(),
                                            controller: _scrollController,
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              childAspectRatio: 1,
                                              crossAxisSpacing: 8,
                                              mainAxisSpacing: 2,
                                            ),
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _listResidents.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => Datasheet(
                                                            character: _characters[
                                                                int.parse((_listResidents[
                                                                            index]
                                                                        .split(
                                                                            '/')
                                                                        .last)) -
                                                                    1])),
                                                  );
                                                },
                                                child: SizedBox(
                                                  width: 80,
                                                  height: 80,
                                                  child: Hero(
                                                    tag: _characters[int.parse(
                                                                (_listResidents[
                                                                        index]
                                                                    .split('/')
                                                                    .last)) -
                                                            1]
                                                        .image,
                                                    createRectTween:
                                                        (begin, end) {
                                                      return MaterialRectCenterArcTween(
                                                          begin: begin,
                                                          end: end);
                                                    },
                                                    child: ClipOval(
                                                      child: Image.network(
                                                        _characters[int.parse(
                                                                    (_listResidents[
                                                                            index]
                                                                        .split(
                                                                            '/')
                                                                        .last)) -
                                                                1]
                                                            .image,
                                                        fit: BoxFit.contain,
                                                        errorBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Object
                                                                    exception,
                                                                StackTrace?
                                                                    stackTrace) {
                                                          return Container(
                                                            width: 80,
                                                            height: 80,
                                                            color: Colors
                                                                .transparent,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : Center(
                                          child: CustomText(
                                              text:
                                                  "No characters were last seen at this location",
                                              color: Colors.green,
                                              fontSize: _fontSize_16),
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
  }
}
