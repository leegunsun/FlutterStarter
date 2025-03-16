
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StompClient _stompClient;
  final TextEditingController _privateMessageController = TextEditingController();
  final TextEditingController _groupMessageController = TextEditingController();
  final List<String> _messages = [];

  @override
  void initState() {
    super.initState();

    // STOMP 클라이언트 설정
    _stompClient = StompClient(
      config: StompConfig(
        url: 'ws://10.0.2.2:8080/ws/websocket',  // ✅ 경로 수정
        onConnect: _onConnect,
        onDisconnect: (frame) => print("연결 종료"),
        onWebSocketError: (error) => print("오류 발생: $error"),

        // 🔥 사용자 정보 전달 (핸드셰이크에 사용)
        stompConnectHeaders: {
          'Authorization': 'Bearer <YOUR_ACCESS_TOKEN>',
          'username': 'testUser'
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer <YOUR_ACCESS_TOKEN>',
          'username': 'testUser'
        },
      ),
    );

    _stompClient.activate();
  }

  void _onConnect(StompFrame frame) {
    // 🔥 1:1 대화 구독
    _stompClient.subscribe(
      destination: '/user/queue/messages',  // ✅ 구독 경로 수정
      callback: (frame) {
        setState(() {
          _messages.add("[1:1] ${jsonDecode(frame.body!)['message']}");
        });
      },
    );

    // 🔥 그룹 대화 구독
    _stompClient.subscribe(
      destination: '/topic/group_name',  // ✅ 그룹 대화 경로 수정
      callback: (frame) {
        setState(() {
          _messages.add("[그룹] ${jsonDecode(frame.body!)['message']}");
        });
      },
    );
  }

  /// 1:1 메시지 전송
  void _sendPrivateMessage() {
    if (_privateMessageController.text.isNotEmpty) {
      _stompClient.send(
        destination: '/app/chat.sendToUser',  // ✅ 전송 경로 수정
        body: jsonEncode({
          "message": _privateMessageController.text,
          "recipient": "recipient",   // ✅ `recipient` 필드만 필요
          "senderId": "sender_id"
        }),
      );
      _privateMessageController.clear();
    }
  }

  /// 그룹 메시지 전송
  void _sendGroupMessage() {
    if (_groupMessageController.text.isNotEmpty) {
      _stompClient.send(
        destination: '/app/chat.sendToGroup',  // ✅ 전송 경로 수정
        body: jsonEncode({
          "message": _groupMessageController.text,
          "groupName": "group_name",  // ✅ `groupName` 필드 추가
          "senderId": "sender_id"
        }),
      );
      _groupMessageController.clear();
    }
  }

  @override
  void dispose() {
    _stompClient.deactivate(); // 연결 종료
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
          // 1:1 메시지 전송 UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _privateMessageController,
                    decoration: const InputDecoration(hintText: '1:1 메시지를 입력하세요'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendPrivateMessage,
                )
              ],
            ),
          ),
          // 그룹 메시지 전송 UI
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _groupMessageController,
                    decoration: const InputDecoration(hintText: '그룹 메시지를 입력하세요'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendGroupMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
