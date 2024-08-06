import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';

import '../../../../common/TButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../Login/Login.dart';

class TSignupForm extends StatefulWidget {
  TSignupForm({Key? key}) : super(key: key);

  @override
  _TSignupFormState createState() => _TSignupFormState();
}

class _TSignupFormState extends State<TSignupForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController companyNameController = TextEditingController();
  final TextEditingController companyIDController = TextEditingController();
  final TextEditingController jobRoleController = TextEditingController();
  final TextEditingController jobLocationController = TextEditingController();
  final TextEditingController tagIDController = TextEditingController();
  bool _obscureText = true; // Initial state for password visibility

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }


  Future<void> signupUser() async {
    final url = 'http://44.214.230.69:8000/signup_new/'; // Replace with your API endpoint
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'email': emailController.text,
      'name': nameController.text,
      'company_name': companyNameController.text,
      'job_role': jobRoleController.text,
      'mycompany_id': companyIDController.text,
      'tag_id': tagIDController.text,
      'job_location': jobLocationController.text,
      'password': passwordController.text,
    });

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        // Handle success
        Get.snackbar('Success', 'Account created successfully', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
        Get.to(() => LoginScreen()); // Navigate to LoginScreen on success
      } else if (response.statusCode == 400) {
        // Log the response body for debugging
        print('Response body: ${response.body}');
        Get.snackbar('Error', 'Invalid data provided', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      } else if (response.statusCode == 409) {
        // Conflict - Email already exists
        Get.snackbar('Error', 'Email already exists', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      } else {
        // Other errors
        Get.snackbar('Error', 'Failed to create account', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      }
    } catch (e) {
      // Handle network error
      Get.snackbar('Error', 'Network error', colorText: TColors.textWhite, backgroundColor: TColors.textBlack);
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: TSizes.spaceBtwSection),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.name,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.user),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: emailController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.email,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                prefixIcon: Icon(Iconsax.direct_right),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: companyNameController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.companyName,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.building),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: companyIDController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.companyID,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.tag),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: jobRoleController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.jobRole,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.user_square),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: jobLocationController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.jobLocation,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.location),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: tagIDController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.tagId,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.tag),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: TSizes.spaceBtwInputFields),
            TextFormField(
              controller: passwordController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.password,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
                prefixIcon: Icon(Iconsax.password_check),
                suffixIcon: GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _obscureText ? Iconsax.eye : Iconsax.eye_slash,
                  ),
                ),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              obscureText: _obscureText, // Manage password visibility
            ),
            SizedBox(height: TSizes.spaceBtwInputFields / 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(value: false, onChanged: (value) {}),
                    Text(TTexts.rememberMe),
                  ],
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(TTexts.forgotPassword),
                ),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TButton(
              title: TTexts.createAcc,
              onPressed: signupUser, // Call the signupUser method
            ),
          ],
        ),
      ),
    );
  }
}
