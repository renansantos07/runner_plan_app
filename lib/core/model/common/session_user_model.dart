import 'package:runner_plan_app/core/model/personal/personal_modal.dart';

class SessionUser {
  final String id;
  final String name;
  final String email;
  final String imageURL;
  final PersonalModel? personal;

  const SessionUser(
      {required this.id,
      required this.name,
      required this.email,
      this.imageURL = "assets/images/avatar.png",
      this.personal});
}
