import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/dictionary_word.dart';

class ResultScreen extends StatefulWidget {
  final String userInput;

  const ResultScreen({super.key, required this.userInput});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List<DictionaryWord>? _words;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _apiCall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('the Pocket Dictionary'),
      ),
      body: Padding(
          padding: EdgeInsets.all(16), child: Center(child: _buildBody())),
    );
  }

  // removed build body from scaffold in order to create if statements normally.
  Widget _buildBody() {
    if (_isLoading) {
      return Text('Fetching Definition for "${widget.userInput}"');
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.userInput,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        SizedBox(height: 10),
        Text(
          "Definition: ${_words!.first.meanings.first.definitions.first.definition}",
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(height: 8),
        if (_words!.first.meanings.first.antonyms!.isNotEmpty)
          Text(
              "Antonym: ${_words!.first.meanings.first.antonyms?.first ?? ''}"),
        SizedBox(height: 8),
        Text("Parts of Speech: ${_words!.first.meanings.first.partOfSpeech} "),
        // SizedBox(height: 8),
        // Text("Phonetic: "),
        // SizedBox(height: 8),
        // Text("Origin: "),
        // SizedBox(height: 8),
        // Text(
        //   "Example",
        //   style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
        // ),
        // SizedBox(height: 8),
        // Text("Audio: "),
      ],
    );
  }

  Future<void> _apiCall() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(
            'api.dictionaryapi.dev', 'api/v2/entries/en/${widget.userInput}'),
      );
      var body = jsonDecode(response.body) as List;
      _words = List.from((body).map((e) => DictionaryWord.fromJSON(e)));
      setState(() {
        _isLoading = false;
      });
    } finally {
      client.close();
    }
  }
}
