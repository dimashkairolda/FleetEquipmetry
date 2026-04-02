import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/reglaments/reglament_comments/reglament_comments_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'adds_widget.dart' show AddsWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddsModel extends FlutterFlowModel<AddsWidget> {
  ///  State fields for stateful widgets in this component.

  bool isDataUploading_wwwdw23 = false;
  FFUploadedFile uploadedLocalFile_wwwdw23 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileAndConvertToBase64toList] action in Button widget.
  dynamic? qqqq;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Button widget.
  ApiCallResponse? apiResulto11;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
