import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/res/string/app_strings.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/configuration.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/detail_grammar_controller.dart';
import '../../theme/app_colors.dart';
import '../../widget/app_bar.dart';

class DetailGrammarPage extends GetView<DetailGrammarController> {
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
          appBar: MyAppBar(
            titleChird: Text(controller.title.value, style: style_S16_W600_WhiteColor,),
            leftWidget: IconButton(
              onPressed: () => controller.onPressKeyBack(),
              icon: const Icon(
                Icons.arrow_back,
                color: Configuration.whiteColor,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(Dimens.spaceXSmall10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                    child: WebViewWidget(controller: controller.webViewController),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: CommonButton(
                    onPressed: () {
                      controller.onPressGotoPractice();
                    },
                    child: Text(AppStrings.titlePractice.tr, style: style_S16_W600_WhiteColor,),
                  ),
                )
                // Container(
                //   padding: EdgeInsets.all(Dimens.spaceXSmall10),
                //   child: Row(
                //     children: [
                //       Expanded(
                //           child: ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ));
  }
}
