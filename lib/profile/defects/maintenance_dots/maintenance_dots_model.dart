import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'maintenance_dots_widget.dart' show MaintenanceDotsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MaintenanceDotsModel extends FlutterFlowModel<MaintenanceDotsWidget> {
  ///  State fields for stateful widgets in this component.

  // Stores action output result for [Backend Call - API (GetMaintanancesDetailed)] action in Column widget.
  ApiCallResponse? apiResultvcv;
  // Stores action output result for [Backend Call - API (GetMaintanancesDetailed)] action in Column widget.
  ApiCallResponse? apiResultvcv1;
  // Stores action output result for [Backend Call - API (MaintenancesComplete)] action in Column widget.
  ApiCallResponse? apiResult00w;
  // Stores action output result for [Backend Call - API (MaintenancesMissed)] action in Column widget.
  ApiCallResponse? apiResult00wCopy;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
