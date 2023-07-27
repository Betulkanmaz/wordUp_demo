import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wordup_demo/helper/strings.dart';
import 'package:wordup_demo/helper/word_model.dart';
import 'package:wordup_demo/screens/home_page.dart';
import 'package:wordup_demo/screens/known_words.dart';
import 'package:wordup_demo/screens/words_to_learn.dart';
import 'package:wordup_demo/theme/colors.dart';
import '../controller/home_controller.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {


  HomeController controller = Get.find(tag: UIStrings.homeControllerTag);
  final List<Widget> pageList = [
    WordsToLearn(),
    HomePageStless(),
    KnownWords(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          children: pageList,
          index: controller.currentIndex.value,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: UIColors.primary400,
        unselectedItemColor: UIColors.grey200,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: controller.currentIndex.value,
        type: BottomNavigationBarType.fixed,
        onTap: (x) {
          controller.currentIndex.value = x;
          if(controller.currentIndex.value == 0){ //bottom deger degistiginde ekran yenileme oge ekleme
            controller.wordsToLearn.clear();
            controller.wordsToLearn.addAll(controller.learn_box.values.map((e) => e is WordModel ? e : null));
            print(controller.wordsToLearn);
          }
          else if(controller.currentIndex.value == 1){
            controller.learn.value = false;

          }
          else if(controller.currentIndex.value == 2){
            controller.knownWords.clear();
            controller.knownWords.addAll(controller.known_box.values.map((e) => e is WordModel ? e : null));
          }
        },
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
            ),
          ),
          BottomNavigationBarItem(
            label: '',
            icon: SvgPicture.asset(
              'assets/images/pin.svg',
              width: MediaQuery.of(context).size.width * 0.064,
              height: MediaQuery.of(context).size.height * 0.029,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
    );
  }
}
