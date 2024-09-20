

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:turnstileadmin_v2/features/presentations/screens/worker_detail/worker_list.dart';
import 'dart:convert';
import '../../../../common/TAppBar.dart';
import '../../../../common/TButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import 'dart:async';

import '../QR/qrScreen.dart';

class EditWorkerScreen extends StatefulWidget {
  final Map<String, dynamic> worker;

  final String projectName;

  const EditWorkerScreen({Key? key, required this.worker, required this.projectName}) : super(key: key);

  @override
  State<EditWorkerScreen> createState() => _EditWorkerScreenState();
}

class _EditWorkerScreenState extends State<EditWorkerScreen> {
  bool isActive = true;

  final _nameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _jobRoleController = TextEditingController();
  final _jobLocationController = TextEditingController();
  final _companyIDController = TextEditingController();
  final _tagIDController = TextEditingController();
  final _emailController = TextEditingController();
  final _siteController = TextEditingController();



  @override
  void dispose() {
    _tagIDController.dispose();
    super.dispose();
  }

  Future<void> _navigateAndScanQr(BuildContext context) async {
    final scannedData = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrScanner(title: TTexts.myTagIdTitle, subtitle: TTexts.qrSubTitle,)),
    );

    if (scannedData != null) {
      setState(() {
        _tagIDController.text = scannedData;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // Populate text fields with the passed worker data
    _nameController.text = widget.worker['name'] ?? '';
    _companyNameController.text = widget.worker['company_name'] ?? '';
    _jobRoleController.text = widget.worker['job_role'] ?? '';
    _jobLocationController.text = widget.worker['job_location'] ?? '';
    _companyIDController.text = widget.worker['mycompany_id'] ?? '';
    _tagIDController.text = widget.worker['tag_id'] ?? '';
    _emailController.text = widget.worker['email'] ?? '';
    _siteController.text = widget.worker['site'] ?? '';

    isActive = widget.worker['status'] == 'active';
  }

  Future<void> updateUser(String email, Map<String, dynamic> updates) async {
    final String url = 'http://44.214.230.69:8000/update_user/';

    try {
      final response = await http.patch(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'email': email,
          ...updates,
        }),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User details updated successfully',
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => WorkerManagement(projectName: widget.projectName)),
        );
      } else {
        Get.snackbar('Error', 'Failed to update user details: ${response.body}',
          backgroundColor: Colors.black,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
        backgroundColor: Colors.black,
        colorText: Colors.white,
      );
    }
  }

  void onSaveChanges() {
    String userEmail = _emailController.text;

    Map<String, dynamic> updates = {
      'name': _nameController.text,
      'company_name': _companyNameController.text,
      'job_role': _jobRoleController.text,
      'job_location': _jobLocationController.text,
      'mycompany_id': _companyIDController.text,
      'tag_id': _tagIDController.text,
      'site': _siteController.text,
      'status': isActive ? 'active' : 'inactive',
    };

    updateUser(userEmail, updates);
  }

  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: TTexts.editDetail,
        leadingIcon: Iconsax.setting,
        onLeadingIconPressed: () {

        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: TSizes.defaultSpace),

              Row(
                children: [
                  Icon(Iconsax.user),
                  SizedBox(width: 5),
                  Text(TTexts.name),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _nameController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.name,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.direct_right),
                  SizedBox(width: 5),
                  Text(TTexts.email),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _emailController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.email,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.building),
                  SizedBox(width: 5),
                  Text(TTexts.site),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _siteController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.site,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.building),
                  SizedBox(width: 5),
                  Text(TTexts.companyName),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _companyNameController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.companyName,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.tag),
                  SizedBox(width: 5),
                  Text(TTexts.companyID),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _companyIDController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.companyID,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.tag),
                  SizedBox(width: 5),
                  Text(TTexts.tagId),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _tagIDController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: (){_navigateAndScanQr(context);},
                    icon: Icon(Iconsax.scan_barcode, color: TColors.textBlack),
                  ),
                  hintText: TTexts.tagId,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.building),
                  SizedBox(width: 5),
                  Text(TTexts.jobRole),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _jobRoleController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.jobRole,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.location),
                  SizedBox(width: 5),
                  Text(TTexts.jobLocation),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _jobLocationController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.jobLocation,
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
              SizedBox(height: TSizes.spaceBtwItems),

              Row(
                children: [
                  Icon(Iconsax.building),
                  SizedBox(width: 5),
                  Text(TTexts.status),
                ],
              ),
              SizedBox(height: TSizes.xs),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isActive = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isActive ? TColors.primaryColorBorder : TColors.inputBg,
                      minimumSize: Size(100, 40), // Adjust the size
                    ),
                    child: Text(
                      'Active',
                      style: TextStyle(color: !isActive ? TColors.primaryColorBorder : TColors.inputBg),
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isActive = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !isActive ? TColors.primaryColorBorder : TColors.inputBg,
                      minimumSize: Size(100, 40), // Adjust the size
                    ),
                    child: Text(
                      'Inactive',
                      style: TextStyle(color: !isActive ? TColors.textWhite : TColors.primaryColorBorder),
                    ),
                  ),
                ],
              ),

              SizedBox(height: TSizes.spaceBtwItems),

              TButton(
                title: TTexts.save,
                onPressed: onSaveChanges,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
