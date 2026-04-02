import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'multiple_from_list_reglament_widget.dart'
    show MultipleFromListReglamentWidget;
import 'package:flutter/material.dart';

class MultipleFromListReglamentModel
    extends FlutterFlowModel<MultipleFromListReglamentWidget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  dynamic jsonData;

  ///  State fields for stateful widgets in this component.

  // State field(s) for CheckboxGroup widget.
  FormFieldController<List<String>>? checkboxGroupValueController;
  List<String>? get checkboxGroupValues => checkboxGroupValueController?.value;
  set checkboxGroupValues(List<String>? v) =>
      checkboxGroupValueController?.value = v;

  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in CheckboxGroup widget.
  ApiCallResponse? apiResultph6Copy3;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
