import 'package:flutter/material.dart';
import '/screens/character_page.dart';
import '/screens/episode_page.dart';
import '/screens/location_page.dart';
import '../constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatefulWidget {
  final int currentIndex;
  final String? episode;
  final String? location;

  const Home({
    Key? key,
    required this.currentIndex,
    this.episode,
    this.location,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List<Widget> _children = [];

  @override
  void initState() {
    _currentIndex = widget.currentIndex;
    _children = [
      const CharacterPage(),
      EpisodePage(
        episode: widget.episode,
      ),
      LocationPage(
        location: widget.location,
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      home: Scaffold(
        backgroundColor: Colors.amber.shade50,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 18,
          selectedLabelStyle: TextStyle(
              fontFamily: 'Creepster', fontSize: 18, color: greenDefault),
          unselectedLabelStyle: TextStyle(
              fontFamily: 'Creepster', fontSize: 14, color: greenDefault),
          backgroundColor: Colors.amber.shade50,
          selectedItemColor: greenDefault,
          unselectedItemColor: greenDefault,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/character.svg',
                height: 30,
                width: 30,
              ),
              label: 'Characters',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.tv,
              ),
              label: 'Episodes',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.language,
              ),
              label: 'Locations',
            ),
          ],
        ),
      ),
    );
  }
}
