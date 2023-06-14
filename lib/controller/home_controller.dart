import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController{

  @override
  void onInit(){
    init();
  }

  init() async{
    await fetchAPIdata();
  }

  Future<dynamic> fetchAPIdata() async {
    //API cagrisi
    try{
      final url = Uri.parse('https://random-word-api.herokuapp.com/all');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData is List<dynamic>?) {
          data.addAll(responseData
              ?.map((e) => e?.toString() ?? "")
              .toList() ??
              []);
          list.addAll(data.take(takeCount));
          isBusy.value = false;
        }
      } else {
        return null;
      }
    }
    catch(_){
      isBusy.value = false;
    }

  }

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
    list.addAll(data.skip(takeCount * page).take(takeCount)); //gelen 10dan sonra liste devamini yukleme
    isBusy.value = false;
  }

  void addWord() async{
    var box2 = Hive.openBox('learn_words');


  }

}