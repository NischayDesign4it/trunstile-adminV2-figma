import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/features/presentations/models/project.dart';
import 'package:turnstileadmin_v2/features/presentations/screens/Documents/documents.dart';
import 'package:turnstileadmin_v2/features/presentations/screens/toolbox/toolbox.dart';
import 'package:turnstileadmin_v2/utils/constants/sizes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../preshift/preshift.dart';



class DocPage extends StatelessWidget {
  final Project project;
  const DocPage({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    print(project.name);
    return Scaffold(

      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(title: 'Documents'),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TileContainer(title: 'Upload Your Orientation Here', onPressed: () => Get.to(() => DocumentPage(project: project))),
            SizedBox(height: TSizes.defaultSpace / 2),
            TileContainer(title: 'Upload Your ToolBox Here', onPressed: () => Get.to(() => ToolBoxScreen(project: project))),
            SizedBox(height: TSizes.defaultSpace / 2),
            TileContainer(title: 'Upload Your PreShift Here', onPressed: () => Get.to(() => PreShiftScreen(project: project,))),



          ],
        ),
      ),

    );
  }
}

class TileContainer extends StatelessWidget {

  final String title;
  final VoidCallback onPressed;
  const TileContainer({
    super.key, required this.title,  required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: dark ? TColors.textWhite : TColors.inputBg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes text and icon with space in between
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Iconsax.direct_right,
                color: TColors.textBlack
              ),
            ),
          ],
        ),
      ),
    );
  }
}
