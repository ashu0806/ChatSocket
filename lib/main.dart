import 'package:chat_socket/bindings/initial_bindings.dart';
import 'package:chat_socket/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  InitialBindings().dependencies();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'ChatSocket',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChatPage(),
    );
  }
}
