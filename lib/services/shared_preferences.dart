import 'dart:ui';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  ///get Visting Flag on first launch
  getVisitingFlag() async {
    var preferences = await SharedPreferences.getInstance();
    var alreadyVisited = preferences.getBool('alreadyVisited') ?? false;
    return alreadyVisited;
  }

  syncLocale() async {
    var preferences = await SharedPreferences.getInstance();
    String lang = preferences.getString('language') ?? "uz";
    Get.updateLocale(Locale(lang));
  }


  Future<String> getLocale() async {
    var preferences = await SharedPreferences.getInstance();
    String lang = preferences.getString('language') ?? "uz";
    return lang;
  }



  setLocale(String locale) async {
    if (Get.locale?.countryCode != locale) {
      Get.updateLocale(Locale(locale));
      var preferences = await SharedPreferences.getInstance();
      preferences.setString("language", locale);
    }
  }

  getParentOrChild() async {
    var preferences = await SharedPreferences.getInstance();
    var isParent = preferences.getBool('isParent') ?? true;
    return isParent;
  }

  getDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var displayShowCase = preferences.getBool('displayShowCase') ?? false;
    return displayShowCase;
  }

  setVisitingFlag({value = true}) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('alreadyVisited', value);
  }

  setParentDevice({value = true}) async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', value);
  }

  setChildDevice() async {
    var preferences = await SharedPreferences.getInstance();
    await preferences.setBool('isParent', false);
  }

  Future<bool> setDisplayShowCase() async {
    var preferences = await SharedPreferences.getInstance();
    var status = await preferences.setBool('displayShowCase', true);
    return status;
  }
}
