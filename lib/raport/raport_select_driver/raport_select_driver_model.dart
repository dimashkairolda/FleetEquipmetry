import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'raport_select_driver_widget.dart' show RaportSelectDriverWidget;
import 'package:flutter/material.dart';

class RaportSelectDriverModel
    extends FlutterFlowModel<RaportSelectDriverWidget> {
  ///  Local state fields for this page.

  int page = 1;

  DateTime? firstdate;

  DateTime? seconddate;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (GetEmployees)] action in RaportSelectDriver widget.
  ApiCallResponse? apiResulta47;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  // Stores action output result for [Backend Call - API (changeRegion)] action in Button widget.
  ApiCallResponse? apiResult4h223;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
