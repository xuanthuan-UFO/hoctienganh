import 'package:flutter/material.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';
import 'package:tuhoctienganhcungthuan/app/util/ufo_logger.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../model/english_exercise.dart';
import '../../util/configuration.dart';
import '../theme/app_colors.dart';

class ItemExerciseWidget extends StatefulWidget {
  final Function? onPress;
  final EnglishExercise? data;
  final bool? hadChecked;

  const ItemExerciseWidget({Key? key, this.onPress, this.data, this.hadChecked})
      : super(key: key);

  @override
  _ItemExerciseWidgetState createState() => _ItemExerciseWidgetState();
}

class _ItemExerciseWidgetState extends State<ItemExerciseWidget> {
  TextEditingController _textAnswer = TextEditingController();
  int? _selectedOption;
  void saveSelectedOptions(int index, String value) {
    setState(() {
      if (widget.hadChecked == true && widget.data?.isCorrect == true) {
        return;
      }
      _selectedOption = index;
      if (widget.onPress != null) {
        widget.onPress!(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.bg_item_practive_false,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(204, 223, 242, 0.17),
                offset: Offset(0, 8),
                blurRadius: 25,
              )
            ]),
        child: Stack(
          children: [
            Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: [
                    TextSpan(
                      text: '${widget.data?.exerciseTitle}: ',
                      style: style_S14_W600_BlackColor,
                    ),
                    TextSpan(
                      text: '${widget.data?.exerciseDescription}',
                    ),
                  ],
                ),
              ),

              // Text('${widget.data?.exerciseTitle}: ${widget.data?.exerciseDescription}'),
              SizedBox(
                height: 10,
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: (widget.data?.options ?? [])
                    .asMap()
                    .entries
                    .map<Widget>((entry) {
                  int index = entry.key;
                  String value = entry.value;
                  return GestureDetector(
                    onTap: () {
                      saveSelectedOptions(index, value);
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: index,
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            // saveSelectedOptions(value);
                          },
                        ),
                          Text(
                              value,
                            style:
                            (widget.hadChecked == false) ? style_S16_W400_BlackColor :
                            ((widget.data?.isCorrect == false && (value == widget.data?.answerYourChoose) && (widget.data?.isChangeStateAnswer == false))
                                ? style_S16_W400_RedColor
                                : ((widget.data?.isCorrect == true && (value == widget.data?.answerYourChoose))
                                  ? style_S16_W400_BlueColor
                                  : style_S16_W400_BlackColor))
                          ),
                        ],
                    ),
                  );
                }).toList(),
              ),
            ]),

            if (widget.data?.formulaLink != null)
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  onPressed: () => onPressShowSuggestion(widget.data!.formulaLink!),
                  icon: Icon(
                    Icons.tips_and_updates_outlined,
                    color: Configuration.orangerMainColour,
                  ),
                ),
              ),
        ]));
  }

  onPressShowSuggestion(String url) {
    UfoLogger().writeLog('onPressShowSuggestion $url');
    WebViewController webViewController = WebViewController();
    webViewController.loadFlutterAsset('assets/$url');

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your Suggestion Title"),
          content: Container(
            height: 300, // Adjust the height as needed
            width: 300,  // Adjust the width as needed
            child: WebViewWidget(controller: webViewController),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
