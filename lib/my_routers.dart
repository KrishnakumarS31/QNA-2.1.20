import 'package:flutter/material.dart';
import 'package:qna_test/Entity/Teacher/question_entity.dart' as questions;
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
import 'package:qna_test/pages/teacher_assessment_looq_prepare_ques.dart';
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
import 'package:qna_test/pages/teacher_submitted_question_preview.dart';
import 'package:qna_test/pages/teacher_user_profile.dart';
import 'package:qna_test/pages/terms_of_services.dart';
import 'EntityModel/student_registration_model.dart';
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
        return SlideRightRoute(widget: const WelcomePage(),settings: settings);

      case '/studentSelectionPage':
        return SlideRightRoute(widget: const StudentSelectionPage(),settings: settings);

      case '/teacherLoginPage':
        return SlideRightRoute(widget: const TeacherLogin(),settings: settings);

      case '/settingsLanguages':
        return SlideRightRoute(widget: const SettingsLanguages(),settings: settings);

      case '/teacherSelectionPage':{
        final userData = settings.arguments as UserDataModel;
        return SlideRightRoute(widget: TeacherSelectionPage(userData: userData),settings: settings);
      }

      case '/teacherRegistrationPage':
        return SlideRightRoute(widget: const TeacherRegistrationPage(),settings: settings);

      case '/teacherForgotPasswordEmail':
        return SlideRightRoute(widget: const TeacherForgotPasswordEmail(),settings: settings);

      case '/teacherQuestionBank':
        return SlideRightRoute(widget: const TeacherQuestionBank(),settings: settings);

      case '/teacherAssessmentLanding':
        return SlideRightRoute(widget: const TeacherAssessmentLanding(),settings: settings);

      case '/teacherLooqQuestionBank':
        {
          final search = settings.arguments as String;
          return SlideRightRoute(widget: TeacherLooqQuestionBank(search: search,),settings: settings);
        }

      case '/teacherPrepareQnBank':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherPrepareQnBank(assessment: arguments[0],assessmentStatus: arguments[1],),settings: settings);
      }

      case '/questionEdit':{
        final question = settings.arguments as questions.Question;
        return SlideRightRoute(widget: QuestionEdit(question: question,),settings: settings);
      }

      case '/teacherMyQuestionBank':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherMyQuestionBank(assessment: assessment),settings: settings);
      }

      case '/teacherQuesDelete':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQuesDelete(quesNum: question[0], finalQuestion: question[1], assessment: question[2],),settings: settings);
      }

      case '/teacherCreateAssessment':
        return SlideRightRoute(widget: const TeacherCreateAssessment(),settings: settings);

      case '/teacherQuestionPreviewDelete':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQuestionPreviewDelete(question: question[0], index: question[1],assessment: question[2],),settings: settings);
      }

      case '/aboutUs':
        return SlideRightRoute(widget: const AboutUs(),settings: settings);

      case '/changeEmailStudent':{
        final userId = settings.arguments as int;
        return SlideRightRoute(widget: ChangeEmailStudent(userId: userId,),settings: settings);
      }

      case '/cookiePolicy':
        return SlideRightRoute(widget: const CookiePolicy(),settings: settings);

      case '/forgotPasswordEmail':
        {
          final isFromStudent = settings.arguments as bool;
          return SlideRightRoute(widget: ForgotPasswordEmail(isFromStudent: isFromStudent,),settings: settings);
        }

      case '/helpPageHamburger':
        return SlideRightRoute(widget: const HelpPageHamburger(),settings: settings);

      case '/privacyPolicyHamburger':
        return SlideRightRoute(widget: const PrivacyPolicyHamburger(),settings: settings);

      case '/resetPasswordStudent':{
        final userId = settings.arguments as int;
        return SlideRightRoute(widget: ResetPasswordStudent(userId: userId,),settings: settings);
      }

      case '/resetPassword':
        return SlideRightRoute(widget: const ResetPassword(),settings: settings);



      case '/studMemAdvisor':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudMemAdvisor(questions: question[0], assessmentId: question[1],),settings: settings);
      }

      case '/studentMemAnswerSheet':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentMemAnswerSheet(questions: question[0], assessmentId: question[1],),settings: settings);
      }

      case '/studQuestion':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudQuestion(assessmentId: question[0], ques: question[1], userName: question[2], userId: question[3],isMember: question[4],assessmentHeaders:question[5] ,),settings: settings);
      }

      case '/studentAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentAssessment(usedData: arguments[0],assessment: arguments[1]),settings: settings);
      }

      case '/studentForgotPassword':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentForgotPassword(email: arguments[0], otp: arguments[1], isFromStudent: arguments[2],),settings: settings);
      }

      case '/studGuestAssessment':{
        final name = settings.arguments as String;
        return SlideRightRoute(widget: StudGuestAssessment(name: name,),settings: settings);
      }

      case '/studentGuestLogin':
        return SlideRightRoute(widget: const StudentGuestLogin(),settings: settings);

      case '/studentLooqLanding':
        return SlideRightRoute(widget: const StudentLooqLanding(),settings: settings);

      case '/studentLooqSelectedAssessment':
        return SlideRightRoute(widget: const StudentLooqSelectedAssessment(),settings: settings);

      case '/studentMemberLoginPage':
        return SlideRightRoute(widget: const StudentMemberLoginPage(),settings: settings);

      case '/studentRegisVerifyOtpPage':{
        final search = settings.arguments as StudentRegistrationModel;
        return SlideRightRoute(widget: StudentRegisVerifyOtpPage(student: search,),settings: settings);
      }

      case '/studentRegistrationPage':
        return SlideRightRoute(widget: const StudentRegistrationPage(),settings: settings);

      case '/studentRegistrationUpdatePage':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentRegistrationUpdatePage(userData: arguments[0], isEdit: arguments[1],),settings: settings);
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
            isMember: arguments[9],
          assessmentHeaders: arguments[10],
        ),settings: settings);
      }

      case '/studentReviseQuest':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: StudentReviseQuest(
            questions: arguments[0],
            userName: arguments[1],
            assessmentID: arguments[2],
            startTime: arguments[3],
            assessmentCode: arguments[4],
            submit: arguments[5],
            userId: arguments[6],
            isMember: arguments[7],
            assessmentHeaders: arguments[8],
            myDuration: arguments[9],
        ),settings: settings);
      }

      case '/studentSearchLibrary':
        return SlideRightRoute(widget: const StudentSearchLibrary(),settings: settings);

      case '/studentUserProfile':{
        final userData = settings.arguments as UserDataModel;
        return SlideRightRoute(widget: StudentUserProfile(userDataModel: userData,),settings: settings);
      }

      case '/teacherActiveAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherActiveAssessment(assessment: arguments[0], assessmentType: arguments[1],),settings: settings);
      }

      case '/teacherAddMyQuestionBankForAssessment':
        {
          final assessment = settings.arguments as bool;
          return SlideRightRoute(widget: TeacherAddMyQuestionBankForAssessment(assessment: assessment,),settings: settings);
        }
      case '/teacherAddMyQuestionBank':
        {
          final assessment = settings.arguments as bool;
          return SlideRightRoute(widget: TeacherAddMyQuestionBank(assessment: assessment,),settings: settings);
        }

      case '/teacherAssessLooqQuesPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessLooqQuesPreview(assessment: arguments[0], finalQuestion: arguments[1],),settings: settings);
      }

      case '/teacherAssessmentLooqPrepareQues':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherAssessmentLooqPrepareQues(assessment: assessment),settings: settings);
      }

      case '/teacherAssessmentLooqQuestionBank':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherAssessmentLooqQuestionBank(assessment: assessment),settings: settings);
      }

      case '/teacherAssessmentQuestionBank':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessmentQuestionBank(assessment: arguments[0],searchText: arguments[1],assessmentType: arguments[2]),settings: settings);
      }

      case '/teacherAssessmentQuestionPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessmentQuestionPreview(assessment: arguments[0], question: arguments[1], index: arguments[2],pageName: arguments[3],assessmentType: arguments[4],),settings: settings);
      }

      case '/teacherAssessmentLooqQuestionPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherAssessmentLooqQuestionPreview(assessment: arguments[0], question: arguments[1], index: arguments[2],pageName: arguments[3], quesId: arguments[4],),settings: settings);
      }

      case '/teacherAssessmentSearched':{
        final assessment = settings.arguments as String;
        return SlideRightRoute(widget: TeacherAssessmentSearched(search: assessment,),settings: settings);
      }

      case '/teacherAssessmentSettingPublish':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherAssessmentSettingPublish(assessmentType: assessmentType,),settings: settings);

      case '/teacherAssessmentSummary':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherAssessmentSummary(assessmentType: assessmentType,),settings: settings);

      case '/teacherClonedAssessment':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherClonedAssessment(assessmentType: assessmentType,),settings: settings);

      case '/teacherClonedAssessmentPreview':
        final assessmentType = settings.arguments as String;
        return SlideRightRoute(widget: TeacherClonedAssessmentPreview(assessmentType: assessmentType,),settings: settings);

      case '/teacherForgotPassword':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherForgotPassword(email: arguments[0], otp: arguments[1],),settings: settings);
      }

      case '/teacherInactiveAssessment':
        return SlideRightRoute(widget: const TeacherInactiveAssessment(),settings: settings);

      case '/teacherLooqClonePreview':{
        final question = settings.arguments as questions.Question;
        return SlideRightRoute(widget: TeacherLooqClonePreview(question: question,),settings: settings);
      }

      case '/teacherLooqPreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherLooqPreview(question: arguments[0], editQuestionModel: arguments[1],),settings: settings);
      }

      case '/looqQuestionEdit':{
        final question = settings.arguments as questions.Question;
        return SlideRightRoute(widget: LooqQuestionEdit(question: question,),settings: settings);
      }

      case '/preparePreviewQnBank':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: PreparePreviewQnBank(question: arguments[0],),settings: settings);
      }

      case '/teacherPrepareQuesForAssessment':{
        final assessment = settings.arguments as bool;
        return SlideRightRoute(widget: TeacherPrepareQuesForAssessment(assessment: assessment),settings: settings);
      }

      case '/teacherPublishedAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherPublishedAssessment(assessmentCode: arguments[0],questionList: arguments[1],),settings: settings);
      }

      case '/teacherPreparePreview':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherPreparePreview(assessment: arguments[0],finalQuestion: arguments[1],assessmentStatus: arguments[2],),settings: settings);
      }

      case '/teacherQnPreviewAssessment':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQnPreviewAssessment(assessment: arguments[0],finalQuestion: arguments[1]),settings: settings);
      }

      case '/teacherQuestionPreview':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherQuestionPreview(question: question[0],editQuestionModel: question[1],),settings: settings);
      }

      case '/teacherSubmittedQuestionPreview':{
        final question = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: TeacherSubmittedQuestionPreview(question: question[0],editQuestionModel: question[1],),settings: settings);
      }

      case '/teacherRecentAssessment':
        {
          final arguments = settings.arguments as List<dynamic>;
          return SlideRightRoute(widget: TeacherRecentAssessment(finalAssessment: arguments[0],assessmentType: arguments[1],),settings: settings);
        }

      case '/teacherRegistrationOtpPage':
        {
          final search = settings.arguments as StudentRegistrationModel;
          return SlideRightRoute(widget: TeacherRegistrationOtpPage(student: search,),settings: settings);
        }

      case '/teacherSelectedQuestionAssessment':
        {
          final arguments = settings.arguments as List<dynamic>;
          return SlideRightRoute(widget: TeacherSelectedQuestionAssessment(questions: arguments[0],assessmentType: arguments[1],),settings: settings);
        }

      case '/teacherUserProfile':{
        final userData = settings.arguments as UserDataModel;
        return SlideRightRoute(widget: TeacherUserProfile(userDataModel: userData,),settings: settings);
      }

      case '/teacherVerifyOtpPage':
        {
          final email = settings.arguments as String;
          return SlideRightRoute(widget: TeacherVerifyOtpPage(email: email,),settings: settings);
        }

      case '/termsOfServiceHamburger':
        return SlideRightRoute(widget: const TermsOfServiceHamburger(),settings: settings);

      case '/verifyOtpPage':{
        final arguments = settings.arguments as List<dynamic>;
        return SlideRightRoute(widget: VerifyOtpPage(isFromStudent: arguments[0], email: arguments[1],),settings: settings);
      }


    }
    //Navigator.pushNamed(context, '/teacherQuestionPreviewDelete');
    //Navigator.pushNamed(context, '/teacherAddMyQuestionBank',arguments: [widget.assessment,widget.assessmentStatus]);

    return MaterialPageRoute(builder: (context) => const Scaffold(
      body: Text('no route defined'),
    ));
  }
}

class SlideRightRoute extends PageRouteBuilder {

  final Widget widget;
  @override
  final RouteSettings settings;
  SlideRightRoute({required this.widget,required this.settings})
      : super(
    settings: RouteSettings(name: '${settings.name}'),
    pageBuilder: (
        BuildContext context, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return widget;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },
  );
}