import 'package:get/get.dart';
import 'en_strings.dart';
import 'vi_strings.dart';

class AppStrings extends Translations {
  static final String localeCodeVi = 'vi_VN';
  static final String localeCodeEn = 'en_US';

  static final String language_code_vi = 'vi';

  @override
  Map<String, Map<String, String>> get keys => {
        localeCodeVi: viStrings,
        localeCodeEn: enStrings,
      };

  static String getString(String key) {
    String result = '';
    Map<String, String> selectedLanguage =
        Get.locale.toString() == localeCodeEn ? enStrings : viStrings;
    if (selectedLanguage != null &&
        selectedLanguage.containsKey(key) &&
        selectedLanguage[key] != null) {
      result = selectedLanguage[key] ?? '';
    }

    return result;
  }

  static String titleNotice = 'titleNotice';
  static String splashSlogan = 'splashSlogan';
  static String titleGrammar = 'titleGrammar';
  static String titleVocabulary = 'titleVocabulary';
  static String titlePractice = 'titlePractice';
  static String title_topic_vocabulary = 'title_topic_vocabulary';

  static String tv_finish_practice = 'tv_finish_practice';
  static String tv_submit_practice = 'tv_submit_practice';
  static String titleSuccessPractice = 'titleSuccessPractice';
  static String msgSuccessPractice = 'msgSuccessPractice';
  static String tv_recheck = 'tv_recheck';
  static String back_to_home = 'back_to_home';
  static String title_you_learned_vocabulary = 'title_you_learned_vocabulary';
  static String title_review_word = 'title_review_word';
  static String title_topic = 'title_topic';
  static String title_target_vocabulary = 'title_target_vocabulary';
  static String title_learn_words_everyday = 'title_learn_words_everyday';
  static String mode_normal_vocabulary = 'mode_normal_vocabulary';
  static String mode_hard_vocabulary = 'mode_hard_vocabulary';
  static String mode_challenge_vocabulary = 'mode_challenge_vocabulary';
  static String title_mode_vocabulary = 'title_mode_vocabulary';
}