import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'one_from_list_reglament_widget.dart' show OneFromListReglamentWidget;
import 'package:flutter/material.dart';

class OneFromListReglamentModel
    extends FlutterFlowModel<OneFromListReglamentWidget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  dynamic jsonData;

  ///  State fields for stateful widgets in this component.

  // State field(s) for RadioButton widget.
  FormFieldController<String>? radioButtonValueController;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in RadioButton widget.
  ApiCallResponse? apiResultph6Copy3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  /// Additional helper methods.
  String? get radioButtonValue => radioButtonValueController?.value;
}
