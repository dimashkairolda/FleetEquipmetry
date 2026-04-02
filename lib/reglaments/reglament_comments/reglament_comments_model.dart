import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'reglament_comments_widget.dart' show ReglamentCommentsWidget;
import 'package:flutter/material.dart';

class ReglamentCommentsModel extends FlutterFlowModel<ReglamentCommentsWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for nazvanie widget.
  FocusNode? nazvanieFocusNode;
  TextEditingController? nazvanieTextController;
  String? Function(BuildContext, String?)? nazvanieTextControllerValidator;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Button widget.
  ApiCallResponse? apiResulthah;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nazvanieFocusNode?.dispose();
    nazvanieTextController?.dispose();
  }
}
