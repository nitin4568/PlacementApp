import 'package:get/get.dart';
import 'package:placement/data/binding/App_binding.dart';
import 'package:placement/view/auth/login_screen/login.dart';
import 'package:placement/view/auth/signup_screen/signup.dart';
import 'package:placement/view/auth/verification/email_verification.dart';
import 'package:placement/view/home_page/Aichats.dart';
import 'package:placement/view/home_page/Profile.dart';
import 'package:placement/view/home_page/home_Page.dart';
import 'package:placement/view/home_page/lecture.dart';
import 'package:placement/view/home_page/resume_analyzer.dart';
import 'package:placement/view/home_page/tests.dart';
import 'package:placement/resource/routes/routs.dart';
import 'package:placement/view/upcoming_event/upcoming_event_list.dart';

class AppRoutes {
  static List<GetPage> appRoutes() => [
    GetPage(
      name: AppRouteNames.login,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRouteNames.signup,
      page: () => SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: AppRouteNames.emailVerification,
      page: () => EmailVerificationScreen(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: AppRouteNames.home,
      page: () => HomeScreen(),
      bindings: [
        HomeBinding(),
        MockTestBinding(),
        UpcomingEventBinding(),
        AiChatsBinding(),
        LectureBinding(),
        PlacementDrivePlacementDriveBinding(),
      ],
    ),
    GetPage(
      name: AppRouteNames.test,
      page: () => MockTestScreen(
          testType: Get.arguments ?? "Aptitude"),
      binding: MockTestBinding(),
    ),
    GetPage(
      name: AppRouteNames.aiChats,
      page: () => AIChatScreen(),
      binding: AiChatsBinding(),
    ),
    GetPage(
      name: AppRouteNames.lecture,
      page: () => LectureScreen(),
      binding: LectureBinding(),
    ),
    GetPage(
      name: AppRouteNames.profile,
      page: () => ProfileScreen(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRouteNames.Resume,
      page: () => ResumeAnalyzerScreen(),
      binding: ResumeBinding(),
    ), GetPage(
      name: AppRouteNames.UpcomingEvent,
      page: () =>UpcomingEventList(),

    ),
  ];
}



