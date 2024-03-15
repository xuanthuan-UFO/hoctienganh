import 'package:flutter/material.dart';

import '../../util/configuration.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({Key? key, this.titleChird, this.leftWidget, this.rightChildren, this.backgroundColor})
      : super(key: key);
  Color? backgroundColor;
  Widget? titleChird;
  Widget? leftWidget;
  Widget? flexibleSpace;
  List<Widget>? rightChildren;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Configuration.whiteColor,
      elevation: 0,
      leading: leftWidget,
      title: titleChird,
      centerTitle: true,
      flexibleSpace:backgroundColor != null ? SizedBox() : Container(
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
      actions: rightChildren ?? [SizedBox()],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
