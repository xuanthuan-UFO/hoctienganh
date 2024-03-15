import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/app_controller.dart';
import '../widget/loading_widget.dart';

class RootScreen extends GetView {
  final Widget? child;
  final MyAppController _appController = Get.find<MyAppController>();

  RootScreen(this.child);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          child!,
          _appController.loading.value ? LoadingWidget() : SizedBox(),
        ],
      );
    });
  }
}
