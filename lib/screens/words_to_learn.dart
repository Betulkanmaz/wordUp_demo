import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';
import '../controller/home_controller.dart';

class WordsToLearn extends StatefulWidget {
  const WordsToLearn({Key? key}) : super(key: key);

  @override
  State<WordsToLearn> createState() => _WordsToLearnState();
}

class _WordsToLearnState extends State<WordsToLearn>{
  var controller = Get.put(HomeController());
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.setWordsToLearn();
    WidgetsBinding.instance.addObserver(
        LifecycleEventHandler(resumeCallBack: () async{
          controller.setWordsToLearn();
        },suspendingCallBack: () async {
          controller.setWordsToLearn();
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx( () =>
      SafeArea(
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.029),
                    ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(height: 8.0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.wordsToLearn.length,
                      physics: ScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: const EdgeInsets.only(
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
                              Text(
                                controller.wordsToLearn[index],
                                style: UIStyle.b1.copyWith(
                                  color: UIColors.grey400,
                                ),
                              ),
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
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver { //tiklanildiginda sayfa yenilenmesi icin
  final AsyncCallback resumeCallBack;
  final AsyncCallback suspendingCallBack;

  LifecycleEventHandler({
    required this.resumeCallBack,
    required this.suspendingCallBack,
  });

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed: 
        if (resumeCallBack != null) {
          await resumeCallBack();
        }
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        if (suspendingCallBack != null) {
          await suspendingCallBack();
        }
        break;
    }
  }
}