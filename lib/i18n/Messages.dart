import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control/i18n/ru_RU.dart';
import 'package:parental_control/i18n/oz_OZ.dart';

class Messages extends Translations {
  static get defaultLang => Locale('uz');

  @override
  Map<String, Map<String, String>> get keys => {
    'uz': oz_OZ.words,
    'ru': ru_RU.words,
  };
}
