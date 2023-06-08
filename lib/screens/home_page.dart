import 'package:flip_card/flip_card.dart';
import 'package:flip_card/flip_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:wordup_demo/screens/known_words.dart';
import 'package:wordup_demo/screens/words_to_learn.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';
import 'dart:ui';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> wordList = [
    "abreact",
    "abreacted",
    "abreacting",
    "abreaction",
    "abreactions",
    "abreacts",
    "abreast",
    "abri",
    "abridge",
    "abridged"
  ];

  List<String> translate = [
    "yanıt ver",
    "iptal edildi",
    "uymak",
    "tepki",
    "tepkiler",
    "yanıt vermiyor",
    "takip et",
    "abri",
    "abridge",
    "kısaltılmış"
  ];

  List<Widget> pageList = [
    WordsToLearn(),
    KnownWords(),
  ];

  CardSwiperController _cardSwiperController = CardSwiperController();
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  FlipCardController flipCardController = FlipCardController();
  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
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
                  child: CardSwiper(
                    isLoop: false,
                    onEnd: () {
                      //10 kart ekle
                    },
                    controller: _cardSwiperController,
                    cardsCount: 10,
                    cardBuilder: (context, index) {
                      return FlipCard(
                        controller: flipCardController,
                        side: CardSide.FRONT,
                        direction: FlipDirection.HORIZONTAL,
                        back: Card(
                          color: UIColors.primary400,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              translate[index],
                              style: UIStyle.h1,
                            ),
                          ),
                        ),
                        front: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0)
                          ),
                          color: UIColors.primary400,
                          child: Container(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  wordList[index],
                                  style: UIStyle.h1,
                                ),
                                Text('TEXT',
                                    style: UIStyle.sh2_medium
                                        .copyWith(color: UIColors.grey100)),
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
                          _cardSwiperController.swipeLeft();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UIColors.grey50,
                          side: BorderSide(color: UIColors.grey100, width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.064,
                          height: MediaQuery.of(context).size.height * 0.029,
                          child: SvgPicture.asset(
                            'assets/images/left.svg',
                            width: MediaQuery.of(context).size.width * 0.064,
                            height: MediaQuery.of(context).size.height * 0.029,
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
                          side: BorderSide(color: UIColors.grey100, width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.064,
                          height: MediaQuery.of(context).size.height * 0.029,
                          child: SvgPicture.asset(
                            'assets/images/flip.svg',
                            width: MediaQuery.of(context).size.width * 0.064,
                            height: MediaQuery.of(context).size.height * 0.029,
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
                            side: BorderSide(color: UIColors.grey100, width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                          ),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.064,
                            height: MediaQuery.of(context).size.height * 0.029,
                            child: SvgPicture.asset(
                              'assets/images/right.svg',
                              width: MediaQuery.of(context).size.width * 0.064,
                              height:
                                  MediaQuery.of(context).size.height * 0.029,
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: SvgPicture.asset(
                'assets/images/pin_cross.svg',
                width: MediaQuery.of(context).size.width * 0.064,
                height: MediaQuery.of(context).size.height * 0.029,
                alignment: Alignment.center,
              ),
            ),
            BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  'assets/images/home.svg',
                  width: MediaQuery.of(context).size.width * 0.060,
                  height: MediaQuery.of(context).size.height * 0.025,
                  alignment: Alignment.center,
                )),
            BottomNavigationBarItem(
                label: '',
                icon: SvgPicture.asset(
                  'assets/images/pin.svg',
                  width: MediaQuery.of(context).size.width * 0.064,
                  height: MediaQuery.of(context).size.height * 0.029,
                  alignment: Alignment.center,
                ))
          ],
        ),
      ),
    );
  }

/* Future<dynamic> fetchAPIdata() async {
    //API cagrisi
    try {
      final response = await http
          .get(Uri.parse('https://random-word-api.herokuapp.com/all'));

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        return result;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  } */
}
