import 'dart:convert';

import 'package:chat_socket/core/app_constant.dart';
import 'package:chat_socket/models/chat_list_model.dart';
import 'package:chat_socket/models/message_model.dart';
import 'package:http/http.dart' as http;

class ChatServices {
  Future initializeChannel(
    String channelId,
  ) async {
    final response = await http.post(
        Uri.parse(
          AppConstant.url + AppConstant.getChannel,
        ),
        headers: {
          'Content-Type': 'application/json',
          "Authorization":
              'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM5YWY5M2JkNmI2MWMwMTExODRiOGI5IiwiZW1haWwiOiJndXB0YWFzaHdpbmk1NTJAZ21haWwuY29tIiwidG9rZW5MaWZlIjoiMzY1ZCIsInJvbGUiOiJ1c2VyIiwidXNlclR5cGUiOjF9LCJpYXQiOjE2NzExMDA3NjcsImV4cCI6MTcwMjYzNjc2N30.iawljRtPB80HbZSsm9faZV2jBXP_9u8yNGHdWV2Qc-Y',
        },
        body: {
          "userId": channelId,
        });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<MessageModel?> getAllMessages({
    required String channelId,
    required int page,
  }) async {
    final response = await http.post(
      Uri.parse(
        AppConstant.url + AppConstant.getMessages,
      ),
      headers: {
        "Authorization":
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM5YWY5M2JkNmI2MWMwMTExODRiOGI5IiwiZW1haWwiOiJndXB0YWFzaHdpbmk1NTJAZ21haWwuY29tIiwidG9rZW5MaWZlIjoiMzY1ZCIsInJvbGUiOiJ1c2VyIiwidXNlclR5cGUiOjF9LCJpYXQiOjE2NzExMDA3NjcsImV4cCI6MTcwMjYzNjc2N30.iawljRtPB80HbZSsm9faZV2jBXP_9u8yNGHdWV2Qc-Y',
      },
      body: {
        "channelRef": channelId,
        "page": page.toString(),
      },
    );
    if (response.statusCode == 200) {
      return MessageModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      return null;
    }
  }

  Future<ChatListModel?> getAllChats(int page) async {
    final response = await http.post(
      Uri.parse(
        AppConstant.url + AppConstant.messageList,
      ),
      headers: {
        "Authorization":
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM5YWY5M2JkNmI2MWMwMTExODRiOGI5IiwiZW1haWwiOiJndXB0YWFzaHdpbmk1NTJAZ21haWwuY29tIiwidG9rZW5MaWZlIjoiMzY1ZCIsInJvbGUiOiJ1c2VyIiwidXNlclR5cGUiOjF9LCJpYXQiOjE2NzExMDA3NjcsImV4cCI6MTcwMjYzNjc2N30.iawljRtPB80HbZSsm9faZV2jBXP_9u8yNGHdWV2Qc-Y',
      },
      body: {
        "page": page.toString(),
      },
    );
    if (response.statusCode == 200) {
      return ChatListModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      return null;
    }
  }
}
