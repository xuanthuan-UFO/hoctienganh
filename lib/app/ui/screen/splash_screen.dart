import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../controller/splash_controller.dart';
import '../../res/image/app_images.dart';
import '../../res/string/app_strings.dart';
import '../theme/app_colors.dart';
import '../theme/app_dimens.dart';
import '../widget/common_screen.dart';

class SplashScreen extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      mainBackgroundColor: AppColors.mainBackground,
      child: Center(
        child: buildSplash(),
        // child: CircularProgressIndicator(),
      ),
    );
  }

  Container buildSplash() {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              AppImages.logo_ufo,
            ),
            const SizedBox(
              height: AppDimens.spaceMedium,
            ),
            Text(
              AppStrings.splashSlogan.tr,
              style: style_S14_W600_BlackColor,
            ),
            SizedBox(
              height: AppDimens.spaceMedium,
            ),
            CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
