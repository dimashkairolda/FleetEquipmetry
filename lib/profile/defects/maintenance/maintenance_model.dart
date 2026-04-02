import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/request_manager.dart';

import '/index.dart';
import 'dart:async';
import 'maintenance_widget.dart' show MaintenanceWidget;
import 'package:flutter/material.dart';

class MaintenanceModel extends FlutterFlowModel<MaintenanceWidget> {
  ///  Local state fields for this page.

  bool isEdit = false;

  String state = 'Все';

  int page = 1;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  bool apiRequestCompleted2 = false;
  String? apiRequestLastUniqueKey2;
  Completer<ApiCallResponse>? apiRequestCompleter1;
  // State field(s) for DropDownClassfication widget.
  String? dropDownClassficationValue;
  FormFieldController<String>? dropDownClassficationValueController;

  /// Query cache managers for this widget.

  final _maintenanceManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> maintenance({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _maintenanceManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearMaintenanceCache() => _maintenanceManager.clear();
  void clearMaintenanceCacheKey(String? uniqueKey) =>
      _maintenanceManager.clearRequest(uniqueKey);

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();

    /// Dispose query cache managers for this widget.

    clearMaintenanceCache();
  }

  /// Additional helper methods.
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

  Future waitForApiRequestCompleted1({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter1?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
