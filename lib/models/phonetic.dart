class Phonetic {
  final String text;
  final String audio;

  Phonetic.fromJSON(Map<String, dynamic> json)
      : text = json['text'],
        audio = json['audio'];
}
