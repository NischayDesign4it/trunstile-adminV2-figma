import 'package:flutter/material.dart';
import '../utils/constants/colors.dart';
import '../utils/helpers/Thelper_functions.dart';

class TOutlinedButton extends StatelessWidget {
  const TOutlinedButton({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return SizedBox(
      height: 40,
      width: double.infinity,

      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: TextStyle(
            fontSize: 15,
          ),
          side: BorderSide(
            color: dark ? TColors.textWhite : TColors.primaryColorBorder,
            width: 2,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(color: dark ? TColors.textWhite : TColors.primaryColorBorder),
        ),
      ),
    );
  }
}
