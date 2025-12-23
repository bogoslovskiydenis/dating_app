import 'package:flutter/foundation.dart';
import 'telegram_sdk_stub.dart'
    if (dart.library.js) 'telegram_sdk_web.dart' as web_impl;

class TelegramSDK {
  static bool get isTelegramWebApp {
    if (!kIsWeb) return false;
    return web_impl.TelegramSDK.isTelegramWebApp;
  }

  static void initializeWebApp() {
    if (!kIsWeb) return;
    web_impl.TelegramSDK.initializeWebApp();
  }

  static void setupMainButton(String text, Function callback) {
    if (!kIsWeb) return;
    web_impl.TelegramSDK.setupMainButton(text, callback);
  }

  static void hideMainButton() {
    if (!kIsWeb) return;
    web_impl.TelegramSDK.hideMainButton();
  }

  static dynamic getUserInfo() {
    if (!kIsWeb) return null;
    return web_impl.TelegramSDK.getUserInfo();
  }

  static void close() {
    if (!kIsWeb) return;
    web_impl.TelegramSDK.close();
  }

  static void showAlert(String message) {
    if (!kIsWeb) return;
    web_impl.TelegramSDK.showAlert(message);
  }

  static bool isDarkTheme() {
    if (!kIsWeb) return false;
    return web_impl.TelegramSDK.isDarkTheme();
  }
}