import 'package:get/get.dart';
import '../models/project.dart';
import 'project_service.dart';

class ProjectController extends GetxController {
  var isLoading = true.obs;
  var projectList = <Project>[].obs;

  @override
  void onInit() {
    fetchProjects();
    super.onInit();
  }

  void fetchProjects() async {
    try {
      isLoading(true);
      var projects = await ProjectService.fetchProjects();
      if (projects != null) {
        projectList.assignAll(projects);
      }
    } finally {
      isLoading(false);
    }
  }
}
