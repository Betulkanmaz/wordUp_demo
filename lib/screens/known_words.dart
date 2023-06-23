import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';
import '../controller/home_controller.dart';

class KnownWords extends StatefulWidget {
  const KnownWords({Key? key}) : super(key: key);

  @override
  State<KnownWords> createState() => _KnownWordsState();
}

class _KnownWordsState extends State<KnownWords> {
  var controller = Get.put(HomeController());
  ScrollController scrollController = ScrollController();

  void initState() {
    super.initState();
    controller.setKnownWords();
    WidgetsBinding.instance
        .addObserver(LifecycleEventHandler(resumeCallBack: () async {
      controller.setKnownWords();
    }, suspendingCallBack: () async {
      controller.setKnownWords();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 24.0, right: 24.0),
          child: Center(
            widthFactor: MediaQuery.of(context).size.width * 0.872,
            heightFactor: MediaQuery.of(context).size.height * 0.816,
            child: Column(
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
                SizedBox(height: MediaQuery.of(context).size.height * 0.029),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 8.0),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: controller.knownWords.length,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              padding: EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                  left: 16.0,
                                  right: 16.0),
                              height:
                                  MediaQuery.of(context).size.height * 0.075,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0),
                                color: UIColors.grey50,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.knownWords[index],
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LifecycleEventHandler extends WidgetsBindingObserver {
  //tiklanildiginda sayfa yenilenmesi icin
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
