import 'package:chat_socket/controllers/chat_controller.dart';
import 'package:get/get.dart';

class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ChatController());
  }
}
