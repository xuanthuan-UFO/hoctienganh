import 'package:get/get.dart';
import '../controller/daily_english_challenges_controller.dart';

class DailyEnglishChallengesBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DailyEnglishChallengesController());
  }
}
