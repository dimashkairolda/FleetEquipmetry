import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'auth_login_widget.dart' show AuthLoginWidget;
import 'package:flutter/material.dart';

class AuthLoginModel extends FlutterFlowModel<AuthLoginWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress widget.
  FocusNode? emailAddressFocusNode;
  TextEditingController? emailAddressTextController;
  String? Function(BuildContext, String?)? emailAddressTextControllerValidator;
  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;
  // Stores action output result for [Backend Call - API (Auth)] action in Button widget.
  ApiCallResponse? authResponse;
  // Stores action output result for [Custom Action - parseJwtToken] action in Button widget.
  DateTime? tokenTime;
  // Stores action output result for [Backend Call - API (session)] action in Button widget.
  ApiCallResponse? apiResultg4e;
  // Stores action output result for [Backend Call - API (GetWorkspaceID)] action in Button widget.
  ApiCallResponse? apiResult3kf;
  // Stores action output result for [Backend Call - API (GetInspectionsShablon)] action in Button widget.
  ApiCallResponse? apiResultgjw;
  // Stores action output result for [Backend Call - API (GetCategories)] action in Button widget.
  ApiCallResponse? apiResultzbt;
  // Stores action output result for [Backend Call - API (GetSTO)] action in Button widget.
  ApiCallResponse? apiResult38q1;

  @override
  void initState(BuildContext context) {
    passwordVisibility = false;
  }

  @override
  void dispose() {
    emailAddressFocusNode?.dispose();
    emailAddressTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();
  }
}
