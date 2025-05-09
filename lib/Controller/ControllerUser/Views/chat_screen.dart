import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/models_patient/ChatService.dart';


class ChatController extends GetxController {
  final ChatService _chatService = ChatService();
  final TextEditingController controller = TextEditingController();
  final RxList<Message> messages = <Message>[].obs;

  int currentUserId = 0;
  int receiverId = 0;

  void initChat(int currentId, int receiver) {
    currentUserId = currentId;
    receiverId = receiver;
    loadMessages();
  }

  Future<void> loadMessages() async {
    final data = await _chatService.getMessages(currentUserId, receiverId);
    messages.assignAll(data);
  }

  Future<void> sendMessage() async {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      final success = await _chatService.sendMessage(currentUserId, receiverId, text);
      if (success) {
        controller.clear();
        await loadMessages();
      }
    }
  }
}
