import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../constet.dart';

class ChatService {
  Future<bool> sendMessage(int senderId, int receiverId, String message) async {
    final response = await http.post(
      Uri.parse("$sendMessage"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['status'] == 'success';
    }

    return false;
  }

  Future<List<Message>> getMessages(int senderId, int receiverId) async {
    final response = await http.get(
      Uri.parse("$getMessage?sender_id=$senderId&receiver_id=$receiverId"),
    );

    if (response.statusCode == 200) {
      final List decoded = jsonDecode(response.body);
      return decoded.map((json) => Message.fromJson(json)).toList();
    }

    return [];
  }
}

class Message {
  final int id;
  final int senderId;
  final int receiverId;
  final String message;
  final String timestamp;

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: int.parse(json['id']),
      senderId: int.parse(json['sender_id']),
      receiverId: int.parse(json['receiver_id']),
      message: json['message'],
      timestamp: json['timestamp'],
    );
  }
}
