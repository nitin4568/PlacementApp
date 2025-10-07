import 'package:get/get.dart';
import 'package:placement/data/repository/homepage_repository/lecture_repository.dart';
import 'package:placement/data/repository/upcomig_repository.dart';
import 'package:placement/view_models/controller/auth_controller/login_controller.dart';
import 'package:placement/view_models/controller/auth_controller/email_varification_contoller.dart';
import 'package:placement/view_models/controller/auth_controller/signup_controller.dart';
import 'package:placement/view_models/controller/home_controller/aichats_controller.dart';
import 'package:placement/view_models/controller/home_controller/home_controller.dart';
import 'package:placement/view_models/controller/home_controller/job_controller.dart';
import 'package:placement/view_models/controller/home_controller/lecture_controller.dart';
import 'package:placement/view_models/controller/home_controller/mock_tests_controller.dart';
import 'package:placement/view_models/controller/home_controller/profile_controller.dart';
import 'package:placement/view_models/controller/home_controller/resume_controler.dart';
import 'package:placement/view_models/controller/home_controller/upcoming_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailVerificationController());
  }
}

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
  }
}

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());

  }
}

class MockTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MockTestController());
  }
}

class AiChatsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AIChatsController());
  }
}

class LectureBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LectureController(repository: LectureRepository()));
  }
}

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }
}
class PlacementDrivePlacementDriveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JobController ());
  }
}
class MocktestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MockTestController ());
  }
}
class ResumeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ResumeController ());
  }
}
class UpcomingEventBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UpcomingEventController(
      repository: UpcomingEventRepository(),
    ));

  }
}
