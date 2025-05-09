import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../Controller/ControllerUser/Views/chat_screen.dart';



class ChatScreen extends StatelessWidget {
  final int currentUserId;
  final int receiverId;
  final String receiverName;

  const ChatScreen({
    Key? key,
    required this.currentUserId,
    required this.receiverId,
    required this.receiverName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());
    controller.initChat(currentUserId, receiverId);

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverName),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              reverse: true,
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                final message = controller.messages[controller.messages.length - index - 1];
                final isMe = message.senderId == currentUserId;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isMe ? Colors.green[800] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.message,
                      style: TextStyle(color: isMe ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            )),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.controller,
                    decoration: InputDecoration.collapsed(hintText: "Type message ..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green),
                  onPressed: controller.sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class ChatService {
  // بيانات تجريبية للرسائل
  Future<List<Message>> getMessages(int currentUserId, int receiverId) async {
    // البيانات التجريبية للرسائل بين المستخدمين
    return [
      Message(senderId: 1, receiverId: 2, message: "السلام عليكم"),
      Message(senderId: 2, receiverId: 1, message: "وعليكم السلام، إزيك؟"),
      Message(senderId: 1, receiverId: 2, message: "الحمد لله، كنت عايز استفسر عن نتيجة التحاليل."),
      Message(senderId: 2, receiverId: 1, message: "أكيد، ابعتهالي وشوفلك الرد."),
      Message(senderId: 1, receiverId: 2, message: "تمام، شكراً ليك يا دكتور."),
      Message(senderId: 2, receiverId: 1, message: "العفو، في خدمتك دايمًا."),
    ];
  }

  Future<bool> sendMessage(int currentUserId, int receiverId, String text) async {
    // هنا ممكن تضيف منطق إرسال الرسالة (مثل إرسالها لـ API)
    // حاليًا نعتبر الرسالة تم إرسالها بنجاح
    return true;
  }
}
class Message {
  final int senderId;
  final int receiverId;
  final String message;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.message,
  });
}
