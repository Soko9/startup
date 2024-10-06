import 'package:client/core/values/app_extensions.dart';
import 'package:client/core/widgets/bb_loader.dart';
import 'package:client/features/auth/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/widgets/bb_button.dart';
import '../../../../core/widgets/bb_form_field.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const String routeName = "/register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthController get controller => Get.find<AuthController>();

  @override
  void dispose() {
    _nameController.dispose();
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
                      Get.offAllNamed(LoginScreen.routeName);
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "already have an account".toUpperCase(),
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
                  "sign up.".toUpperCase(),
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
                        controller: _nameController,
                        hint: "name",
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Empty Name".toUpperCase();
                          }
                          return null;
                        },
                      ),
                      12.gapV,
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
                    label: "sign up",
                    callback: () async {
                      if (_formKey.currentState!.validate()) {
                        await controller.signup(
                          name: _nameController.text.trim(),
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
