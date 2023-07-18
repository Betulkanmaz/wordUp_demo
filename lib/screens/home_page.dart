import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';
import '../controller/home_controller.dart';
import '../helper/strings.dart';

class HomePageStless extends StatefulWidget {
  const HomePageStless({Key? key}) : super(key: key);

  @override
  State<HomePageStless> createState() => _HomePageStlessState();
}

class _HomePageStlessState extends State<HomePageStless> {
  HomeController controller = Get.find(tag: UIStrings.homeControllerTag);
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SafeArea(
          ///ekranda kelime bittiginde kelime olmadıgını goster kosul ifadesi kullan
          child: controller.isBusy.value
              ? const CircularProgressIndicator()
              : (controller.learn.value == true)
                  ? Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.732,
                              width: MediaQuery.of(context).size.width * 0.872,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.872,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.036,
                                            child: Text('Words',
                                                style: UIStyle.sh2.copyWith(
                                                    color: UIColors.grey400,
                                                    fontFamily:
                                                        'Poppins-Regular',
                                                    fontWeight:
                                                        FontWeight.w700),
                                                textAlign: TextAlign.center),
                                          ),
                                        ],
                                      ),
                                      Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.872,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          child: Obx(
                                            () => Text(
                                                'You have ${controller.counter} words',
                                                style: UIStyle.b2_medium
                                                    .copyWith(
                                                        color:
                                                            UIColors.grey200),
                                                textAlign: TextAlign.center),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.872,
                                    height: MediaQuery.of(context).size.height *
                                        0.472,
                                    child: CardSwiper(
                                      backCardOffset: const Offset(0, 27.0),
                                      padding: EdgeInsets.zero,
                                      numberOfCardsDisplayed: controller
                                                  .wordsToLearn.length <
                                              3
                                          ? controller.wordsToLearn.length : 3,
                                      isLoop: true,
                                      onSwipe: (previousIndex, currentIndex,
                                          direction) {
                                        if (direction ==
                                            CardSwiperDirection.right) {
                                          if(controller.flipCardController.state?.isFront==false){
                                            controller.flipCardController.toggleCard();
                                            controller.changeBack(index);
                                            controller.addknownWord(
                                                controller.wordsToLearn[index]);
                                            controller.learn_box.delete(
                                                controller.wordsToLearn[index]);
                                          }else
                                          {
                                            controller.addknownWord(
                                                controller.wordsToLearn[index]);
                                            controller.learn_box.delete(
                                                controller.wordsToLearn[index]);
                                          }
                                        } else if (direction ==
                                            CardSwiperDirection.left) {
                                          if(controller.flipCardController.state?.isFront==false){
                                            controller.flipCardController.toggleCard();
                                            controller.changeBack(index);
                                            controller.addLearnWord(
                                                controller
                                                    .wordsToLearn[index]);
                                            controller.learn_box.delete(
                                                controller.wordsToLearn[index]);
                                          }else
                                          {
                                            controller.addLearnWord(
                                                controller.wordsToLearn[index]);
                                            controller.learn_box.delete(
                                                controller.wordsToLearn[index]);
                                          }
                                        }
                                        index = currentIndex ?? previousIndex;
                                        return Future.value(true);
                                      },
                                      controller:
                                          controller.cardSwiperController,
                                      cardsCount:
                                          controller.wordsToLearn.length,
                                      cardBuilder: (context, index) {
                                        return FlipCard(
                                          controller:
                                              controller.flipCardController,
                                          side: CardSide.FRONT,
                                          onFlip: () async {
                                            if (controller.flipCardController
                                                    .state?.isFront ==
                                                true) {
                                              controller
                                                  .translateLearnWords(index);
                                            } else if (controller
                                                    .flipCardController
                                                    .state
                                                    ?.isFront ==
                                                false) {
                                              controller.changeBackLearn(index);
                                            }
                                          },
                                          direction: FlipDirection.HORIZONTAL,
                                          back: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            color: UIColors.primary400,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                ///translate
                                                controller.wordsToLearn[index],
                                                textAlign: TextAlign.center,
                                                style: UIStyle.h1,
                                              ),
                                            ),
                                          ),
                                          front: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0)),
                                            color: UIColors.primary400,
                                            child: Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                controller.wordsToLearn
                                                    .elementAt(index),
                                                style: UIStyle.h1,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      /*onEnd: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: new Text("Alert"),
                                                content: new Text(" "),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Get.to(() => WordsToLearn());
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },*/
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.693,
                                    height: MediaQuery.of(context).size.height *
                                        0.078,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          //sola kaydirma
                                          onPressed: () {
                                            controller.decrement();
                                            controller.cardSwiperController
                                                .swipeLeft();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.grey50,
                                            side: BorderSide(
                                                color: UIColors.grey100,
                                                width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.064,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029,
                                            child: SvgPicture.asset(
                                              'assets/images/left.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.064,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.029,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          //ters-duz etme
                                          onPressed: () {
                                            controller.flipCardController
                                                .toggleCard();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.grey50,
                                            side: BorderSide(
                                                color: UIColors.grey100,
                                                width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.064,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029,
                                            child: SvgPicture.asset(
                                              'assets/images/flip.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.064,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.029,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          //saga kaydirma
                                          onPressed: () {
                                            controller.decrement();
                                            controller.cardSwiperController
                                                .swipeRight();
                                            controller.addknownWord(
                                                controller.wordsToLearn[index]);
                                            controller.learn_box
                                                .deleteAt(index);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.grey50,
                                            side: BorderSide(
                                                color: UIColors.grey100,
                                                width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.064,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029,
                                            child: SvgPicture.asset(
                                              'assets/images/right.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.064,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.029,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Scaffold(
                      body: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.732,
                              width: MediaQuery.of(context).size.width * 0.872,
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.872,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.036,
                                        child: Text('Words',
                                            style: UIStyle.sh2.copyWith(
                                                color: UIColors.grey400,
                                                fontFamily: 'Poppins-Regular',
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.872,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        child: Text(
                                            'Guess the meaning of the worlds',
                                            style: UIStyle.b2_medium.copyWith(
                                                color: UIColors.grey200),
                                            textAlign: TextAlign.center),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.872,
                                    height: MediaQuery.of(context).size.height *
                                        0.472,
                                    child: controller.list.isNotEmpty
                                        ? CardSwiper(
                                            allowedSwipeDirection:
                                                AllowedSwipeDirection.only(
                                                    right: true,
                                                    left: true,
                                                    down: false,
                                                    up: false),
                                            backCardOffset:
                                                const Offset(0, 27.0),
                                            padding: EdgeInsets.zero,
                                            numberOfCardsDisplayed:
                                                controller.list.length < 3
                                                    ? controller.list.length
                                                    : 3,
                                            isLoop: true,
                                            onEnd: () {
                                              controller.listNext();
                                            },
                                            onSwipe: (previousIndex,
                                                currentIndex, direction) {
                                              if (direction ==
                                                  CardSwiperDirection.right) {
                                                if(controller.flipCardController.state?.isFront==false){
                                                  controller.flipCardController.toggleCard();
                                                  controller.changeBack(index);
                                                  controller.addknownWord(
                                                      controller.list[index]);
                                                  controller.word_box.delete(
                                                      controller.list[index]);
                                                }else
                                                {
                                                  controller.addknownWord(
                                                      controller.list[index]);
                                                  controller.word_box.delete(
                                                      controller.list[index]);
                                                }
                                              } else if (direction ==
                                                  CardSwiperDirection.left) {
                                                if(controller.flipCardController.state?.isFront==false){
                                                  controller.flipCardController.toggleCard();
                                                  controller.changeBack(index);
                                                  controller.addLearnWord(
                                                      controller
                                                          .list[index]);
                                                  controller.word_box.delete(controller.list[index]);
                                                }else
                                                {
                                                  controller.addLearnWord(
                                                      controller.list[index]);
                                                  controller.word_box.delete(
                                                      controller.list[index]);
                                                }
                                              }
                                              index =
                                                  currentIndex ?? previousIndex;
                                              return Future.value(true);
                                            },
                                            controller:
                                                controller.cardSwiperController,
                                            cardsCount: controller.list.length,
                                            cardBuilder: (context, index) {
                                              return FlipCard(
                                                onFlip: () async {
                                                  controller.isCardBusy.value = true;
                                                  if (controller
                                                          .flipCardController
                                                          .state
                                                          ?.isFront ==
                                                      true) {
                                                    await controller
                                                        .translateWords(index);

                                                  } else if (controller
                                                          .flipCardController
                                                          .state
                                                          ?.isFront ==
                                                      false) {
                                                    controller
                                                        .changeBack(index);
                                                  }
                                                },
                                                onFlipDone: (isDone){
                                                  controller.isCardBusy.value = false;
                                                },
                                                controller: controller
                                                    .flipCardController,
                                                side: CardSide.FRONT,
                                                direction:
                                                    FlipDirection.HORIZONTAL,
                                                back: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  color: UIColors.primary400,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child:
                                                        controller.isCardBusy.value ? CircularProgressIndicator() :
                                                    Text(
                                                      controller.list[index],

                                                      ///TRANSLATE INDEX AYARI
                                                      style: UIStyle.h1,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                                front: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  color: UIColors.primary400,
                                                  child: Container(
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      controller.list[index],
                                                      style: UIStyle.h1,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          )
                                        : Container(
                                            child: Text(
                                                'There are no words to show.',
                                                style: UIStyle.h1),
                                          ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.693,
                                    height: MediaQuery.of(context).size.height *
                                        0.078,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          //sola kaydirma
                                          onPressed: () {
                                            if (controller.flipCardController
                                                    .state!.isFront ==
                                                false) {
                                              controller.flipCardController
                                                  .toggleCard();
                                              controller.changeBack(index);
                                              controller.wordsToLearn
                                                  .add(controller.list[index]);
                                              controller.word_box.delete(
                                                  controller.list[index]);
                                              controller.cardSwiperController
                                                  .swipeLeft();
                                            } else {
                                              controller.wordsToLearn
                                                  .add(controller.list[index]);
                                              controller.word_box.delete(
                                                  controller.list[index]);
                                              controller.cardSwiperController
                                                  .swipeLeft();
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.grey50,
                                            side: BorderSide(
                                                color: UIColors.grey100,
                                                width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.064,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029,
                                            child: SvgPicture.asset(
                                              'assets/images/left.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.064,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.029,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          //ters-duz etme
                                          onPressed: () async {
                                            controller.flipCardController
                                                .toggleCard();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.grey50,
                                            side: BorderSide(
                                                color: UIColors.grey100,
                                                width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.064,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029,
                                            child: SvgPicture.asset(
                                              'assets/images/flip.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.064,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.029,
                                            ),
                                          ),
                                        ),
                                        ElevatedButton(
                                          //saga kaydirma
                                          onPressed: () {
                                            controller.flipCardController.state
                                                ?.isFront = true;
                                            controller.cardSwiperController
                                                .swipeRight();
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: UIColors.grey50,
                                            side: BorderSide(
                                                color: UIColors.grey100,
                                                width: 1),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        16.0)),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.064,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.029,
                                            child: SvgPicture.asset(
                                              'assets/images/right.svg',
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.064,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.029,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
        ));
  }
}

///kelimelerin turkce ingilizce degisimlerinde bekleme suresi
///wordtolearn ekranda gozuktukten sonra diger sayfaya gidiste sayfa iste guncellemesini sagla
