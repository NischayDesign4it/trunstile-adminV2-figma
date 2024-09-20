import 'dart:convert';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TButton.dart';
import 'package:turnstileadmin_v2/features/presentations/screens/worker_detail/worker_detail.dart';
import 'package:turnstileadmin_v2/utils/constants/sizes.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../common/TAppBar.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import 'edit_worker.dart';

class onSite extends StatefulWidget {

  final String projectName;
  const onSite({Key? key, required this.projectName}) : super(key: key);

  @override
  State<onSite> createState() => _onSiteState();
}

class _onSiteState extends State<onSite> {
  late Map<String, List<Map<String, dynamic>>> _groupedData = {};
  Map<String, bool> _selectedWorkers = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {

      final response = await http.get(Uri.parse('http://44.214.230.69:8000/site_users/${widget.projectName}/'));

      if (response.statusCode == 200) {
        print(widget.projectName);
        final List<dynamic> responseData = json.decode(response.body);

        // Group workers by company name
        Map<String, List<Map<String, dynamic>>> groupedData = {};
        for (var worker in responseData) {
          final companyName = worker['company_name'];
          if (!groupedData.containsKey(companyName)) {
            groupedData[companyName] = [];
          }
          groupedData[companyName]!.add(worker);
        }

        setState(() {
          _groupedData = groupedData;
          _isLoading = false;
          print(_groupedData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  Future<void> _deleteWorker(String email) async {
    try {
      print('Deleting user with email: $email'); // Print the email for debugging

      final response = await http.delete(
        Uri.parse('http://44.214.230.69:8000/delete_user/'),
        body: json.encode({'email': email}),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['message'] == 'User deleted successfully') {
          setState(() {
            fetchData(); // Refresh the worker list after deletion
          });
          Get.snackbar('Success', 'Worker deleted successfully',
              snackPosition: SnackPosition.TOP, colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
        } else {
          throw Exception('Failed to delete worker');
        }
      } else {
        throw Exception('Failed to delete worker');
      }
    } catch (error) {
      print('Error deleting worker: $error');
      Get.snackbar('Error', 'Failed to delete worker',
          snackPosition: SnackPosition.TOP, colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
    }
  }

  // Future<void> _bulkUpdateStatus(String status) async {
  //   try {
  //     final List<Map<String, String>> selectedEmails = _selectedWorkers.entries
  //         .where((entry) => entry.value)
  //         .map((entry) => {'email': entry.key, 'status': status})
  //         .toList();
  //
  //     if (selectedEmails.isEmpty) {
  //       Get.snackbar('No Selection', 'Please select at least one worker.',
  //           snackPosition: SnackPosition.TOP, colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
  //       return;
  //     }
  //
  //     final response = await http.post(
  //       Uri.parse('http://44.214.230.69:8000/bulk_active_inactive/'),
  //       body: json.encode(selectedEmails),
  //       headers: {'Content-Type': 'application/json'},
  //     );
  //
  //     print('Response status code: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       final responseData = json.decode(response.body);
  //
  //       if (responseData['status'] == 'success') {
  //         setState(() {
  //           fetchData(); // Refresh the worker list after updating status
  //           _selectedWorkers.clear(); // Uncheck all checkboxes
  //         });
  //         Get.snackbar('Success', 'Status updated successfully',
  //             snackPosition: SnackPosition.TOP, colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
  //       } else {
  //         throw Exception('Unexpected server response: ${responseData}');
  //       }
  //     } else {
  //       throw Exception('Unexpected response status code: ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error updating status: $error');
  //     Get.snackbar('Error', 'Failed to update status: $error',
  //         snackPosition: SnackPosition.TOP, colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
  //   }
  // }


  void _showDeleteConfirmationDialog(Map<String, dynamic> worker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Worker'),
          content: Text('Are you sure you want to delete ${worker['name']}?'),
          actions: [
            TButton(
              title: 'Delete',
              onPressed: () {
                Navigator.of(context).pop();
                _deleteWorker(worker['email']);
              },
            ),
            SizedBox(height: TSizes.xs),
            TButton(
              title: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: 'ON-Site user',
        leadingIcon: Iconsax.user_add,
        // onLeadingIconPressed: () {
        //   Get.to(() => WorkerScreen());
        // },
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchData(), // Call fetchData method when refreshing
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(
              color: TColors.primaryColorButton), // Loading indicator
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _groupedData.length,
                itemBuilder: (context, index) {
                  final companyName = _groupedData.keys.elementAt(index);
                  final workers = _groupedData[companyName]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 50,
                        color: TColors.inputBg,
                        child: ListTile(
                          title: Text(
                            overflow: TextOverflow.ellipsis,
                            companyName,
                            style: TextStyle(
                              color: TColors.textBlack,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: workers.length,
                        itemBuilder: (context, index) {
                          final worker = workers[index];
                          final isSelected = _selectedWorkers[worker['email']] ?? false;
                          return ListTile(
                            leading: worker['picture'] != null
                                ? CircleAvatar(
                              backgroundImage: NetworkImage(worker['picture']),
                              radius: 25,
                            )
                                : CircleAvatar(
                              child: Icon(Icons.person),
                              radius: 25,
                            ),
                            title: Text(
                              worker['name'],
                              style: TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              'Tag ID: ${worker['tag_id']}',
                              style: TextStyle(fontSize: 16),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Checkbox(
                                //   value: isSelected,
                                //   onChanged: (bool? value) {
                                //     setState(() {
                                //       _selectedWorkers[worker['email']] = value ?? false;
                                //     });
                                //   },
                                //   fillColor: MaterialStateProperty.resolveWith<Color>(
                                //         (Set<MaterialState> states) {
                                //       if (states.contains(MaterialState.selected)) {
                                //         return TColors.primaryColorButton; // Color when checked
                                //       }
                                //       return TColors.textWhite; // Color when unchecked
                                //     },
                                //   ),
                                //   checkColor: TColors.textWhite,
                                // ),
                                IconButton(
                                  onPressed: () {
                                    _showDeleteConfirmationDialog(worker);
                                  },
                                  icon: Icon(Iconsax.trash,
                                      color: TColors.redDelete),
                                ),
                              ],
                            ),
                            onTap: () {
                              _showWorkerDetailsDialog(worker);
                            },
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(25.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //     children: [
            //       Expanded(
            //         child: TButton(
            //           title: 'Active',
            //           onPressed: () {
            //             _bulkUpdateStatus('active');
            //           },
            //         ),
            //       ),
            //       SizedBox(width: 8.0),
            //       Expanded(
            //         child: TButton(
            //           title: 'Inactive',
            //           onPressed: () {
            //             _bulkUpdateStatus('inactive');
            //           },
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showWorkerDetailsDialog(Map<String, dynamic> worker) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(worker['name']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Tag ID: ${worker['tag_id']}'),
              Text('Timestamp: ${worker['timestamp']}'),
              Text('Site Name: ${worker['site']}'),
              Text('Status: ${worker['status']}'),

              GestureDetector(
                onTap: () {
                  _launchDocument(worker['orientation']);
                },
                child: Text(
                  'Orientation: View Document',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TButton(
              title: 'Edit',
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.to(() => EditWorkerScreen(worker: worker, projectName: widget.projectName,));

              },
            ),
            SizedBox(height: TSizes.sm),
            TButton(
              title: 'Close',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchDocument(String? url) async {
    if (url != null && url.isNotEmpty) {
      final uri = Uri.parse(url);
      if (await launcher.canLaunchUrl(uri)) {
        await launcher.launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } else {
      print('URL is null or empty');
    }
  }
}



