import 'package:manager_users/modules/permission/permission_model.dart';

class ProfileModel {
  int? id;
  String name;
  List<PermissionModel>? permissions;

  ProfileModel({
    this.id,
    required this.name,
    this.permissions,
  });
}
