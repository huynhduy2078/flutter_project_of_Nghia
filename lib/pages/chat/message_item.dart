import 'package:chat_messanger_ui/constant/evenSelectMessage.dart';
import 'package:chat_messanger_ui/core/models/chat_model.dart';
import 'package:chat_messanger_ui/core/viewmodels/chat_vm.dart';
import 'package:chat_messanger_ui/core/viewmodels/user_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/widget/custom_pop_up_menu.dart';

import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  //final bool isMe;
  final ChatModel message;
  const MessageItem({
    Key key,
    //this.isMe = false,
    this.message,
  }) : super(key: key);

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<MessageItem> {
  CustomPopupMenuController _controller = CustomPopupMenuController();
  var isSelectPopUp = false;
  var messageIdSelect = '';

  var providerUser = UserViewModel();
  var providerChat = ChatViewModel();

  Widget build(BuildContext context) {
    var isMe = widget.message.isMe;
    var icon = widget.message.icon;

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
                                      image: NetworkImage(
                                          providerUser.getImgByUser(
                                              widget.message.username)),
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
                          barrierColor: transparent,
                          pressType: PressType.longPress,
                          showArrow: false,
                          listEventIcon: listEventIcon,
                          onChangeIcon: (int idIconSelect) {
                            providerChat.updateIconMessage(
                                widget.message.id, idIconSelect);
                            // setState(() {
                            //   fakeMessageShow = updateMessageIcon(
                            //       widget.message.id, idIconSelect);
                            // });
                          },
                          onShowIcon: (bool value) {
                            setState(() {
                              isSelectPopUp = value;
                              if (value) {
                                messageIdSelect = widget.message.id;
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
                                    (MediaQuery.of(context).size.width * 0.7)),
                            decoration: BoxDecoration(
                                color: (isSelectPopUp &&
                                        (messageIdSelect == widget.message.id))
                                    ? hover_ms
                                    : isMe
                                        ? bg_ms_me
                                        : white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            child: Padding(
                              padding: EdgeInsets.all(13.0),
                              child: Text(
                                widget.message.message,
                                textAlign: TextAlign.justify,
                                style: TextStyle(color: black, fontSize: 17),
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
                                  color: white,
                                  border: Border.all(color: black, width: 0.5)),
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
  }
}
