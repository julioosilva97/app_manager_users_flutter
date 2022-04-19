import 'package:flutter/foundation.dart';
import 'package:manager_users/modules/profile/profile_model.dart';

class ProfileProvider extends ChangeNotifier {
  List<ProfileModel> profiles = [
    ProfileModel(id: 1, name: 'name 1'),
    ProfileModel(id: 2, name: 'name 2 '),
    ProfileModel(id: 3, name: 'name 3'),
  ];

  ProfileModel? profileSelected;

  ProfileModel? currentProfile;

  getProfiles() {
    return profiles;
  }

  addProfile(ProfileModel profileModel) {
    profiles.add(profileModel);
    notifyListeners();
  }

  ProfileModel? getProfileSelected() {
    return profileSelected;
  }

  void setProfileSelected(ProfileModel? profileSelected) {
    this.profileSelected = profileSelected;
    notifyListeners();
  }

  void setCurrentProfile(ProfileModel? currentProfile) {
    this.currentProfile = currentProfile;
    notifyListeners();
  }

  ProfileModel? getCurrentProfile() {
    return currentProfile ?? null;
  }

  void deleteProfile(ProfileModel profile) {
    this.profiles.remove(profile);
    notifyListeners();
  }
}
