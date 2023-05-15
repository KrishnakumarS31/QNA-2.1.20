import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../Entity/user_details.dart';

// UserDetails userdata= Provider.of<LanguageChangeProvider>(context, listen: false).userDetails;
// print(userdata.toString());

class LanguageChangeProvider with ChangeNotifier {
  String _currentLocale='en';
  UserDetails _userDetails = UserDetails();

  String get currentLocale => _currentLocale;

  UserDetails get userDetails => _userDetails;

  void changeLocale(String locale) {
    _currentLocale = locale;
    notifyListeners();
  }

  void updateUserDetails(UserDetails userDetails) {
    _userDetails = userDetails.copyWith();
    notifyListeners();
  }

}
