import 'package:flutter/material.dart';

class ChatModel {
  String id;
  String username;
  String message;
  bool isMe;
  DateTime timestamp;
  int icon;

  ChatModel({
    this.id,
    this.isMe,
    this.username,
    this.message,
    this.icon,
    this.timestamp,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    isMe = json['isMe'];
    message = json['message'];
    icon = json['icon'];
    if (json['timestamp'] != null) {
      timestamp = DateTime.fromMillisecondsSinceEpoch(json['timestamp']);
    } else {
      timestamp = this.timestamp;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['message'] = this.message;
    data['icon'] = this.icon;
    data['timestamp'] = this.timestamp.millisecondsSinceEpoch;
    return data;
  }
}
