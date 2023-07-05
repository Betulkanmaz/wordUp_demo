import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  @override
  Future<void> onInit() async {
    super.onInit();
    init();
  }

  var word_box = Hive.box('word_box');
  var learn_box = Hive.box('learn_words');
  var known_box = Hive.box('known_words');

  init() async {
    if (word_box.isEmpty) {
      await fetchAPIdata();
    }
    if(word_box.isNotEmpty) {
      ///uygulama tekrar acildiginda kelime eksilmesini sagla!!!!!!!!!!!!!!!!!
      data.addAll(word_box.values
          .map((e) => e.toString())); //uygulama tekrar acildiginda
      /*data.removeWhere(
          (word) => learn_box.values.contains(word) || known_box.values.contains(word));*/
    }
    //data.shuffle();
    list.addAll(data.take(takeCount));
    isBusy.value = false;
  }

  setWordsToLearn() {
    wordsToLearn.clear();
    wordsToLearn.addAll(learn_box.values.map((e) => e.toString()));
  }

  setKnownWords() {
    knownWords.clear();
    knownWords.addAll(known_box.values.map((e) => e.toString()));
  }

  RxList<String> wordsToLearn = <String>[].obs;
  RxList<String> knownWords = <String>[].obs;

  Future<dynamic> fetchAPIdata() async {
    //API cagrisi
    try {
      final url = Uri.parse('https://random-word-api.herokuapp.com/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>?) {
          data.addAll(
              responseData?.map((e) => e?.toString() ?? "").toList() ?? []);
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

  final RxBool learn = false.obs;
  RxList<String> list = <String>[].obs;
  RxList<String> data = <String>[].obs;

  CardSwiperController cardSwiperController = CardSwiperController();
  FlipCardController flipCardController = FlipCardController();

  var isBusy = true.obs;

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

  deleteWord(String word) {
    var index = word_box.values
        .toList()
        .indexWhere((element) => element.toString() == word);
    word_box.deleteAt(index);
  }

  addLearnWord(String word) {
    list.remove(word);
    if(!learn_box.containsKey(word)) {
      learn_box.add(word);
    }//kutuya ekleme
  }

  addknownWord(String word) {
    if (!known_box.containsKey(word)) {
      known_box.add(word);
    }
  }

//initiliza et sayfayi arttir, listeyi sifirla
}
