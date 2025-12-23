import 'dart:js' as js;

class TelegramSDK {
  static bool get isTelegramWebApp {
    try {
      return js.context.hasProperty('Telegram') &&
          js.context['Telegram'] != null &&
          js.context['Telegram'].hasProperty('WebApp');
    } catch (e) {
      return false;
    }
  }

  static void initializeWebApp() {
    if (!isTelegramWebApp) return;
    try {
      js.context['Telegram']['WebApp'].callMethod('ready');
      js.context['Telegram']['WebApp'].callMethod('expand');
    } catch (e) {
      print('TelegramSDK initialization error: $e');
    }
  }

  static void setupMainButton(String text, Function callback) {
    if (!isTelegramWebApp) return;
    try {
      final mainButton = js.context['Telegram']['WebApp']['MainButton'];
      mainButton.callMethod('setText', [text]);
      mainButton.callMethod('onClick', [callback]);
      mainButton.callMethod('show');
    } catch (e) {
      print('Error setting up main button: $e');
    }
  }

  static void hideMainButton() {
    if (!isTelegramWebApp) return;
    try {
      js.context['Telegram']['WebApp']['MainButton'].callMethod('hide');
    } catch (e) {
      print('Error hiding main button: $e');
    }
  }

  static dynamic getUserInfo() {
    if (!isTelegramWebApp) return null;
    try {
      return js.context['Telegram']['WebApp']['initDataUnsafe']['user'];
    } catch (e) {
      return null;
    }
  }

  static void close() {
    if (!isTelegramWebApp) return;
    try {
      js.context['Telegram']['WebApp'].callMethod('close');
    } catch (e) {
      print('Error closing WebApp: $e');
    }
  }

  static void showAlert(String message) {
    if (!isTelegramWebApp) return;
    try {
      js.context['Telegram']['WebApp'].callMethod('showAlert', [message]);
    } catch (e) {
      print('Error showing alert: $e');
    }
  }

  static bool isDarkTheme() {
    if (!isTelegramWebApp) return false;
    try {
      return js.context['Telegram']['WebApp']['colorScheme'] == 'dark';
    } catch (e) {
      return false;
    }
  }
}