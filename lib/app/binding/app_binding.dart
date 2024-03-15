import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/controller/daily_english_challenges_controller.dart';
import 'package:tuhoctienganhcungthuan/app/controller/practice_controller.dart';
import 'package:tuhoctienganhcungthuan/app/controller/vocabulary_controller.dart';

import '../controller/app_controller.dart';
import '../controller/grammar_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyAppController());

    // Get.put(GrammarController());
    // Get.put(VocabularyController());
    // Get.put(PracticeController());
    Get.lazyPut(() => DailyEnglishChallengesController());
    Get.lazyPut(() => GrammarController());
    Get.lazyPut(() => VocabularyController());
    Get.lazyPut(() => PracticeController());
  }
}
