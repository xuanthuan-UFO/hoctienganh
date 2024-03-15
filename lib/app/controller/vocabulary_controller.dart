import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/model/vocabulary.dart';
import 'package:tuhoctienganhcungthuan/app/res/string/app_strings.dart';
import 'package:tuhoctienganhcungthuan/app/route/app_pages.dart';
import 'package:tuhoctienganhcungthuan/app/util/local_storage.dart';
import 'package:tuhoctienganhcungthuan/app/util/styles.dart';

import '../util/configuration.dart';

class VocabularyController extends GetxController {
  late BuildContext context;
  RxInt totalWordLearned = 0.obs;
  RxList<bool> _isChecked = [false, false, false].obs; // Track the checked state of each option
  List<String> options = [];
  RxInt yourTarget = 0.obs;
  RxInt totalWordLearnToday = 0.obs;

  Future<bool> onPressKeyBack() {
    Get.back();
    return Future.value(false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }

  void onResume() async {
    // Thực hiện các hành động khi ứng dụng được resume
    totalWordLearnToday.value = await LocalStorage().getData(LocalStorage.totalWordLearnToday, 0);
    totalWordLearned.value = await LocalStorage().getData(LocalStorage.totalWordLearn, 0);
  }

  @override
  void onInit() async {
    super.onInit();
    //get mode
    int indexMode = await LocalStorage().getData(LocalStorage.vocabulary_mode, 0);
    _isChecked[indexMode] = true;
    yourTarget.value = await LocalStorage().getTargetWordInDay();

    options.add(AppStrings.mode_normal_vocabulary.tr);
    options.add(AppStrings.mode_hard_vocabulary.tr);
    options.add(AppStrings.mode_challenge_vocabulary.tr);
  }

  @override
  void onReady() async {
    super.onReady();
    initData();
  }

  void initData() async {
    totalWordLearnToday.value = await LocalStorage().getData(LocalStorage.totalWordLearnToday, 0);
    totalWordLearned.value = await LocalStorage().getData(LocalStorage.totalWordLearn, 0);
  }

  void onPressTest() async {
    String inputText = await loadAsset();
    Map<String, dynamic> jsonList = jsonDecode(inputText);

    Vocabulary vocabularyData = Vocabulary.fromJson(jsonList);
    print('data ${vocabularyData.topic![0].topicName}');
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/data_voucabulary.txt');
  }

  void onPressReviewVocabulary() {

  }

  void onPressLearnVocabulary() {
    Map param = {
      'type': TrxTypeVocabulary.LEAN_NEW,
    };
    Get.toNamed(AppRoute.topic_vocabulary_screen, arguments: param);
  }

  void onPressTopicVocabulary() {
    Map param = {
      'type': TrxTypeVocabulary.LEARN_TOPIC,
    };
    Get.toNamed(AppRoute.topic_vocabulary_screen, arguments: param);
  }

  onPressSettingVocabulary() {
    showModalBottomSheet(
        context: context, builder: (context) {
      return Obx(
        ()=> Container(
          height: 300,
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                  child: Text(AppStrings.getString(AppStrings.title_mode_vocabulary), style: style_S14_W600_BlackColor,)),
              Divider(
                  color: Colors.black
              ),
              for (int i = 0; i < options.length; i++)
                CheckboxListTile(
                  title: Text(options[i]),
                  value: _isChecked[i],
                  onChanged: (value) {
                    onPressSelectModeVocabulary(i, value!);
                  },
                ),
            ],
          ),
        ),
      );
    });
  }

  void onPressSelectModeVocabulary(int index, bool value) async {
    for (int j = 0; j < _isChecked.length; j++) {
      if (j != index) {
        _isChecked[j] = false;
      }
    }
    // Check the selected checkbox
    if (_isChecked[index] == false) {
      _isChecked[index] = value;
      print('index = $index');
      // await LocalStorage().saveData(LocalStorage.vocabulary_mode, index);
      // int data = await LocalStorage().getData(LocalStorage.vocabulary_mode, -1);
      // print('Data= $data');

      await LocalStorage().saveData(LocalStorage.vocabulary_mode, index);
      yourTarget.value = await LocalStorage().getTargetWordInDay();
      print('yourTarget= ${yourTarget.value}');

    //   LocalStorage().saveData(LocalStorage.vocabulary_mode, index).then((value) => () async {
    //     yourTarget.value = await LocalStorage().getTargetWordInDay();
    //   print('yourTarget then= ${yourTarget.value}'); });
    }
  }
}
