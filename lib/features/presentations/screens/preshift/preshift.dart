import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/features/presentations/models/project.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher package
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/common/TButton.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import '../../../authentications/screens/Login/TFormDivider.dart';

class PreShiftScreen extends StatefulWidget {
  final Project project;
  const PreShiftScreen({super.key, required this.project});

  @override
  State<PreShiftScreen> createState() => _PreShiftScreenState();
}

class _PreShiftScreenState extends State<PreShiftScreen> {
  late List<dynamic> toolDocLinks;
  late DateTime selectedDate;
  bool isLoading = false;
  bool isUploading = false;
  File? _selectedFile;
  String selectedProject = 'PROJECT 1';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    toolDocLinks = [];
    _callToolBoxAPI(widget.project);
  }


  Future<void> _callToolBoxAPI(Project project) async {
    setState(() {
      isLoading = true;
    });

    final uri = Uri.parse('http://44.214.230.69:8000/preshift_api/${project.name}/');
    print('Requesting URL: $uri');
    final response = await http.get(uri);

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      print('Response Data: $responseData');

      final filteredDocs = responseData.where((doc) {
        DateTime docDate = DateTime.parse(doc['date']).toLocal();
        DateTime selectedDateLocal = selectedDate.toLocal();
        print('Document Date: $docDate, Selected Date: $selectedDateLocal'); // Debug print
        return docDate.year == selectedDateLocal.year &&
            docDate.month == selectedDateLocal.month &&
            docDate.day == selectedDateLocal.day;
      }).toList();

      print('Filtered Docs: $filteredDocs');

      setState(() {
        toolDocLinks = filteredDocs;
        isLoading = false;
      });

      if (filteredDocs.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Documents Not Available'),
              content: Text('No documents available for the selected date.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      print('Failed to load data from API');
      setState(() {
        isLoading = false;
      });
    }
  }


  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _callToolBoxAPI(widget.project); // Call API with the newly selected date
      });
    }
  }

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
            content: Text('Please select a file to upload.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
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
      isUploading = true;
    });

    var url = Uri.parse('http://44.214.230.69:8000/preshift_api/');
    var request = http.MultipartRequest('POST', url)
      ..fields['site'] = widget.project.name
      ..files.add(await http.MultipartFile.fromPath(
        'document',
        _selectedFile!.path,
      ));

    var response = await request.send();

    if (response.statusCode == 201) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Successful'),
            content: Text('The document has been uploaded successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() {
        _selectedFile = null;
        _callToolBoxAPI(widget.project);
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Upload Rejected'),
            content: Text('Failed to upload file. Please check the format and try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    setState(() {
      isUploading = false;
    });
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
          style: TextStyle(
            color: dark ? TColors.textWhite : TColors.textBlack,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Text(
                _selectedFile!.path.split('/').last,
                style: TextStyle(
                  color: dark ? TColors.textWhite : TColors.textBlack,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis, // Handle long file names
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: 'PreShift',
        leadingIcon: Iconsax.calendar_edit,
        onLeadingIconPressed: () => _selectDate(context),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: TSizes.sm,),
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
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: TSizes.spaceBtwSection),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Iconsax.document_text),
                            SizedBox(height: TSizes.sm),
                            Text("Upload new PreShift here"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems),
                TDivider(dark: dark),
                SizedBox(height: TSizes.spaceBtwItems),
                _buildSelectedFileWidget(),
              ],
            ),
          ),
          if (_selectedFile != null)
            Padding(
              padding: EdgeInsets.only(right: TSizes.lg, left: TSizes.lg),
              child: isUploading
                  ? Center(child: CircularProgressIndicator(
                color: TColors.primaryColorButton,
              ))
                  : TButton(
                  title: "Upload your document", onPressed: _uploadFile),
            ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
              padding: EdgeInsets.all(10),
              itemCount: toolDocLinks.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                final docLink = toolDocLinks[index]['document'];

                // Ensure docLink is a Uri
                Uri uri = Uri.parse(docLink ?? '');

                return GestureDetector(
                  onTap: () async {
                    print('Attempting to launch URL: $uri');
                    try {
                      final bool canLaunchUrl = await launchUrl(uri);
                      print('Can launch URL: $canLaunchUrl');
                      if (canLaunchUrl) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      } else {
                        print('Cannot launch URL');
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to launch document.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    } catch (e) {
                      print('Error launching URL: $e');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error'),
                            content: Text('Failed to launch document: $e'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },

                  child: Container(
                    padding: EdgeInsets.all(12),
                    color: Colors.grey[200],
                    child: Row(
                      children: [
                        Icon(Iconsax.document_text, color: TColors.textBlack,),
                        SizedBox(width: 10),
                        Text("View Document", style: TextStyle(color: TColors.textBlack),),
                        // Display original document name
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

