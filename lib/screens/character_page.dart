import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../components/custom_circular_progress.dart';
import '../components/custom_text.dart';
import 'datasheet_page.dart';
import '../model/character.dart';
import '../model/character_data.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  _CharacterPageState createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  List<Character> _characters = [];
  String _selectedCharacterName = '';
  final characterData = CharacterData();

  @override
  void initState() {
    super.initState();
    _characters = characterData.characters;
    _selectedCharacterName = _characters[0].name;
  }

  void _searchCharacter(String name) {
    setState(() {
      _selectedCharacterName = name;
    });
  }

  String _searchCharacterImage(List<Character> chars, String name) {
    for (var character in chars) {
      if (character.name == name) {
        return character.image;
      }
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width * 1;
    double _fontSize_16 = MediaQuery.of(context).size.width * .04;
    double _fontSize_24 = MediaQuery.of(context).size.width * .06;
    return _characters.isEmpty
        ? Center(
            child: Column(
              children: const [
                CustomCircularProgress(),
              ],
            ),
          )
        : Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: _width,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 300,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        onPageChanged: (index, reason) {
                          _searchCharacter(_characters[index].name);
                        },
                        aspectRatio: 16 / 9,
                        viewportFraction: .75,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayCurve: Curves.easeInOutQuint,
                        pauseAutoPlayOnTouch: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        scrollDirection: Axis.horizontal,
                      ),
                      items: _characters.map((Character character) {
                        final imageUrl =
                            _searchCharacterImage(_characters, character.name);
                        return imageUrl.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Datasheet(
                                        character: character,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: character.image,
                                  createRectTween: (begin, end) {
                                    return MaterialRectCenterArcTween(
                                        begin: begin, end: end);
                                  },
                                  child: ClipOval(
                                    child: Image.network(
                                      imageUrl,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ))
                            : Center(
                                child: Text(
                                  'Image unavailable',
                                  style: TextStyle(
                                    fontSize: _fontSize_16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                      }).toList(),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    width: _width,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: CustomText(
                            text: _selectedCharacterName,
                            color: Colors.green,
                            fontSize: _fontSize_24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
