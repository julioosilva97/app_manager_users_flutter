import 'package:flutter/foundation.dart';
import 'package:manager_users/modules/user/user_model.dart';

class UserProvider extends ChangeNotifier {
  List<UserModel> users = [];
  UserModel? currentUser;

  List<UserModel> getUsers() {
    return users;
  }

  void addUser(UserModel user) {
    users.add(user);
    notifyListeners();
  }

  void updateUser(UserModel user) {
    //TODO
  }

  void deleteUser(UserModel user) {
    users.remove(user);
    notifyListeners();
  }

  UserModel? getCurrentUser() {
    return currentUser ?? null;
  }

  void setCurrentUser(UserModel? user) {
    currentUser = user;
    notifyListeners();
  }
}
