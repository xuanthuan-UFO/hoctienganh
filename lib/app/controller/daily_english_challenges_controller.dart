import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'app_controller.dart';

class DailyEnglishChallengesController extends GetxController {
  final MyAppController _appController = Get.find<MyAppController>();
  late BuildContext context;

  RxString titleChallenges = ''.obs;
  RxString streak = ''.obs;

  @override
  void onInit() {
    super.onInit();

    titleChallenges.value = '30 ngày học ngữ pháp';
    streak.value = '100201';
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  Future<bool> onPressKeyBack() {
    Get.back();
    return Future.value(false);
  }

}
