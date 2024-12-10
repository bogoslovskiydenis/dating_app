import 'dart:js' as js;
@JS()

import 'package:js/js.dart';

class TelegramSDK {
  static void initializeWebApp() {
    // Реализация для веб
    js.context.callMethod('Telegram.WebApp.ready');
  }

  static void setupMainButton(String text, Function callback) {
    final mainButton = js.context['Telegram']['WebApp']['MainButton'];
    mainButton.callMethod('setText', [text]);
    mainButton.callMethod('onClick', [js.allowInterop(callback)]);
    mainButton.callMethod('show');
  }

  static void hideMainButton() {
    js.context['Telegram']['WebApp']['MainButton'].callMethod('hide');
  }

  static dynamic getUserInfo() {
    return js.context['Telegram']['WebApp']['initDataUnsafe']['user'];
  }
}