import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController comment;
  final String hintText;
  final Function()? send;

  const CustomTextField({
    Key? key,
    required this.comment,
    required this.hintText,
    this.send,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        50,
      ),
      child: Container(
        height: 45,
        color: const Color.fromARGB(255, 234, 234, 234),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: comment,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  fillColor: Colors.transparent,
                  hintStyle: const TextStyle(
                    fontSize: 15,
                  ),
                  filled: true,
                  hintText: hintText,
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: send,
              icon: const Icon(
                Icons.send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
