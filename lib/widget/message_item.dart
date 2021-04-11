import 'dart:math';

import 'package:chat_messanger_ui/constant/evenSelectMessage.dart';
import 'package:chat_messanger_ui/constant/eventMessage.dart';
import 'package:chat_messanger_ui/constant/data.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:chat_messanger_ui/widget/custom_pop_up_menu.dart';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class MessageItem extends StatefulWidget {
  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<MessageItem> {
  TextEditingController _sendMessageController = new TextEditingController();
  CustomPopupMenuController _controller = CustomPopupMenuController();
  var isSelectPopUp = false;
  var messageIdSelect = '';
  var listMessage = messages;

  Widget build(BuildContext context) {
    return Container(
      color: CommonColors.bg_room,
      child: ListView(
        padding: EdgeInsets.only(right: 20, left: 20, top: 20, bottom: 80),
        children: List.generate(listMessage.length, (index) {
          var id = listMessage[index]['idMessage'];
          var isMe = listMessage[index]['isMe'];
          var messageType = listMessage[index]['messageType'];
          var message = listMessage[index]['message'];
          var icon = listMessage[index]['icon'];
          var profileImg = listMessage[index]['profileImg'];
          return GestureDetector(
            child: Container(
              width: (MediaQuery.of(context).size.width - 40),
              child: Padding(
                padding: EdgeInsets.fromLTRB(1, 1, 1, (icon > 0 ? 10.0 : 1.0)),
                child: Row(
                  mainAxisAlignment:
                      isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                  children: [
                    isMe
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: Stack(
                              children: [
                                Center(
                                  child: Container(
                                    width: 35,
                                    height: 35,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(profileImg),
                                            fit: BoxFit.cover)),
                                  ),
                                )
                              ],
                            ),
                          ),
                    Stack(
                      children: <Widget>[
                        Flexible(
                          child: Row(
                            children: [
                              CustomPopupMenu(
                                controller: _controller,
                                barrierColor: CommonColors.transparent,
                                pressType: PressType.longPress,
                                showArrow: false,
                                listEventIcon: listEventIcon,
                                onChangeIcon: (int idIconSelect) {
                                  setState(() {
                                    listMessage = updateMessageIcon(
                                        listMessage, id, idIconSelect);
                                  });
                                },
                                onShowIcon: (bool value) {
                                  print(value);
                                  setState(() {
                                    isSelectPopUp = value;
                                    if (value) {
                                      messageIdSelect = id;
                                    } else {
                                      messageIdSelect = '';
                                    }
                                  });
                                },
                                onChangeAction: (int value) {},
                                child: Container(
                                  constraints: BoxConstraints(
                                      minWidth: 50,
                                      maxWidth:
                                          (MediaQuery.of(context).size.width *
                                              0.7)),
                                  decoration: BoxDecoration(
                                      color: (isSelectPopUp &&
                                              (messageIdSelect == id))
                                          ? Colors.red
                                          : isMe
                                              ? CommonColors.bg_ms_me
                                              : CommonColors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Text(
                                      message,
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                          color: CommonColors.black,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        icon > 0
                            ? Positioned.fill(
                                child: Align(
                                alignment: Alignment.bottomRight,
                                child: FractionalTranslation(
                                  translation: Offset(-0.1, 0.4),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: CommonColors.white,
                                        border: Border.all(
                                            color: CommonColors.black,
                                            width: 0.5)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Container(
                                          width: 12,
                                          height: 12,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                              image: new ExactAssetImage(
                                                  getIcon(icon)['iconPng']),
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    ),
                                  ),
                                ),
                              ))
                            : Container()
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

List updateMessageIcon(List messages, idMessage, int idIcon) {
  print(idMessage);
  print(idIcon);
  var listMessage = messages;
  for (var i = 0; i < listMessage.length; i++) {
    if (listMessage[i]['idMessage'] == idMessage) {
      if (listMessage[i]['icon'] == idIcon) {
        listMessage[i]['icon'] = 0;
      } else {
        listMessage[i]['icon'] = idIcon;
      }
    }
  }
  print(listMessage);
  return listMessage;
}
