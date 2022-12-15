import 'package:chat_socket/core/socket_manager.dart';
import 'package:chat_socket/models/chat_list_model.dart';
import 'package:chat_socket/models/message_model.dart';
import 'package:chat_socket/services/chat_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticularChatController extends GetxController {
  final TextEditingController messageText = TextEditingController();
  LastMessage? lastMessage;

  String businessRef = "";
  String channelId = "";

  late bool _hasNext;
  bool _isFetching = false;
  bool get hasNext => _hasNext;
  int page = 0;

  List<MessageData> getMessages = [];

  Future fetchChannel() async {
    SocketManager.socketDisconnect();
    SocketManager.connectSocket(
      () async {
        debugPrint("Getting Channel id");
        if (channelId == "") {
          var response = await ChatServices().initializeChannel(
            businessRef,
          );
          channelId = response["data"]["channelId"];
        }
        connectChannelToSocket();
        setupSocketListener();
        fetchMessages();
      },
    );
  }

  connectChannelToSocket() {
    debugPrint("connectChannelToSocket");
    SocketManager.socket!.emit(
      "subscribe_channel",
      {
        "channelRef": channelId,
      },
    );
    SocketManager.socket!.emit(
      "subscribe_user",
      {
        "userRef": "639af93bd6b61c011184b8b9",
      },
    );
  }

  void setupSocketListener() {
    debugPrint("setupSocketListener...");
    readAllMsg();
    SocketManager.socket!.on('message', (data) {
      debugPrint("GET message $data");
      readAllMsg();
      var messageData = MessageData(
        createdAt: DateTime.parse(data["createdOn"]),
        userId: data["userId"],
        picture: "",
        message: data["message"],
      );
      getMessages.insert(0, messageData);
      lastMessage = LastMessage(
        message: messageData.message,
        createdAt: messageData.createdAt,
        user: User(
          name: '',
          id: messageData.userId,
          picture: '',
          businessName: '',
        ),
      );

      debugPrint("ON MSG ARR ${getMessages.length}");
      update();
    });
  }

  void readAllMsg() {
    SocketManager.socket!.emit(
      'read_all',
      {
        "channelRef": channelId,
        "id": "639af93bd6b61c011184b8b9",
      },
    );
  }

  Future fetchMessages() async {
    page = 0;
    _isFetching = false;
    getMessages.clear();
    await fetchNextMessages();
  }

  Future fetchNextMessages() async {
    if (_isFetching) return;
    _isFetching = true;
    page++;
    var request = await ChatServices().getAllMessages(
      page: page,
      channelId: channelId,
    );
    getMessages.addAll(request!.data.map((e) => e));
    if (getMessages.isNotEmpty) {
      lastMessage = LastMessage(
        message: getMessages.first.message,
        createdAt: getMessages.first.createdAt,
        user: User(
          name: '',
          id: getMessages.first.id,
          picture: '',
          businessName: '',
        ),
      );
    }

    _hasNext = request.hasMore;
    _isFetching = false;
    update();
  }

  Future sendMessages() async {
    String msg = messageText.text.trim();
    messageText.clear();
    debugPrint("sendMessages");
    SocketManager.socket!.emit(
      'message',
      {
        "channelRef": channelId,
        "message": msg,
        "id": "639af93bd6b61c011184b8b9"
      },
    );
  }

  @override
  void dispose() {
    SocketManager.socketDisconnect();
    super.dispose();
  }
}
