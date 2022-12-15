import 'package:chat_socket/models/chat_list_model.dart';
import 'package:chat_socket/services/chat_services.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  int page = 1;

  ChatController() {
    page = 1;
  }

  List<AllChatData> chatList = [];

  Future<List<AllChatData>> getAllChatList(int offset) async {
    if (offset == 0) {
      page = 1;
      chatList.clear();
    }
    if (page == -1) {
      return [];
    }
    var response = await ChatServices().getAllChats(
      page,
    );
    var temp = response!.data;
    chatList.addAll(temp);
    page = response.hasMore ? page + 1 : -1;
    return temp;
  }

  realAllMessagesLocally(AllChatData allChatData) {
    allChatData.unreadCount = 0;
    update();
  }
}
