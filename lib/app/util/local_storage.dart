import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/vocabulary.dart';

class LocalStorage {
  static const KEY_LANGUAGE_APP = 'KEY_LANGUAGE_APP';
  static const vocabulary_mode = 'vocabulary_mode';
  static const totalWordLearnToday = 'totalWordLearnToday';
  static const totalWordLearn = 'totalWordLearn';
  static const wordLearned = 'wordLearned';

  static const storage = FlutterSecureStorage();

  Future<String> getWordLearned() async {
    String dataWordLearned = await LocalStorage().getData(LocalStorage.wordLearned, '').timeout(Duration(seconds: 2));
    return dataWordLearned;
  }

  setWordLearned(DetailWord newWord) async {
    int totalWordLearn = await LocalStorage().getData(LocalStorage.totalWordLearn, 0).timeout(Duration(seconds: 10));
    String dataWordLearned = await LocalStorage().getData(LocalStorage.wordLearned, '').timeout(Duration(seconds: 2));
    if (dataWordLearned.isNotEmpty) {
      Map<String, dynamic> jsonData = jsonDecode(dataWordLearned);
      Topic data = Topic.fromJson(jsonData);
      bool isExits = false;
      for (var word in data.data) {
        if (word.word == newWord.word) {
          isExits = true;
          break;
        }
      }
      if (!isExits) {
        totalWordLearn = totalWordLearn + 1;
        data.data.add(newWord);
        Map<String, dynamic> importData = data.toJson();
        await LocalStorage().saveData(LocalStorage.totalWordLearn, totalWordLearn); // + 1 world learn
        saveData(wordLearned, jsonEncode(importData));
      }
    }else {
      totalWordLearn = totalWordLearn + 1;
      List<DetailWord> list = List<DetailWord>.empty(growable: true);
      list.add(newWord);
      Topic data = Topic(topicName: 'wordLearn', data: list);
      Map<String, dynamic> importData = data.toJson();
      await LocalStorage().saveData(LocalStorage.totalWordLearn, totalWordLearn); // + 1 world learn
      saveData(wordLearned, jsonEncode(importData));
    }
  }

  Future<int> getTargetWordInDay() async {
    //get mode
    int yourTarget = 0;
    int indexMode = await LocalStorage().getData(LocalStorage.vocabulary_mode, 0).timeout(Duration(seconds: 2));
    print('idex mode= ${indexMode}');
    if (indexMode == 0) {
      yourTarget = 5;
    }else if (indexMode == 1) {
      yourTarget = 10;
    } else {
      yourTarget = 15;
    }

    return yourTarget;
  }

  Future clear(String key) async {
    await storage.delete(key: key);
  }

  Future clearAll() async {
    await storage.deleteAll();
  }

  void convertField(SharedPreferences prefs, String key) {
    String? result = prefs.getString(key);
    if(result!=null) {
      saveData(key, result);
    }
  }

  setLanguageApp(String? value){
    saveData(KEY_LANGUAGE_APP, value);
  }

  Future<String> getLanguageApp() async {
    return await getData(KEY_LANGUAGE_APP, '');
  }

  Future<void> saveData(String key, dynamic value) async {
    await storage.write(key: key, value: value.toString());
    print('Data saved successfully.');
  }

  dynamic getData(String key, [dynamic defaultData]) async {
    if (await storage.containsKey(key: key)) {
      String? value = await storage.read(key: key);
      if (defaultData == null) {
        return value;
      } else {
        try {
          if (defaultData is bool) {
            if (value!.toLowerCase() == 'true') {
              return true;
            } else if (value.toLowerCase() == 'false') {
              return false;
            } else {
              return defaultData;
            }
          }
          else if (defaultData is int) {
            return int.parse(value!);
          } else if (defaultData is double) {
            return double.parse(value!);
          } else {
            return value;
          }
        } catch (e) {
          print(e);
          return defaultData;
        }
      }
    }
    return defaultData;
  }

  Future<void> saveDataToLast(String key, dynamic value) async {
    String? currentData;
    if (await storage.containsKey(key: key)) {
      currentData = await storage.read(key: key);
    }
    storage.write(key: key, value: '${currentData != null ? ('$currentData\n') : ''}${value.toString()}');
  }
}

