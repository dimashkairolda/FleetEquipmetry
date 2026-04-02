import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'chooseasset_c_t_o_widget.dart' show ChooseassetCTOWidget;
import 'dart:async';
import 'package:flutter/material.dart';

class ChooseassetCTOModel extends FlutterFlowModel<ChooseassetCTOWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  int end = 10;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Column111 widget.
  ScrollController? column111ScrollController;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  bool apiRequestCompleted = false;
  String? apiRequestLastUniqueKey;
  // State field(s) for Row widget.
  ScrollController? rowController;
  // State field(s) for DropDownColumn widget.
  String? dropDownColumnValue;
  FormFieldController<String>? dropDownColumnValueController;
  // State field(s) for DropDownClassfication widget.
  String? dropDownClassficationValue;
  FormFieldController<String>? dropDownClassficationValueController;
  // State field(s) for DropDownBrand widget.
  String? dropDownBrandValue;
  FormFieldController<String>? dropDownBrandValueController;
  // State field(s) for DropDownModel widget.
  String? dropDownModelValue;
  FormFieldController<String>? dropDownModelValueController;
  // State field(s) for Column widget.
  ScrollController? columnController;

  @override
  void initState(BuildContext context) {
    column111ScrollController = ScrollController();
    rowController = ScrollController();
    columnController = ScrollController();
  }

  @override
  void dispose() {
    column111ScrollController?.dispose();
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();

    rowController?.dispose();
    columnController?.dispose();
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
      final requestComplete = apiRequestCompleted;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
