import 'package:flutter/material.dart';

enum TrxType {NONE, LEARN_GRAMMAR, LEARN_VOCABULARY, EXERCISES} // parent type.
enum TrxTypePractice {NORMAL, CARD_GAMMAR, CARD_VOCABULARY, CARD_VOCABULARY_AND_PRACTICE}            // practive type.
enum TrxTypeVocabulary {LEAN_NEW, LEARN_TOPIC}


class Configuration {
  static String versionCode = '231218.1412';

  String dataGrammar = '{ "data": [ { "nameFile": "1_simple_tenses.html", "deceptionVi": "Thì hiện tại đơn", "deceptionEn": "Simple Tenses", "idPractice": "id1|simple_tenses" }, { "nameFile": "2_Bay_Thi_Don.html", "deceptionVi": "Mẹo thì đơn", "deceptionEn": "Tips Simple Tenses", "idPractice": "id2|tips_simple_tenses" }, { "nameFile": "3_thi_tiep_dien.html", "deceptionVi": "Thì tiếp diễn", "deceptionEn": "Present Continuous Tenses", "idPractice": "id3|present_continuous" } ] }';
  String dataVocabulary = '[ { "word": "red", "spelling": "red", "pronunciation": "/red/", "type": "Adjective", "definition": "Màu đỏ" }, { "word": "blue", "spelling": "blue", "pronunciation": "/bluː/", "type": "Noun", "definition": "Màu xanh." } ]';


  static const mainBackground = Color.fromRGBO(242, 242, 242, 1);
  static const hintLightMainColor = Color.fromRGBO(233, 233, 233, 1);
  static const hintMainColor = Color.fromRGBO(128, 136, 144, 1);
  static const blackMainColour = Color.fromRGBO(64, 64, 64, 1);
  static const orangerMainColour = Color.fromRGBO(255, 164, 18, 1.0);
  static const orangerLightMainColour = Color.fromRGBO(255, 242, 220, 1.0);
  static const blueMainColour = Color.fromRGBO(53, 152, 219, 1.0);
  static const greenMainColour = Color.fromRGBO(111, 166, 55, 1);
  static const greenLightMainColour = Color.fromRGBO(241, 246, 235, 1);
  static const mainColour = Color.fromRGBO(207, 58, 63, 1.0);
  static const whiteColor = Color.fromRGBO(255, 255, 255, 1.0);
  static const whiteColor1 = Color.fromRGBO(236, 245, 236, 1.0);
  static Color blue2MainColor = Color(0xff008BF4);

  static const gray = Color(0xFF515151);
  static const green = Color(0xFF00913D);
  static const redText2 = Color(0xFFC21A15);
  static const orangeDark = Color(0xFFE99323);
  static const tabUnSelected = Color(0xFFB8BDC0);
  static const blue = Color(0xFF0066B3);
  static const greyTextContent = Color(0xFF868F95);

  static const int rejectOrderCounting = 5;
  static const double paddingMain = 15.0;
  static const space24 = 24.0;
  static const space32 = 32.0;
  static const space18 = 18.0;
  static const space14 = 14.0;
  static const space10 = 10.0;
  static const space8 = 8.0;

  // Icon size
  static const icon60 = 60.0;

  static const double cornerRadius15 = 15.0;
  static const double cornerRadius10 = 10.0;
  static const double cornerRadius5 = 5.0;

  static const double fontTitlePolicy = 12;
  static const double fontNormal = 14;
  static const double fontButton = 16;
  static const double fontLarger = 18;
  static const double fontTitle = 20;

  static const double heightMainTextFeild = 60;
  static const double heightMainButton = 50;
  static const double heightSimpleButton = 40;

  static String Type_Action_Order_Update = 'UPDATE';
  static String Type_Action_Order_Add = 'ADD';
  static String Type_Action_Order_Remove = 'REMOVE';
  static String Type_Action_Order_Refresh = 'REFRESH';

  static const String logger_Storage = 'LOG_STORAGE';
  static const String LOGGER_TYPE_ACTION = 'ACTION';
  static const String LOGGER_TYPE_REQUEST = 'REQUEST';
  static const String LOGGER_TYPE_RESPONSE = 'RESPONSE';
}

class Dimens {
  static const double iconCloseWidth = 15;

  // Space
  static const spaceXSmall4 = 4.0;
  static const spaceXSmall6 = 6.0;
  static const spaceXSmall8 = 8.0;
  static const spaceXSmall10 = 10.0;
  static const spaceXSmall = 12.0;
  static const spaceSmall = 14.0;
  static const spaceMedium = 16.0;
  static const spaceLarge = 18.0;
  static const spaceLarge24 = 24.0;
  static const spaceLarge32 = 32.0;
  static const spaceLarge48 = 48.0;
  static const spaceLarge64 = 64.0;
}
