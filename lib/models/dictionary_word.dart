import 'package:pocket_dictionary/models/phonetic.dart';

import 'meaning.dart';

class DictionaryWord {
  final String word;
  final String phonetic;
  final String? origin;
  final List<Phonetic> phonetics;
  final List<Meaning> meanings;

  DictionaryWord.fromJSON(Map<String, dynamic> json)
      : word = json['word'],
        phonetic = json['phonetic'],
        origin = json.containsKey('origin') ? json['origin'] : null,
        phonetics = List.from(
            (json['phonetics'] as List).map((e) => Phonetic.fromJSON(e))),
        meanings = List.from(
            (json['meanings'] as List).map((e) => Meaning.fromJSON(e)));
}
