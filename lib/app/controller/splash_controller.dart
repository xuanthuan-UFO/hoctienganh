import 'dart:io';
import 'dart:ui';

import 'package:get/get.dart';

import '../res/string/app_strings.dart';
import '../route/app_pages.dart';
import '../util/app_validation.dart';
import '../util/local_storage.dart';
import 'app_controller.dart';

class SplashController extends GetxController {
  MyAppController _appController = Get.find<MyAppController>();

  @override
  void onReady() async {
    // await Firebase.initializeApp();
    //
    // await FirebaseMessaging.instance.setAutoInitEnabled(true);
    //
    // try {
    //   final fcmToken = await FirebaseMessaging.instance.getToken();
    //   print("fcmToken = $fcmToken");
    //   _appController.deviceIdentifier = fcmToken;
    // } catch (e) {
    //   print(e);
    // }

    super.onReady();
    String langString = await LocalStorage().getLanguageApp();
    print('langString=' + langString);
    if (isNullEmpty(langString)) {
      String currLangSys = Platform.localeName;
      print('currLangSys=$currLangSys');
      if (currLangSys != AppStrings.localeCodeVi) {
        langString = 'en';
      } else {
        langString = 'vi';
      }
      LocalStorage().setLanguageApp(langString);
    }
    Get.updateLocale(
        langString == 'vi' ? Locale('vi', 'VN') : Locale('en', 'US'));
    _appController.currentLanguageApp.value = langString;
    Get.offAndToNamed(AppRoute.main_screen);
  }

// void getVersionApp() async {
//   PackageInfo packageInfo = await PackageInfo.fromPlatform();
//   _appController.appVersion = packageInfo.version;
//   _appController.buildNumber = packageInfo.buildNumber;
//   SessionData.version = packageInfo.version;
// }
}
