import 'package:flutter/material.dart';
import '/screens/home_page.dart';
import '../constants/constants.dart';
import '../model/character.dart';
import '../components/custom_text.dart';

class Datasheet extends StatefulWidget {
  final Character character;
  const Datasheet({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  _DatasheetState createState() => _DatasheetState();
}

class _DatasheetState extends State<Datasheet> {
  String _selectedCharacterName = '';
  String _selectedCharacterStatus = '';
  String _selectedCharacterSpecies = '';
  String _selectedCharacterType = '';
  String _selectedCharacterGender = '';

  @override
  void initState() {
    super.initState();
    _selectedCharacterName = widget.character.name;
    _selectedCharacterStatus = widget.character.status;
    _selectedCharacterSpecies = widget.character.species;
    _selectedCharacterType = widget.character.type;
    _selectedCharacterGender = widget.character.gender;
  }

  @override
  Widget build(BuildContext context) {
    double _fontSize_16 = MediaQuery.of(context).size.width * .04;
    double _fontSize_24 = MediaQuery.of(context).size.width * .06;
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 56,
                        left: 24,
                        right: 24,
                        bottom: 8,
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 1.0,
                                color: Colors.white,
                              ),
                            ),
                            child: Hero(
                              tag: widget.character.image,
                              createRectTween: (begin, end) {
                                return MaterialRectCenterArcTween(
                                    begin: begin, end: end);
                              },
                              child: ClipOval(
                                child: Image.network(
                                  widget.character.image,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: CustomText(
                          text: _selectedCharacterName,
                          color: Colors.green,
                          fontSize: _fontSize_24),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 64,
                  right: 16,
                  left: 16,
                  bottom: 24,
                ),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: CustomText(
                                text: 'Full name:',
                                color: Colors.black,
                                fontSize: _fontSize_16),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: CustomText(
                                    text: _selectedCharacterName,
                                    color: Colors.green,
                                    fontSize: _fontSize_16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: CustomText(
                              text: 'Status:',
                              color: Colors.black,
                              fontSize: _fontSize_16,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: CustomText(
                                    text: _selectedCharacterStatus,
                                    color: Colors.green,
                                    fontSize: _fontSize_16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: CustomText(
                              text: 'Specie:',
                              color: Colors.black,
                              fontSize: _fontSize_16,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: CustomText(
                                    text: _selectedCharacterSpecies,
                                    color: Colors.green,
                                    fontSize: _fontSize_16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _selectedCharacterType.isEmpty
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(2),
                                  child: CustomText(
                                      text: 'Type:',
                                      color: Colors.black,
                                      fontSize: _fontSize_16),
                                ),
                          _selectedCharacterType.isEmpty
                              ? Container()
                              : Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CustomText(
                                          text: _selectedCharacterType,
                                          color: Colors.green,
                                          fontSize: _fontSize_16),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: CustomText(
                              text: 'Gender:',
                              color: Colors.black,
                              fontSize: _fontSize_16,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: CustomText(
                                    text: _selectedCharacterGender,
                                    color: Colors.green,
                                    fontSize: _fontSize_16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: CustomText(
                              text: 'Origin:',
                              color: Colors.black,
                              fontSize: _fontSize_16,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: GestureDetector(
                                onTap:
                                    widget.character.originName.toLowerCase() !=
                                            "unknown"
                                        ? (() {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Home(
                                                          currentIndex: 2,
                                                          location: widget
                                                              .character
                                                              .originName,
                                                        )));
                                          })
                                        : () {},
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CustomText(
                                    text: widget.character.originName,
                                    color: Colors.green,
                                    fontSize: _fontSize_16,
                                    underline: widget.character.originName
                                            .toLowerCase() !=
                                        "unknown",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: CustomText(
                              text: 'Location:',
                              color: Colors.black,
                              fontSize: _fontSize_16,
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(
                                                currentIndex: 2,
                                                location: widget
                                                    .character.locationName,
                                              )));
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CustomText(
                                    text: widget.character.locationName,
                                    color: Colors.green,
                                    fontSize: _fontSize_16,
                                    underline: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: Row(
                              children: [
                                CustomText(
                                    text: 'First seen in:',
                                    color: Colors.black,
                                    fontSize: _fontSize_16),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(
                                              currentIndex: 1,
                                              episode: getEpisode(
                                                widget.character.episode.first,
                                              ))));
                                }),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: CustomText(
                                    text: getEpisodeName(
                                        widget.character.episode.first),
                                    color: Colors.green,
                                    fontSize: _fontSize_16,
                                    underline: true,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
