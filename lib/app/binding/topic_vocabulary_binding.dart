import 'package:get/get.dart';

import '../controller/topic_vocabulary_controller.dart';

class TopicVocabularyBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(TopicVocabularyController());
  }
}
