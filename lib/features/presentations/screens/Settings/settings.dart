import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:turnstileadmin_v2/common/TAppBar.dart';
import 'package:turnstileadmin_v2/utils/constants/sizes.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/helpers/Thelper_functions.dart';


class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      appBar: TAppBar(title: 'Settings'),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.fontSizeLg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Iconsax.star),
                SizedBox(width: TSizes.sm),
                Text("Rate us"),
                Spacer(),
                Icon(Iconsax.arrow_right),
              ],
            ),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Icon(Iconsax.lock),
                SizedBox(width: TSizes.sm),
                Text("Privacy policy"),
                Spacer(),
                Icon(Iconsax.arrow_right),
              ],
            ),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Icon(Iconsax.warning_2),
                SizedBox(width: TSizes.sm),
                Text("Disclaimer"),
                Spacer(),
                Icon(Iconsax.arrow_right),
              ],
            ),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Icon(Iconsax.message_question),
                SizedBox(width: TSizes.sm),
                Text("FAQ"),
                Spacer(),
                Icon(Iconsax.arrow_right),
              ],
            ),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            Row(
              children: [
                Icon(Iconsax.call),
                SizedBox(width: TSizes.sm),
                Text("Contact us"),
                Spacer(),
                Icon(Iconsax.arrow_right),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Iconsax.logout, color: Colors.red),
                SizedBox(width: TSizes.sm),
                Text("Log out", style: TextStyle( color: Colors.red)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
