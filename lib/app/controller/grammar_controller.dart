import 'dart:convert';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/route/app_pages.dart';
import 'package:tuhoctienganhcungthuan/app/util/configuration.dart';
import 'package:tuhoctienganhcungthuan/app/util/ufo_logger.dart';
import '../model/data_grammars.dart';
import '../util/local_storage.dart';
import 'app_controller.dart';

class GrammarController extends GetxController {
  final MyAppController _appController = Get.find<MyAppController>();
  late BuildContext context;

  TrxType followType = TrxType.LEARN_GRAMMAR;

  RxList<DataGrammars> listGroupData = RxList();

  @override
  void onInit() async {
    super.onInit();

    if (Get.arguments != null) {
      followType = Get.arguments;
    }
    UfoLogger().writeLog('$followType');


    //todo test - get config data grammar.
    Map<String, dynamic> jsonData = jsonDecode(Configuration().dataGrammar);
    List<dynamic> dataJson = jsonData['data'];
    listGroupData.value = dataJson.map((item) => DataGrammars.fromJson(item)).toList();
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

  onPressItemGrammar(DataGrammars data) {
    UfoLogger().writeLog('deception: ${data.deceptionVi} -- nameFile: ${data.nameFile}');
    Map param = {"followType": followType, "data": data, 'title': (Get.find<MyAppController>().currentLanguageApp.value == 'vi') ? data.deceptionVi : data.deceptionEn,};
    Get.toNamed(AppRoute.detail_grammar_screen, arguments: param);
  }
}
