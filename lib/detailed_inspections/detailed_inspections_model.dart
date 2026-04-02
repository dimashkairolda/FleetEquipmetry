import '/components/radio_defect_widget.dart';
import '/components/zamery_widget.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'detailed_inspections_widget.dart' show DetailedInspectionsWidget;
import 'package:flutter/material.dart';

class DetailedInspectionsModel
    extends FlutterFlowModel<DetailedInspectionsWidget> {
  ///  State fields for stateful widgets in this page.

  // Models for radio_defect dynamic component.
  late FlutterFlowDynamicModels<RadioDefectModel> radioDefectModels;
  // Models for zamery dynamic component.
  late FlutterFlowDynamicModels<ZameryModel> zameryModels;

  @override
  void initState(BuildContext context) {
    radioDefectModels = FlutterFlowDynamicModels(() => RadioDefectModel());
    zameryModels = FlutterFlowDynamicModels(() => ZameryModel());
  }

  @override
  void dispose() {
    radioDefectModels.dispose();
    zameryModels.dispose();
  }
}
