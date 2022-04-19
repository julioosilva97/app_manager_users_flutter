import 'package:manager_users/modules/profile/profile_model.dart';
import 'package:manager_users/modules/user/user_form_page.dart';

class UserModel {
  int? id;
  String name;
  String email;
  String? password;
  bool enabled;
  ProfileModel? profile;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.password,
    required this.enabled,
  });
}
