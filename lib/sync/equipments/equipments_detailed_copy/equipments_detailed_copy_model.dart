import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'dart:async';
import 'equipments_detailed_copy_widget.dart' show EquipmentsDetailedCopyWidget;
import 'package:flutter/material.dart';

class EquipmentsDetailedCopyModel
    extends FlutterFlowModel<EquipmentsDetailedCopyWidget> {
  ///  Local state fields for this page.

  List<dynamic> parameters = [];
  void addToParameters(dynamic item) => parameters.add(item);
  void removeFromParameters(dynamic item) => parameters.remove(item);
  void removeAtIndexFromParameters(int index) => parameters.removeAt(index);
  void insertAtIndexInParameters(int index, dynamic item) =>
      parameters.insert(index, item);
  void updateParametersAtIndex(int index, Function(dynamic) updateFn) =>
      parameters[index] = updateFn(parameters[index]);

  int xarakteristic = 0;

  dynamic catalogId;

  String? state;

  String? expensedate;

  int expensepage = 10;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GPSToken)] action in EquipmentsDetailedCopy widget.
  ApiCallResponse? apiResultrpn;
  // Stores action output result for [Backend Call - API (objectstatus)] action in EquipmentsDetailedCopy widget.
  ApiCallResponse? apiResult030;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  Completer<ApiCallResponse>? apiRequestCompleter1;
  // State field(s) for DropDownColumn widget.
  String? dropDownColumnValue;
  FormFieldController<String>? dropDownColumnValueController;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  Completer<ApiCallResponse>? apiRequestCompleter2;
  DateTime? datePicked;
  // State field(s) for DropDownBrand widget.
  String? dropDownBrandValue;
  FormFieldController<String>? dropDownBrandValueController;
  // Stores action output result for [Backend Call - API (objectstatus)] action in Column widget.
  ApiCallResponse? apiResult0301;
  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();
  }

  /// Additional helper methods.
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

  Future waitForApiRequestCompleted2({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter2?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
