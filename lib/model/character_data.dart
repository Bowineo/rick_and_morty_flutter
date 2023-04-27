import 'character.dart';

class CharacterData {
  List<Character> characters = [];
  
  static final CharacterData _instance = CharacterData._internal();
  factory CharacterData() => _instance;
  CharacterData._internal();
}
