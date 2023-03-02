import 'package:flutter/material.dart';

import '../EntityModel/CreateAssessmentModel.dart';


class CreateAssessmentProvider extends ChangeNotifier {
  CreateAssessmentModel _assessment =CreateAssessmentModel(questions: []);

  CreateAssessmentModel get getAssessment => _assessment;

  void updateAssessment(CreateAssessmentModel assessment){
    _assessment=assessment;
    notifyListeners();
  }

}

