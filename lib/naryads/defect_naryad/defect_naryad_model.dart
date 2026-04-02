import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'defect_naryad_widget.dart' show DefectNaryadWidget;
import 'package:flutter/material.dart';

class DefectNaryadModel extends FlutterFlowModel<DefectNaryadWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Auth)] action in DefectNaryad widget.
  ApiCallResponse? authResponse2;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();
  }
}
