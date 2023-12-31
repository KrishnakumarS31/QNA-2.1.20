import 'package:flutter/material.dart';

import '../Entity/Teacher/question_entity.dart';

class QuestionPrepareProviderFinal extends ChangeNotifier {
  List<Question> _questionList = [];

  List<Question> get getAllQuestion => _questionList;

  void addQuestion(Question question) {
    _questionList.add(question);
    notifyListeners();
  }

  void reSetQuestionList() {
    //_questionList.clear();
    _questionList=[];
    notifyListeners();
  }

  void deleteQuestionList(int index) {
    _questionList.length == 1 ? reSetQuestionList() : _questionList.removeAt(index);
    notifyListeners();
  }

  void updateQuestionList(int id, Question demoQuestionModel) {
    _questionList[id] = demoQuestionModel;
    notifyListeners();
  }

  //used for creating assessment
  void removeQuestion(int questionId) {
    List<int> quesIds = [];
    for (int i = 0; i < _questionList.length; i++) {
      quesIds.add(_questionList[i].questionId!);
    }
    int index = quesIds.indexOf(questionId);
    _questionList.removeAt(index);
    notifyListeners();
  }

  void updatemark(int mark, int quesIndex) {
    _questionList[quesIndex].questionMark = mark;
    notifyListeners();
  }
}
