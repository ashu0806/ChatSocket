import 'package:chat_socket/controllers/chat_controller.dart';
import 'package:chat_socket/core/app_constant.dart';
import 'package:chat_socket/core/date_time_extension.dart';
import 'package:chat_socket/models/chat_list_model.dart';
import 'package:chat_socket/pages/particular_chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_view/pagination_view.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});
  static GlobalKey<PaginationViewState> paginationKey =
      GlobalKey<PaginationViewState>();

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "All Chats",
          ),
          centerTitle: true,
        ),
        body: GetBuilder<ChatController>(
          builder: (controller) {
            return PaginationView(
              pullToRefresh: true,
              key: ChatPage.paginationKey,
              physics: const AlwaysScrollableScrollPhysics(),
              initialLoader: const Center(
                child: CircularProgressIndicator(),
              ),
              itemBuilder:
                  (BuildContext context, AllChatData allChatData, int index) {
                return chatListTile(
                  allChatData,
                );
              },
              pageFetch: controller.getAllChatList,
              onEmpty: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        ChatPage.paginationKey.currentState!.refresh();
                      },
                      icon: const Icon(
                        Icons.restart_alt,
                      ),
                    ),
                    const Text(
                      "No messages yet",
                    ),
                  ],
                ),
              ),
              onError: (error) {
                return Center(
                  child: Text(
                    error,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  chatListTile(AllChatData allChatData) {
    return GetBuilder<ChatController>(
      builder: (controller) {
        return Padding(
          padding: const EdgeInsets.all(
            5.0,
          ),
          child: Column(
            children: [
              ListTile(
                horizontalTitleGap: 12,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                leading: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: FadeInImage(
                        placeholder: const AssetImage(
                          'assets/user.png',
                        ),
                        image: NetworkImage(
                          AppConstant.imageUrl +
                              allChatData.chatUserDetail.picture,
                        ),
                        fit: BoxFit.cover,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/user.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          );
                        },
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -3,
                      child: allChatData.unreadCount == 0
                          ? const SizedBox()
                          : const CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.white,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: Color(0xff8BC53F),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
                subtitle: Text(
                  allChatData.lastMessage.message,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
                title: Text(
                  allChatData.chatUserDetail.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Get.to(
                    () => ParticularChatPage(
                      channelId: allChatData.channelRef,
                      businessRef: allChatData.chatUserDetail.id,
                      userName: allChatData.chatUserDetail.name,
                    ),
                  );
                  controller.realAllMessagesLocally(allChatData);
                },
                trailing: Padding(
                  padding: const EdgeInsets.only(bottom: 11),
                  child: Text(
                    DateTimeFormatExtension.displayMSGTimeFromTimestamp(
                        allChatData.lastMessage.createdAt.toLocal()),
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withOpacity(0.50),
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
        );
      },
    );
  }
}
