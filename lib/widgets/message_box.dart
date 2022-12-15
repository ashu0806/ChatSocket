import 'package:chat_socket/core/date_time_extension.dart';
import 'package:chat_socket/models/message_model.dart';
import 'package:flutter/material.dart';

messageBox(MessageData messageData) {
  if (messageData.userId == "639af93bd6b61c011184b8b9") {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(
              22,
            ),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(left: 50),
          child: Text(messageData.message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
              )),
        ),
        const SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Text(
            DateTimeFormatExtension.displayMSGTimeFromTimestamp(
                messageData.createdAt.toLocal()),
            style: const TextStyle(
              color: Color(0xff7C8392),
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  } else {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: const Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(22)),
          margin: const EdgeInsets.only(right: 50),
          padding: const EdgeInsets.all(15),

          child: Text(messageData.message,
              style: const TextStyle(
                fontSize: 14,
              )),
          // margin: const EdgeInsets.only(left: 10.0),
        ),
        const SizedBox(
          height: 7,
        ),
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: Text(
            DateTimeFormatExtension.displayMSGTimeFromTimestamp(
                messageData.createdAt.toLocal()),
            style: const TextStyle(
              color: Color(0xff7C8392),
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(
          height: 7,
        ),
      ],
    );
  }
}
