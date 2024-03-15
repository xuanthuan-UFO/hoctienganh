import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tuhoctienganhcungthuan/app/route/app_pages.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/daily_english_challenges_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/practice/practice_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/vocabulary/vocabulary_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/theme/app_colors.dart';
import 'package:tuhoctienganhcungthuan/app/util/configuration.dart';
import '../res/string/app_strings.dart';
import '../ui/screen/gammar/grammar_page.dart';
import '../util/app_validation.dart';
import '../util/local_storage.dart';
import '../util/ufo_logger.dart';
import 'app_controller.dart';

class MainController extends GetxController {
  final MyAppController _appController = Get.find<MyAppController>();
  late BuildContext context;

  PersistentTabController controllerNavBar =
      PersistentTabController(initialIndex: 0);

  var currentIndex = 0.obs;

  void initLanguage() async {
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
  }

  @override
  void onInit() {
    super.onInit();
    initLanguage();
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

  void onPressGotoVocabulary() {
    UfoLogger().writeLog('goto vocabulary page');
    Get.toNamed(AppRoute.vocabulary_screen, arguments: TrxType.LEARN_GRAMMAR);
  }

  void onPressGotoGrammar() {
    UfoLogger().writeLog('goto Grammar page');
    Get.toNamed(AppRoute.grammar_screen, arguments: TrxType.LEARN_GRAMMAR);
  }

  void onPressGotoPractice() {
    UfoLogger().writeLog('goto Practice page');
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }

  List<Widget> buildScreens() {
    return [DailyEnglishChallengesPage(), GrammarPage(), VocabularyPage()];
  }

  List<PersistentBottomNavBarItem> navBarsItems() {
    return [
      PersistentBottomNavBarItem(
          icon: const Icon(CupertinoIcons.home),
          title: ('Daily'),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
          ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.book),
          title: ('Grammar'),
        activeColorPrimary: AppColors.orange,
        inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: AppRoute.grammar_screen,
            // routes: {
            //   "/first": (final context) => const MainScreen2(),
            //   "/second": (final context) => const MainScreen3(),
            // },
          )
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.doc_chart),
        title: ('Vocabulary'),
        activeColorPrimary: AppColors.green,
          inactiveColorPrimary: CupertinoColors.systemGrey,
          routeAndNavigatorSettings: const RouteAndNavigatorSettings(
            initialRoute: AppRoute.vocabulary_screen,
            // routes: {
            //   "/first": (final context) => const MainScreen2(),
            //   "/second": (final context) => const MainScreen3(),
            // },
          )
      ),
    ];
  }
}
