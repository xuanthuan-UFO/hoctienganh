import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/route/app_pages.dart';
import 'package:tuhoctienganhcungthuan/app/util/configuration.dart';
import 'package:tuhoctienganhcungthuan/app/util/ufo_logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../model/data_grammars.dart';
import 'app_controller.dart';

class DetailGrammarController extends GetxController {
  final MyAppController _appController = Get.find<MyAppController>();
  late BuildContext context;

  TrxType followType = TrxType.NONE;
  DataGrammars dataGrammars = DataGrammars();
  WebViewController webViewController = WebViewController();
  RxString title = ''.obs;

  @override
  void onInit() {
    super.onInit();

    followType = Get.arguments['followType'] ?? TrxType.NONE;
    dataGrammars = Get.arguments['data'] ?? DataGrammars();
    title.value = Get.arguments['title'];
    UfoLogger().writeLog('$followType');

    //initWebview
    webViewController.loadFlutterAsset('assets/${dataGrammars.nameFile}');
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

  onPressGotoPractice() {
    UfoLogger().writeLog('goto Practice screen ');
    UfoLogger().writeLog('followType: $followType -- idPractice: ${dataGrammars.idPractice}');
    Map param = {
      'followType': followType,
      'idPractice': dataGrammars.idPractice,
      'title': title.value
    };
    Get.toNamed(AppRoute.practice_screen, arguments: param);
  }
}
