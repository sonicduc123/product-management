class UserModel {
  String? id;
  String? email;
  String? name;
  String? avatar;
  String? role;

  UserModel({
    this.id,
    this.email,
    this.name,
    this.avatar,
    this.role,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    avatar = json['avatar'];
    role = json['role'];
  }
}
