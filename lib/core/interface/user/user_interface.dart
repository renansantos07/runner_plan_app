import 'dart:io';

import 'package:runner_plan_app/core/model/common/session_user_model.dart';
import 'package:runner_plan_app/core/service/user/user_service.dart';

abstract class UserInterface {
  Future<void> savePersonalUser(SessionUser user);
  Future<String?> uploadUserImage(File? image);

  factory UserInterface() {
    return UserService();
  }
}
