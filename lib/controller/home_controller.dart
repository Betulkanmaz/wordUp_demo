import 'dart:async';

import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../theme/colors.dart';

class HomeController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    init();
  }

  final RxInt currentIndex = 1.obs;
  static final _apiKey = 'AIzaSyBcUb8FhTlF97npdF60hlnzR2A5ILf7zGo';

  var word_box = Hive.box('word_box');
  var learn_box = Hive.box('learn_words');
  var known_box = Hive.box('known_words');

  Rx<String> lastWord = "".obs;

  init() async {
    if (word_box.isEmpty) {
      await fetchAPIdata();
    }
    if (word_box.isNotEmpty) {
      data.addAll(word_box.values.map((e) => e.toString()));
      data.removeWhere(
              (word) => learn_box.values.contains(word) || known_box.values.contains(word));

      list.addAll(data.take(takeCount));
      isBusy.value = false;
      //await translateWords();
    }
  }

  RxList<String> wordsToLearn = <String>[].obs;
  RxList<String> knownWords = <String>[].obs;

  setWordsToLearn() {
    wordsToLearn.clear();
    wordsToLearn.addAll(learn_box.values.map((e) => e.toString()));
  }

  setKnownWords() {
    knownWords.clear();
    knownWords.addAll(known_box.values.map((e) => e.toString()));
  }

  final RxBool learn = false.obs;
  RxList<String> list = <String>[].obs;
  RxList<String> data = <String>[].obs;
  RxInt count = 0.obs;

  Future<dynamic> fetchAPIdata() async {
    try {
      final url = Uri.parse('https://random-word-api.herokuapp.com/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>) {
          data.addAll(responseData.map((e) => e.toString()).toList());
          word_box.addAll(data);
          isBusy.value = false;
        }
      } else {
        return null;
      }
    } catch (_) {
      isBusy.value = false;
    }
  }

  Future<String> translate(String message, String toLanguageCode) async {
    final url = Uri.parse('https://translation.googleapis.com/language/translate/v2');
    final response = await http.post(
      url,
      body: {
        'target': toLanguageCode,
        'key': _apiKey,
        'q': message,
      },
    );

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final translations = body['data']['translations'] as List;
      final translation = translations.first;
      final translatedText = translation['translatedText'] as String;

      return translatedText;
    } else {
      throw Exception('Failed to translate message.');
    }
  }

  RxList<String> translatedWords = <String>[].obs;

  RxBool isBusy = true.obs;

  int get counter => wordsToLearn.length;

  decrement(){
    wordsToLearn.refresh();
    wordsToLearn.length--;
  }

  Future<void> translateWords(index) async {
      var value = await translate(list[index], 'tr');
      lastWord.value = list[index];
      list[index] = value;
      refresh();
      update(list);
  }

  CardSwiperController cardSwiperController = CardSwiperController();
  FlipCardController flipCardController = FlipCardController();

  var takeCount = 10;
  var page = 1;

  void listNext() {
    isBusy.value = true;
    list.clear();
    page++;
    list.addAll(data
        .skip(takeCount * page)
        .take(takeCount)); //gelen 10dan sonra liste devamini yukleme
    isBusy.value = false;
  }

  addLearnWord(String word) {
    if (!learn_box.values.contains(word)) {
      learn_box.add(word);
    }
  }

  addknownWord(String word) {
    if (!known_box.values.contains(word)) {
      known_box.add(word);
    }
  }

  void changeBack(int index) {
      list[index] = lastWord.value;
      refresh();
      update(list);
  }

}
