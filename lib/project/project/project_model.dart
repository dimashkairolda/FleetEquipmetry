import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dart:async';
import 'project_widget.dart' show ProjectWidget;
import 'package:flutter/material.dart';

class ProjectModel extends FlutterFlowModel<ProjectWidget> {
  ///  Local state fields for this page.

  int page = 10;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // State field(s) for region widget.
  String? regionValue;
  FormFieldController<String>? regionValueController;
  // State field(s) for customer widget.
  String? customerValue;
  FormFieldController<String>? customerValueController;
  // State field(s) for projects widget.
  String? projectsValue;
  FormFieldController<String>? projectsValueController;
  // State field(s) for payment widget.
  String? paymentValue;
  FormFieldController<String>? paymentValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
