import 'package:flutter/material.dart';

import '../EntityModel/get_assessment_model.dart';


class EditAssessmentProvider extends ChangeNotifier {
  Datum _assessment=Datum();

  Datum get getAssessment => _assessment;

  void updateAssessment(Datum assessment){
    _assessment=assessment;
    notifyListeners();
  }

}