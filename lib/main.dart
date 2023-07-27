import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wordup_demo/helper/bottom_navigaton_bar.dart';
import 'package:wordup_demo/theme/colors.dart';
import 'package:wordup_demo/theme/typhograpy.dart';
import 'controller/home_controller.dart';
import 'helper/word_model.dart';
import 'helper/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordModelAdapter());
  await Hive.openBox('learn_words');
  await Hive.openBox('known_words');
  await Hive.openBox('word_box');
  Get.put(HomeController(),tag: UIStrings.homeControllerTag);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WordUp Demo',
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  HomeController homeController = Get.find(tag: UIStrings.homeControllerTag);

  @override
  void initState() {
    super.initState();
    if(homeController.isBusy.value == false){
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Get.off(() => const BottomNavBar());
      });
    }
    homeController.isBusy.listen((value) {
      if(value == false){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Get.off(() => const BottomNavBar());
        });
      }
    });
    ever(homeController.isBusy, (value){
      if(value == false){
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Get.off(() => const BottomNavBar());
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: UIColors.primary400,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'wordUp',
                style: UIStyle.h2.copyWith(color: UIColors.white),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 16.0),
                child: Text(
                  'Loading Words',
                  style: UIStyle.b1_medium.copyWith(color: UIColors.white),
                ),
              ),
              CircularProgressIndicator(color: UIColors.white,)
            ],
          ),
        ),
      ),
    );
  }
}
