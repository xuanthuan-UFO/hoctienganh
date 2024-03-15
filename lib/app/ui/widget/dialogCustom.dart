import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tuhoctienganhcungthuan/app/res/image/app_images.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../util/configuration.dart';

typedef FunctioMainAction = void Function(String textInput);

// ignore: must_be_immutable
class DialogCustom extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonMainText;
  final String? buttonTextCancel;
  final String? type;
  final String? inputTitle;
  final FunctioMainAction? onClickMain;
  final Function? onClickCancel;
  final Widget? childBody;
  Color? _colorTitleBg;
  String? iconType;
  TextAlign? textAlignDetail = TextAlign.center;
  var textConfirm = TextEditingController(text: "");
  bool validConfirmButtonState = false;
  final bool? dismissPopUp;
  int? delay;

  static const String TYPE_SUCCESS = "SUCCESS";
  static const String TYPE_ERROR = "ERROR";
  static const String TYPE_WARNING = "WARNING";
  static const String TYPE_CONFIRM = "CONFIRM";

  DialogCustom(
      {this.title,
      this.description,
      this.buttonTextCancel,
      required this.buttonMainText,
      this.inputTitle,
      this.type,
      this.onClickMain,
      this.onClickCancel,
      this.dismissPopUp,
      this.childBody,
      this.textAlignDetail, this.delay});

  static showDialogWithType(BuildContext contextMain,
      {String? type,
      String? title,
      String? message,
      String? titleButtonCancel,
      String? titleButtonMain = "Đóng",
      FunctioMainAction? actionMainButton,
      String? textInputMessage,
      TextAlign textAlign = TextAlign.center,
      Widget? childBody,
      int? delay}) {
    showDialog(
        context: contextMain,
        barrierDismissible: false,
        builder: (BuildContext context) => DialogCustom(
              type: type,
              title: title,
              description: message,
              buttonTextCancel: titleButtonCancel,
              buttonMainText: titleButtonMain,
              onClickMain: actionMainButton,
              inputTitle: textInputMessage,
              textAlignDetail: textAlign,
              childBody: childBody,
            ));
  }

  @override
  Widget build(BuildContext context) {
    if (delay != null){
      Timer(Duration(seconds: delay!), () {
        if (context.mounted){
          Navigator.pop(context);
        }
      });
    }
    initStyleByType();
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Configuration.cornerRadius5)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  initStyleByType() {
    _colorTitleBg = Configuration.mainColour;
    iconType = null;
    if (type == TYPE_ERROR) {
      _colorTitleBg = Configuration.mainColour;
      iconType = AppImages.ic_dialog_error;
    } else if (type == TYPE_WARNING) {
      _colorTitleBg = Configuration.orangerMainColour;
      iconType = AppImages.ic_dialog_warning;
    } else if (type == TYPE_SUCCESS) {
      _colorTitleBg = Configuration.greenMainColour;
      iconType = AppImages.ic_dialog_success;
    }
  }

  bool validMainButton() {
    if (type == TYPE_CONFIRM) {
      return validConfirmButtonState;
    } else {
      return true;
    }
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            bottom: 8,
          ),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Configuration.cornerRadius15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: new BorderRadius.only(
                                topLeft: Radius.circular(
                                    Configuration.cornerRadius15),
                                topRight: Radius.circular(
                                    Configuration.cornerRadius15))),
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            iconType != null
                                ? Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Image.asset(
                                      iconType!,
                                      width: 60,
                                      height: 60,
                                    ),
                                  )
                                : Padding(padding: EdgeInsets.zero),
                            title != null
                                ? Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      title!,
                                      style: style_S16_W600_BlackColor,
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(top: 0)),
                          ],
                        )),
                  ),
                ],
              ),
              SizedBox(height: 14),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                //Text Message
                child: Column(
                  children: [
                    childBody ?? SizedBox(),
                    Text(
                      description!,
                      textAlign: textAlignDetail != null
                          ? textAlignDetail
                          : TextAlign.center,
                      style: TextStyle(
                          fontSize: Configuration.fontButton,
                          fontWeight: FontWeight.w400),
                    ),
                    (inputTitle != null && inputTitle!.isNotEmpty)
                        ? TextField(
                            textAlign: TextAlign.center,
                            obscureText: true,
                            keyboardAppearance: Brightness.light,
                            onChanged: (value) {
                              if (value.length > 3) {
                                validConfirmButtonState = true;
                              } else {
                                validConfirmButtonState = false;
                              }
                            },
                            style: TextStyle(
                                fontSize: Configuration.fontTitle,
                                fontWeight: FontWeight.w500),
                            controller: textConfirm,
                            decoration: InputDecoration(
                                hintText: inputTitle,
                                hintStyle: TextStyle(
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.w500),
                                border: InputBorder.none))
                        : SizedBox(height: 1)
                  ],
                ),
              ),
              SizedBox(height: 5),
              //Button action
              Padding(
                padding: const EdgeInsets.only(
                    top: 8, left: 20, right: 20, bottom: 8),
                child: Container(
                  height: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Visibility(
                        visible: buttonTextCancel != null ? true : false,
                        child: Expanded(
                            child: SizedBox.expand(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: buttonTextCancel != null
                                ? MaterialButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            Configuration.cornerRadius5)),
                                    color: Configuration.hintMainColor,
                                    onPressed: onClickCancel == null
                                        ? () {
                                            Navigator.of(context).pop();
                                          }
                                        : () {
                                      (dismissPopUp != null && dismissPopUp == false) ? null : Navigator.of(context).pop();

                                      if (onClickCancel != null) {
                                              onClickCancel!();
                                            }
                                          },
                                    child: Text(
                                      buttonTextCancel!,
                                      textAlign: TextAlign.center,
                                      style: style_S16_W400_WhiteColor,
                                    ),
                                  )
                                : null,
                          ),
                        )),
                      ),
                      Expanded(
                          child: SizedBox.expand(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: MaterialButton(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Configuration.cornerRadius5)),
                            color: _colorTitleBg,
                            //Color.fromRGBO(237, 237, 237, 1)
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (onClickMain != null) {
                                onClickMain!(textConfirm.text);
                              }
                            },
                            child: Text(
                              buttonMainText ?? '',
                              style: style_S16_W400_WhiteColor),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
