import 'package:flutter/material.dart';

import '../Entity/Teacher/question_entity.dart';

class NewQuestionProvider extends ChangeNotifier {
  final List<Question> _questionList = [];

  List<Question> get getAllQuestion => _questionList;

  void addQuestion(Question question) {
    question.questionMark=0;
    _questionList.add(question);
    notifyListeners();
  }

  void reSetQuestionList() {
    _questionList.clear();
    notifyListeners();
  }

  void deleteQuestionList(int id) {
    _questionList.removeAt(id);
    notifyListeners();
  }

  void updateQuestionList(int id, Question demoQuestionModel) {
    _questionList[id] = demoQuestionModel;
    notifyListeners();
  }
}
