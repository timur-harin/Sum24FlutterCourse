import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'ShowerCycle.dart';

class LocalStorage {
  final String numberOfShowersKey = 'numberOfShowers';
  Future<void>saveShower(ShowerCycle showerCycle) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(showerCycle.toJson());
    int numberOfContrastShowers = prefs.getInt(numberOfShowersKey) ?? 0;
    numberOfContrastShowers++;
    await prefs.setString(numberOfContrastShowers.toString(), jsonString);
    await prefs.setInt(numberOfShowersKey, numberOfContrastShowers);
    print("Added a shower with ID $numberOfContrastShowers\nCurrent amount of showers is: ${prefs.getInt('numberOfShowers')}");
  }

  // Future<ShowerCycle?>getShower(int key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (key > numberOfContrastShowers) {
  //     return null;
  //   }
  //   String? jsonString = prefs.getString(key.toString());
  //   if (jsonString != null) {
  //     Map<String, dynamic> jsonMap = jsonDecode(jsonString);
  //     return ShowerCycle.fromJson(jsonMap);
  //   }
  //   return null;
  // }
  //
  // Future<void> deleteShower(int key) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (key > numberOfContrastShowers) {
  //     return;
  //   }
  //   await prefs.remove(key.toString());
  //
  //   for (int i = key + 1; i < numberOfContrastShowers; i++) {
  //     String? jsonString = prefs.getString(i.toString());
  //     if (jsonString != null) {
  //       await prefs.setString((i - 1).toString(), jsonString);
  //       await prefs.remove(i.toString());
  //     }
  //   }
  //
  //   numberOfContrastShowers--;
  //   await prefs.setInt('numberOfShower', numberOfContrastShowers);
  // }

  Future<void> loadNumberOfShowers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int numberOfContrastShowers = prefs.getInt('numberOfShowers') ?? 0;
  }

  Future<List<ShowerCycle>> getAllShowers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<ShowerCycle> showers = [];
    int numberOfContrastShowers = prefs.getInt(numberOfShowersKey) ?? 0;
    for (int i = 1; i <= numberOfContrastShowers; i++) {
      String? jsonString = prefs.getString(i.toString());
      if (jsonString != null) {
        Map<String, dynamic> jsonMap = jsonDecode(jsonString);
        showers.add(ShowerCycle.fromJson(jsonMap));
        print("Added shower $i\n$jsonMap");
      }
    }
    return showers;
  }
}