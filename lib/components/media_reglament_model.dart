import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'media_reglament_widget.dart' show MediaReglamentWidget;
import 'package:flutter/material.dart';

class MediaReglamentModel extends FlutterFlowModel<MediaReglamentWidget> {
  ///  Local state fields for this component.

  int isTrue = 0;

  bool isBig = false;

  dynamic jsonData;

  ///  State fields for stateful widgets in this component.

  bool isDataUploading_wwwdw21 = false;
  FFUploadedFile uploadedLocalFile_wwwdw21 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Custom Action - uploadFileAndConvertToBase64toList] action in Container1 widget.
  dynamic qqqq;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Container1 widget.
  ApiCallResponse? apiResulto11;
  // Stores action output result for [Backend Call - API (PutDetailedReglament)] action in Icon widget.
  ApiCallResponse? apiResultph6Copy2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
