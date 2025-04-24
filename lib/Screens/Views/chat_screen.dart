import 'package:flutter/material.dart';
import '../../models/models_patient/ChatService.dart';

class ChatScreen extends StatefulWidget {
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
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _controller = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    final messages = await _chatService.getMessages(widget.currentUserId, widget.receiverId);
    setState(() {
      _messages = messages;
    });
  }

  Future<void> _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      final success = await _chatService.sendMessage(widget.currentUserId, widget.receiverId, text);
      if (success) {
        _controller.clear();
        _loadMessages(); // Reload after send
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverName),
        actions: [
          IconButton(icon: Icon(Icons.call), onPressed: () {}),
          IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - index - 1];
                final isMe = message.senderId == widget.currentUserId;

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
            ),
          ),
          Divider(height: 1),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration.collapsed(hintText: "Type message ..."),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, color: Colors.green),
                  onPressed: _sendMessage,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
