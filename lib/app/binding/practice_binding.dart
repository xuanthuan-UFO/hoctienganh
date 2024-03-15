import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/controller/practice_controller.dart';

class PracticeBinding implements Bindings {
  @override
  void dependencies() {
    // Get.put(PracticeController());
    Get.lazyPut(()=> PracticeController(), fenix: false);
  }
}
