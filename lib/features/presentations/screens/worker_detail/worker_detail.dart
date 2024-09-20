import 'dart:async';
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import '../../../../common/TButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../QR/qrScreen.dart';

class WorkerScreen extends StatefulWidget {
  const WorkerScreen({Key? key}) : super(key: key);

  @override
  _WorkerScreenState createState() => _WorkerScreenState();
}

class _WorkerScreenState extends State<WorkerScreen> {
  bool isActive = true; // Track the status
  File? _selectedImage;
  final picker = ImagePicker();



  // Controllers for the text fields
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




  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }



  Future<void> _submitData() async {
    String url = "http://44.214.230.69:8000/users/";

    var request = http.MultipartRequest('POST', Uri.parse(url));
    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('picture', _selectedImage!.path));
    }
    request.fields['name'] = _nameController.text;
    request.fields['company_name'] = _companyNameController.text;
    request.fields['job_role'] = _jobRoleController.text;
    request.fields['mycompany_id'] = _companyIDController.text;
    request.fields['tag_id'] = _tagIDController.text;
    request.fields['job_location'] = _jobLocationController.text;
    request.fields['email'] = _emailController.text;
    request.fields['site'] = _siteController.text;
    // request.fields['orientation'] = 'http://44.214.230.69:9000/media/attachments/newjs_VefPxld.jpeg';
    request.fields['status'] = isActive ? 'active' : 'inactive';

    var response = await request.send();
    if (response.statusCode == 201) {
      // Show success snackbar
      Get.snackbar(
        'Success',
        'Data submitted successfully.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        colorText: TColors.textWhite,
          backgroundColor: Colors.black
      );
      _clearFields();
    } else {
      print('Failed to post data');
      // Show error snackbar
      Get.snackbar(
        'Error',
        'Failed to submit data.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        colorText: TColors.textWhite,
        backgroundColor: Colors.black
      );
    }
  }


  Future<void> _updateData() async {
    String url = "http://44.214.230.69:8000/update_user/";

    var request = http.MultipartRequest('PATCH', Uri.parse(url));

    if (_selectedImage != null) {
      request.files.add(await http.MultipartFile.fromPath('picture', _selectedImage!.path));
    }

    if (_nameController.text.isNotEmpty) {
      request.fields['name'] = _nameController.text;
    }
    if (_companyNameController.text.isNotEmpty) {
      request.fields['company_name'] = _companyNameController.text;
    }
    if (_jobRoleController.text.isNotEmpty) {
      request.fields['job_role'] = _jobRoleController.text;
    }
    if (_companyIDController.text.isNotEmpty) {
      request.fields['mycompany_id'] = _companyIDController.text;
    }
    if (_tagIDController.text.isNotEmpty) {
      request.fields['tag_id'] = _tagIDController.text;
    }
    if (_jobLocationController.text.isNotEmpty) {
      request.fields['job_location'] = _jobLocationController.text;
    }
    if (_emailController.text.isNotEmpty) {
      request.fields['email'] = _emailController.text;
    }
    if (_siteController.text.isNotEmpty) {
      request.fields['site'] = _siteController.text;
    }

    request.fields['status'] = isActive ? 'active' : 'inactive';

    try {
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        // Show success snackbar
        Get.snackbar(
          'Success',
          'Data updated successfully.',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          colorText: TColors.textWhite,
          backgroundColor: Colors.black,
        );
        _clearFields();
      } else {
        var responseData = await http.Response.fromStream(response);
        print('Failed to post data: ${responseData.body}');
        // Show error snackbar
        Get.snackbar(
          'Error',
          'Failed to update data. Error: ${responseData.body}',
          snackPosition: SnackPosition.TOP,
          duration: Duration(seconds: 3),
          colorText: TColors.textWhite,
          backgroundColor: Colors.black,
        );
      }
    } catch (e) {
      print('Error: $e');
      // Show error snackbar
      Get.snackbar(
        'Error',
        'An error occurred. Please try again.',
        snackPosition: SnackPosition.TOP,
        duration: Duration(seconds: 3),
        colorText: TColors.textWhite,
        backgroundColor: Colors.black,
      );
    }
  }

  void _clearFields() {
    _nameController.clear();
    _companyNameController.clear();
    _jobRoleController.clear();
    _jobLocationController.clear();
    _companyIDController.clear();
    _tagIDController.clear();
    _emailController.clear();
    _siteController.clear();
    setState(() {
      _selectedImage = null;
      isActive = true; // Reset status to active
    });
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: TTexts.workerDetail,
        leadingIcon: Iconsax.setting, // Replace with your leading icon
        onLeadingIconPressed: () {

        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Image with Border
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: TColors.primaryColorBorder, // Border color
                        width: 2,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null, // Display selected image if available
                      child: _selectedImage == null
                          ? Icon(
                        Iconsax.user,
                        size: 40,
                        color: Colors.grey, // Hide the icon when the image is loaded
                      )
                          : null, // No child if image is displayed
                    ),
                  ),
                ),
              ),
              SizedBox(height: TSizes.md),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12)),
                    height: 40,
                    width: 150,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Iconsax.camera,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text("Change Image",
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: TSizes.defaultSpace), // Add space below image

              // Full Name
              Row(
                children: [
                  Icon(Iconsax.user),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.name),
                ],
              ),
              SizedBox(height: TSizes.xs),

              TextFormField(
                controller: _nameController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.name, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.email),
                ],
              ),
              SizedBox(height: TSizes.xs),

              TextFormField(
                controller: _emailController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.email, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.site),
                ],
              ),
              SizedBox(height: TSizes.xs),

              TextFormField(
                controller: _siteController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.site, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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


              // Company Name
              Row(
                children: [
                  Icon(Iconsax.building),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.companyName),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _companyNameController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.companyName, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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

              // Company ID
              Row(
                children: [
                  Icon(Iconsax.tag),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.companyID),
                ],
              ),
              SizedBox(height: TSizes.xs),

              TextFormField(
                controller: _companyIDController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.companyID, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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

              // Tag ID
              Row(
                children: [
                  Icon(Iconsax.tag),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.tagId),
                ],
              ),
              SizedBox(height: TSizes.xs),
              // TextFormField(
              //   controller: _tagIDController,
              //   cursorColor: TColors.textBlack,
              //   style: TextStyle(color: TColors.textBlack),
              //   decoration: InputDecoration(
              //     suffixIcon: IconButton(onPressed: () => {
              //       Get.to(() => QrScanner(title: TTexts.myTagIdTitle, subtitle: TTexts.qrSubTitle,))
              //
              //     }, icon: Icon(Iconsax.scan_barcode, color: TColors.textBlack,)),
              //     hintText: TTexts.tagId, // Add a hint text for the description
              //     hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
              //     contentPadding: EdgeInsets.symmetric(
              //       vertical: 12, // Increased vertical padding
              //       horizontal: 15,
              //     ),
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderSide: BorderSide.none,
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),

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

              // Worker ID
              Row(
                children: [
                  Icon(Iconsax.user_tag),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.jobRole),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _jobRoleController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.jobRole, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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

              // Job Role
              Row(
                children: [
                  Icon(Iconsax.user_square),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.jobLocation),
                ],
              ),

              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: _jobLocationController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.jobLocation, // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)), // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12, // Increased vertical padding
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

              // Status Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "STATUS",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                ],
              ),

              SizedBox(height: TSizes.spaceBtwSection),
              TButton(title: TTexts.save, onPressed: _submitData),
              SizedBox(height: TSizes.spaceBtwItems/2),
              TButton(title: "Update", onPressed: _updateData),
              SizedBox(height: TSizes.spaceBtwItems/2),
              // TButton(title: "Delete", onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}


