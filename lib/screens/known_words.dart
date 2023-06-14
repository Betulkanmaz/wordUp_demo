import 'package:flutter/material.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';

class KnownWords extends StatefulWidget {
  const KnownWords({Key? key}) : super(key: key);

  @override
  State<KnownWords> createState() => _KnownWordsState();
}

class _KnownWordsState extends State<KnownWords> {
  final List<String> words = [
    "abreact",
    "abreacted",
    "abreacting",
    "abreaction",
    "abreactions",
    "abreacts",
    "abreast",
    "abri",
    "abridge",
    "abridged",
    "abridgement",
    "abridgements",
    "abridger",
    "abridgers",
    "abridges",
    "abridging",
    "abridgment",
    "abridgments",
    "abris",
    "abroach",
    "abroad",
    "abrogable",
    "abrogate",
    "abrogated",
    "abrogates",
    "abrogating",
    "abrogation",
    "abrogations",
    "abrogator",
    "abrogators",
    "abrosia",
    "abrosias",
    "abrupt",
    "abrupter",
    "abruptest",
    "abruption",
    "abruptions",
    "abruptly",
    "abruptness",
    "abruptnesses"
  ];

  ScrollController scrollController = ScrollController();

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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Known words',
                          style: UIStyle.sh2.copyWith(color: UIColors.grey400)),
                      Text(
                        'We must repeat it regularly so that we do not forget the words we know.',
                        style:
                            UIStyle.b2_medium.copyWith(color: UIColors.grey200),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.029),
                  ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(height: 8.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: words.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
                        height: MediaQuery.of(context).size.height * 0.075,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: UIColors.grey50,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(words[index], style: UIStyle.b1.copyWith(color: UIColors.grey400,)),
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
