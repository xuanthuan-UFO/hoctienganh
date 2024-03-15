import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tuhoctienganhcungthuan/app/model/vocabulary.dart';
import 'package:tuhoctienganhcungthuan/app/util/local_storage.dart';

import '../route/app_pages.dart';
import '../util/configuration.dart';
import '../util/ufo_logger.dart';
import 'app_controller.dart';

class TopicVocabularyController extends GetxController {
  late BuildContext context;
  final MyAppController _appController = Get.find<MyAppController>();

  Rx<Vocabulary> listGroupData = Vocabulary().obs;

  TrxTypeVocabulary typeVocabulary = TrxTypeVocabulary.LEAN_NEW;

  Future<bool> onPressKeyBack() {
    Get.back();
    return Future.value(false);
  }

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      typeVocabulary = Get.arguments['type'];
      UfoLogger().writeLog('typeVocabulary = $typeVocabulary');
    }
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    _appController.showLoading();
    String data_vocabulary = await loadFileVocabulary();
    Map<String, dynamic> jsonData = jsonDecode(data_vocabulary);
    listGroupData.value = Vocabulary.fromJson(jsonData);
    _appController.hideLoading();
  }

  Future<String> loadFileVocabulary() async {
    return await rootBundle.loadString('assets/data_voucabulary.txt');
  }

  void onPressSelectTopic(Topic topic) async {
    UfoLogger().writeLog('name: ${topic.topicName}');
    TrxTypePractice typePractice =  TrxTypePractice.CARD_VOCABULARY;
    if (typeVocabulary == TrxTypeVocabulary.LEAN_NEW) {
      typePractice = TrxTypePractice.CARD_VOCABULARY_AND_PRACTICE;
      int targetWordInDay = await LocalStorage().getTargetWordInDay();
      print('targetWordInDay= $targetWordInDay');
      String word_learn = await LocalStorage().getWordLearned();
      List<DetailWord> newDetailWords = [];
      if (word_learn.isNotEmpty) {
        Map<String, dynamic> jsonData = jsonDecode(word_learn);
        Topic topicLearn = Topic.fromJson(jsonData);

        for (var wordData in topic.data) {
          bool exists = topicLearn.data.any((data) => data.word == wordData.word);
          UfoLogger().writeLog('exists= $exists');
          if (!exists) {
            newDetailWords.add(wordData);
          }
          if (newDetailWords.length >= targetWordInDay) {
            break;
          }
        }
      }else {
        newDetailWords = takeWord(topic.data, targetWordInDay);
      }
      Topic topicNew = Topic(topicName: topic.topicName, data: newDetailWords);
      Map param = {'title': topic.topicName,"followType": TrxType.LEARN_VOCABULARY, "typePractice": typePractice, 'dataTopicVocabulary': topicNew};
      Get.toNamed(AppRoute.practice_screen, arguments: param);
      return;
    }

    Map param = {'title': topic.topicName,"followType": TrxType.LEARN_VOCABULARY, "typePractice": typePractice, 'dataTopicVocabulary': topic};
    Get.toNamed(AppRoute.practice_screen, arguments: param);
  }

  List<T> takeWord<T>(List<T> list, int num) {
    if (list.length <= num) {
      return list;
    } else {
      return list.sublist(0, num);
    }
  }

}
