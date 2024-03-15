import 'dart:convert';
import 'dart:math';

import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/controller/vocabulary_controller.dart';
import 'package:tuhoctienganhcungthuan/app/model/english_exercise.dart';
import 'package:tuhoctienganhcungthuan/app/res/string/app_strings.dart';
import 'package:tuhoctienganhcungthuan/app/route/app_pages.dart';
import 'package:tuhoctienganhcungthuan/app/ui/widget/dialogCustom.dart';
import 'package:tuhoctienganhcungthuan/app/util/local_storage.dart';
import 'package:tuhoctienganhcungthuan/app/util/ufo_logger.dart';
import '../model/vocabulary.dart';
import '../util/configuration.dart';
import 'app_controller.dart';

class PracticeController extends GetxController {
  final MyAppController _appController = Get.find<MyAppController>();
  late BuildContext context;

  Rx<TrxType> followType = TrxType.NONE.obs;
  Rx<Topic> dataTopic = Topic(topicName: '', data: []).obs;
  Rx<TrxTypePractice> typePractice = TrxTypePractice.CARD_GAMMAR.obs;
  RxString idPractice = ''.obs;
  RxString title = ''.obs;
  RxInt state_vocabuary = 0.obs;   // =0 is Card word, =1 is card practice word

  String data = '';
  RxList<EnglishExercise?> dataExercise = RxList();
  RxInt totalYourAnswer = 0.obs;
  RxInt totalYourAnswerCorrect = 0.obs;
  RxBool isShowResult = false.obs;  // show total answer correct - hide total answer
  RxBool hadChecked = false.obs;  // had clicked check result>

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      title.value = Get.arguments['title'] ?? '';
      followType.value = Get.arguments['followType'] ?? TrxType.NONE;
      if (followType.value == TrxType.LEARN_GRAMMAR) {
        idPractice.value = Get.arguments['idPractice'] ?? '';

        //todo sau khi sử dụng idPractice để fetch data, có data
        // data = '{ "data": [ { "exerciseTitle": "Past Tense Practice", "exerciseDescription": "Complete the sentences using the correct past tense form of the verbs.", "answerHints": [ "Use past tense for verbs.", "Check subject-verb agreement.", "Consider prepositions and conjunctions." ], "formulaLink": "1_simple_tenses.html", "options": [ "Option A", "Option B", "Option C", "Option D" ], "correctAnswerIndex": 2 }, { "exerciseTitle": "Past Tense Practice", "exerciseDescription": "this is good application, right?.", "answerHints": [ "Use past tense for verbs.", "Check subject-verb agreement.", "Consider prepositions and conjunctions." ], "formulaLink": "https://example.com/past-tense-formula", "options": [ "Yes", "No"], "correctAnswerIndex": 0 } ] }';
        data = '{ "data": [ { "exerciseTitle": "Past Tense Practice", "exerciseDescription": "Complete the sentences using the correct past tense form of the verbs.", "answerHints": [ "Use past tense for verbs.", "Check subject-verb agreement.", "Consider prepositions and conjunctions." ], "formulaLink": "1_simple_tenses.html", "options": [ "Option A", "Option B", "Option C", "Option D" ], "correctAnswer": "Option C" }, { "exerciseTitle": "Past Tense Practice", "exerciseDescription": "this is good application, right?.", "answerHints": [ "Use past tense for verbs.", "Check subject-verb agreement.", "Consider prepositions and conjunctions." ], "formulaLink": "https://example.com/past-tense-formula", "options": [ "Yes", "No" ], "correctAnswer": "Yes" } ] }';
        AllEnglishExercise allEnglishExercise = AllEnglishExercise.fromJson(jsonDecode(data));
        dataExercise.value.addAll(allEnglishExercise.data as Iterable<EnglishExercise>);

      } else if (followType.value == TrxType.LEARN_VOCABULARY) {
        typePractice.value = Get.arguments['typePractice'];
        dataTopic.value = Get.arguments['dataTopicVocabulary'];
        state_vocabuary.value = 0;
        if (typePractice.value == TrxTypePractice.CARD_VOCABULARY_AND_PRACTICE) {
          initDataVocabularyPractice();
        }
      }
    }
    totalYourAnswer.value = 0;

    UfoLogger().writeLog('followType: ${followType.value}');
    UfoLogger().writeLog('typePractice: ${typePractice.value}');
    UfoLogger().writeLog('idPractice: ${idPractice.value}');
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() async {
    super.onClose();
  }

  Future<bool> onPressKeyBack() {
    Get.back();
    return Future.value(false);
  }

  onPressfinishPractice() {
    UfoLogger().writeLog('onPressfinishPractice');

  }

  onPressChoseAnswer(int index, String answer) {
    if (hadChecked.value && dataExercise.value[index]?.isCorrect == true) {
      return;
    }
    UfoLogger().writeLog('answer: $answer -- index: $index');
    if (dataExercise.value[index]?.answerYourChoose == 'null') {
      totalYourAnswer.value++;
    }
    dataExercise[index]?.answerYourChoose = answer;
    if (dataExercise.value[index]?.isCorrect == false) { //case đặc biệt - đã click kiểm tra|not correct|indexYourChoose đã được update = index -> text có màu đỏ
      dataExercise[index]?.isChangeStateAnswer = true;
    }
  }

  void onPressSubmitPractice() async {
    UfoLogger().writeLog('onPressSubmitPractice');
    //check all had chose
    if (totalYourAnswer == dataExercise.length) {
      hadChecked.value = true;
      isShowResult.value = true;
      totalYourAnswerCorrect.value = 0;
      UfoLogger().writeLog('all answer had chose');
      //ufo check isAnswerCorrect
      for (int i = 0; i < dataExercise.value.length; i++) {
        if (dataExercise[i]?.answerYourChoose != dataExercise.value[i]?.correctAnswer) {
          dataExercise.value[i]?.isCorrect = false;
          dataExercise[i]?.isChangeStateAnswer = false;
        }else {
          dataExercise.value[i]?.isCorrect = true;
          totalYourAnswerCorrect.value ++;
        }
      }
      dataExercise.refresh();

      //Xử lý thành công: Lưu lại các từ đã học
      if (totalYourAnswerCorrect == dataExercise.length) {
        for (var index in dataTopic.value.data) {
          await LocalStorage().setWordLearned(index);
        }
        await LocalStorage().saveData(LocalStorage.totalWordLearnToday, dataExercise.length);

        DialogCustom.showDialogWithType(context,
            type: DialogCustom.TYPE_SUCCESS,
            title: AppStrings.titleSuccessPractice.tr,
            message: AppStrings.msgSuccessPractice.tr,
            titleButtonCancel: AppStrings.tv_recheck.tr,
            titleButtonMain: AppStrings.back_to_home.tr, actionMainButton: (_) {
          Get.find<VocabularyController>().initData();
          Get.offAndToNamed(AppRoute.main_screen);
        });
      }
    }
  }

  void initDataVocabularyPractice() {
    AllEnglishExercise allEnglishExercise = AllEnglishExercise(data: []);
    for (int i =0; i < dataTopic.value.data.length; i++) {
      EnglishExercise englishExercise = EnglishExercise();
      englishExercise.exerciseDescription = dataTopic.value.data[i].word;
      englishExercise.correctAnswer = dataTopic.value.data[i].definition;

      List<String> allPronunciations = [];
      for (var detailWord in dataTopic.value.data) {
        if (detailWord.definition != null && (detailWord.definition != dataTopic.value.data[i].definition)) {
          allPronunciations.add(detailWord.definition!);
        }
      }
      Set<String> uniquePronunciations = allPronunciations.toSet();
      List<String> optionsAnswer = [];
      if (uniquePronunciations.length >= 3) {
        optionsAnswer = uniquePronunciations.toList()..shuffle();
        optionsAnswer = optionsAnswer.sublist(0, 3);
      } else {
        optionsAnswer = uniquePronunciations.toList();
      }
      optionsAnswer.add(dataTopic.value.data[i].definition ?? ''); //đáp án đúng
      englishExercise.options = optionsAnswer..shuffle();
      allEnglishExercise.data!.add(englishExercise);
    }

    dataTopic.value.data.forEach((element) {

    });

    dataExercise.addAll(allEnglishExercise.data as Iterable<EnglishExercise>);
  }

  String getOptionsByDataVocabulary(int index) {


    return '';
  }


  void onChangeModePracticeWord() {
    UfoLogger().writeLog('onChangeModePracticeWord');

    state_vocabuary.value = 1;


  }
}
