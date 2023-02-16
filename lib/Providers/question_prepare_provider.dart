import 'package:flutter/material.dart';

import '../EntityModel/GetQuestionBankModel.dart';
class QuestionPrepareProvider extends ChangeNotifier {
  final List<Question> _questionList = [];

  List<Question> get getAllQuestion => _questionList;

  void addQuestion(Question question){
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

  void updateQuestionList(int id,Question demoQuestionModel){
    _questionList[id]=demoQuestionModel;
    print("updated");
    notifyListeners();
  }
}

