import 'dart:io';

import 'package:referral_app/core/constants/storage_constant.dart';
import 'package:referral_app/core/di/di.dart';

import 'package:shared_preferences/shared_preferences.dart';

Map<String, String> getHeader({
  bool requiresAuthorization = true,
  bool contentTypeIsMultiPart = false,
  bool setContentType = true,
}) {
  String? token = di<SharedPreferences>().getString(
    StorageConstant.kSessionToken,
  );
  return {
    if (setContentType)
      "Content-Type": contentTypeIsMultiPart
          ? "multipart/form-data"
          : "application/json",
    "User-Agent": Platform.isAndroid
        ? 'Mozilla/5.0 (Linux; Android 14; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/141.0.0.0 Mobile Safari/537.36'
        : 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1',
    "Accept-Language": "en",
    if (token != null && requiresAuthorization)
      "Authorization": "Bearer $token",
  };
}
