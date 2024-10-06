import 'package:client/core/controllers/current_user_controller.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/view/screens/login_screen.dart';
import 'package:client/features/home/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthWrapper extends GetView<CurrentUserController> {
  const AuthWrapper({super.key});

  static const String routeName = "/";

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.user == UserModel.empty()
          ? const LoginScreen()
          : const HomeScreen(),
    );
  }
}
