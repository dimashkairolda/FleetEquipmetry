import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import 'date_reglament_widget.dart' show DateReglamentWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DateReglamentModel extends FlutterFlowModel<DateReglamentWidget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  dynamic jsonData;

  ///  State fields for stateful widgets in this component.

  DateTime? datePicked1;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Row widget.
  ApiCallResponse? apiResultph6Copy3;
  DateTime? datePicked2;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Column widget.
  ApiCallResponse? apiResultph6Cop;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
