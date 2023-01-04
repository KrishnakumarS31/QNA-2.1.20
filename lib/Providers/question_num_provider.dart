import 'package:flutter/material.dart';
 class QuestionNumProvider extends ChangeNotifier{
   int _questionNum =1;

   int get questionNum => _questionNum;

   void increment(){
    _questionNum++;
    notifyListeners();
   }

   void decrement(){
    _questionNum--;
    notifyListeners();
   }

   void reset(){
    _questionNum=1;
    notifyListeners();
   }
 }

 class Questions extends ChangeNotifier{

   final Map _quesAns = Map();

   Map get totalQuestion => _quesAns;

   void createQuesAns(int totalQuestion){
     for(int i =1;i<=totalQuestion;i++){
       _quesAns['$i']=[[],Color.fromRGBO(179, 179, 179, 1),false];
     }
     notifyListeners();
   }

   void selectOption(int quesNum,List<dynamic> option,Color colorFlag,bool notSure){
     _quesAns['${quesNum}'] = [option,colorFlag,notSure];
     print(_quesAns['${quesNum}']);
     notifyListeners();
   }

 }