import 'package:get/get.dart';
import 'package:placement/models/home_models/job_model.dart';
import 'package:placement/data/repository/homepage_repository/job_repository.dart';

class JobController extends GetxController {
  var latestJob = Rxn<Job>();
  var isLoading = false.obs;

  final JobRepository repository = JobRepository();

  @override
  void onInit() {
    fetchLatestJob();
    super.onInit();
  }

  Future<void> fetchLatestJob() async {
    try {
      isLoading.value = true;
      latestJob.value = await repository.fetchLatestJob();
    } catch (e) {
      print("JobController Error: $e");
      latestJob.value = null;
    } finally {
      isLoading.value = false;
    }
  }
}
