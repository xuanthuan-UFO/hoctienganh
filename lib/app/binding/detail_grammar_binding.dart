import 'package:get/get.dart';

import '../controller/detail_grammar_controller.dart';

class DetailGrammarBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(DetailGrammarController());
  }
}
