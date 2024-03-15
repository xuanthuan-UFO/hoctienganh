import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../res/string/app_strings.dart';

convertPhoneToOrigin(String phone) {
  String phoneNumber = phone.trim();
  if (phoneNumber.length != 0) {
    phoneNumber = phoneNumber.replaceFirst('(+84)', '0');
    phoneNumber = phoneNumber.replaceFirst('+84', '0');
    // phoneNumber = phoneNumber.replace('0084', '0');
    phoneNumber = phoneNumber.replaceAll(' ', '');
    // phoneNumber = phoneNumber.replace(/[^0-9]/g, '');
  }
  return phoneNumber;
}

bool isNullEmpty(Object? o) => o == null || "" == o;

bool isNullEmptyOrFalse(Object? o) => o == null || false == o || "" == o;

bool isNullEmptyFalseOrZero(Object? o) => o == null || false == o || 0 == o || "" == o || "0" == o;

bool isNumeric(dynamic s) {
  String sConvert = s.toString();
  if (sConvert == null) {
    return false;
  }
  return (double.tryParse(sConvert) != null || int.tryParse(sConvert) != null);
}

int convertStringToInt(String? data) {
  if ((data != null) && (data.isNotEmpty) && isNumeric(data)) {
    return int.parse(data);
  }else {
    return 0;
  }
}

buildFormatBankNumber(String bankNumber) {
  StringBuffer formattedString = StringBuffer();

  int length = bankNumber.length;
  int index = 0;
  while (index < length) {
    if (index + 4 <= length) {
      formattedString.write(bankNumber.substring(index, index + 4));
      index += 4;
      if (index < length) {
        formattedString.write('  ');
      }
    } else {
      formattedString.write(bankNumber.substring(index));
      break;
    }
  }

  return formattedString.toString();
}

bool checkMinMaxAmount(String amount, String minAmount, String maxAmount) {
  if (isNullEmpty(amount) || isNullEmpty(minAmount) || isNullEmpty(maxAmount)) {
    return false;
  }
  amount = convertMoney(amount);
  return int.parse(minAmount) <= int.parse(amount) && int.parse(amount) <= int.parse(maxAmount);
}

String convertMoney(String amountMoney) {
  return amountMoney.replaceAll("[^\\d]", "").trim();
}