
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatMessage {

  ChatMessage({required this.type, required this.message, required this.receiverId, required this.roomId, required this.senderId});

   String type; // "PRIVATE" 또는 "GROUP"
   String senderId;
   String receiverId; // 1:1 채팅 상대
   String roomId; // 그룹 채팅 ID
   String message;
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StompClient _stompClient;
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();

    // STOMP 클라이언트 설정
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/chat/websocket',  // 변경된 URL
        // url: 'ws://10.0.2.2:8080/chat', // 실패하는 Url
        // url: 'ws://localhost:8080/chat',
        onConnect: _onConnect,
        onDisconnect: (frame) => print("연결 종료"),
        onWebSocketError: (error) => print("오류 발생: $error"),
      ),
    );

    _stompClient.activate();  // 연결 활성화
  }

  void _onConnect(StompFrame frame) {
    _stompClient.subscribe(
      destination: '/topic/public',
      callback: (frame) {
        setState(() {
          _messages.add(jsonDecode(frame.body!)['message']);
        });
      },
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _stompClient.send(
        destination: '/app/chat.send',
        body: jsonEncode({
          "sender": "Flutter_User",
          "message": _controller.text,
          "type": "PRIVATE",
          "receiverId": "receiver_id",
          "roomId": "room_id",
          "senderId": "sender_id"
        }),
      );
      _controller.clear();
    }
  }


  @override
  void dispose() {
    _stompClient.deactivate();  // 연결 종료
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('STOMP WebSocket 채팅')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(_messages[index]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: '메시지를 입력하세요'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}