import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_form_widget.dart' show CreateFormWidget;
import 'package:flutter/material.dart';

class CreateFormModel extends FlutterFlowModel<CreateFormWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (PostInspectionsShablon)] action in Container widget.
  ApiCallResponse? apiResulth96;
  // Stores action output result for [Backend Call - API (GetInspectionsShablon)] action in Container widget.
  ApiCallResponse? aa;
  // State field(s) for nazvanie widget.
  FocusNode? nazvanieFocusNode1;
  TextEditingController? nazvanieTextController1;
  String? Function(BuildContext, String?)? nazvanieTextController1Validator;
  String? _nazvanieTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  // State field(s) for nazvanie widget.
  FocusNode? nazvanieFocusNode2;
  TextEditingController? nazvanieTextController2;
  String? Function(BuildContext, String?)? nazvanieTextController2Validator;
  String? _nazvanieTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    nazvanieTextController1Validator = _nazvanieTextController1Validator;
    nazvanieTextController2Validator = _nazvanieTextController2Validator;
  }

  @override
  void dispose() {
    nazvanieFocusNode1?.dispose();
    nazvanieTextController1?.dispose();

    nazvanieFocusNode2?.dispose();
    nazvanieTextController2?.dispose();
  }
}
