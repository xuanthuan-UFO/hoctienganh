import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/vocabulary/vocabulary_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/theme/app_colors.dart';

import '../../controller/app_controller.dart';
import '../../controller/main_controller.dart';
import 'daily_english_challenges_page.dart';
import 'gammar/grammar_page.dart';

class MainScreen extends GetView<MainController> {
  final MyAppController _appController = Get.find<MyAppController>();

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return WillPopScope(
        onWillPop: () async {
          return controller.onPressKeyBack();
        },
        child: Container(
          color: Theme.of(context).colorScheme.onBackground,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.mainBackground,
              // body: Obx(() => _buildCurrentScreen(controller.currentIndex.value)),
              bottomNavigationBar: _buildBottomNavigationBar(context),
            ),
          ),
        ));
  }

  Widget _buildCurrentScreen(int index) {
    switch (index) {
      case 0:
        return DailyEnglishChallengesPage();
      case 1:
        return GrammarPage();
      case 2:
        return VocabularyPage();
      // case 3:
      //   return PracticePage();
      default:
        return Container();
    }
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        child: PersistentTabView(
          context,
          controller: controller.controllerNavBar,
          screens: controller.buildScreens(),
          items: controller.navBarsItems(),
          confineInSafeArea: true,
          backgroundColor: AppColors.mainBackground,
          // Default is AppColors.mainBackground.
          handleAndroidBackButtonPress: true,
          // Default is true.
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight + 20,
          bottomScreenMargin: 0,
          // selectedTabScreenContext: (final context) {
          //   testContext = context;
          // },
          // hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle: NavBarStyle.style1,
        ),
      ),
    );
  }
}
