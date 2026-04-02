import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'expense_journal_widget.dart' show ExpenseJournalWidget;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ExpenseJournalModel extends FlutterFlowModel<ExpenseJournalWidget> {
  ///  Local state fields for this page.

  int? start;

  int? end;

  int page = 10;

  String? date;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  Completer<ApiCallResponse>? apiRequestCompleter;
  DateTime? datePicked;
  // State field(s) for DropDownColumn widget.
  String? dropDownColumnValue1;
  FormFieldController<String>? dropDownColumnValueController1;
  // State field(s) for DropDownColumn widget.
  String? dropDownColumnValue2;
  FormFieldController<String>? dropDownColumnValueController2;
  // State field(s) for DropDownClassfication widget.
  String? dropDownClassficationValue;
  FormFieldController<String>? dropDownClassficationValueController;
  // State field(s) for DropDownBrand widget.
  String? dropDownBrandValue;
  FormFieldController<String>? dropDownBrandValueController;

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
