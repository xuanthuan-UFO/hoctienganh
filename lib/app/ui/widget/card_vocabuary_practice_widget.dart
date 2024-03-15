import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tuhoctienganhcungthuan/app/model/vocabulary.dart';
import 'package:tuhoctienganhcungthuan/app/res/image/app_images.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';
import 'package:tuhoctienganhcungthuan/app/util/ufo_logger.dart';

import '../../model/english_exercise.dart';
import '../theme/app_colors.dart';

class CardVocabularyPracticeWidget extends StatefulWidget {
  final Function onPress;
  final Function onChangeMode;
  final Topic? dataTopic;
  final bool? hadChecked;
  final int statePractice;
  final List<EnglishExercise?>? dataExercise;

  const CardVocabularyPracticeWidget(
      {Key? key,
      required this.onPress,
      required this.onChangeMode,
      required this.statePractice,
      this.dataTopic,
      this.hadChecked, this.dataExercise})
      : super(key: key);

  @override
  _CardVocabularyPracticeWidgetState createState() => _CardVocabularyPracticeWidgetState();
}

class _CardVocabularyPracticeWidgetState extends State<CardVocabularyPracticeWidget> {
  final SwiperController controller = SwiperController();

  int totalPageNext = 0; // số trang mà ng dùng đã swipe
  int positonItem = 0;
  bool isChecked = false;
  Map<int, int?> selectedOptionIndexes = {}; // Track selected index for each card

  FlutterTts? flutterTts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initVoice();
  }

  @override
  void dispose() {
    super.dispose();
    flutterTts?.stop();
  }

  void initVoice() async {
    flutterTts = FlutterTts();
    await flutterTts?.setLanguage('en-US');
    await flutterTts?.awaitSpeakCompletion(true);
    try {
      await flutterTts?.getDefaultEngine;
      await flutterTts?.getDefaultVoice;
    }catch (e) {
      print(e);
    }
    await flutterTts?.setVolume(1.0);
    await flutterTts?.setSpeechRate(0.4);
    await flutterTts?.setPitch(1.0);
  }

  void saveSelectedOptions(String value, int indexOptions, int cardIndex) {
    setState(() {
      if (widget.hadChecked == true &&
          widget.dataExercise?[positonItem]?.isCorrect == true) {
        return;
      }
      widget.onPress(positonItem, value);
      selectedOptionIndexes[positonItem] = indexOptions; // Update selected index for current card
      controller.next();       // tự động chuyển item tiếp theo khi click 1 đáp án
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Swiper(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          return (widget.statePractice == 0) ? _buildCardVocabulary(context, widget.dataTopic?.data[index] ?? DetailWord(), index) : _buildCard(context, widget.dataExercise?[index] ?? EnglishExercise());
        },
        itemCount: (widget.statePractice == 0) ? (widget.dataTopic?.data.length ?? 0) : (widget.dataExercise?.length ?? 0),
        layout: SwiperLayout.TINDER,
        loop: true,
        viewportFraction: 0.8,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: MediaQuery.of(context).size.height * 0.8,
        onIndexChanged: (i) {
          totalPageNext++;
          UfoLogger().writeLog('onIndexChanged: $totalPageNext');
          if ((totalPageNext == widget.dataTopic?.data.length) && (widget.dataExercise != null && widget.dataExercise!.isNotEmpty)) {
            widget.onChangeMode();
          }
          setState(() {
            UfoLogger().writeLog('onIndexChanged: $i');
            positonItem = i;
          });
        },
      ),
    );
  }

  Widget _buildCardVocabulary(BuildContext context, DetailWord data, int index) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.tabUnSelected,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 6, right: 6, top: 6),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                child: Container(          // card vocabulary
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data.word ?? '',
                        style: style_S24_W600_WhiteColor,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        '/${data.pronunciation ?? ''}/',
                        style: style_S20_W600_WhiteColor,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      (data.type != null && data.type!.isNotEmpty) ? Text(
                        data.type ?? '',
                        style: style_S20_W600_WhiteColor,
                        textAlign: TextAlign.center,
                      ) : SizedBox.shrink(),
                      (data.type != null && data.type!.isNotEmpty) ? SizedBox(
                        height: 15,
                      ) : SizedBox.shrink(),
                      Text(
                        data.definition ?? '',
                        style: style_S20_W600_WhiteColor,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          flutterTts?.speak(data.word ?? '');
                        },
                        child: Image.asset(AppImages.ic_dialog_error, height: 60, ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _cardVocabulary(index)
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, EnglishExercise? dataExercise) {
    return Card(
      color: AppColors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.tabUnSelected,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 6, right: 6, top: 6),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                child: Container(          // card practice
                  child: Text(
                    dataExercise?.exerciseDescription ?? '',
                    style: style_S20_W600_WhiteColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          _buildOptions(context, dataExercise?.options ?? [], positonItem)
        ],
      ),
    );
  }

  Widget _cardVocabulary(int index) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                controller.previous();
              },
              child: Image.asset(AppImages.ic_dialog_error, height: 60, ),
            ),
            SizedBox(width: 40,),
            InkWell(
              onTap: () {
                if (((index +1) == widget.dataTopic?.data.length) && (widget.dataExercise != null && widget.dataExercise!.isNotEmpty)) {
                  widget.onChangeMode();
                  setState(() {
                    positonItem = widget.dataExercise!.length - 1;
                  });
                } else {
                  controller.next();
                }
              },
              child: Image.asset(AppImages.ic_dialog_success, height: 60, ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(
      BuildContext context, List<String> options, int cardIndex) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20, left: 6, right: 6),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 cột
          crossAxisSpacing: 15,
          mainAxisSpacing: 10,
          mainAxisExtent: 70.0,
        ),
        itemCount: options.length,
        itemBuilder: (context, index) {
          String value = options[index];
          return CommonButton(
              color: (widget.dataExercise?[positonItem]?.isCorrect == false &&
                      (value ==
                          widget.dataExercise?[positonItem]?.answerYourChoose) &&
                      (widget.dataExercise?[positonItem]?.isChangeStateAnswer ==
                          false))
                  ? AppColors.red
                  : (selectedOptionIndexes[cardIndex] == index
                      ? AppColors.bg_item_practive_true
                      : AppColors.lightGray),
              borderCircular: 10,
              onPressed: () {
                saveSelectedOptions(value, index, cardIndex);
              },
              child: Text(
                value,
                style: style_S16_W600_WhiteColor,
                textAlign: TextAlign.center,
              ));
        },
      ),
    );
  }
}
