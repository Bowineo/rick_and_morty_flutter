import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../constants/constants.dart';
import '../model/character.dart';
import '../model/character_data.dart';
import 'home_page.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  late List<Character> _characters;

  @override
  void initState() {
    super.initState();
    _characters = [];
    loadData();
  }

  Future<void> loadData() async {
    final Map<String, String> charactersMap = {};

    int page = 1;
    bool hasMorePages = true;
    while (hasMorePages) {
      final response =
          await http.get(Uri.parse(pathApi('character?page=$page')));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'] as List<dynamic>;
        for (final result in results) {
          final character = Character.fromJson(result);
          _characters.add(character);
          charactersMap[character.name] = character.image;
          charactersMap[character.status] = character.status;
          charactersMap[character.species] = character.species;
          charactersMap[character.type] = character.type;
          charactersMap[character.gender] = character.gender;
        }
        if (data['info']['next'] == null) {
          hasMorePages = false;
        } else {
          page++;
        }
      } else {
        throw Exception('Failed to load data');
      }
    }
    CharacterData().characters = _characters;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) =>  Home(currentIndex: 0,)));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            color: Colors.amber.shade50,
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/title.png',
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.width * .2,
                    fit: BoxFit.contain,
                  ),
                  Image.asset(
                    'assets/images/loading.gif',
                    width: MediaQuery.of(context).size.width * .5,
                    height: MediaQuery.of(context).size.width * .3,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
