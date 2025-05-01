import 'dart:io' show Platform;

import 'package:leancode_app_rating/src/data/contracts/contracts.dart';

String get systemVersion => Platform.operatingSystemVersion;

PlatformDTO get operatingSystem =>
    Platform.isAndroid ? PlatformDTO.android : PlatformDTO.ios;

String get getStoreName {
  if (Platform.isAndroid) {
    return 'Google Play';
  }
  if (Platform.isIOS || Platform.isMacOS) {
    return 'App Store';
  }
  if (Platform.isMacOS) {
    return 'Microsoft Store';
  }
  return '';
}
