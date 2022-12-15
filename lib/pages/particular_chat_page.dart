import 'package:chat_socket/controllers/chat_controller.dart';
import 'package:chat_socket/controllers/particular_chat_controller.dart';
import 'package:chat_socket/core/app_constant.dart';
import 'package:chat_socket/models/chat_list_model.dart';
import 'package:chat_socket/widgets/message_box.dart';
import 'package:chat_socket/widgets/post_detail_bottom_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParticularChatPage extends StatefulWidget {
  const ParticularChatPage({
    super.key,
    required this.businessRef,
    this.channelId = '',
    required this.userName,
    this.allChatData,
  });
  final String businessRef;
  final String channelId;
  final String userName;
  final AllChatData? allChatData;

  @override
  State<ParticularChatPage> createState() => _ParticularChatPageState();
}

class _ParticularChatPageState extends State<ParticularChatPage> {
  final particularChatController = Get.put(
    ParticularChatController(),
  );
  final scrollController = ScrollController();

  @override
  void initState() {
    particularChatController.businessRef = widget.businessRef;
    particularChatController.channelId = widget.channelId;
    particularChatController.fetchChannel();
    scrollController.addListener(scrollListener);
    super.initState();
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent / 2 &&
        !scrollController.position.outOfRange) {
      if (particularChatController.hasNext) {
        particularChatController.fetchNextMessages();
      }
    }
  }

  @override
  void deactivate() {
    debugPrint("deactive");
    if (particularChatController.lastMessage != null) {
      ChatController controller = Get.find<ChatController>();
      int index = controller.chatList.indexWhere(
          (element) => element.chatUserDetail.id == widget.businessRef);
      if (index != -1) {
        controller.chatList[index].lastMessage =
            particularChatController.lastMessage!;
        controller.update();
      }
    }
    super.deactivate();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppConstant.disposeKeyboard();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.userName,
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: GetBuilder<ParticularChatController>(
          builder: (controller) {
            return controller.channelId == "" && controller.getMessages.isEmpty
                ? GetPlatform.isAndroid
                    ? const Center(
                        child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ))
                    : const Center(
                        child: CupertinoActivityIndicator(),
                      )
                : Stack(
                    children: [
                      ListView.builder(
                        controller: scrollController,
                        reverse: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.getMessages.length,
                        padding: const EdgeInsets.only(
                            bottom: 90, left: 13, right: 13),
                        itemBuilder: (context, index) {
                          return messageBox(
                            controller.getMessages[index],
                          );
                        },
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: SafeArea(
                          child: PostDetailsBottomView(
                            comment: particularChatController.messageText,
                            send: () {
                              if (particularChatController.messageText.text
                                  .trim()
                                  .isNotEmpty) {
                                particularChatController.sendMessages();
                              }
                            },
                            hintText: "Type a message!",
                          ),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
