import 'package:flutter/material.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';
import 'package:tuhoctienganhcungthuan/app/util/ufo_logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/english_exercise.dart';
import '../../util/configuration.dart';
import '../theme/app_colors.dart';
import 'item_exercise_widget.dart';

class NormalPracticeWidget extends StatefulWidget {
  final Function onPress;
  final List<EnglishExercise?> dataExercise;
  final bool? hadChecked;

  const NormalPracticeWidget({Key? key, required this.onPress, required this.dataExercise, this.hadChecked})
      : super(key: key);

  @override
  _NormalPracticeWidgetState createState() => _NormalPracticeWidgetState();
}

class _NormalPracticeWidgetState extends State<NormalPracticeWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        itemCount: widget.dataExercise.length,
        itemBuilder: (context, index) {
          return ItemExerciseWidget(
            hadChecked: widget.hadChecked,
            data: widget.dataExercise[index],
            onPress: (answer) {
              widget.onPress!(index, answer);
              // controller.onPressChoseAnswer(index, answer);
            },
          );
        },
      ),
    );
  }
}
