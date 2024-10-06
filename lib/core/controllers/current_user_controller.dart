import 'package:get/get.dart';

import '../../features/auth/model/user_model.dart';

class CurrentUserController extends GetxController {
  final Rx<UserModel> _user = UserModel.empty().obs;
  UserModel get user => _user.value;
  set user(UserModel value) => _user.value = value;
}
