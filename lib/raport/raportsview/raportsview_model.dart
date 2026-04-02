import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'raportsview_widget.dart' show RaportsviewWidget;
import 'package:flutter/material.dart';

class RaportsviewModel extends FlutterFlowModel<RaportsviewWidget> {
  ///  Local state fields for this component.

  bool aa = false;

  String? location;

  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (GpsEquipAuth)] action in raportsview widget.
  ApiCallResponse? apiResultep1;
  // State field(s) for PageView widget.
  PageController? pageViewController;

  int get pageViewCurrentIndex => pageViewController != null &&
          pageViewController!.hasClients &&
          pageViewController!.page != null
      ? pageViewController!.page!.round()
      : 0;
  // Stores action output result for [Backend Call - API (GpsEquipAuthTwo)] action in Text widget.
  ApiCallResponse? apiResulte40;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
