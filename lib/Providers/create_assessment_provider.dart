import 'package:flutter/material.dart';
import 'package:qna_test/Entity/Teacher/assessment_settings_model.dart';
import '../EntityModel/CreateAssessmentModel.dart';

class CreateAssessmentProvider extends ChangeNotifier {
  CreateAssessmentModel _assessment = CreateAssessmentModel(
      questions: [], removeQuestions: [], addQuestion: []);

  CreateAssessmentModel get getAssessment => _assessment;

  void updateAssessment(CreateAssessmentModel assessment) {
    _assessment = assessment;
    notifyListeners();
  }

  void resetAssessment() {
    AssessmentSettings settings=AssessmentSettings();
    _assessment = CreateAssessmentModel(
        questions: [], removeQuestions: [], addQuestion: [],assessmentSettings: settings);
    notifyListeners();
  }

  void addQuestion(int questionId, int mark) {
    Question question = Question(questionId: questionId, questionMarks: mark);
    _assessment.questions?.add(question);
    notifyListeners();
  }

  void removeQuestion(int questionId) {
    List<int> quesIds = [];
    for (int i = 0; i < _assessment.questions!.length; i++) {
      quesIds.add(_assessment.questions![i].questionId!);
    }
    int index = quesIds.indexOf(questionId);
    _assessment.questions!.removeAt(index);
    _assessment.removeQuestions!.add(questionId);
    notifyListeners();
  }

  void addRemoveQuesList(int questionId) {
    _assessment.removeQuestions?.add(questionId);
    notifyListeners();
  }

  void addLooqQuestion(int questionId, int mark) {
    Question question = Question(questionId: questionId, questionMarks: mark);
    _assessment.questions?.add(question);
    notifyListeners();
  }

  void removeLooqQuestion(int questionId) {
    List<int> quesIds = [];
    for (int i = 0; i < _assessment.questions!.length; i++) {
      quesIds.add(_assessment.questions![i].questionId!);
    }
    int index = quesIds.indexOf(questionId);
    _assessment.questions!.removeAt(index);
    _assessment.removeQuestions!.add(questionId);
    notifyListeners();
  }

  void removeLooqQuestionInAssess(int questionId) {
    List<int> quesIds = [];
    List<int> addQuesIds = [];
    for (int i = 0; i < _assessment.questions!.length; i++) {
      quesIds.add(_assessment.questions![i].questionId!);
    }
    for (int i = 0; i < _assessment.addQuestion!.length; i++) {
      addQuesIds.add(_assessment.addQuestion![i].questionId!);
    }

    if (addQuesIds.contains(questionId)) {
      int index = addQuesIds.indexOf(questionId);
      _assessment.addQuestion!.removeAt(index);
    } else {
      int index = quesIds.indexOf(questionId);
      _assessment.questions!.removeAt(index);
      _assessment.removeQuestions!.add(questionId);
    }
    notifyListeners();
  }

  void updatemark(int mark, int quesIndex) {
    _assessment.questions![quesIndex].questionMarks = mark;
    notifyListeners();
  }
  void updateAddQuestionmark(int mark, int quesIndex) {
    _assessment.addQuestion![quesIndex].questionMark = mark;
    notifyListeners();
  }

  void removeQuestionInAddQuestion(int questionId) {
    List<int> quesIds = [];
    for (int i = 0; i < _assessment.addQuestion!.length; i++) {
      quesIds.add(_assessment.addQuestion![i].questionId!);
    }
    int index = quesIds.indexOf(questionId);
    _assessment.addQuestion!.removeAt(index);
    notifyListeners();
  }
}
