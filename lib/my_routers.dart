

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart' as QuestionEntity;
import 'package:qna_test/EntityModel/CreateAssessmentModel.dart';
import 'package:qna_test/EntityModel/user_data_model.dart';
import 'package:qna_test/Pages/welcome_page.dart';
import 'package:qna_test/pages/about_us.dart';
import 'package:qna_test/pages/change_email_student.dart';
import 'package:qna_test/pages/cookie_policy.dart';
import 'package:qna_test/pages/help_page.dart';
import 'package:qna_test/pages/reset_password_teacher.dart';
import 'package:qna_test/pages/student_assessment_questions.dart';
import 'package:qna_test/pages/student_guest_assessment.dart';
import 'package:qna_test/pages/student_looq_landing_page.dart';
import 'package:qna_test/pages/student_looq_selected_assessment.dart';
import 'package:qna_test/pages/student_registration_update_page.dart';
import 'package:qna_test/pages/student_result_page.dart';
import 'package:qna_test/pages/student_revise_quest.dart';
import 'package:qna_test/pages/student_search_library.dart';
import 'package:qna_test/pages/student_user_profile.dart';
import 'package:qna_test/pages/teacher_active_assessment.dart';
import 'package:qna_test/pages/teacher_add_my_question_bank_for_assessment.dart';
import 'package:qna_test/pages/teacher_assess_looq_ques_preview.dart';
import 'package:qna_test/pages/teacher_assessment_landing.dart';
import 'package:qna_test/pages/teacher_assessment_looq_preapare_ques.dart';
import 'package:qna_test/pages/teacher_assessment_looq_ques_bank.dart';
import 'package:qna_test/pages/teacher_assessment_looq_question_preview.dart';
import 'package:qna_test/pages/teacher_assessment_question_bank.dart';
import 'package:qna_test/pages/teacher_assessment_question_preview.dart';
import 'package:qna_test/pages/teacher_assessment_searched.dart';
import 'package:qna_test/pages/teacher_assessment_summary.dart';
import 'package:qna_test/pages/teacher_cloned_assessment.dart';
import 'package:qna_test/pages/teacher_cloned_assessment_preview.dart';
import 'package:qna_test/pages/teacher_inactive_assessment.dart';
import 'package:qna_test/pages/teacher_my_question_bank.dart';
import 'package:qna_test/pages/teacher_prepare_preview_qnBank.dart';
import 'package:qna_test/pages/teacher_prepare_ques_for_assessment.dart';
import 'package:qna_test/pages/teacher_published_assessment.dart';
import 'package:qna_test/pages/teacher_qn_preview_for_assessment.dart';
import 'package:qna_test/pages/teacher_question_delete_page.dart';
import 'package:qna_test/pages/teacher_question_edit.dart';
import 'package:qna_test/pages/teacher_question_preview.dart';
import 'package:qna_test/pages/teacher_question_preview_delete.dart';
import 'package:qna_test/pages/teacher_recent_assessment.dart';
import 'package:qna_test/pages/teacher_selected_questions_assessment.dart';
import 'package:qna_test/pages/teacher_selection_page.dart';
import 'package:qna_test/pages/teacher_user_profile.dart';
import 'package:qna_test/pages/terms_of_services.dart';
import 'Entity/Teacher/get_assessment_model.dart';
import 'Pages/forgot_password_email.dart';
import 'Pages/privacy_policy_hamburger.dart';
import 'Pages/reset_password_student.dart';
import 'Pages/settings_languages.dart';
import 'Pages/student_Advisor.dart';
import 'Pages/student_answersheet.dart';
import 'Pages/student_assessment_start.dart';
import 'Pages/student_forgot_password.dart';
import 'Pages/student_guest_login_page.dart';
import 'Pages/student_member_login_page.dart';
import 'Pages/student_regis_verify_otp.dart';
import 'Pages/student_registration_page.dart';
import 'Pages/student_selection_page.dart';
import 'Pages/teacher_add_my_question_bank.dart';
import 'Pages/teacher_assessment_settings_publish.dart';
import 'Pages/teacher_create_assessment.dart';
import 'Pages/teacher_forgot_password.dart';
import 'Pages/teacher_forgot_password_email.dart';
import 'Pages/teacher_login.dart';
import 'Pages/teacher_looq_clone_preview.dart';
import 'Pages/teacher_looq_preview.dart';
import 'Pages/teacher_looq_question_edit.dart';
import 'Pages/teacher_looq_search_question.dart';
import 'Pages/teacher_prepare_qnBank.dart';
import 'Pages/teacher_qn_preview.dart';
import 'Pages/teacher_questionBank_page.dart';
import 'Pages/teacher_registration_page.dart';
import 'Pages/teacher_registration_verify_page.dart';
import 'Pages/teacher_verify_page.dart';
import 'Pages/verify_otp_page.dart';

class MyRoutes{



  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (settings.name){
      case '/':
        return SlideRightRoute(widget: WelcomePage());

      case '/studentSelectionPage':
        return SlideRightRoute(widget: StudentSelectionPage());

      case '/teacherLoginPage':
        return SlideRightRoute(widget: TeacherLogin());

      case '/settingsLanguages':
        return SlideRightRoute(widget: SettingsLanguages());

      case '/teacherSelectionPage':{
        final userData = settings.arguments as UserDataModel;
        return SlideRightRoute(widget: TeacherSelectionPage(userData: userData));
      }

      case '/teacherRegistrationPage':
        return SlideRightRoute(widget: TeacherRegistrationPage());

      case '/teacherForgotPasswordEmail':
        return SlideRightRoute(widget: TeacherForgotPasswordEmail());

      case '/teacherQuestionBank':
        return SlideRightRoute(widget: TeacherQuestionBank());

      case '/teacherAssessmentLanding':
        return SlideRightRoute(widget: TeacherAssessmentLanding());

      case '/teacherLooqQuestionBank':
        {
          final search = settings.arguments as String;
          return SlideRightRoute(widget: TeacherLooqQuestionBank(search: search,));
        }

      case '/teacherPrepareQnBank':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherPrepareQnBank(assessment: arguments[0],assessmentStatus: arguments[1],));
      }

      case '/questionEdit':{
        final question = settings.arguments as QuestionEntity.Question;
        return SlideRightRoute(widget: QuestionEdit(question: question,));
      }

      case '/teacherMyQuestionBank':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherMyQuestionBank(assessment: assessment));
      }

      case '/teacherQuesDelete':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQuesDelete(quesNum: question[0], finalQuestion: question[1], assessment: question[2],));
      }

      case '/teacherCreateAssessment':
        return SlideRightRoute(widget: TeacherCreateAssessment());

      case '/teacherQuestionPreviewDelete':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQuestionPreviewDelete(question: question[0], index: question[1],assessment: question[2],));
      }

      case '/aboutUs':
        return SlideRightRoute(widget: AboutUs());

      case '/changeEmailStudent':{
        final userId = settings.arguments as int;
        return SlideRightRoute(widget: ChangeEmailStudent(userId: userId,));
      }

      case '/cookiePolicy':
        return SlideRightRoute(widget: CookiePolicy());

      case '/forgotPasswordEmail':
        {
          final isFromStudent = settings.arguments as bool;
          return SlideRightRoute(widget: ForgotPasswordEmail(isFromStudent: isFromStudent,));
        }

      case '/helpPageHamburger':
        return SlideRightRoute(widget: HelpPageHamburger());

      case '/privacyPolicyHamburger':
        return SlideRightRoute(widget: PrivacyPolicyHamburger());

      case '/privacyPolicyHamburger':
        return SlideRightRoute(widget: PrivacyPolicyHamburger());

      case '/resetPasswordStudent':{
        final userId = settings.arguments as int;
        return SlideRightRoute(widget: ResetPasswordStudent(userId: userId,));
      }

      case '/resetPassword':
        return SlideRightRoute(widget: ResetPassword());



      case '/studMemAdvisor':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudMemAdvisor(questions: question[0], assessmentId: question[1],));
      }

      case '/studentMemAnswerSheet':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentMemAnswerSheet(questions: question[0], assessmentId: question[1],));
      }

      case '/studQuestion':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudQuestion(assessmentId: question[0], ques: question[1], userName: question[2], userId: question[3]));
      }

      case '/studentAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentAssessment(regNumber: arguments[0], usedData: arguments[1],));
      }

      case '/studentForgotPassword':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentForgotPassword(email: arguments[0], otp: arguments[1], isFromStudent: arguments[2],));
      }

      case '/studGuestAssessment':{
        final name = settings.arguments as String;
        return SlideRightRoute(widget: StudGuestAssessment(name: name,));
      }

      case '/studentGuestLogin':
        return SlideRightRoute(widget: StudentGuestLogin());

      case '/studentLooqLanding':
        return SlideRightRoute(widget: StudentLooqLanding());

      case '/studentLooqSelectedAssessment':
        return SlideRightRoute(widget: StudentLooqSelectedAssessment());

      case '/studentMemberLoginPage':
        return SlideRightRoute(widget: StudentMemberLoginPage());

      case '/studentRegisVerifyOtpPage':{
        final email = settings.arguments as String;
        return SlideRightRoute(widget: StudentRegisVerifyOtpPage(email: email,));
      }

      case '/studentRegistrationPage':
        return SlideRightRoute(widget: StudentRegistrationPage());

      case '/studentRegistrationUpdatePage':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentRegistrationUpdatePage(userData: arguments[0], isEdit: arguments[1],));
      }

      case '/studentResultPage':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentResultPage(
          totalMarks: arguments[0],
          date: arguments[1],
          time: arguments[2],
          questions: arguments[3],
          assessmentCode: arguments[4],
          userName: arguments[5],
          message: arguments[6],
          endTime: arguments[7],
          givenMark: arguments[8],
        ));
      }

      case '/studentReviseQuest':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentReviseQuest(
            questions: arguments[0],
            userName: arguments[1],
            assessmentID: arguments[2],
            startTime: arguments[3],
            assessmentid: arguments[4],
            submit: arguments[5],
            userId: arguments[6]
        ));
      }

      case '/studentSearchLibrary':
        return SlideRightRoute(widget: StudentSearchLibrary());

      case '/studentUserProfile':{
        final userData = settings.arguments as UserDataModel;
        return SlideRightRoute(widget: StudentUserProfile(userDataModel: userData,));
      }

      case '/teacherActiveAssessment':{
        final assessment = settings.arguments as GetAssessmentModel;
        return SlideRightRoute(widget: TeacherActiveAssessment(assessment: assessment,));
      }

      case '/teacherAddMyQuestionBankForAssessment':
        {
          final assessment = settings.arguments as bool;
          return SlideRightRoute(widget: TeacherAddMyQuestionBankForAssessment(assessment: assessment,));
        }
      case '/teacherAddMyQuestionBank':
        {
          final assessment = settings.arguments as bool;
          return SlideRightRoute(widget: TeacherAddMyQuestionBank(assessment: assessment,));
        }

      case '/teacherAssessLooqQuesPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessLooqQuesPreview(assessment: arguments[0], finalQuestion: arguments[1],));
      }

      case '/teacherAssessmentLooqPrepareQues':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherAssessmentLooqPrepareQues(assessment: assessment));
      }

      case '/teacherAssessmentLooqQuestionBank':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherAssessmentLooqQuestionBank(assessment: assessment));
      }

      case '/teacherAssessmentQuestionBank':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessmentQuestionBank(assessment: arguments[0],searchText: arguments[1],assessmentType: arguments[2]));
      }

      case '/teacherAssessmentQuestionPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessmentQuestionPreview(assessment: arguments[0], question: arguments[1], index: arguments[2],pageName: arguments[3],assessmentType: arguments[4],));
      }

      case '/teacherAssessmentLooqQuestionPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessmentLooqQuestionPreview(assessment: arguments[0], question: arguments[1], index: arguments[2],pageName: arguments[3], quesId: arguments[4],));
      }

      case '/teacherAssessmentSearched':{
        final assessment = settings.arguments as String;
        return SlideRightRoute(widget: TeacherAssessmentSearched(search: assessment,));
      }

      case '/teacherAssessmentSettingPublish':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherAssessmentSettingPublish(assessmentType: assessmentType,));

      case '/teacherAssessmentSummary':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherAssessmentSummary(assessmentType: assessmentType,));

      case '/teacherClonedAssessment':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherClonedAssessment(assessmentType: assessmentType,));

      case '/teacherClonedAssessmentPreview':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherClonedAssessmentPreview(assessmentType: assessmentType,));

      case '/teacherForgotPassword':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherForgotPassword(email: arguments[0], otp: arguments[1],));
      }

      case '/teacherInactiveAssessment':
        return SlideRightRoute(widget: TeacherInactiveAssessment());

      case '/teacherLooqClonePreview':{
        final question = settings.arguments as QuestionEntity.Question;
        return SlideRightRoute(widget: TeacherLooqClonePreview(question: question,));
      }

      case '/teacherLooqPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherLooqPreview(question: arguments[0], editQuestionModel: arguments[1],));
      }

      case '/looqQuestionEdit':{
        final question = settings.arguments as QuestionEntity.Question;
        return SlideRightRoute(widget: LooqQuestionEdit(question: question,));
      }

      case '/preparePreviewQnBank':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: PreparePreviewQnBank(question: arguments[0], finalQuestion: arguments[1],));
      }

      case '/teacherPrepareQuesForAssessment':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherPrepareQuesForAssessment(assessment: assessment));
      }

      case '/teacherPublishedAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherPublishedAssessment(assessmentCode: arguments[0],questionList: arguments[1],));
      }

      case '/teacherPreparePreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherPreparePreview(assessment: arguments[0],finalQuestion: arguments[1],assessmentStatus: arguments[2],));
      }

      case '/teacherQnPreviewAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQnPreviewAssessment(assessment: arguments[0],finalQuestion: arguments[1]));
      }

      case '/teacherQuestionPreview':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQuestionPreview(question: question[0],editQuestionModel: question[1],));
      }

      case '/teacherRecentAssessment':
        {
          final arguments = settings.arguments as List<dynamic>;
          return SlideRightRoute(widget: TeacherRecentAssessment(finalAssessment: arguments[0],assessmentType: arguments[1],));
        }

      case '/teacherRegistrationOtpPage':
        {
          final search = settings.arguments as String;
          return SlideRightRoute(widget: TeacherRegistrationOtpPage(email: search,));
        }

      case '/teacherSelectedQuestionAssessment':
        {
          final arguments = settings.arguments as List<dynamic>;
          return SlideRightRoute(widget: TeacherSelectedQuestionAssessment(questions: arguments[0],assessmentType: arguments[1],));
        }

      case '/teacherUserProfile':{
        final userData = settings.arguments as UserDataModel;
        return SlideRightRoute(widget: TeacherUserProfile(userDataModel: userData,));
      }

      case '/teacherVerifyOtpPage':
        {
          final email = settings.arguments as String;
          return SlideRightRoute(widget: TeacherVerifyOtpPage(email: email,));
        }

      case '/termsOfServiceHamburger':
        return SlideRightRoute(widget: TermsOfServiceHamburger());

      case '/verifyOtpPage':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: VerifyOtpPage(isFromStudent: arguments[0], email: arguments[1],));
      }


    }
    //Navigator.pushNamed(context, '/teacherQuestionPreviewDelete');
    //Navigator.pushNamed(context, '/teacherAddMyQuestionBank',arguments: [widget.assessment,widget.assessmentStatus]);

    return MaterialPageRoute(builder: (context) => Scaffold(
      body: Text('no route defiend'),
    ));
  }
}

class SlideRightRoute extends PageRouteBuilder {
  final Widget widget;
  SlideRightRoute({required this.widget})
      : super(
    pageBuilder: (BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}