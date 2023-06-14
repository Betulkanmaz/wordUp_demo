import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';

class WordsToLearn extends StatefulWidget {
  const WordsToLearn({Key? key}) : super(key: key);

  @override
  State<WordsToLearn> createState() => _WordsToLearnState();
}

class _WordsToLearnState extends State<WordsToLearn> {

  var box1 = Hive.openBox('learn_words');

  List<String> wordList = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
          child: Center(
            widthFactor: MediaQuery.of(context).size.width * 0.872,
            heightFactor: MediaQuery.of(context).size.height * 0.816,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.722,
                        height: MediaQuery.of(context).size.height * 0.108,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Words to Learn',
                              style:
                                  UIStyle.sh2.copyWith(color: UIColors.grey400),
                            ),
                            Text(
                              'Repeat to learn words you don`t know the meaning of.',
                              style: UIStyle.b2_medium
                                  .copyWith(color: UIColors.grey200),
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        alignment: Alignment.center,
                        icon: SvgPicture.asset(
                          'assets/images/start.svg',
                          width: MediaQuery.of(context).size.width * 0.128,
                          height: MediaQuery.of(context).size.height * 0.059,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {

                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.029),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 8.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 20,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                        height: MediaQuery.of(context).size.height * 0.075,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: UIColors.grey50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('xxxxx',
                                style: UIStyle.b1.copyWith(
                                  color: UIColors.grey400,
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
