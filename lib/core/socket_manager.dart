import 'package:chat_socket/core/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketManager {
  static IO.Socket? socket;
  static void connectSocket(Function onConnect) {
    socket = IO.io(
      AppConstant.socketBaseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders({
            "authorization":
                "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjp7ImlkIjoiNjM5YWY5M2JkNmI2MWMwMTExODRiOGI5IiwiZW1haWwiOiJndXB0YWFzaHdpbmk1NTJAZ21haWwuY29tIiwidG9rZW5MaWZlIjoiMzY1ZCIsInJvbGUiOiJ1c2VyIiwidXNlclR5cGUiOjF9LCJpYXQiOjE2NzExMDA3NjcsImV4cCI6MTcwMjYzNjc2N30.iawljRtPB80HbZSsm9faZV2jBXP_9u8yNGHdWV2Qc-Y",
          })
          .setQuery({
            "id": "639af93bd6b61c011184b8b9",
          })
          .disableAutoConnect()
          .enableForceNew()
          .build(),
    );
    socket!.connect();
    socket!.onConnect((_) {
      debugPrint('connectted');
      onConnect();
    });
    socket!.onConnecting(
      (data) => debugPrint("onConnecting $data"),
    );
    socket!.onConnectError(
      (data) => debugPrint("onConnectError $data"),
    );
    socket!.onError(
      (data) => debugPrint("onError $data"),
    );
    socket!.onDisconnect(
      (data) => debugPrint("onDisconnect $data"),
    );
  }

  static void socketDisconnect() {
    if (SocketManager.socket != null) {
      SocketManager.socket!.disconnect();
      socket!.onDisconnect(
        (data) => debugPrint("onDisconnect $data"),
      );
    }
  }
}
