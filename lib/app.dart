import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:turnstileadmin_v2/features/presentations/screens/home/entryScreen.dart';
import 'package:turnstileadmin_v2/utils/theme/theme.dart';



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: EntryScreen(),
      title: "Turn-adminV2",
    );
  }
}
