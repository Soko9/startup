import 'package:client/core/controllers/current_user_controller.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:client/features/auth/repo/auth_local_repo.dart';
import 'package:client/features/auth/repo/auth_remote_repo.dart';
import 'package:client/features/home/view/screens/home_screen.dart';
import 'package:get/get.dart';

import '../view/screens/login_screen.dart';

class AuthController extends GetxController {
  final AuthRemoteRepo _authRemoteRepo;
  final AuthLocalRepo _authLocalRepo;
  final CurrentUserController _currentUserController;

  AuthController({
    required AuthRemoteRepo authRemoteRepo,
    required AuthLocalRepo authLocalRepo,
    required CurrentUserController currentUserController,
  })  : _authRemoteRepo = authRemoteRepo,
        _authLocalRepo = authLocalRepo,
        _currentUserController = currentUserController;

  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;
  set isLoading(bool value) => _isLoading.value = value;

  final RxString _error = "".obs;
  String get error => _error.value;
  set error(String value) => _error.value = value;
  void clearError() {
    error = "";
  }

  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    isLoading = true;
    clearError();
    final either = await _authRemoteRepo.signup(
      name: name,
      email: email,
      password: password,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (userModel) {
        _currentUserController.user = userModel;
        Get.offAllNamed(LoginScreen.routeName);
      },
    );
    isLoading = false;
  }

  Future<void> signin({
    required String email,
    required String password,
  }) async {
    isLoading = true;
    clearError();
    final either = await _authRemoteRepo.signin(
      email: email,
      password: password,
    );

    either.fold(
      (failure) {
        error = failure.message;
      },
      (userModel) {
        _authLocalRepo.setToken(token: userModel.token);
        _currentUserController.user = userModel;
        Get.offAllNamed(HomeScreen.routeName);
      },
    );
    isLoading = false;
  }

  Future<UserModel?> getCurrentUser() async {
    isLoading = true;
    clearError();
    final token = _authLocalRepo.getToken();
    if (token == null) {
      error = "No token found";
      return null;
    }

    final either = await _authRemoteRepo.getCurrentUser(token: token);
    UserModel? currentUserModel;
    either.fold(
      (failure) {
        error = failure.message;
        currentUserModel = null;
      },
      (userModel) {
        _currentUserController.user = userModel;
        currentUserModel = userModel;
      },
    );
    isLoading = false;
    return currentUserModel;
  }
}
