// Stub implementation for non-web platforms
class TelegramSDK {
  static bool get isTelegramWebApp => false;

  static void initializeWebApp() {}

  static void setupMainButton(String text, Function callback) {}

  static void hideMainButton() {}

  static dynamic getUserInfo() => null;

  static void close() {}

  static void showAlert(String message) {}

  static bool isDarkTheme() => false;
}

