import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tuhoctienganhcungthuan/app/route/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'app/binding/app_binding.dart';
import 'app/res/string/app_strings.dart';
import 'app/ui/screen/root_screen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // Future.delayed(const Duration(milliseconds: 100));
  runApp(GetMaterialApp(
    initialBinding: AppBinding(),
    initialRoute: AppRoute.main_screen,
    getPages: AppPages.pages,
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    translations: AppStrings(),
    supportedLocales: [const Locale('vi', 'VN'), const Locale('en', 'US')],
    locale: const Locale('vi', 'VN'),
    fallbackLocale: const Locale('vi', 'VN'),
    builder: (context, child) {
      return RootScreen(child);
    },
  ));
}
