import 'package:client/core/controllers/current_user_controller.dart';
import 'package:client/features/auth/controller/auth_controller.dart';
import 'package:client/features/auth/repo/auth_local_repo.dart';
import 'package:client/features/auth/repo/auth_remote_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppBindings implements Bindings {
  @override
  Future<void> dependencies() async {
    // Services
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Get.put<SharedPreferences>(sharedPreferences);

    // Repos
    Get.put<AuthRemoteRepo>(AuthRemoteRepo());
    Get.put<AuthLocalRepo>(
      AuthLocalRepo(sharedPreferences: Get.find<SharedPreferences>()),
    );

    // Controllers
    Get.put<CurrentUserController>(CurrentUserController());
    Get.put<AuthController>(
      AuthController(
        authRemoteRepo: Get.find<AuthRemoteRepo>(),
        authLocalRepo: Get.find<AuthLocalRepo>(),
        currentUserController: Get.find<CurrentUserController>(),
      ),
    );

    await Get.find<AuthController>().getCurrentUser();
  }
}
