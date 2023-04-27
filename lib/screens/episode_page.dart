import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../components/custom_circular_progress.dart';
import '../components/custom_text.dart';
import '../constants/constants.dart';
import '../model/character.dart';
import '../model/episode_data.dart';
import '../model/character_data.dart';
import '../model/episode.dart';
import 'datasheet_page.dart';

class EpisodePage extends StatefulWidget {
  final String? episode;
  EpisodePage({
    Key? key,
    this.episode,
  }) : super(key: key);

  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  List<Episode> _episodes = [];
  String _selectedEpisodeName = '';
  String _airDate = '';
  String _idEpisode = '';
  List<Character> _characters = [];
  final characterData = CharacterData();
  List<String> _listCharacters = [];
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedEpisodeName = '';
    _airDate = '';
    _episodes = [];
    _characters = characterData.characters;
    _idEpisode = '';
    if (EpisodeData().episodes.isEmpty) {
      _loadData();
    } else {
      if (widget.episode == null) {
        setState(() {
          _episodes = EpisodeData().episodes;
          _idEpisode = _episodes[0].id.toString();
          _selectedEpisodeName = _episodes[0].name;
          _airDate = _episodes[0].airDate;
          _listCharacters = _episodes[0].characters;
        });
      } else {
        int n = int.parse(widget.episode.toString()) - 1;
        setState(() {
          _episodes = EpisodeData().episodes;
          _idEpisode = _episodes[n].id.toString();
          _selectedEpisodeName = _episodes[n].name;
          _airDate = _episodes[n].airDate;
          _listCharacters = _episodes[n].characters;
        });
      }
    }
  }

  Future<void> _loadData() async {
    int page = 1;
    bool hasMorePages = true;
    final List<Episode> episodes = [];

    while (hasMorePages) {
      final response = await http.get(Uri.parse(pathApi('episode?page=$page')));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        for (final result in data['results']) {
          final episode = Episode.fromJson(result);
          episodes.add(episode);
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

    if (widget.episode == null) {
      setState(() {
        _episodes = episodes;
        _idEpisode = _episodes[0].id.toString();
        _selectedEpisodeName = _episodes[0].name;
        _airDate = _episodes[0].airDate;
        _listCharacters = _episodes[0].characters;
        EpisodeData().episodes = episodes;
      });
    } else {
      int n = int.parse(widget.episode.toString()) - 1;
      setState(() {
        _episodes = episodes;
        _idEpisode = _episodes[n].id.toString();
        _selectedEpisodeName = _episodes[n].name;
        _airDate = _episodes[n].airDate;
        _listCharacters = _episodes[n].characters;
      });
    }
  }

  void _searchEpisode(String name) {
    final selectedEpisode = _episodes.firstWhere((e) => e.name == name);
    setState(() {
      _idEpisode = selectedEpisode.id.toString();
      _selectedEpisodeName = selectedEpisode.name;
      _airDate = selectedEpisode.airDate;
      _listCharacters = selectedEpisode.characters;
    });
  }

  @override
  Widget build(BuildContext context) {
    double _fontSize_16 = MediaQuery.of(context).size.width * .04;
    double _fontSize_24 = MediaQuery.of(context).size.width * .06;
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: _episodes.isEmpty
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
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonFormField<String>(
                            decoration:  InputDecoration(
                              labelText: 'Select the episode',
                              labelStyle: TextStyle(
                                  fontFamily: 'Creepster',
                                  fontSize: _fontSize_16,
                                  color: Colors.black),
                              border: OutlineInputBorder(),
                            ),
                            value: _selectedEpisodeName,
                            onChanged: (value) => _searchEpisode(value!),
                            items: _episodes
                                .map(
                                  (episode) => DropdownMenuItem<String>(
                                    value: episode.name,
                                    child: Text(
                                      episode.episode,
                                      style:  TextStyle(
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
                                  text: 'Episode: ',
                                  color: Colors.black,
                                  fontSize: _fontSize_16),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: CustomText(
                                      text: _idEpisode,
                                      color: Colors.green,
                                      fontSize: _fontSize_16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
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
                                      text: _selectedEpisodeName,
                                      color: Colors.green,
                                      fontSize: _fontSize_16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            children: [
                               CustomText(
                                  text: 'Air date: ',
                                  color: Colors.black,
                                  fontSize: _fontSize_16),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: CustomText(
                                      text: _airDate,
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
                                        'Characters participating in this episode:',
                                    color: Colors.black,
                                    fontSize: _fontSize_16),
                              ),
                              Container(
                                color: Colors.transparent,
                                height:
                                    MediaQuery.of(context).size.height * .45,
                                width: MediaQuery.of(context).size.width * 1,
                                child: _listCharacters.isNotEmpty
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
                                          itemCount: _listCharacters.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => Datasheet(
                                                          character: _characters[
                                                              int.parse((_listCharacters[
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
                                                              (_listCharacters[
                                                                      index]
                                                                  .split('/')
                                                                  .last)) -
                                                          1]
                                                      .image,
                                                  createRectTween:
                                                      (begin, end) {
                                                    return MaterialRectCenterArcTween(
                                                        begin: begin, end: end);
                                                  },
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      _characters[int.parse(
                                                                  (_listCharacters[
                                                                          index]
                                                                      .split(
                                                                          '/')
                                                                      .last)) -
                                                              1]
                                                          .image,
                                                      fit: BoxFit.contain,
                                                      errorBuilder:
                                                          (BuildContext context,
                                                              Object exception,
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
                                                "No characters participate in this episode",
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
            ),
    );
  }
}
