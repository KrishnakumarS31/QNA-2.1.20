import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LanguageChangeProvider with ChangeNotifier {
  late Locale _currentLocale;

  Locale get currentLocale => _currentLocale;

  set cLocale(String value) {
    _currentLocale = Locale(value);
    notifyListeners();
  }

  Locale currentLocaleValue(String _locale) {
    this._currentLocale = new Locale(_locale);
    notifyListeners();
    return this._currentLocale;
    //return _currentLocale;
  }

  Locale changeLocale(String _locale) {
    //print(_locale + "this is from change locale");
    this._currentLocale = new Locale(_locale);
    //print(_currentLocale);
    notifyListeners();
    return this._currentLocale;
  }
}
