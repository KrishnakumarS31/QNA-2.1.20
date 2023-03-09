import 'package:flutter/material.dart';
import '../Entity/Teacher/get_assessment_model.dart';
import '../Entity/Teacher/question_entity.dart';



class EditAssessmentProvider extends ChangeNotifier {
  GetAssessmentModel _assessment=GetAssessmentModel();

  GetAssessmentModel get getAssessment => _assessment;

  void updateAssessment(GetAssessmentModel assessment){
    _assessment=assessment;
    notifyListeners();
  }

  void addQuestion(Question question){
    _assessment.questions?.add(question);
    notifyListeners();
  }

}