import 'package:flutter/material.dart';

import '../EntityModel/CreateAssessmentModel.dart';


class CreateAssessmentProvider extends ChangeNotifier {
  CreateAssessmentModel _assessment =CreateAssessmentModel(questions: [],removeQuestions: []);

  CreateAssessmentModel get getAssessment => _assessment;

  void updateAssessment(CreateAssessmentModel assessment){
    _assessment=assessment;
    notifyListeners();
  }

  void addQuestion(int questionId,int mark){
    Question question=Question(questionId: questionId,questionMarks: mark);
    _assessment.questions?.add(question);
    print(_assessment.toString());
    notifyListeners();
  }

  void removeQuestion(int questionId){
    List<int> quesIds=[];
    for(int i=0;i < _assessment.questions!.length;i++){
      quesIds.add(_assessment.questions![i].questionId!);
    }
    int index =quesIds.indexOf(questionId);
    _assessment.questions!.removeAt(index);
    _assessment.removeQuestions!.add(questionId);
    print(_assessment.toString());
    notifyListeners();
  }

  void addRemoveQuesList(int questionId){
    // List<int> quesInt = [];
    // quesInt
    _assessment.removeQuestions?.add(questionId);
    print(_assessment.toString());
    notifyListeners();
  }

}

