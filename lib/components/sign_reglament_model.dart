import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'sign_reglament_widget.dart' show SignReglamentWidget;
import 'package:flutter/material.dart';

class SignReglamentModel extends FlutterFlowModel<SignReglamentWidget> {
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

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
