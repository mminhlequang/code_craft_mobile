import 'dart:io';
import 'dart:convert';

import 'package:internal_core/internal_core.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:path_provider/path_provider.dart';

class AppPrefs {
  AppPrefs._();

  static final AppPrefs _instance = AppPrefs._();

  static AppPrefs get instance => _instance;

  late Box _boxData;
  late Box _boxAuth;
  bool _initialized = false;

  Future initialize() async {
    if (_initialized) return;
    if (!kIsWeb) {
      Directory appDocDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocDirectory.path);
    }
    _boxData = await Hive.openBox('data');
    _boxAuth = await Hive.openBox(
      'auth',
      encryptionCipher: HiveAesCipher(base64Url.decode(
        const String.fromEnvironment(
          'SECRET_KEY',
          defaultValue: 'jgGYXtQC6hIAROYyI_bbBZu4jFVHiqUICSf8yN2zp_8=',
        ),
      )),
    );
    _initialized = true;
  }

  Stream watch(key) => _boxData.watch(key: key);

  void clear() {
    _boxData.deleteAll([
      keyRefreshToken,
      keyAccessToken,
      keyThemeMode,
      keyLanguageCode,
      "user_info",
    ]);
  }

  bool get isDarkTheme => themeModel == keyThemeModeDark;

  set themeModel(String? value) => _boxData.put(keyThemeMode, value);

  String? get themeModel => _boxData.get(keyThemeMode);

  set languageCode(String? value) => _boxData.put(keyLanguageCode, value);

  String get languageCode => _boxData.get(keyLanguageCode) ?? 'en';

  bool get isLanguageCodeEmpty => _boxData.get(keyLanguageCode) == null || _boxData.get(keyLanguageCode) == '';

  /// Index of the currently selected color palette.
  /// 0 = default (blue), 1 = green, ... etc. The values are mapped in
  /// [AppColors.availablePalettes].
  int get colorPaletteIndex => (_boxData.get(keyColorPalette) ?? 0) as int;
  set colorPaletteIndex(int value) => _boxData.put(keyColorPalette, value);

  set dateFormat(String value) => _boxData.put('dateFormat', value);

  String get dateFormat => _boxData.get('dateFormat') ?? 'dd/MM/yyyy';

  set timeFormat(String value) => _boxData.put('timeFormat', value);

  String get timeFormat => _boxData.get('timeFormat') ?? 'HH:mm';

  // Future saveAccountToken(AccountToken token) async {
  //   await Future.wait([
  //     _box.put(AppPrefsBase.accessTokenKey, token.accessToken),
  //     _box.put(AppPrefsBase.refreshTokenKey, token.refreshToken)
  //   ]);
  // }

  // dynamic getNormalToken() async {
  //   var result = await _box.get(AppPrefsBase.accessTokenKey);
  //   if (result != null) {
  //     DateTime? expiryDate = Jwt.getExpiryDate(result.toString());
  //     if (expiryDate != null &&
  //         expiryDate.millisecondsSinceEpoch <
  //             DateTime.now().millisecondsSinceEpoch) {
  //       String? refresh = await _box.get(AppPrefsBase.refreshTokenKey);
  //       if (refresh != null) {
  //         NetworkResponse response =
  //             await AccountUsersRepo().refresh_access_token(refresh);
  //         if (response.data?.accessToken != null) {
  //           result = response.data?.accessToken;
  //           saveAccountToken(response.data!);
  //         }
  //       }
  //     }
  //   }
  //   return result;
  // }

  // AccountUser? get user {
  //   final objectString = _box.get('user_info');
  //   if (objectString != null) {
  //     final jsonMap = jsonDecode(objectString);
  //     return AccountUser.fromJson(jsonMap);
  //   }
  //   return null;
  // }

  // set user(userInfo) {
  //   if (userInfo != null) {
  //     final string = json.encode(userInfo.toJson());
  //     _box.put('user_info', string);
  //   } else {
  //     _box.delete('user_info');
  //   }
  // }
}
