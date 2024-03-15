import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/binding/daily_engish_challenges_binding.dart';
import 'package:tuhoctienganhcungthuan/app/binding/grammar_binding.dart';
import 'package:tuhoctienganhcungthuan/app/binding/vocabulary_binding.dart';
import 'package:tuhoctienganhcungthuan/app/controller/topic_vocabulary_controller.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/daily_english_challenges_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/gammar/detail_grammar_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/gammar/grammar_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/practice/practice_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/vocabulary/topic_vocabulary_page.dart';
import 'package:tuhoctienganhcungthuan/app/ui/screen/vocabulary/vocabulary_page.dart';

import '../binding/detail_grammar_binding.dart';
import '../binding/main_binding.dart';
import '../binding/practice_binding.dart';
import '../binding/splash_binding.dart';
import '../binding/topic_vocabulary_binding.dart';
import '../ui/screen/main_screen.dart';
import '../ui/screen/splash_screen.dart';

class AppPages {
  // static final args = Get.arguments as Map<String, dynamic>?;
  static final pages = [
    GetPage(
        name: AppRoute.splash_screen,
        page: () => SplashScreen(),
        binding: SplashBinding()),
    GetPage(
        name: AppRoute.main_screen,
        page: () => MainScreen(),
        binding: MainBinding()),
    GetPage(
        name: AppRoute.grammar_screen,
        page: () => GrammarPage(),
        binding: GrammarBinding()),
    GetPage(
        name: AppRoute.detail_grammar_screen,
        page: () => DetailGrammarPage(),
        binding: DetailGrammarBinding()),
    GetPage(
        name: AppRoute.vocabulary_screen,
        page: () => VocabularyPage(),
        binding: VocabularyBinding()),
    GetPage(
        name: AppRoute.practice_screen,
        page: () => PracticePage(),
        binding: PracticeBinding()),
    GetPage(
        name: AppRoute.daily_english_challenges_screen,
        page: () => DailyEnglishChallengesPage(),
        binding: DailyEnglishChallengesBinding()),
    GetPage(
        name: AppRoute.topic_vocabulary_screen,
        page: () => TopicVocabularyPage(),
        transition: Transition.fade,
        binding: TopicVocabularyBinding()),
  ];
}

class AppRoute {
  static const String splash_screen = '/splash_screen';
  static const String main_screen = '/main_screen';
  static const String grammar_screen = '/grammar_screen';
  static const String detail_grammar_screen = '/detail_grammar_screen';
  static const String vocabulary_screen = '/vocabulary_screen';
  static const String practice_screen = '/practice_screen';
  static const String daily_english_challenges_screen = '/daily_english_challenges_screen';
  static const String topic_vocabulary_screen = '/topic_vocabulary_screen';
}
