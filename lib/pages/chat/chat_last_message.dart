import 'package:chat_messanger_ui/core/viewmodels/chat_vm.dart';
import 'package:chat_messanger_ui/utils/colors.dart';
import 'package:chat_messanger_ui/utils/size_config.dart';
import 'package:flutter/material.dart';

class LastMessage extends StatelessWidget {
  const LastMessage({
    Key key,
    this.username,
  }) : super(key: key);
  final String username;

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    var provider = ChatViewModel();
    var lastMessage = provider.getLassMessageById(username);
    return (lastMessage != null)
        ? SizedBox(
            width: MediaQuery.of(context).size.width - defaultSize * 13.5,
            child: Text(
              lastMessage.message,
              style: TextStyle(
                  fontSize: defaultSize * 1.5, color: black.withOpacity(0.8)),
              overflow: TextOverflow.ellipsis,
            ),
          )
        : Container();
  }
}
