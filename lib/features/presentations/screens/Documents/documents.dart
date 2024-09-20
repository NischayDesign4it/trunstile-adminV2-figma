import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;
import 'package:turnstileadmin_v2/common/TButton.dart';
import 'package:turnstileadmin_v2/features/presentations/models/project.dart';

import '../../../../common/TAppBar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../../../authentications/screens/Login/TFormDivider.dart';


class DocumentPage extends StatefulWidget {
  final Project project;
  DocumentPage({Key? key, required this.project}) : super(key: key);

  @override
  _DocumentPageState createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  File? _selectedFile;
  bool _isLoading = false;
  Future<void> _selectFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }


  Future<void> _uploadFile() async {
    if (_selectedFile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Rejected'),
            content: Text('Please upload the file'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse('http://44.214.230.69:8000/post_orientation_sheet/');
    var request = http.MultipartRequest('POST', url)
      ..files.add(await http.MultipartFile.fromPath(
        'attachments',
        _selectedFile!.path,
      ))
    ..fields['site'] = widget.project.name;


    try {
      var response = await request.send();
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 201) {
        // File uploaded successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Upload Successful'),
              content: Text('The document has been uploaded successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      _selectedFile = null; // Clear selected file
                    });
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Handle other status codes (if needed)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Upload Failed'),
              content: Text('Failed to upload document. Please try again later.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error uploading file: $e');
      setState(() {
        _isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Failed'),
            content: Text('An error occurred while uploading. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }



  Widget _buildSelectedFileWidget() {
    final dark = THelperFunctions.isDarkMode(context);
    if (_selectedFile == null) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected File:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Icon(Iconsax.document_text), // Replace with appropriate file icon
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedFile!.path.split('/').last, // Display file name
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${(_selectedFile!.lengthSync() / 1024).toStringAsFixed(2)} KB', // Display file size
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Iconsax.close_circle), 
              onPressed: () {
                setState(() {
                  _selectedFile = null;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 16),
        _isLoading

            ? Center(child: CircularProgressIndicator(
          color:  dark ? TColors.textWhite : TColors.primaryColorButton,
        )) // Show loading indicator if uploading
            : TButton(title: "Upload", onPressed: _uploadFile),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    print(widget.project.name);

    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: "Orientation",
        leadingIcon: Iconsax.notification, onLeadingIconPressed: () {  },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DottedBorder(
              borderType: BorderType.RRect,
              radius: Radius.circular(12),
              dashPattern: [6, 3],
              color: dark ? TColors.textWhite : TColors.textBlack,
              strokeWidth: 2,
              child: GestureDetector(
                onTap: _selectFile,
                child: Container(
                  height: 150,
                  width: 350,
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: TSizes.spaceBtwSection),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Iconsax.document_text),
                        Text("Upload new orientation here"),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TDivider(dark: dark),
            SizedBox(height: TSizes.spaceBtwItems),

            Expanded(child: _buildSelectedFileWidget()),
            // TButton(title: "ToolBox", onPressed: () => Get.to(() => ToolBoxScreen())),
            // SizedBox(height: TSizes.sm),
            // TButton(title: "PreShift", onPressed: () => Get.to(() => PreShiftScreen())),
            //

          ],
        ),
      ),
    );
  }
}




