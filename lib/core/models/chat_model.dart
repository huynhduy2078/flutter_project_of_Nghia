import 'package:flutter/material.dart';

class ChatModel {
  String id;
  String username;
  String message;
  DateTime timestamp;

  ChatModel({
    required this.id,
    required this.username,
    required this.message,
    required this.timestamp,
  });

  fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    message = json['message'];
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
    data['timestamp'] = this.timestamp.millisecondsSinceEpoch;
    return data;
  }
}
