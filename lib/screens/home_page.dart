import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:wordup_demo/screens/words_to_learn.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';
import 'dart:ui';
import '../controller/home_controller.dart';

//3 hive box

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> data = [];

  var box1 = Hive.openBox('words');
  var box3 = Hive.openBox('known_words');

  @override
  Future<void> initState() async {
    // TODO: implement initState
    super.initState();
    //fetchAPIdata();
    box1.then((value) {
      setState(() {
        box1 = value as Future<Box>;
      });
    });

  }


  CardSwiperController _cardSwiperController = CardSwiperController();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  FlipCardController flipCardController = FlipCardController();

  var isBusy = true;
  var takeCount = 10;
  var list = <String>[];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: isBusy
              ? CircularProgressIndicator()
              : Container(
                  height: MediaQuery.of(context).size.height * 0.732,
                  width: MediaQuery.of(context).size.width * 0.872,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.872,
                            height: MediaQuery.of(context).size.height * 0.036,
                            child: Text('Words',
                                style: UIStyle.sh2.copyWith(
                                    color: UIColors.grey400,
                                    fontFamily: 'Poppins-Regular',
                                    fontWeight: FontWeight.w700),
                                textAlign: TextAlign.center),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.872,
                            height: MediaQuery.of(context).size.height * 0.025,
                            child: Text('Guess the meaning of the worlds',
                                style: UIStyle.b2_medium
                                    .copyWith(color: UIColors.grey200),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.872,
                        height: MediaQuery.of(context).size.height * 0.472,
                        child: StatefulBuilder(
                          builder: (context, changeState) {
                            return CardSwiper(
                              backCardOffset: Offset(0, 27.0),
                              padding: EdgeInsets.zero,
                              numberOfCardsDisplayed: 3,
                              isLoop: false,
                              onEnd: () {
                                changeState(() {
                                  list.addAll(
                                      data.skip(takeCount).take(takeCount));
                                });
                              },
                              controller: _cardSwiperController,
                              cardsCount: list.length,
                              cardBuilder: (context, index) {
                                return FlipCard(
                                  controller: flipCardController,
                                  side: CardSide.FRONT,
                                  direction: FlipDirection.HORIZONTAL,
                                  back: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    color: UIColors.primary400,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "BACK",
                                        style: UIStyle.h1,
                                      ),
                                    ),
                                  ),
                                  front: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    color: UIColors.primary400,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            list[index],
                                            style: UIStyle.h1,
                                          ),
                                          Text('TEXT',
                                              style: UIStyle.sh2_medium
                                                  .copyWith(
                                                      color: UIColors.grey100)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.693,
                        height: MediaQuery.of(context).size.height * 0.078,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              //sola kaydirma
                              onPressed: () {
                                _cardSwiperController.swipeLeft();

                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: UIColors.grey50,
                                side: BorderSide(
                                    color: UIColors.grey100, width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                              ),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.064,
                                height:
                                    MediaQuery.of(context).size.height * 0.029,
                                child: SvgPicture.asset(
                                  'assets/images/left.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.064,
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              //ters-duz etme
                              onPressed: () {
                                flipCardController.toggleCard();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: UIColors.grey50,
                                side: BorderSide(
                                    color: UIColors.grey100, width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                              ),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.064,
                                height:
                                    MediaQuery.of(context).size.height * 0.029,
                                child: SvgPicture.asset(
                                  'assets/images/flip.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.064,
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              //saga kaydirma
                              onPressed: () {
                                _cardSwiperController.swipeRight();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: UIColors.grey50,
                                side: BorderSide(
                                    color: UIColors.grey100, width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                              ),
                              child: SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.064,
                                height:
                                    MediaQuery.of(context).size.height * 0.029,
                                child: SvgPicture.asset(
                                  'assets/images/right.svg',
                                  width:
                                      MediaQuery.of(context).size.width * 0.064,
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class HomePageStless extends StatelessWidget {
  HomePageStless({Key? key}) : super(key: key);

  WordsToLearn wordsToLearnInstance = WordsToLearn();
  var controller = Get.put(HomeController());
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SafeArea(
        child: Scaffold(
          body: Center(
            child: controller.isBusy.value
                ? CircularProgressIndicator()
                : Container(
                    height: MediaQuery.of(context).size.height * 0.732,
                    width: MediaQuery.of(context).size.width * 0.872,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.872,
                              height:
                                  MediaQuery.of(context).size.height * 0.036,
                              child: Text('Words',
                                  style: UIStyle.sh2.copyWith(
                                      color: UIColors.grey400,
                                      fontFamily: 'Poppins-Regular',
                                      fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.872,
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                              child: Text('Guess the meaning of the worlds',
                                  style: UIStyle.b2_medium
                                      .copyWith(color: UIColors.grey200),
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.872,
                          height: MediaQuery.of(context).size.height * 0.472,
                          child: CardSwiper(
                            backCardOffset: Offset(0, 27.0),
                            padding: EdgeInsets.zero,
                            numberOfCardsDisplayed: 3,
                            isLoop: true,
                            onEnd: () {
                              controller.listNext();
                            },
                            controller: controller.cardSwiperController,
                            cardsCount: controller.list.length,
                            cardBuilder: (context, index) {
                              return FlipCard(
                                controller: controller.flipCardController,
                                side: CardSide.FRONT,
                                direction: FlipDirection.HORIZONTAL,
                                back: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: UIColors.primary400,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "BACK",
                                      style: UIStyle.h1,
                                    ),
                                  ),
                                ),
                                front: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20.0)),
                                  color: UIColors.primary400,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          controller.list[index],
                                          style: UIStyle.h1,
                                        ),
                                        Text('TEXT',
                                            style: UIStyle.sh2_medium.copyWith(
                                                color: UIColors.grey100)),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.693,
                          height: MediaQuery.of(context).size.height * 0.078,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                //sola kaydirma
                                onPressed: () {
                                  controller.cardSwiperController.swipeLeft();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: UIColors.grey50,
                                  side: BorderSide(
                                      color: UIColors.grey100, width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.064,
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                  child: SvgPicture.asset(
                                    'assets/images/left.svg',
                                    width: MediaQuery.of(context).size.width *
                                        0.064,
                                    height: MediaQuery.of(context).size.height *
                                        0.029,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                //ters-duz etme
                                onPressed: () {
                                  controller.flipCardController.toggleCard();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: UIColors.grey50,
                                  side: BorderSide(
                                      color: UIColors.grey100, width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.064,
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                  child: SvgPicture.asset(
                                    'assets/images/flip.svg',
                                    width: MediaQuery.of(context).size.width *
                                        0.064,
                                    height: MediaQuery.of(context).size.height *
                                        0.029,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                //saga kaydirma
                                onPressed: () {
                                  controller.cardSwiperController.swipeRight();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: UIColors.grey50,
                                  side: BorderSide(
                                      color: UIColors.grey100, width: 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(16.0)),
                                ),
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.064,
                                  height: MediaQuery.of(context).size.height *
                                      0.029,
                                  child: SvgPicture.asset(
                                    'assets/images/right.svg',
                                    width: MediaQuery.of(context).size.width *
                                        0.064,
                                    height: MediaQuery.of(context).size.height *
                                        0.029,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
