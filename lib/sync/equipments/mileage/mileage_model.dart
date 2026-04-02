import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'mileage_widget.dart' show MileageWidget;
import 'package:flutter/material.dart';

class MileageModel extends FlutterFlowModel<MileageWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (CreateMileage)] action in Container widget.
  ApiCallResponse? apiResultenx1;
  // Stores action output result for [Backend Call - API (CreateMileage)] action in Container widget.
  ApiCallResponse? apiResultenx;
  // State field(s) for odometer widget.
  FocusNode? odometerFocusNode;
  TextEditingController? odometerTextController;
  String? Function(BuildContext, String?)? odometerTextControllerValidator;
  String? _odometerTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  // State field(s) for motohours widget.
  FocusNode? motohoursFocusNode;
  TextEditingController? motohoursTextController;
  String? Function(BuildContext, String?)? motohoursTextControllerValidator;

  @override
  void initState(BuildContext context) {
    odometerTextControllerValidator = _odometerTextControllerValidator;
  }

  @override
  void dispose() {
    odometerFocusNode?.dispose();
    odometerTextController?.dispose();

    motohoursFocusNode?.dispose();
    motohoursTextController?.dispose();
  }
}
