class TypingModel {
  String id;
  String username;
  bool typing;

  TypingModel({required this.id, required this.username, required this.typing});

  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    typing = json['typing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['typing'] = this.typing;
    return data;
  }
}
