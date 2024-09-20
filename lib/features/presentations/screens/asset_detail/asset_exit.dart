import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:http/http.dart' as http;
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/Thelper_functions.dart';

class ExitStatus extends StatefulWidget {

  final String projectName;
  const ExitStatus({Key? key, required this.projectName}) : super(key: key);

  @override
  State<ExitStatus> createState() => _ExitStatusState();
}

class _ExitStatusState extends State<ExitStatus> {
  late List<Map<String, dynamic>> _data = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await http.get(Uri.parse('http://44.214.230.69:8000/exits/${widget.projectName}/'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        print(responseData);
        setState(() {
          _data = List<Map<String, dynamic>>.from(responseData);
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await fetchData();
  }


  void _handleImageTap(String imageUrl) async {
    if (imageUrl.isNotEmpty && await canLaunchUrl(Uri.parse(imageUrl))) {
      await launchUrl(Uri.parse(imageUrl));
    } else {
      Get.snackbar(
        'Error',
        'Image not available',
        snackPosition: SnackPosition.TOP,
        backgroundColor: TColors.textBlack,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(title: 'Exit Status',),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(
        color: TColors.primaryColorButton,
      ))
          : RefreshIndicator(
        onRefresh: _refreshData,
        child: ListView(
          children: [
            SizedBox(height: 20.0),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: [
                  DataColumn(label: Text("SR No.")),
                  DataColumn(label: Text("Asset ID")),
                  DataColumn(label: Text("Tag ID")),
                  DataColumn(label: Text("Asset Name")),
                  DataColumn(label: Text("Location")),
                  DataColumn(label: Text("Time")),
                  DataColumn(label: Text("Footage")),
                ],
                rows: _data.asMap().entries.map((entry) {
                  int serialNumber = entry.key + 1;
                  Map<String, dynamic> data = entry.value;
                  return DataRow(cells: [
                    DataCell(Text(serialNumber.toString())),
                    DataCell(Text(data['asset_id'].toString())),
                    DataCell(Text(data['tag_id'].toString())),
                    DataCell(Text(data['asset_name'].toString())),
                    DataCell(Text(data['location'].toString())),
                    DataCell(Text(data['time_log'].toString())),
                    DataCell(
                      GestureDetector(
                        onTap: () {
                          _handleImageTap(data['footage'].toString());
                        },
                        child: Text(
                          'View Image',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
