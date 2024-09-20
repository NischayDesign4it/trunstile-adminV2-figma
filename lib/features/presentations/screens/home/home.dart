import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import '../../../../Navigation_menu.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../../controllers/project_controller.dart';
import '../../models/project.dart';
import '../Settings/settings.dart';



class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProjectController projectController = Get.put(ProjectController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: "Projects",
        leadingIcon: Iconsax.setting,
        onLeadingIconPressed: () => Get.to(() => SettingsPage()),
      ),
      body: Obx(() {
        if (projectController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            padding: EdgeInsets.all(16.0),
            itemCount: projectController.projectList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  buildCard(context, projectController.projectList[index]),
                  SizedBox(height: TSizes.spaceBtwItems),
                ],
              );
            },
          );
        }
      }),
    );
  }

  Widget buildCard(BuildContext context, Project project) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NavigationMenu(project: project));
      },
      child: Card(
        elevation: 2.0,
        child: Column(
          children: [
            Container(
              height: 150.0,
              width: double.infinity,
              child: Image.network(
                project.pictureUrl,
                fit: BoxFit.cover,
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: TColors.primaryColorButton,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  }
                },
                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                  return Center(
                    child: Text(
                      "Failed to load image",
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                },
              ),
            ),


            Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              alignment: Alignment.centerLeft,
              child: Text(project.name),
            ),
            Container(
              padding: EdgeInsets.only(top: 10.0, left: 10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: Colors.grey,
                  ),
                  SizedBox(width: 4.0),
                  Expanded(
                    child: Text(project.location),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text("Outgoing"),
                  ),
                  Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Text("TOTAL: ${project.totalUser}"),
                  ),
                  Expanded(
                    child: Text("Active: ${project.activeUser}"),
                  ),
                  Expanded(
                    child: Text("Inactive: ${project.inactiveUser}"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
