import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? backgroundColor;

  const LoadingWidget({Key? key, this.backgroundColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      color: backgroundColor ?? AppColors.black.withOpacity(0.6),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
