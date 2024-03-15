import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/ui/theme/app_colors.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';
import '../../controller/app_controller.dart';
import '../../controller/daily_english_challenges_controller.dart';

class DailyEnglishChallengesPage extends GetView<DailyEnglishChallengesController> {
  final MyAppController _appController = Get.find<MyAppController>();

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return Container(
      color: AppColors.mainBackground,
      child: Obx(
            () => Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // header
              Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          child: Icon(CupertinoIcons.profile_circled, color: AppColors.primary, size: 30,),
                          onTap: () {
                            print('tap tap');
                          },
                        ),
                        SizedBox(width: 10,),
                        Text(controller.titleChallenges.value, style: style_S14_W600_BlackColor,),
                      ],
                    ),
                    Row(
                      children: [
                        Text(controller.streak.value, style: style_S18_W600_RedColor,),
                        SizedBox(width: 5,),
                        Icon(CupertinoIcons.flame_fill, color: AppColors.red, size: 20,),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 10,
                color: AppColors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}
