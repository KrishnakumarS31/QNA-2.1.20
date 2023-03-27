import 'package:flutter/material.dart';

import '../Entity/Teacher/question_entity_for_assessment_settings_published.dart';

class QuestionsForAssessmentSettingsPublishedProvider extends ChangeNotifier {
  final List<QuestionEntityForAssessmentSettingsPublished> _questionList = [];

  List<QuestionEntityForAssessmentSettingsPublished> get getAllQuestion =>
      _questionList;

  void addQuestion(QuestionEntityForAssessmentSettingsPublished question) {
    _questionList.add(question);
    notifyListeners();
  }

  void reSetQuestionList() {
    _questionList.clear();
    notifyListeners();
  }

  void deleteQuestionList(int id) {
    _questionList.removeAt(id);
    print("deleted");
    notifyListeners();
  }

  void updateQuestionList(
      int id, QuestionEntityForAssessmentSettingsPublished demoQuestionModel) {
    _questionList[id] = demoQuestionModel;
    print("updated");
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
