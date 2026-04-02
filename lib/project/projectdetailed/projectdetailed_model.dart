import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'projectdetailed_widget.dart' show ProjectdetailedWidget;
import 'package:flutter/material.dart';

class ProjectdetailedModel extends FlutterFlowModel<ProjectdetailedWidget> {
  ///  Local state fields for this page.

  List<dynamic> parameters = [];
  void addToParameters(dynamic item) => parameters.add(item);
  void removeFromParameters(dynamic item) => parameters.remove(item);
  void removeAtIndexFromParameters(int index) => parameters.removeAt(index);
  void insertAtIndexInParameters(int index, dynamic item) =>
      parameters.insert(index, item);
  void updateParametersAtIndex(int index, Function(dynamic) updateFn) =>
      parameters[index] = updateFn(parameters[index]);

  int xarakteristic = 0;

  dynamic catalogId;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetCatalogId)] action in projectdetailed widget.
  ApiCallResponse? apiResultqt2;
  // Stores action output result for [Backend Call - API (GetCatalogRoot)] action in projectdetailed widget.
  ApiCallResponse? apiResultuhu;
  // Stores action output result for [Backend Call - API (GPSToken)] action in projectdetailed widget.
  ApiCallResponse? apiResultrpn;
  // Stores action output result for [Backend Call - API (objectstatus)] action in projectdetailed widget.
  ApiCallResponse? apiResult030;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();
  }
}
