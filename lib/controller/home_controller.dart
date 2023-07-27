import 'dart:async';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../helper/word_model.dart';

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
      data.removeWhere((word) =>
          learn_box.values.contains(word) || known_box.values.contains(word));
      list.addAll(data.take(takeCount));
      isBusy.value = false;
    }
  }

  RxList<WordModel?> wordsToLearn = <WordModel?>[].obs;
  RxList<WordModel?> knownWords = <WordModel?>[].obs;

  RxBool isWordEnding = false.obs;

  setWordsToLearn() {
    wordsToLearn.clear();
    wordsToLearn.addAll(learn_box.values.map((e) => e is WordModel ? e : null));
  }

  setKnownWords() {
    knownWords.clear();
    knownWords.addAll(known_box.values.map((e) => e is WordModel ? e : null));
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
    final url =
        Uri.parse('https://translation.googleapis.com/language/translate/v2');
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

  RxBool isBusy = true.obs;
  RxBool isCardBusy = false.obs;

  int get counter => wordsToLearn.length;

  var languageCode = 'tr';

  decrement() {
    wordsToLearn.refresh();
    wordsToLearn.length--;
  }

  Future<void> translateWords(index) async {
    var value = await translate(list[index], languageCode);
    lastWord.value = list[index];
    list[index] = value;
    refresh();
    update(list);
    isCardBusy.value = false;
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

  addLearnWord(String word) async {
    var translatedWord = await translate(word, languageCode);
    var wordOnBox = WordModel(word, translatedWord);
    if (!learn_box.values.any(
        (element) => element is WordModel ? element.english == word : false)) {
      learn_box.add(wordOnBox);
      await word_box.deleteAt(word_box.values
          .toList()
          .indexOf(word_box.values.firstWhere((element) => element == word)));
      if (word ==
          known_box.values
              .toList()
              .indexOf(known_box.values.where((element) => element == word))) {
        known_box.delete(word);
      }
    }
  }

  addknownWord(String word) async {
    var translatedWord = await translate(word, languageCode);
    var wordOnBox = WordModel(word, translatedWord);
    if (!known_box.values.any(
        (element) => element is WordModel ? element.english == word : false)) {
      known_box.add(wordOnBox);
      await word_box.delete(word_box.values.toList().indexOf(word_box.values
          .where((element) =>
              element ==
              word))); //listeye cevirdikten sonra element ilk gorulen yerde bulup sil
      if (word ==
          learn_box.values
              .toList()
              .indexOf(learn_box.values.where((element) => element == word))) {
        known_box.delete(word);
      }
    }
  }

  addSecondList(String word) async {
    var translatedWord = await translate(word, languageCode);
    var wordOnBox = WordModel(word, translatedWord);
    if (!known_box.values.any(
        (element) => element is WordModel ? element.english == word : false)) {
      known_box.add(wordOnBox);
      await learn_box.delete(learn_box.values.toList().indexOf(learn_box.values
          .where((element) =>
              element ==
              word))); //listeye cevirdikten sonra element ilk gorulen yerde bulup sil
    }
  }

  void changeBack(int index) {
    list[index] = lastWord.value;
    refresh();
    update(list);
  }
}
