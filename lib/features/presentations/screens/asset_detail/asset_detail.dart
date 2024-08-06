// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:turnstileadmin_v2/common/TAppBar.dart';
// import 'package:turnstileadmin_v2/common/TOutlinedButton.dart';
// import '../../../../common/TButton.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/helpers/Thelper_functions.dart';
// import '../QR/qrScreen.dart';
//
// class AssetScreen extends StatefulWidget {
//   const AssetScreen({Key? key}) : super(key: key);
//
//   @override
//   _AssetScreenState createState() => _AssetScreenState();
// }
//
// class _AssetScreenState extends State<AssetScreen> {
//   bool isActive = true;
//   bool dark = false;
//
//   final TextEditingController tagIdController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     dark = THelperFunctions.isDarkMode(context);
//
//     return Scaffold(
//       backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
//       appBar: TAppBar(
//         title: TTexts.assetDetail,
//         leadingIcon: Iconsax.setting,
//         onLeadingIconPressed: () {},
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(TSizes.md),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: TColors.primaryColorBorder,
//                       width: 2,
//                     ),
//                   ),
//                   child: CircleAvatar(
//                     radius: 50,
//                     backgroundColor: Colors.grey[200],
//                     // Specify your image here
//                     child: Icon(
//                       Iconsax.user,
//                       size: 40,
//                       color: Colors.grey, // Hide the icon when the image is loaded
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(height: TSizes.md),
//               Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                       color: Colors.grey[200],
//                       borderRadius: BorderRadius.circular(12)),
//                   height: 40,
//                   width: 150,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Iconsax.camera,
//                         color: Colors.black,
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Text("Change Image",
//                           style: TextStyle(color: Colors.black)),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: TSizes.defaultSpace), // Add space below image
//               // Full Name
//               Row(
//                 children: [
//                   Icon(Iconsax.box),
//                   SizedBox(width: 5), // Add space between icon and text
//                   Text(TTexts.assetName),
//                 ],
//               ),
//               SizedBox(height: TSizes.xs),
//               TextFormField(
//                 cursorColor: TColors.textBlack,
//                 style: TextStyle(color: TColors.textBlack),
//                 decoration: InputDecoration(
//                   hintText: TTexts.assetName,
//                   // Add a hint text for the description
//                   hintStyle:
//                   TextStyle(color: TColors.textBlack.withOpacity(0.5)),
//                   // Hint text style
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 12, // Increased vertical padding
//                     horizontal: 15,
//                   ),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: TSizes.spaceBtwItems),
//               // Company Name
//               Row(
//                 children: [
//                   Icon(Iconsax.menu),
//                   SizedBox(width: 5), // Add space between icon and text
//                   Text(TTexts.category),
//                 ],
//               ),
//               SizedBox(height: TSizes.xs),
//               TextFormField(
//                 cursorColor: TColors.textBlack,
//                 style: TextStyle(color: TColors.textBlack),
//                 decoration: InputDecoration(
//                   hintText: TTexts.category,
//                   // Add a hint text for the description
//                   hintStyle:
//                   TextStyle(color: TColors.textBlack.withOpacity(0.5)),
//                   // Hint text style
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 12, // Increased vertical padding
//                     horizontal: 15,
//                   ),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: TSizes.spaceBtwItems),
//               // Tag ID
//               Row(
//                 children: [
//                   Icon(Iconsax.tag),
//                   SizedBox(width: 5), // Add space between icon and text
//                   Text(TTexts.tagId),
//                 ],
//               ),
//               SizedBox(height: TSizes.xs),
//               TextFormField(
//                 controller: tagIdController,
//                 cursorColor: TColors.textBlack,
//                 style: TextStyle(color: TColors.textBlack),
//                 decoration: InputDecoration(
//                   hintText: TTexts.tagId,
//                   // Add a hint text for the description
//                   hintStyle:
//                   TextStyle(color: TColors.textBlack.withOpacity(0.5)),
//                   // Hint text style
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 12, // Increased vertical padding
//                     horizontal: 15,
//                   ),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: TSizes.spaceBtwItems),
//               Row(
//                 children: [
//                   Icon(Iconsax.document_text),
//                   SizedBox(width: 5), // Add space between icon and text
//                   Text(TTexts.des),
//                 ],
//               ),
//               SizedBox(height: TSizes.xs),
//               TextFormField(
//                 cursorColor: TColors.textBlack,
//                 style: TextStyle(color: TColors.textBlack),
//                 maxLines: null,
//                 // Allows the field to be multiline
//                 keyboardType: TextInputType.multiline,
//                 textAlignVertical: TextAlignVertical.top,
//                 // Aligns text to the top
//                 decoration: InputDecoration(
//                   hintText: 'Enter description',
//                   // Add a hint text for the description
//                   hintStyle:
//                   TextStyle(color: TColors.textBlack.withOpacity(0.5)),
//                   // Hint text style
//                   contentPadding: EdgeInsets.symmetric(
//                     vertical: 20, // Increased vertical padding
//                     horizontal: 15,
//                   ),
//                   filled: true,
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide.none,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                 ),
//               ),
//               SizedBox(height: TSizes.spaceBtwItems),
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "STATUS",
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: TSizes.xs),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             isActive = true;
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: isActive
//                               ? TColors.primaryColorBorder
//                               : TColors.inputBg,
//                           minimumSize: Size(100, 40), // Adjust the size
//                         ),
//                         child: Text(
//                           'Active',
//                           style: TextStyle(
//                               color: !isActive
//                                   ? TColors.primaryColorBorder
//                                   : TColors.inputBg),
//                         ),
//                       ),
//                       SizedBox(width: 10),
//                       ElevatedButton(
//                         onPressed: () {
//                           setState(() {
//                             isActive = false;
//                           });
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: !isActive
//                               ? TColors.primaryColorBorder
//                               : TColors.inputBg,
//                           minimumSize: Size(100, 40), // Adjust the size
//                         ),
//                         child: Text(
//                           'Inactive',
//                           style: TextStyle(
//                               color: !isActive
//                                   ? TColors.textWhite
//                                   : TColors.primaryColorBorder),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: TSizes.spaceBtwSection),
//               TButton(title: TTexts.save, onPressed: () {}),
//               SizedBox(height: TSizes.spaceBtwItems),
//               TOutlinedButton(
//                 title: "Scan QR Code",
//                 onPressed: () async {
//                   final scannedValue = await Get.to(() => QrScanner(
//                     title: TTexts.qrTitle,
//                     subtitle: TTexts.qrSubTitle,
//                   ));
//                   if (scannedValue != null) {
//                     setState(() {
//                       tagIdController.text = scannedValue;
//                     });
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/common/TOutlinedButton.dart';
import 'package:turnstileadmin_v2/common/TButton.dart';
import 'package:turnstileadmin_v2/utils/constants/colors.dart';
import 'package:turnstileadmin_v2/utils/constants/sizes.dart';
import 'package:turnstileadmin_v2/utils/constants/text_strings.dart';
import 'package:turnstileadmin_v2/utils/helpers/Thelper_functions.dart';
import '../QR/qrScreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AssetScreen extends StatefulWidget {
  const AssetScreen({Key? key}) : super(key: key);

  @override
  _AssetScreenState createState() => _AssetScreenState();
}

class _AssetScreenState extends State<AssetScreen> {
  bool isActive = true;
  bool dark = false; // Initialize with default value

  final TextEditingController tagIdController = TextEditingController();
  final TextEditingController assetNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController assetIdController = TextEditingController();
  final TextEditingController siteController = TextEditingController();


  File? _imageFile; // Selected image file

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    dark = THelperFunctions.isDarkMode(context);

    Future<void> _pickImage() async {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _imageFile = File(pickedFile.path);
        }
      });
    }

    Future<void> _submitForm() async {
      final assetName = assetNameController.text;
      final assetId = assetIdController.text;
      final category = categoryController.text;
      final tagId = tagIdController.text;
      final description = descriptionController.text;
      final site = siteController.text;
      final status = isActive ? "active" : "inactive";

      if (assetName.isEmpty || category.isEmpty || tagId.isEmpty || description.isEmpty) {
        Get.snackbar("Error", "Please fill all mandatory fields");
        return;
      }

      var request = http.MultipartRequest('POST', Uri.parse('http://44.214.230.69:8000/asset_api/'));
      request.fields['asset_id'] = assetId;
      request.fields['asset_name'] = assetName;
      request.fields['tag_id'] = tagId;
      request.fields['description'] = description;
      request.fields['asset_category'] = category;
      request.fields['status'] = status;
      request.fields['site'] = site;

      // request.fields['location'] = 'abc';

      if (_imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath('footage', _imageFile!.path));
      }

      var response = await request.send();

      if (response.statusCode == 201) {
        Get.snackbar("Success", "Asset saved successfully", colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      } else {
        // final responseBody = await response.stream.bytesToString();
        Get.snackbar("Error", "Failed to save asset", colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      }
    }



    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: TTexts.assetDetail,
        leadingIcon: Iconsax.setting,
        onLeadingIconPressed: () {},
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
                        width: 2, // Border width
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                      child: _imageFile == null
                          ? Icon(
                        Iconsax.user,
                        size: 40,
                        color: Colors.grey,
                      )
                          : null,
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
                      borderRadius: BorderRadius.circular(12),
                    ),
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
                        Text(
                          "Change Image",
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: TSizes.defaultSpace), // Add space below image
              // Full Name
              Row(
                children: [
                  Icon(Iconsax.box),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.assetName),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: assetNameController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.assetName,
                  // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
                  // Hint text style
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
                  Icon(Iconsax.box),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.site),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: siteController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.site,
                  // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
                  // Hint text style
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
                  Icon(Iconsax.tag),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.assetID),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: assetIdController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.assetID,
                  // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
                  // Hint text style
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
                  Icon(Iconsax.menu),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.category),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: categoryController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.category,
                  // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
                  // Hint text style
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
              TextFormField(
                controller: tagIdController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                decoration: InputDecoration(
                  hintText: TTexts.tagId,
                  // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
                  // Hint text style
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
                  Icon(Iconsax.document_text),
                  SizedBox(width: 5), // Add space between icon and text
                  Text(TTexts.des),
                ],
              ),
              SizedBox(height: TSizes.xs),
              TextFormField(
                controller: descriptionController,
                cursorColor: TColors.textBlack,
                style: TextStyle(color: TColors.textBlack),
                maxLines: null,
                // Allows the field to be multiline
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                // Aligns text to the top
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  // Add a hint text for the description
                  hintStyle: TextStyle(color: TColors.textBlack.withOpacity(0.5)),
                  // Hint text style
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 20, // Increased vertical padding
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
                          backgroundColor: isActive
                              ? TColors.primaryColorBorder
                              : TColors.inputBg,
                          minimumSize: Size(100, 40), // Adjust the size
                        ),
                        child: Text(
                          'Active',
                          style: TextStyle(
                              color: !isActive
                                  ? TColors.primaryColorBorder
                                  : TColors.inputBg),
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
                          backgroundColor: !isActive
                              ? TColors.primaryColorBorder
                              : TColors.inputBg,
                          minimumSize: Size(100, 40), // Adjust the size
                        ),
                        child: Text(
                          'Inactive',
                          style: TextStyle(
                              color: !isActive
                                  ? TColors.textWhite
                                  : TColors.primaryColorBorder),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwSection),
              TButton(
                title: TTexts.save,
                onPressed: _submitForm,
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              TOutlinedButton(
                title: "Scan QR Code",
                onPressed: () async {
                  final scannedValue = await Get.to(() => QrScanner(
                    title: TTexts.qrTitle,
                    subtitle: TTexts.qrSubTitle,
                  ));
                  if (scannedValue != null) {
                    setState(() {
                      tagIdController.text = scannedValue;
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
