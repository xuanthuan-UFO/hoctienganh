import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/controller/grammar_controller.dart';
import 'package:tuhoctienganhcungthuan/app/model/data_grammars.dart';
import 'package:tuhoctienganhcungthuan/app/res/string/app_strings.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/configuration.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../../controller/app_controller.dart';
import '../../theme/app_colors.dart';
import '../../widget/app_bar.dart';

class GrammarPage extends GetView<GrammarController> {
  final MyAppController _appController = Get.find<MyAppController>();

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
      appBar: MyAppBar(
        titleChird: Text(AppStrings.titleGrammar.tr, style: style_S16_W600_WhiteColor,),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(bottom: Dimens.spaceLarge48),
          padding: const EdgeInsets.all(Dimens.spaceXSmall10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
          child: Center(
            child: controller.listGroupData.value.isNotEmpty ?
            // ListView.builder(
            //   shrinkWrap: true,
            //   padding: EdgeInsets.only(top: 5),
            //   itemCount: 1,
            //   itemBuilder: (context, index) {
            //     return itemGrammarWidget(context, index);
            //   },)
            GridView.builder(
              itemCount: controller.listGroupData.value.length,
              scrollDirection: Axis.vertical,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  childAspectRatio: 1,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemBuilder: (BuildContext context, int index) {
                return itemGrammarWidget(context, index);
              },
            )

                : SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget itemGrammarWidget(BuildContext context, int index) {
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
            controller.onPressItemGrammar(controller.listGroupData.value[index]);
          },
          color: AppColors.transparent,
          child: Center(
            child: Text((Get.find<MyAppController>().currentLanguageApp.value == 'vi') ? controller.listGroupData.value[index].deceptionVi.toString() : controller.listGroupData.value[index].deceptionEn.toString(), style: style_S16_W600_WhiteColor,),
          ),
        ),
      ),
    );
  }

  Widget _buildItemRowTransaction(DataGrammars data) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: 10),
        child: CommonButton(
          title: (Get.find<MyAppController>().currentLanguageApp.value == 'vi') ? data.deceptionVi : data.deceptionEn,
          onPressed: () => controller.onPressItemGrammar(data),
        ),
      ),
    );
  }
}
