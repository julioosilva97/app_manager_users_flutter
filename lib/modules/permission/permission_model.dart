class PermissionModel {
  int? id;
  String? name;

  PermissionModel({this.id, this.name});
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
    };
  }
}
