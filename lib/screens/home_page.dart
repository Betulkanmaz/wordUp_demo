import 'package:flutter/material.dart';
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
  ];

  List<Widget> pageList = [
    WordsToLearn(),
    KnownWords(),
  ];

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
                          style: UIStyle.b2_medium.copyWith(
                              color: UIColors.grey200,
                              fontFamily: 'Poppins-Regular'),
                          textAlign: TextAlign.center),
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.872,
                  height: MediaQuery.of(context).size.height * 0.472,

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
                        onPressed: () {
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
                          child: Icon(
                            Icons.clear,
                            color: UIColors.primary300,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: UIColors.grey50,
                          side: BorderSide(color: UIColors.grey100, width: 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0)),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.064,
                          height: MediaQuery.of(context).size.height * 0.029,
                          child: Icon(
                            Icons.rotate_left_sharp,
                            color: UIColors.primary300,
                          ),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
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
                            child: Icon(
                              Icons.check,
                              color: UIColors.primary300,
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.zero,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            items: [
              BottomNavigationBarItem(
                  label: '',
                  icon: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.048,
                      height: MediaQuery.of(context).size.height * 0.022,
                      child: Icon(Icons.star_border,
                          color: UIColors.grey200))),
              BottomNavigationBarItem(
                  label: '',
                  icon: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.048,
                    height: MediaQuery.of(context).size.height * 0.022,
                    child: Icon(
                      Icons.home,
                      color: UIColors.grey200,
                    ),
                  )),
              BottomNavigationBarItem(
                  label: '',
                  icon: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.048,
                      height: MediaQuery.of(context).size.height * 0.022,
                      child: Icon(Icons.star_border, color: UIColors.grey200)))
            ],
          ),
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

