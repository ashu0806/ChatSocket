import 'package:flutter/material.dart';

mixin AppConstant {
  static const String url = "http://3.110.39.213:3000/api/";
  static const String socketBaseUrl = "http://3.110.39.213:3000";
  static const String getChannel = "chat/getchannel";
  static const String getMessages = "messages/get";
  static const String messageList = "chat/listChat";
  static const String imageUrl =
      "https://greboapp.s3.amazonaws.com/production/images/average/";

  static void disposeKeyboard() {
    return FocusManager.instance.primaryFocus?.unfocus();
  }
}
// {"code":100,"message":"Success","data":{"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM5YWY5M2JkNmI2MWMwMTExODRiOGI5IiwiZW1haWwiOiJndXB0YWFzaHdpbmk1NTJAZ21haWwuY29tIiwidG9rZW5MaWZlIjoiMzY1ZCIsInJvbGUiOiJ1c2VyIiwidXNlclR5cGUiOjF9LCJpYXQiOjE2NzExMDA3NjcsImV4cCI6MTcwMjYzNjc2N30.iawljRtPB80HbZSsm9faZV2jBXP_9u8yNGHdWV2Qc-Y","user":{"_id":"639af93bd6b61c011184b8b9","profileCompleted":false,"userType":1,"verifiedByAdmin":false,"images":[],"websites":[],"workingDays":[],"email":"guptaashwini552@gmail.com","name":"Ashwini","picture":"1671100731404","createdOn":"2022-12-15T10:38:53.687Z","updatedOn":"2022-12-15T10:39:27.968Z","followers":0,"following":0,"categories":[],"rating":0,"isFollow":false,"services":[],"firstAfterVerification":false}},"format":"response","timestamp":"Thu, 15 Dec 2022 10:39:28 GMT"}