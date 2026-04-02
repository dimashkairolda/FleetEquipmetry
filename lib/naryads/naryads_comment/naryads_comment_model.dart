import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'naryads_comment_widget.dart' show NaryadsCommentWidget;
import 'package:flutter/material.dart';

class NaryadsCommentModel extends FlutterFlowModel<NaryadsCommentWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (NaryadsComment)] action in Container widget.
  ApiCallResponse? apiResult4h2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
