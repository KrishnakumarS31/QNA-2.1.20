import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LanguageChangeProvider with ChangeNotifier {
  String _currentLocale='en';

  String get currentLocale => _currentLocale;

  void changeLocale(String locale) {
    _currentLocale = locale;
    notifyListeners();
  }
}
