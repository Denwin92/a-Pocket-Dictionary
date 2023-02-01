import 'package:pocket_dictionary/models/definition.dart';

class Meaning {
  final String partOfSpeech;
  final List<Definition> definitions;
  final List<String>? synonyms;
  final List<String>? antonyms;

  Meaning.fromJSON(Map<String, dynamic> json)
      : partOfSpeech = json['partOfSpeech'],
        definitions = List.from(
            (json["definitions"] as List).map((e) => Definition.fromJson(e))),
        synonyms = json.containsKey('synonyms')
            ? List.from((json['synonyms'] as List).map((e) => e))
            : null,
        antonyms = json.containsKey('antonyms')
            ? List.from((json['antonyms'] as List).map((e) => e))
            : null;
}
