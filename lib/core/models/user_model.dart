class UserModel {
  int userId;
  String name;
  String email;
  String phone;
  String profilePicUrl;
  String deviceId;
  bool isOnline;
  List<dynamic> blocked;
  bool isAdmin;

  UserModel({
    this.name,
    this.email,
    this.phone,
    this.profilePicUrl,
    this.userId,
    this.isOnline = false,
    this.isAdmin,
    this.deviceId,
  });

  UserModel.fromMap(Map<dynamic, dynamic> map)
      : userId = map['userId'],
        name = map['name'],
        phone = map['phone'],
        email = map['email'],
        isAdmin = map['isAdmin'],
        blocked = map['blocked'] ?? List(),
        isOnline = map['isOnline'] ?? false,
        profilePicUrl = map['profilePicUrl'];

  UserModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        name = json['name'],
        phone = json['phone'],
        isOnline = json['isOnline'] ?? false,
        isAdmin = json['isAdmin'],
        email = json['email'],
        profilePicUrl = json['profilePicUrl'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['userId'] = this.userId;
    data['name'] = this.name;
    data['isAdmin'] = this.isAdmin;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['profilePicUrl'] = this.profilePicUrl;
    return data;
  }

  @override
  String toString() => '${this.runtimeType}(${this.toJson()})';
}
