import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'send_zakup_widget.dart' show SendZakupWidget;
import 'package:flutter/material.dart';

class SendZakupModel extends FlutterFlowModel<SendZakupWidget> {
  ///  Local state fields for this component.

  StorehouseStruct? asd;
  void updateAsdStruct(Function(StorehouseStruct) updateFn) {
    updateFn(asd ??= StorehouseStruct());
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue2;
  FormFieldController<List<String>>? dropDownValueController2;
  // Stores action output result for [Backend Call - API (SendZakup)] action in Button widget.
  ApiCallResponse? apiResultkl7;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
