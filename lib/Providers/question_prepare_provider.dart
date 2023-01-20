import 'package:flutter/material.dart';

import '../Entity/demo_question_model.dart';
class QuestionPrepareProvider extends ChangeNotifier {
  final List<DemoQuestionModel> _questionList = [];

  List<DemoQuestionModel> get getAllQuestion => _questionList;

  void addQuestion(DemoQuestionModel question){
    _questionList.add(question);
    notifyListeners();
  }

  void reSetQuestionList(){
    _questionList.clear();
    notifyListeners();
  }

  void deleteQuestionList(int id){
    _questionList.removeAt(id);
    print("deleted");
    notifyListeners();
  }

  void updateQuestionList(int id,DemoQuestionModel demoQuestionModel){
    _questionList[id]=demoQuestionModel;
    print("updated");
    notifyListeners();
  }
}

