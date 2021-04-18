import 'dart:async';
import 'dart:io';

import 'package:chat_messanger_ui/core/models/chat_model.dart';
import 'package:chat_messanger_ui/core/models/typing_model.dart';
import 'package:chat_messanger_ui/pages/chat/message_item.dart';
import 'package:flutter/material.dart';

import 'package:socket_io_client/socket_io_client.dart';
import 'package:username_gen/username_gen.dart';

class ChatViewModel extends ChangeNotifier {
  TextEditingController txt = TextEditingController();

  final username = UsernameGen.gen();

  List<MessageItem> _messages = [];
  List<MessageItem> get messages => _messages;

  set messages(List<MessageItem> val) {
    _messages = val;
    notifyListeners();
  }

  Socket _socket;
  Socket get socket => _socket;
  set socket(Socket val) {
    _socket = val;
    notifyListeners();
  }

  String _typing = '';
  String get typing => _typing;
  set typing(String val) {
    _typing = val;
    notifyListeners();
  }

  Timer _debounce;
  Timer get debounce => _debounce;
  set debounce(Timer val) {
    _debounce = val;
    notifyListeners();
  }

  void connectToServer() {
    // try {
    //   socket = io('http://127.0.0.1:3000', <String, dynamic>{
    //     'transports': ['websocket'],
    //     'autoConnect': false,
    //   });
    //   socket.connect();
    //   socket.on('connect', (_) => print('connect: ${socket.id}'));
    //   socket.on('typing', handleTyping);
    //   socket.on('message', handleMessage);
    //   socket.on('disconnect', (_) => print('disconnect'));
    //   socket.on('fromServer', (_) => print(_));
    // } catch (e) {
    //   print(e.toString());
    // }
    //

// list of messages

    getAllMessage(fakeMessage);
    //handleMessage(fakeMessage);
  }

  sendTyping(bool typing) {
    socket.emit(
        "typing",
        TypingModel(
          id: socket.id,
          username: username,
          typing: typing,
        ).toJson());
  }

  void handleTyping(data) {
    final typingModel = TypingModel.fromJson(data);

    if (!isMe(typingModel.id) && typingModel.typing) {
      typing = '${typingModel.username} is typing...';
    } else if (!isMe(typingModel.id) && !typingModel.typing) {
      typing = '';
    }
  }

  // Handle Messages

  sendMessage() {
    try {
      if (txt.text.length == 0) {
        return;
      }
      sendTyping(false);
      socket.emit(
        "message",
        ChatModel(
          id: socket.id,
          message: txt.text,
          timestamp: DateTime.now(),
          username: username,
        ).toJson(),
      );
      txt.clear();
    } catch (e) {}
  }

  void handleMessage(data) {
    // try {
    //   var msg = ChatModel.fromJson(data);
    //   messages.insert(
    //     0,
    //     MessageItem(
    //       //isMe: isMe(msg.id),
    //       message: msg,
    //     ),
    //   );
    //   notifyListeners();
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  void getAllMessage(data) {
    try {
      for (var i = 0; i < data.length; i++) {
        messages.add(
          MessageItem(
            //isMe: isMe(msg.id),
            message: fakeMessage[i],
          ),
        );
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  getLassMessageById(username) {}

  void updateIconMessage(idMessage, icon) {}

  bool isMe(String id) => id == socket.id;

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  List<ChatModel> fakeMessage = [
    ChatModel(
      id: "user1_user2_1",
      isMe: true,
      username: "huunghia8896@gmail.com",
      message: "Xin chào",
      icon: 0,
    ),
    ChatModel(
      id: "user1_user2_2",
      isMe: false,
      username: "huunghia8896@gmail.com",
      message: "Chào cậu",
      icon: 0,
    ),
    ChatModel(
      id: "user1_user2_3",
      isMe: true,
      username: "huunghia8896@gmail.com",
      message: "Làm quen nhé, Bạn có người yêo chưa :D",
      icon: 4,
    ),
  ];
}
