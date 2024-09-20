import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/utils/constants/colors.dart';
import 'package:turnstileadmin_v2/utils/helpers/Thelper_functions.dart';
import 'features/presentations/models/project.dart';
import 'features/presentations/screens/Documents/DocPage.dart';
import 'features/presentations/screens/Profile/profile.dart';
import 'features/presentations/screens/analytics/analytics.dart';
import 'features/presentations/screens/home/project_detail.dart';

class NavigationMenu extends StatelessWidget {
  final Project project;
  const NavigationMenu({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    print(project.name);
    final controller = Get.put(NavigationController(project: project));
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Obx(
            () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.textBlack : Colors.white,
          indicatorColor: darkMode ? TColors.textWhite.withOpacity(0.1) : TColors.textBlack.withOpacity(0.1),
          destinations: [
            NavigationDestination(icon: Icon(Iconsax.menu_board), label: "Projects"),
            NavigationDestination(icon: Icon(Iconsax.chart_square), label: "Analytics"),
            NavigationDestination(icon: Icon(Iconsax.folder_open), label: "Documents"),
            NavigationDestination(icon: Icon(Iconsax.user), label: "Profile"),
          ],
        ),
      ),
      body: Obx(()=> controller.screens[controller.selectedIndex.value]),
    );
  }
}




class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  late final List<Widget> screens;

  final Project project;
  NavigationController({required this.project});

  @override
  void onInit() {
    super.onInit();
    screens = [
      ProjectDetailScreen(project: project),
      AnalyticsPage(),
      DocPage(project: project),
      ProfileScreen(),
    ];
  }
}

