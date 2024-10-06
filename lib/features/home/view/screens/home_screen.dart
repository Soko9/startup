import 'package:client/core/controllers/current_user_controller.dart';
import 'package:client/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const String routeName = "/home";

  CurrentUserController get currentUserController =>
      Get.find<CurrentUserController>();

  AuthController get authController => Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final user = currentUserController.user;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                authController.signout();
              },
              icon: const Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          "${user.name.toUpperCase()}\n${user.email}",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }
}
