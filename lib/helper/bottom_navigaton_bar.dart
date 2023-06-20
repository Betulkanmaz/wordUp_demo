import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wordup_demo/screens/home_page.dart';
import 'package:wordup_demo/screens/known_words.dart';
import 'package:wordup_demo/screens/words_to_learn.dart';
import 'package:wordup_demo/theme/colors.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentIndex = 1;

  List<Widget> pageList = [
    WordsToLearn(),
    HomePageStless(),
    KnownWords(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: UIColors.primary400,
        unselectedItemColor: UIColors.grey200,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (x){
          setState(() {
            currentIndex= x;
          });
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
      body: pageList[currentIndex],
    );
  }
}
