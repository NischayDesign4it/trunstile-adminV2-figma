import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/features/authentications/screens/forgotPassword.dart';
import 'package:turnstileadmin_v2/features/presentations/screens/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../common/TButton.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controllers/login_controller.dart';
import '../Signup/signup.dart';

class TLoginForm extends StatefulWidget {
  TLoginForm({super.key});

  @override
  _TLoginFormState createState() => _TLoginFormState();
}

class _TLoginFormState extends State<TLoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  bool _rememberMe = false;




  @override
  void initState() {
    super.initState();
    _loadCredentials(); // Load stored credentials when the widget is initialized
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _loadCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';

    if (email.isNotEmpty && password.isNotEmpty) {

      emailController.text = email;
      passwordController.text = password;
      setState(() {
        _rememberMe = true;
      });
    }
  }

  Future<void> _submitForm(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Example validation
    if (email.isEmpty || password.isEmpty) {
      // Handle empty fields
      return;
    }

    // Call the login API service
    bool loggedIn = await APIService.login(email, password);

    if (loggedIn) {
      // Navigate to dashboard on successful login
      Get.to(() => HomePage());
    } else {

      ScaffoldMessenger.of(context).showSnackBar(Get.snackbar(
          "Login failed", "Please check your credentials.",
          colorText: TColors.textWhite,
          backgroundColor: TColors.textBlack) as SnackBar);
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
              controller: emailController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.email,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
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
              controller: passwordController,
              cursorColor: TColors.textBlack,
              style: TextStyle(color: TColors.textBlack),
              decoration: InputDecoration(
                hintText: TTexts.password,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
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
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return TColors.primaryColorButton; // Color when checked
                          }
                          return TColors.textWhite; // Color when unchecked
                        },
                      ),
                      checkColor: TColors.textWhite, // Color of the checkmark
                    ),
                    Text(TTexts.rememberMe),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ForgotPassword());
                  },
                  child: Text(TTexts.forgotPassword),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => Get.to(() => SignupScreen()),
              child: Text(TTexts.dont),
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            TButton(
              title: TTexts.signIn,
              onPressed: () => _submitForm(context),
            ),
          ],
        ),
      ),
    );
  }
}
