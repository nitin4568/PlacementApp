import 'package:get/get.dart';
import 'package:placement/data/repository/homepage_repository/lecture_repository.dart';
import 'package:placement/models/home_models/lecture_model.dart';

class LectureController extends GetxController {
  final LectureRepository repository;
  LectureController({required this.repository});

  var lectures = <Lecture>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPopularLectures();
  }

  /// Fetch default/popular lectures on screen open
  void fetchPopularLectures() async {
    try {
      isLoading.value = true;
      final result = await repository.searchLectures("popular DSA lectures");
      lectures.value = result;
    } catch (e) {
      print("Error fetching popular lectures: $e");
      Get.snackbar("Error", "Failed to fetch default lectures");
    } finally {
      isLoading.value = false;
    }
  }

  /// Search based on user input
  void searchLecture(String query) async {
    if (query.isEmpty) return;
    try {
      isLoading.value = true;
      final result = await repository.searchLectures(query);
      lectures.value = result;
    } catch (e) {
      print("Error fetching lectures: $e");
      Get.snackbar("Error", "Failed to fetch lectures");
    } finally {
      isLoading.value = false;
    }
  }
}
