import 'package:client/app_bindings.dart';
import 'package:client/config/navigation/app_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppBindings().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MusicApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darktheme,
      themeMode: ThemeMode.light,
      initialRoute: "/",
      getPages: AppNavigation.pages,
    );
  }
}
