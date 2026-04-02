import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'naryads_offline_widget.dart' show NaryadsOfflineWidget;
import 'package:flutter/material.dart';

class NaryadsOfflineModel extends FlutterFlowModel<NaryadsOfflineWidget> {
  ///  Local state fields for this page.

  dynamic defectss;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetDefectsbyTicketId)] action in NaryadsOffline widget.
  ApiCallResponse? apiResultytd;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for Checkbox widget.
  Map<dynamic, bool> checkboxValueMap = {};
  List<dynamic> get checkboxCheckedItems =>
      checkboxValueMap.entries.where((e) => e.value).map((e) => e.key).toList();

  // Stores action output result for [Backend Call - API (NaryadTask)] action in Checkbox widget.
  ApiCallResponse? apiResultrrz;
  // Stores action output result for [Backend Call - API (NaryadTask)] action in Checkbox widget.
  ApiCallResponse? apiResultrrzCopy;
  // Stores action output result for [Backend Call - API (NaryadsStart)] action in Button widget.
  ApiCallResponse? apiResult7;
  // Stores action output result for [Backend Call - API (NaryadsPause)] action in IconButton widget.
  ApiCallResponse? apiResult72432;
  // Stores action output result for [Backend Call - API (NaryadsStart)] action in IconButton widget.
  ApiCallResponse? apiResult724811;
  // Stores action output result for [Backend Call - API (NaryadsFinalize)] action in Button widget.
  ApiCallResponse? apiResult72472;
  // Stores action output result for [Backend Call - API (statusfixed)] action in Button widget.
  ApiCallResponse? apiResult4573;
  // Stores action output result for [Backend Call - API (NaryadsReject)] action in Button widget.
  ApiCallResponse? apiResult7240;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
