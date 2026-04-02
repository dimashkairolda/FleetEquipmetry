import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'defect_c_t_o_widget.dart' show DefectCTOWidget;
import 'package:flutter/material.dart';

class DefectCTOModel extends FlutterFlowModel<DefectCTOWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Auth)] action in DefectCTO widget.
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
