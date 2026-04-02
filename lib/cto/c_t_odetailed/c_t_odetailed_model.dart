import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'c_t_odetailed_widget.dart' show CTOdetailedWidget;
import 'package:flutter/material.dart';

class CTOdetailedModel extends FlutterFlowModel<CTOdetailedWidget> {
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

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz9;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz10;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz11;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz7;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz8;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResul;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz3;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz4;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz5;
  // Stores action output result for [Backend Call - API (CTOCommand)] action in Button widget.
  ApiCallResponse? apiResult4jz6;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }
}
