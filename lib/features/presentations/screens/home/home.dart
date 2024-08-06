import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/common/TButton.dart';
import 'package:turnstileadmin_v2/common/TOutlinedButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../../controllers/project_controller.dart';
import '../../models/project.dart';
import '../Settings/settings.dart';
import '../asset_detail/asset_list.dart';
import '../worker_detail/worker_list.dart';



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
        onLeadingIconPressed:  () =>
            Get.to(() => SettingsPage()),
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
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                children: [
                  Text("Project Details"),
                  Spacer(),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Iconsax.close_circle))
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 150.0,
                      child: project.picture != null &&
                          project.picture.isNotEmpty
                          ? Ink.image(
                        image: NetworkImage(project.picture),
                        fit: BoxFit.cover,
                      )
                          : Center(
                        child: Text(
                          "No Image",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(project.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Row(
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
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                          child: Text("Outgoing"),
                        ),
                        Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 2.0),
                        Expanded(
                          child: Text("TOTAL: ${project.totalUsers}"),
                        ),
                        Expanded(
                          child: Text("Active: ${project.activeUsers}"),
                        ),
                        Expanded(
                          child: Text("Inactive: ${project.inactiveUsers}"),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: [
                        Expanded(
                            child: TOutlinedButton(
                                title: "Workers",
                                onPressed: () =>
                                    Get.to(() => WorkerManagement()))),
                        SizedBox(width: TSizes.sm),
                        Expanded(
                            child: TOutlinedButton(
                                title: "Assets",
                                onPressed: () =>
                                    Get.to(() => assetManagement()))),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    TButton(title: "Mark as Done", onPressed: () {}),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Card(
        elevation: 2.0,
        child: Column(
          children: [
            Container(
              height: 150.0,
              child: project.picture != null && project.picture.isNotEmpty
                  ? Ink.image(
                image: NetworkImage(project.picture),
                fit: BoxFit.cover,
              )
                  : Center(
                child: Text(
                  "No Image",
                  style: TextStyle(color: Colors.grey),
                ),
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
                    child: Text("TOTAL: ${project.totalUsers}"),
                  ),
                  Expanded(
                    child: Text("Active: ${project.activeUsers}"),
                  ),
                  Expanded(
                    child: Text("Inactive: ${project.inactiveUsers}"),
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