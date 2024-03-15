import 'package:flutter/material.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../../util/configuration.dart';

class CommonButton extends MaterialButton {
  final String? title;
  final double? maxWidth;
  final double? minWidth;
  final double? height;
  final double? textSize;
  final double? elevation;
  final double? borderCircular;
  final String? fontFamily;
  final TextDecoration? textDecoration;

  const CommonButton({
    required VoidCallback? onPressed,
    Color? textColor,
    Color? color,
    this.title,
    this.maxWidth,
    this.minWidth,
    this.height,
    this.textSize,
    this.elevation,
    this.fontFamily,
    this.borderCircular,
    Widget? child,
    ShapeBorder? shape,
    EdgeInsetsGeometry? padding,
    this.textDecoration,
  }) : super(
          onPressed: onPressed,
          textColor: textColor,
          color: color,
          child: child,
          shape: shape,
          padding: padding,
        );

  @override
  Widget build(BuildContext context) {
    final ButtonThemeData buttonTheme = ButtonTheme.of(context);
    return RawMaterialButton(
      onPressed: () async{
          // delay for show effect press to button
          await Future.delayed(Duration(milliseconds: 100));
          onPressed!();
      },
      fillColor: color ?? Configuration.greenMainColour,
      elevation: elevation ?? 0,
      constraints: color != Colors.transparent
          ? buttonTheme.getConstraints(this).copyWith(
              maxWidth: maxWidth ?? double.infinity,
              minWidth: minWidth ?? double.infinity,
              minHeight: height ?? 50,
              maxHeight: height ?? 50)
          : BoxConstraints.tightFor(),
      // constraints: BoxConstraints(minWidth: 88.0, minHeight: 10.0, maxHeight: 10),
      padding: padding ?? EdgeInsets.only(left: 10, right: 10),
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(borderCircular??6),
          ),
      child: child ??
        Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: textSize ?? 18,
            color: textColor ?? Colors.white,
            fontFamily: fontFamily ?? kFontFamilyBeVietnamPro,
            // fontFamily: fontFamily ?? AppFonts.robotoMedium,
            decoration: textDecoration??TextDecoration.none,
          ),
        )
    );
  }
}
