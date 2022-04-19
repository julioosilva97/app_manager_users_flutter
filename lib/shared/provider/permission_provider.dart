import 'package:flutter/foundation.dart';
import 'package:manager_users/modules/permission/permission_model.dart';
import 'package:manager_users/modules/profile/profile_model.dart';

class PermissionProvider extends ChangeNotifier {
  List<PermissionModel> permissions = [
    PermissionModel(id: 1, name: 'permissão 1'),
    PermissionModel(id: 2, name: 'permissão 2'),
    PermissionModel(id: 3, name: 'permissão 3'),
  ];

  PermissionModel? currentPermission;

  List<PermissionModel> getPermissions() {
    return permissions;
  }

  void addPermission(PermissionModel permission) {
    permissions.add(permission);
    notifyListeners();
  }

  void setCurrentPermission(PermissionModel? permissionModel) {
    this.currentPermission = permissionModel;
    notifyListeners();
  }

  PermissionModel? getCurrentPermission() {
    return currentPermission ?? null;
  }

  void deletePermission(PermissionModel permissionModel) {
    this.permissions.remove(permissionModel);
    notifyListeners();
  }
}
