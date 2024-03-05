import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ulearning_app/common/entities/entities.dart';
import 'package:ulearning_app/common/values/constants.dart';

class StorageService {
  late final SharedPreferences prefs;

  // initialize SharedPreference
  Future<StorageService> init() async {
    prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await prefs.setBool(key, value);
  }

  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  bool getDeviceFirstOpen() {
    return prefs.getBool(AppConstants.STORAGE_DEVICE_OPEN_FIRST_TIME) ?? false;
  }

  bool getIsLoggedIn() {
    return prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) == null ? false : true;
  }

  Future<bool> remove(String key) {
    return prefs.remove(key);
  }

  String getUserToken(){
    return prefs.getString(AppConstants.STORAGE_USER_TOKEN_KEY) ?? "";
  }

  UserItem? getUserProfile() {
    var profileOffline = prefs.getString(AppConstants.STORAGE_USER_PROFILE_KEY) ?? "";
    if (profileOffline.isNotEmpty) {
      return UserItem.fromJson(json.decode(profileOffline));
    }

    return null;
  }
}
