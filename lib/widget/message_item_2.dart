import 'package:chat_messanger_ui/core/models/chat_model.dart';
import 'package:chat_messanger_ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:socket_chat/core/models/chat_model.dart';
// import 'package:socket_chat/utils/margin.dart';
// import 'package:socket_chat/utils/timeago.dart';

class MessageItem_ extends StatelessWidget {
  final bool isMe;
  final ChatModel message;
  const MessageItem_({
    Key? key,
    this.isMe = false,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: (isMe ? CommonColors.bg_ms_me : CommonColors.white)
                      .withOpacity(0.12),
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(15), //getPadding
                child: Center(
                  child: Text(
                    message?.message ?? '',
                    style: GoogleFonts.poppins(
                      color: Colors.white.withOpacity(isMe ? 1 : 0.8),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // const YMargin(3),
          // Text(
          //   '${timeAgoSinceDate(message?.timestamp ?? DateTime.now())}',
          //   style: GoogleFonts.manrope(
          //       color: Colors.grey, fontSize: 10, fontWeight: FontWeight.w300),
          // ),
        ],
      ),
    );
  }
}