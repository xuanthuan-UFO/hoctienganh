import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/res/string/app_strings.dart';
import 'package:tuhoctienganhcungthuan/app/ui/theme/app_colors.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/card_practice_widget.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/practice_controller.dart';
import '../../../util/configuration.dart';
import '../../widget/card_vocabuary_practice_widget.dart';
import '../../widget/normal_practice_widget.dart';

class PracticePage extends GetView<PracticeController> {
  final MyAppController _appController = Get.find<MyAppController>();

  @override
  Widget build(BuildContext context) {
    controller.context = context;

    return WillPopScope(
        onWillPop: () async {
          return controller.onPressKeyBack();
        },
        child: Scaffold(
          backgroundColor: AppColors.mainBackground,
          body: SafeArea(
            child: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: true,
                    pinned: false,
                    title: Text(controller.title.value,
                        style: style_S16_W600_WhiteColor),
                    snap: true,
                    flexibleSpace: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: <Color>[
                              Color.fromRGBO(209, 45, 91, 1),
                              Color.fromRGBO(219, 88, 39, 1)
                            ]),
                      ),
                    ),
                    leading: IconButton(
                      onPressed: () => controller.onPressKeyBack(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Configuration.whiteColor,
                      ),
                    ),
                  ),
                  Obx(() {
                    if ((controller.typePractice.value == TrxTypePractice.CARD_VOCABULARY || controller.typePractice.value == TrxTypePractice.CARD_VOCABULARY_AND_PRACTICE) && (controller.state_vocabuary.value == 1)) {
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: _SliverAppBarDelegate(
                          PreferredSize(
                            preferredSize: Size.fromHeight(60),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Obx(
                                          () => Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          controller.isShowResult.value
                                              ? const SizedBox()
                                              : Text(
                                            'Đã chọn: ${controller.totalYourAnswer.value}/${controller.dataExercise.length}',
                                            style: style_S14_W600_BlackColor,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          controller.isShowResult.value
                                              ? Text(
                                              'Chính xác: ${controller.totalYourAnswerCorrect.value}/${controller.dataExercise.length}',
                                              style: style_S14_W600_RedColor)
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: CommonButton(
                                      color: (controller.totalYourAnswer.value ==
                                          controller.dataExercise.length)
                                          ? AppColors.primary
                                          : AppColors.tabUnSelected,
                                      padding: EdgeInsets.all(5),
                                      title: AppStrings.tv_submit_practice.tr,
                                      onPressed: () {
                                        controller.onPressSubmitPractice();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Return an empty sliver if conditions are not met
                      return SliverToBoxAdapter(child: SizedBox());
                    }
                  }),
                ];
              },
              body: Container(
                child: Obx(
                  () {
                    switch (controller.followType.value) {
                      case TrxType.LEARN_GRAMMAR:
                        switch (controller.typePractice.value) {
                          case TrxTypePractice.NORMAL:
                            return NormalPracticeWidget(
                              onPress: (index, value) =>
                                  controller.onPressChoseAnswer(index, value),
                              dataExercise: controller.dataExercise.value,
                              hadChecked: controller.hadChecked.value,
                            );
                          case TrxTypePractice.CARD_GAMMAR:
                            return CardPracticeWidget(
                              onPress: (index, value) =>
                                  controller.onPressChoseAnswer(index, value),
                              dataExercise: controller.dataExercise.value,
                              hadChecked: controller.hadChecked.value,
                            );
                          default:
                            return SizedBox(); // Thêm widget mặc định ở đây nếu có loại typePractice khác
                        }
                      case TrxType.LEARN_VOCABULARY:
                        return CardVocabularyPracticeWidget(
                          statePractice: controller.state_vocabuary.value,
                          dataTopic: controller.dataTopic.value,
                          onPress: (index, value) {
                            controller.onPressChoseAnswer(index, value);
                          },
                          dataExercise: controller.dataExercise,
                          onChangeMode: () {
                            controller.onChangeModePracticeWord();
                          },
                        );
                      default:
                        return SizedBox();
                    }
                  },
                ),
              ),
            ),
          ),
        ));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final PreferredSize widget;

  _SliverAppBarDelegate(this.widget);

  @override
  double get minExtent => widget.preferredSize.height;

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.mainBackground,
      child: widget,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
