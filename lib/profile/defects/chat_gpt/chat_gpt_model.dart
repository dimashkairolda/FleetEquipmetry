import '/flutter_flow/flutter_flow_util.dart';
import 'chat_gpt_widget.dart' show ChatGptWidget;
import 'package:flutter/material.dart';

class ChatGptModel extends FlutterFlowModel<ChatGptWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // Stores action output result for [Custom Action - generateDefectFromGemini] action in Button widget.
  dynamic qwe;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();
  }
}
