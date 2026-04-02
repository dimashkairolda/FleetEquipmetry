import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/raport/raportsview/raportsview_widget.dart';
import '/index.dart';
import 'dart:async';
import 'raport_widget.dart' show RaportWidget;
import 'package:flutter/material.dart';

class RaportModel extends FlutterFlowModel<RaportWidget> {
  ///  Local state fields for this page.

  int page = 1;

  DateTime? date;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (FirebasePost)] action in Raport widget.
  ApiCallResponse? firebase;
  // Stores action output result for [Backend Call - API (FirebaseUpdate)] action in Raport widget.
  ApiCallResponse? apiResult0u3;
  // Stores action output result for [Backend Call - API (GetColumns)] action in Raport widget.
  ApiCallResponse? apiResultk1r;
  bool apiRequestCompleted3 = false;
  String? apiRequestLastUniqueKey3;
  bool apiRequestCompleted1 = false;
  String? apiRequestLastUniqueKey1;
  bool apiRequestCompleted2 = false;
  String? apiRequestLastUniqueKey2;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  DateTime? datePicked;
  // State field(s) for DropDownColumn widget.
  String? dropDownColumnValue;
  FormFieldController<String>? dropDownColumnValueController;
  // State field(s) for DropDownREgion widget.
  String? dropDownREgionValue;
  FormFieldController<String>? dropDownREgionValueController;
  // State field(s) for Checkbox widget.
  bool? checkboxValue;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Models for raportsview dynamic component.
  late FlutterFlowDynamicModels<RaportsviewModel> raportsviewModels;

  @override
  void initState(BuildContext context) {
    raportsviewModels = FlutterFlowDynamicModels(() => RaportsviewModel());
  }

  @override
  void dispose() {
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();

    raportsviewModels.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted3({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted3;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted1;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleted2;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
