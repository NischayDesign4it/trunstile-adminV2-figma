import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TButton.dart';
import 'package:turnstileadmin_v2/common/TOutlinedButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../../models/project.dart';
import '../worker_detail/onsite.dart';
import '../worker_detail/worker_list.dart';
import '../asset_detail/asset_list.dart';
import '../worker_detail/pending_worker.dart';

class ProjectDetailScreen extends StatelessWidget {
  final Project project;

  const ProjectDetailScreen({Key? key, required this.project}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    print(project.name);
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: AppBar(
        title: Text(project.name),
        backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left, color: dark ? TColors.textWhite : TColors.textBlack),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0), // Adjust the radius as needed
                image: project.pictureUrl.isNotEmpty
                    ? DecorationImage(
                  image: NetworkImage(project.pictureUrl),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: project.pictureUrl.isEmpty
                  ? Center(
                child: Text(
                  "No Image",
                  style: TextStyle(color: Colors.grey),
                ),
              )
                  : null,
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Text(project.name, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.grey),
                SizedBox(width: 4.0),
                Expanded(child: Text(project.location)),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Expanded(
                  child: Text("Outgoing"),
                ),
                Icon(Icons.person, color: Colors.grey),
                SizedBox(width: 1.0),
                Expanded(child: Text("TOTAL: ${project.totalUser}")),
                SizedBox(width: 1.0),
                Expanded(child: Text("Active: ${project.activeUser}")),
                SizedBox(width: 1.0),
                Expanded(child: Text("Inactive: ${project.inactiveUser}")),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Expanded(
                  child: TOutlinedButton(
                    title: "Workers",
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => WorkerManagement(projectName: project.name),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: TSizes.sm),
                Expanded(
                  child: TOutlinedButton(
                    title: "Assets",
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AssetManagement(projectName: project.name),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Expanded(
                  child: TOutlinedButton(
                    title: "Pending Workers",
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PendingWorker(projectName: project.name),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: TSizes.sm),
                Expanded(
                  child: TOutlinedButton(
                    title: "ON-Site Users",
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => onSite(projectName: project.name),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // SizedBox(height: TSizes.spaceBtwItems),
            // TButton(
            //   title: "Pending Workers",
            //   onPressed: () => Navigator.of(context).push(
            //     MaterialPageRoute(
            //       builder: (context) => PendingWorker(projectName: project.name),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
