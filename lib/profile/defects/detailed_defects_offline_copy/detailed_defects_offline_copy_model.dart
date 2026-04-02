import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'detailed_defects_offline_copy_widget.dart'
    show DetailedDefectsOfflineCopyWidget;
import 'package:flutter/material.dart';

class DetailedDefectsOfflineCopyModel
    extends FlutterFlowModel<DetailedDefectsOfflineCopyWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - API (CentrZatrat)] action in Container widget.
  ApiCallResponse? apiResultu7h;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
