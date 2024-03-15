import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/local_storage.dart';

class MyAppController extends SuperController {
  RxBool loading = false.obs;
  String? appVersion = '';
  String? buildNumber = '';
  Timer? _timer;

  RxString currentLanguageApp = ''.obs;

  showLoading({bool autoHide = true}) {
    loading.value = true;
    if (autoHide) {
      _timer = Timer.periodic(Duration(seconds: 40), (timer) {
        if (loading.value == true) {
          hideLoading();
        }
      });
    }
  }

  hideLoading() {
    loading.value = false;
    if (_timer != null) {
      _timer!.cancel();
    }
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    // _checkCacheLogError();
  }

  // changeLanguageApp(BuildContext? context) async {
  //   String currentLanguageApp = await localStorage.getLanguageApp();
  //   if (currentLanguageApp.length > 0) {
  //     List<ObjSettingSelect> listLanguage = [
  //       ObjSettingSelect('Tiếng Việt', 'vi'),
  //       ObjSettingSelect('English', 'en'),
  //     ];
  //
  //     showModalBottomSheet(
  //       context: context!,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
  //       ),
  //       builder: (context) => SettingLanguage(
  //         onSelectItem: (settingSelected) {
  //           AppUtils.log('select item ${settingSelected.value}');
  //           handlerSelectLanguage(settingSelected.value);
  //         },
  //         listSetting: listLanguage,
  //         valueSelected: ObjSettingSelect('', currentLanguageApp),
  //       ),
  //       isScrollControlled: true,
  //       isDismissible: false,
  //     );
  //   }
  // }
  //
  // handlerSelectLanguage(String? languageSelected) {
  //   Get.back();
  //   Get.updateLocale(
  //       languageSelected == 'vi' ? Locale('vi', 'VN') : Locale('en', 'US'));
  //   localStorage.setLanguageApp(languageSelected);
  //   NativeBridge.getInstance().nativeSetLanguage(languageSelected);
  // }
}
