import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'cto_widget.dart' show CtoWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class CtoModel extends FlutterFlowModel<CtoWidget> {
  ///  Local state fields for this page.

  int page = 10;

  DateTime? date;

  ///  State fields for stateful widgets in this page.

  Completer<ApiCallResponse>? apiRequestCompleter;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  DateTime? datePicked;
  // State field(s) for DropDownStatus widget.
  String? dropDownStatusValue;
  FormFieldController<String>? dropDownStatusValueController;

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
