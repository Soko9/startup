import 'package:client/core/values/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/bb_button.dart';
import '../../../../core/widgets/bb_form_field.dart';
import '../../../../core/widgets/bb_loader.dart';
import '../../controller/auth_controller.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthController get controller => Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.offAllNamed(RegisterScreen.routeName);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "don't have an account".toUpperCase(),
                          style: const TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                        8.gapH,
                        Text(
                          "→",
                          style: TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                64.gapV,
                Text(
                  "login.".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                24.gapV,
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: controller.isLoading
                        ? const BBLoader()
                        : controller.error.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .errorContainer,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  controller.error,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onErrorContainer,
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      BBFormField(
                        controller: _emailController,
                        hint: "email",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Empty Email".toUpperCase();
                          }
                          if (!GetUtils.isEmail(value)) {
                            return "Invalid Email Pattern".toUpperCase();
                          }
                          return null;
                        },
                      ),
                      12.gapV,
                      BBFormField(
                        controller: _passwordController,
                        hint: "password",
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Empty Password".toUpperCase();
                          }
                          if (value.length < 6) {
                            return "Password Must Contain At Least 6 Characters"
                                .toUpperCase();
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                24.gapV,
                Align(
                  alignment: Alignment.centerRight,
                  child: BBButton(
                    label: "login",
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.signin(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                      }
                    },
                    icon: Icons.last_page_outlined,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
