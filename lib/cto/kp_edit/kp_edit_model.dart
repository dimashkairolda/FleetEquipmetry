import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'kp_edit_widget.dart' show KpEditWidget;
import 'package:flutter/material.dart';

class KpEditModel extends FlutterFlowModel<KpEditWidget> {
  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (CTOCommand)] action in Container widget.
  ApiCallResponse? apiResultih5;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
