import 'package:client/features/auth/view/screens/auth_wrapper.dart';
import 'package:client/features/auth/view/screens/login_screen.dart';
import 'package:client/features/auth/view/screens/register_screen.dart';
import 'package:client/features/home/view/screens/home_screen.dart';
import 'package:get/get.dart';

abstract class AppNavigation {
  static List<GetPage> get pages => [
        GetPage(
          name: AuthWrapper.routeName,
          page: () => const AuthWrapper(),
        ),
        GetPage(
          name: LoginScreen.routeName,
          page: () => const LoginScreen(),
        ),
        GetPage(
          name: RegisterScreen.routeName,
          page: () => const RegisterScreen(),
        ),
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
        ),
      ];
}
