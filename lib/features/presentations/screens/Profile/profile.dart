import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/common/TButton.dart';
import 'package:turnstileadmin_v2/utils/constants/colors.dart';
import 'package:turnstileadmin_v2/utils/constants/sizes.dart';
import 'package:turnstileadmin_v2/utils/constants/text_strings.dart';
import 'package:turnstileadmin_v2/utils/helpers/Thelper_functions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../../globals.dart';
import '../Settings/settings.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController jobRoleController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController tagIdController = TextEditingController();
  final TextEditingController companyIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final response = await http.get(Uri.parse('http://44.214.230.69:8000/get_signup/$loggedInUserEmail/'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        nameController.text = data['name'] ?? '';
        companyNameController.text = data['company_name'] ?? '';
        jobRoleController.text = data['job_role'] ?? '';
        jobLocationController.text = data['job_location'] ?? '';
        tagIdController.text = data['tag_id'] ?? '';
        companyIdController.text = data['mycompany_id'] ?? '';
      });
    } else {
      // Handle the error
    }
  }

  Future<void> updateProfileData() async {
    final Map<String, dynamic> updatedData = {
      'name': nameController.text,
      'company_name': companyNameController.text,
      'job_role': jobRoleController.text,
      'job_location': jobLocationController.text,
      'tag_id': tagIdController.text,
      'mycompany_id': companyIdController.text,
    };

    final response = await http.patch(
      Uri.parse('http://44.214.230.69:8000/update_signup/$loggedInUserEmail/'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      Get.snackbar('Updated', 'Profile update successfully', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      // Handle successful update
    } else {
      Get.snackbar('Error', 'Failed to update profile', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: 'Profile',
        leadingIcon: Iconsax.setting,
        onLeadingIconPressed: () => Get.to(() => SettingsPage()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTextFieldRow(Iconsax.user, TTexts.name, nameController),
              SizedBox(height: TSizes.spaceBtwItems),
              buildTextFieldRow(Iconsax.building, TTexts.companyName, companyNameController),
              SizedBox(height: TSizes.spaceBtwItems),
              buildTextFieldRow(Iconsax.user_tag, TTexts.jobRole, jobRoleController),
              SizedBox(height: TSizes.spaceBtwItems),
              buildTextFieldRow(Iconsax.user_square, TTexts.jobLocation, jobLocationController),
              SizedBox(height: TSizes.spaceBtwItems),
              buildTextFieldRow(Iconsax.tag, TTexts.tagId, tagIdController),
              SizedBox(height: TSizes.spaceBtwItems),
              buildTextFieldRow(Iconsax.tag, TTexts.companyID, companyIdController),
              SizedBox(height: TSizes.spaceBtwSection),
              TButton(
                title: TTexts.save,
                onPressed: updateProfileData,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFieldRow(IconData icon, String labelText, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon),
            SizedBox(width: 5),
            Text(labelText),
          ],
        ),
        SizedBox(height: TSizes.xs),
        TextFormField(
          controller: controller,
          cursorColor: TColors.textBlack,
          style: TextStyle(color: TColors.textBlack),
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
            contentPadding: EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 15,
            ),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
