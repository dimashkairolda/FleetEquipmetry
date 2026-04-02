// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import '/custom_code/widgets/index.dart';
import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatBottWidget extends StatefulWidget {
  final String token;
  final String workspace;
  final double width;
  final double height;

  const ChatBottWidget({
    Key? key,
    required this.token,
    required this.workspace,
    this.width = 350,
    this.height = 500,
  }) : super(key: key);

  @override
  State<ChatBottWidget> createState() => _ChatBottWidgetState();
}

class _ChatBottWidgetState extends State<ChatBottWidget> {
  late IO.Socket socket;
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _connectSocket();
  }

  void _connectSocket() {
    socket = IO.io(
      'wss://fleet.equipmetry.kz',
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setPath('/socket.io')
          .setQuery({'EIO': '4'})
          .setExtraHeaders({
            // Убедитесь, что токен передается в правильном формате.
            // Если сервер требует 'Bearer ', добавьте его здесь или при вызове виджета.
            'authorization': widget.token,
            'workspace': widget.workspace,
          })
          .build(),
    );

    socket.connect();

    socket.onConnect((_) => debugPrint('✅ Socket connected'));

    // ИСПРАВЛЕНИЕ 1: Слушаем событие 'chat_response', а не 'chat_message'
    socket.on('chat_response', (data) {
      debugPrint('📩 Received: $data'); // Для отладки
      if (mounted) {
        setState(() {
          // ИСПРАВЛЕНИЕ 2: Извлекаем текст из JSON объекта
          String replyText;
          if (data is Map && data.containsKey('response')) {
            replyText = data['response'].toString();
          } else {
            replyText = data.toString();
          }

          _messages.insert(0, "🤖 $replyText");
        });
      }
    });

    socket.onDisconnect((_) => debugPrint('❌ Socket disconnected'));
    socket.onError((err) => debugPrint('⚠️ Socket error: $err'));
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    // Отправка выглядит верной, судя по логам: event 'chat_message', payload {userMessage: ...}
    socket.emit('chat_message', {'userMessage': text});

    if (mounted) {
      setState(() {
        _messages.insert(0, "🧑 $text");
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    // Важно: отключаем сокет при уничтожении виджета
    socket.disconnect();
    socket.dispose();
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            'Чат с ИИ',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Inter',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: true, // Сообщения идут снизу вверх
              itemCount: _messages.length,
              itemBuilder: (_, index) {
                final message = _messages[index];
                final isUserMessage = message.startsWith("🧑");

                // Убираем иконки для отображения чистого текста
                final cleanMessage = message.substring(2);

                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 14.0),
                    constraints: BoxConstraints(maxWidth: widget.width * 0.75),
                    decoration: BoxDecoration(
                      color: isUserMessage
                          ? FlutterFlowTheme.of(context).primary
                          : FlutterFlowTheme.of(context).primaryBackground,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isUserMessage
                            ? const Radius.circular(16)
                            : Radius.zero,
                        bottomRight: isUserMessage
                            ? Radius.zero
                            : const Radius.circular(16),
                      ),
                    ),
                    child: Text(
                      cleanMessage,
                      style: TextStyle(
                        color: isUserMessage
                            ? Colors.white
                            : FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    style: FlutterFlowTheme.of(context).bodyMedium,
                    decoration: InputDecoration(
                      hintText: 'Введите сообщение...',
                      hintStyle: FlutterFlowTheme.of(context).labelMedium,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).alternate),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary),
                      ),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 10),
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: _sendMessage,
                  child: CircleAvatar(
                    backgroundColor: FlutterFlowTheme.of(context).primary,
                    child:
                        const Icon(Icons.send, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}