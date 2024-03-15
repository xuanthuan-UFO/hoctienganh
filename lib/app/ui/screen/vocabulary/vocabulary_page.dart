import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tuhoctienganhcungthuan/app/controller/vocabulary_controller.dart';
import 'package:tuhoctienganhcungthuan/app/res/image/app_images.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../../controller/app_controller.dart';
import '../../../controller/main_controller.dart';
import '../../../res/string/app_strings.dart';
import '../../../util/configuration.dart';
import '../../theme/app_colors.dart';
import '../../widget/app_bar.dart';

class VocabularyPage extends GetView<VocabularyController> {
  final MyAppController _appController = Get.find<MyAppController>();

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          titleChird: Text(
            AppStrings.titleVocabulary.tr,
            style: style_S16_W600_WhiteColor,
          ),
          rightChildren: [
            IconButton(
              onPressed: () => controller.onPressSettingVocabulary(),
              icon: const Icon(
                Icons.settings_sharp,
                color: Configuration.whiteColor,
              ),
            )
          ],
        ),
        backgroundColor: AppColors.mainBackground,
        body: SafeArea(child: _buildNormalScreen(context)),
      ),
    );
  }

  Widget _buildNormalScreen(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(bottom: Dimens.spaceLarge48),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.title_target_vocabulary.tr,
                    style: TextStyle(
                        fontFamily: kFontFamilyBeVietnamPro,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColors.primary
                    ), textAlign: TextAlign.center,
                  ),
                  const SizedBox(width: 20,),
                  CircularPercentIndicator(
                    radius: 30.0,
                    lineWidth: 8.0,
                    percent: controller.totalWordLearnToday.value/controller.yourTarget.value,
                    center: Text('${controller.totalWordLearnToday.value}/${controller.yourTarget.value}',
                    style: TextStyle(
                      color: (controller.totalWordLearnToday.value != controller.yourTarget.value) ? AppColors.orange : AppColors.success,
                      fontFamily: kFontFamilyBeVietnamPro,
                    ),),
                    backgroundColor: AppColors.gray2,
                    progressColor: (controller.totalWordLearnToday.value != controller.yourTarget.value) ? AppColors.orange : AppColors.success,
                  )
                ],
              ),
            ),
            Expanded(child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    itemOptionsVocabulary(context, () {
                      controller.onPressReviewVocabulary();
                    },
                        AppStrings.title_review_word.tr.replaceFirst(
                            '%1s', controller.totalWordLearned.value.toString()),
                        AppImages.ic_dialog_success),
                    SizedBox(
                      height: Dimens.spaceXSmall10,
                    ),
                    itemOptionsVocabulary(context, () {
                      controller.onPressLearnVocabulary();
                    }, AppStrings.title_learn_words_everyday.tr.replaceFirst('%1s', controller.yourTarget.value.toString()), AppImages.ic_dialog_error),
                    SizedBox(
                      height: Dimens.spaceXSmall10,
                    ),
                    itemOptionsVocabulary(context, () {
                      controller.onPressTopicVocabulary();
                    }, AppStrings.title_topic.tr, AppImages.ic_dialog_warning),
                  ],
                ),
              ),
            ),)
          ],
        )
      ),
    );
  }

  Widget itemOptionsVocabulary(
      BuildContext context, VoidCallback? onPress, String title, String icon) {
    return Container(
      width: MediaQuery.of(context).size.width - 80,
      height: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.grayBorder,
          width: 1.0,
        ),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color.fromRGBO(209, 45, 91, 1),
              Color.fromRGBO(219, 88, 39, 1)
            ]),
        // color: AppColors.mainBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CommonButton(
        color: AppColors.transparent,
        onPressed: onPress,
        padding: EdgeInsets.zero,
        borderCircular: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(left: 10),
                child: Center(
                    child: Image.asset(
                  icon,
                  height: 50,
                ))),
            Expanded(
                child: Center(
              child: Container(
                child: Text(
                  title,
                  style: style_S16_W600_WhiteColor,
                  textAlign: TextAlign.center,
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
