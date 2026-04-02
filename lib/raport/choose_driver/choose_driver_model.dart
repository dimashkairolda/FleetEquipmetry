import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'choose_driver_widget.dart' show ChooseDriverWidget;
import 'package:flutter/material.dart';

class ChooseDriverModel extends FlutterFlowModel<ChooseDriverWidget> {
  ///  Local state fields for this page.

  dynamic content;

  bool isedited = false;

  ///  State fields for stateful widgets in this page.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  String? dropDownValue2;
  FormFieldController<String>? dropDownValueController2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
