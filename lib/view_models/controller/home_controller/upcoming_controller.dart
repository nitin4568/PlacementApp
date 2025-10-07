import 'package:get/get.dart';
import 'package:placement/data/repository/upcomig_repository.dart';
import 'package:placement/models/home_models/upcoming_model.dart';

class UpcomingEventController extends GetxController {
  var events = <UpcomingEvent>[].obs;
  var isLoading = true.obs;

  final UpcomingEventRepository repository;

  UpcomingEventController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      isLoading.value = true;
      final result = await repository.fetchUpcomingEvents();
      events.value = result;
    } catch (e) {
      print("Error fetching events: $e");
      events.clear();
    } finally {
      isLoading.value = false;
    }
  }
}
