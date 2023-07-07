import 'package:runner_plan_app/core/model/personal/personal_modal.dart';

class SessionUser {
  String id;
  String name;
  String surname;
  String email;
  String imageURL;

  SessionUser(
      {required this.id,
      required this.name,
      required this.surname,
      required this.email,
      this.imageURL = "assets/images/avatar.png"});
}
