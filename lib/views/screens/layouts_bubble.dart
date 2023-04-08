import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class MessageBubble extends StatelessWidget {
  MessageBubble({required this.text, required this.time, required this.isSent, required this.reply});
final String reply;
  final String text;
  final DateTime time;
  final bool isSent;

  @override
  Widget build(BuildContext context) {
    String getDisplayTime() {
      var difference = DateTime.now().difference(time);
      if (difference.inSeconds < 60) {
        return 'Just now';
      } else if (difference.inMinutes < 60) {
        return '${difference.inMinutes} minutes ago';
      } else if (difference.inHours < 24) {
        return '${difference.inHours} hours ago';
      } else {
        return '${difference.inDays} days ago';
      }
    }

    return Column(
      mainAxisAlignment:
          isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment:
          isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ChatBubble(
          clipper: ChatBubbleClipper1(
              type: isSent ? BubbleType.sendBubble : BubbleType.receiverBubble),
          alignment: isSent ? Alignment.topRight : Alignment.topLeft,
          margin: EdgeInsets.only(top: 5),
          backGroundColor: isSent ? buttonColor : Color(0xffD7D7D7),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Column(
              crossAxisAlignment:
                  isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: isSent ? Colors.white : Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  getDisplayTime(),
                  textAlign: isSent ? TextAlign.end : TextAlign.start,
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: isSent ? Colors.white : Colors.black,
                    fontSize: 8.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
