


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'dart:convert';

import '../../../../common/TButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/Thelper_functions.dart';
import 'asset_detail.dart';
import 'asset_exit.dart';

class assetManagement extends StatefulWidget {
  const assetManagement({Key? key});

  @override
  State<assetManagement> createState() => _assetManagementState();
}

class _assetManagementState extends State<assetManagement> {
  late List<Map<String, dynamic>> _data = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('http://44.214.230.69:8000/get_assets_api/'));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          _data = List<Map<String, dynamic>>.from(responseData);
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error fetching data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(
        title: 'Asset list',
        leadingIcon: Iconsax.box_add,
        onLeadingIconPressed: () {
          Get.to(() => AssetScreen());
        },
      ),
      body: RefreshIndicator(
        onRefresh: () => fetchData(),
        child: _isLoading
            ? Center(
          child: CircularProgressIndicator(),
        )
            : ListView.builder(
          itemCount: _data.length,
          itemBuilder: (context, index) {
            final asset = _data[index];
            return GestureDetector(
              onTap: () {
                _showAssetDetailsDialog(asset);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListTile(
                  leading: Container(child: _buildAssetImage(asset['picture'])),
                  title: Text(
                    asset['asset_name'],
                    style: TextStyle(fontSize: 20),
                  ),
                  subtitle: Text(
                    'Asset ID: ${asset['asset_id']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  trailing: IconButton(onPressed: () {  }, icon: Icon(Iconsax.trash, color: TColors.redDelete),),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=> ExitStatus());
        },
        child: Icon(Icons.exit_to_app, color: TColors.textWhite,),
        backgroundColor: TColors.primaryColorButton, // Customize the color as needed
      ),
    );
  }

  Widget _buildAssetImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    } else {
      return Image.asset(
        'assets/logo/Asset-demo.jpeg',
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      );
    }
  }

  void _showAssetDetailsDialog(Map<String, dynamic> asset) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(asset['asset_name']),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Asset ID: ${asset['asset_id']}'),
              Text('Description: ${asset['description']}'),
              Text('Category: ${asset['asset_category']}'),
            ],
          ),
          actions: [
            TButton(title: 'Close', onPressed: (){
              Navigator.of(context).pop();

            })
          ],
        );
      },
    );
  }
}
