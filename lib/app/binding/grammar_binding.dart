import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/controller/grammar_controller.dart';

import '../controller/main_controller.dart';

class GrammarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GrammarController());
  }
}
