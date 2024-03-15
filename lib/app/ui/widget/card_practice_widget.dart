import 'package:flutter/material.dart';
import 'package:flutter_swipe/flutter_swipe.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/common_button.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../model/english_exercise.dart';
import '../theme/app_colors.dart';

class CardPracticeWidget extends StatefulWidget {
  final Function onPress;
  final List<EnglishExercise?> dataExercise;
  final bool? hadChecked;

  const CardPracticeWidget(
      {Key? key,
      required this.onPress,
      required this.dataExercise,
      this.hadChecked})
      : super(key: key);

  @override
  _CardPracticeWidgetState createState() => _CardPracticeWidgetState();
}

class _CardPracticeWidgetState extends State<CardPracticeWidget> {
  final SwiperController controller = SwiperController();

  int positonItem = 0;
  bool isChecked = false;
  Map<int, int?> selectedOptionIndexes = {}; // Track selected index for each card

  void saveSelectedOptions(String value, int indexOptions) {
    setState(() {
      if (widget.hadChecked == true &&
          widget.dataExercise[positonItem]?.isCorrect == true) {
        return;
      }
      widget.onPress(positonItem, value);
      // controller.next();       // tự động chuyển item tiếp theo khi click 1 đáp án
      selectedOptionIndexes[positonItem] = indexOptions; // Update selected index for current card
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Swiper(
        controller: controller,
        itemBuilder: (BuildContext context, int index) {
          // positonItem = index;
          return _buildCard(context, widget.dataExercise[index]);
        },
        itemCount: widget.dataExercise.length,
        layout: SwiperLayout.TINDER,
        loop: true,
        viewportFraction: 0.8,
        itemWidth: MediaQuery.of(context).size.width,
        itemHeight: MediaQuery.of(context).size.height * 0.8,
        onIndexChanged: (i) {
          setState(() {
            positonItem = i;
          });
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, EnglishExercise? data) {
    return Card(
      color: AppColors.grayBackgroundStt,
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
                color: AppColors.bg_item_practive_true,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(left: 6, right: 6, top: 6),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Center(
                child: Container(
                  child: Text(
                    data?.exerciseDescription ?? '',
                    style: style_S20_W600_WhiteColor,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          _buildOptions(context, data?.options ?? [], positonItem),
        ],
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
              color: (widget.dataExercise[positonItem]?.isCorrect == false &&
                      (value ==
                          widget.dataExercise[positonItem]?.answerYourChoose) &&
                      (widget.dataExercise[positonItem]?.isChangeStateAnswer ==
                          false))
                  ? AppColors.red
                  : (selectedOptionIndexes[cardIndex] == index
                      ? AppColors.bg_item_practive_true
                      : AppColors.orange1),
              borderCircular: 10,
              onPressed: () {
                saveSelectedOptions(value, index);
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
