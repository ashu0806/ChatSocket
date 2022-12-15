import 'package:chat_socket/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailsBottomView extends StatelessWidget {
  final TextEditingController comment;
  final Function()? send;
  final String hintText;

  const PostDetailsBottomView({
    Key? key,
    required this.comment,
    this.send,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: 0.2,
            width: Get.width,
            // color: const Color(0xff707070).withOpacity(0.7),
          ),
          const SizedBox(
            height: 13,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              comment: comment,
              hintText: hintText,
              send: send,
            ),
          ),
          const SizedBox(
            height: 13,
          ),
        ],
      ),
    );
  }
}
