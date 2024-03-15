import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../../controller/app_controller.dart';
import '../../../controller/topic_vocabulary_controller.dart';
import '../../../res/string/app_strings.dart';
import '../../../util/configuration.dart';
import '../../theme/app_colors.dart';
import '../../widget/app_bar.dart';

class TopicVocabularyPage extends GetView<TopicVocabularyController> {
  final MyAppController _appController = Get.find<MyAppController>();

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return WillPopScope(
        onWillPop: () async {
          return controller.onPressKeyBack();
        },
        child: Scaffold(
          appBar: MyAppBar(
            titleChird: Text(
              AppStrings.title_topic_vocabulary.tr,
              style: style_S16_W600_WhiteColor,
            ),
            leftWidget: IconButton(
              onPressed: () => controller.onPressKeyBack(),
              icon: const Icon(
                Icons.arrow_back,
                color: Configuration.whiteColor,
              ),
            ),
          ),
          backgroundColor: AppColors.mainBackground,
          body: SafeArea(
            child: Obx(
              () => Container(
                padding: const EdgeInsets.all(Dimens.spaceXSmall10),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                child: Center(
                  child: (controller.listGroupData.value.topic != null) ?
                  GridView.builder(
                    itemCount: controller.listGroupData.value.topic!.length,
                    scrollDirection: Axis.vertical,
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 250,
                        childAspectRatio: 1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, int index) {
                      return itemTopicVocabularyWidget(context, index);
                    },
                  )

                      : SizedBox.shrink(),
                ),
              ),
            ),
          ),
        ));
  }

  Widget itemTopicVocabularyWidget(BuildContext context, int index) {
    return Obx(
          () => Container(
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
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          onPressed: () async{
            // delay for show effect press to button
            await Future.delayed(Duration(milliseconds: 100));
            controller.onPressSelectTopic(controller.listGroupData.value.topic![index]);
          },
          color: AppColors.transparent,
          child: Center(
            child: Text(controller.listGroupData.value.topic![index].topicName.toString(), style: style_S16_W600_WhiteColor,),
          ),
        ),
      ),
    );
  }
}
