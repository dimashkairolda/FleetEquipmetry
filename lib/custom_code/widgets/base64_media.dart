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

import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'dart:convert';
class Base64Media extends StatefulWidget {
  final double width;
  final double height;
  final String base64Data;
  final bool controllable; // 👈 добавили новый параметр

  const Base64Media({
    super.key,
    required this.width,
    required this.height,
    required this.base64Data,
    this.controllable = true, // по умолчанию можно управлять
  });

  @override
  _Base64MediaState createState() => _Base64MediaState();
}

class _Base64MediaState extends State<Base64Media> {
  VideoPlayerController? _controller;
  bool _isVideo = false;
  bool _isLoading = false;
  bool _showControls = true; // 👈 видимость кнопок
  late bool _canControl;

  @override
  void initState() {
    super.initState();
    _canControl = widget.controllable;
    _initMedia();
  }

  Future<void> _initMedia() async {
    if (widget.base64Data.startsWith("data:video")) {
      _isVideo = true;
      setState(() => _isLoading = true);

      final base64Str = widget.base64Data.split(',').last;
      final bytes = base64Decode(base64Str);

      final dir = await getTemporaryDirectory();
      final file = File("${dir.path}/temp_video.mp4");
      await file.writeAsBytes(bytes);

      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            _isLoading = false;
          });
          // Если нельзя управлять — просто показываем первый кадр
          if (!_canControl) {
            _controller!.pause();
          }
        });
    }
  }

  void _togglePlayPause() {
    if (_controller == null || !_canControl) return;
    setState(() {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      // Показать кнопки на короткое время
      _showControls = true;
    });

    // Через 2 секунды скрыть кнопки
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _onTapScreen() {
    if (!_canControl) return;
    setState(() => _showControls = !_showControls);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 🖼️ Если изображение
    if (widget.base64Data.startsWith("data:image")) {
      final base64Str = widget.base64Data.split(',').last;
      final decodedBytes = base64Decode(base64Str);
      return Image.memory(
        decodedBytes,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.contain,
      );
    }

    // 🎞️ Если видео
    if (_isVideo) {
      if (_isLoading ||
          _controller == null ||
          !_controller!.value.isInitialized) {
        return SizedBox(
          width: widget.width,
          height: widget.height,
          child: const Center(child: CircularProgressIndicator()),
        );
      }

      final videoWidget = Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller!.value.aspectRatio,
            child: VideoPlayer(_controller!),
          ),
          if (_showControls && _canControl)
            Container(
              color: Colors.black26,
              child: Center(
                child: IconButton(
                  iconSize: 64,
                  color: Colors.white,
                  icon: Icon(
                    _controller!.value.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                  ),
                  onPressed: _togglePlayPause,
                ),
              ),
            ),
        ],
      );

      // 🔧 Если контролы включены — оборачиваем GestureDetector
      if (_canControl) {
        return GestureDetector(
          onTap: _onTapScreen,
          child: videoWidget,
        );
      }

      // ⚡ Если controllable = false → просто возвращаем видео без GestureDetector
      return videoWidget;
    }

    // ❌ Неизвестный тип
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: const Center(child: Text("Unsupported media type")),
    );
  }
}
