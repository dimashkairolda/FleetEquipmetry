import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'short_text_reglament_widget.dart' show ShortTextReglamentWidget;
import 'package:flutter/material.dart';

class ShortTextReglamentModel
    extends FlutterFlowModel<ShortTextReglamentWidget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  dynamic jsonData;

  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in TextField widget.
  ApiCallResponse? apiResultph6Copy3;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Icon widget.
  ApiCallResponse? apiResultph6;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Icon widget.
  ApiCallResponse? apiResultph6Copy;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Icon widget.
  ApiCallResponse? apiResultph6CopyCopy;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Icon widget.
  ApiCallResponse? apiResultph6Copy2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
