import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dart:async';
import 'defects_widget.dart' show DefectsWidget;
import 'package:flutter/material.dart';

class DefectsModel extends FlutterFlowModel<DefectsWidget> {
  ///  Local state fields for this page.

  int page = 10;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (Auth)] action in Defects widget.
  ApiCallResponse? authResponse2;
  // State field(s) for ListView widget.
  ScrollController? listViewController;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  Completer<ApiCallResponse>? apiRequestCompleter;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // State field(s) for DropDownColumn widget.
  String? dropDownColumnValue;
  FormFieldController<String>? dropDownColumnValueController;
  // State field(s) for DropDownClassfication widget.
  String? dropDownClassficationValue;
  FormFieldController<String>? dropDownClassficationValueController;
  // State field(s) for DropDownStatus widget.
  String? dropDownStatusValue;
  FormFieldController<String>? dropDownStatusValueController;

  @override
  void initState(BuildContext context) {
    listViewController = ScrollController();
    rowController = ScrollController();
  }

  @override
  void dispose() {
    listViewController?.dispose();
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();

    rowController?.dispose();
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
