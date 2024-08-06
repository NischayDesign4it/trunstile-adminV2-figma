import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/constants/sizes.dart';
import '../utils/device/device_utility.dart';
import '../utils/helpers/Thelper_functions.dart';

class TAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TAppBar({super.key, required this.title,  this.leadingIcon,  this.onLeadingIconPressed});

  final IconData? leadingIcon;
  final String title;
  final VoidCallback? onLeadingIconPressed;


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return AppBar(
      backgroundColor: dark ? TColors.textBlack : TColors.textWhite,
      title: Row(
        children: [
          Text(title, style: TextStyle(fontSize: TSizes.lg)),
          Spacer(),
          IconButton(onPressed: onLeadingIconPressed, icon: Icon(leadingIcon)),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
