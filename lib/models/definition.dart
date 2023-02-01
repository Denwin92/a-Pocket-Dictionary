class Definition {
  final String definition;
  final String? example;
  final List<String> synonyms;
  final List<String> antonyms;

  Definition.fromJson(Map<String, dynamic> json)
      : definition = json['definition'],
        example = json.containsKey('example') ? json['example'] : null,
        synonyms = List.from((json['synonyms'] as List).map((e) => e)),
        antonyms = List.from((json["antonyms"] as List).map((e) => e));
}
