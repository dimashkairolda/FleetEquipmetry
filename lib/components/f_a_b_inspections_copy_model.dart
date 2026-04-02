import '/flutter_flow/flutter_flow_util.dart';
import 'f_a_b_inspections_copy_widget.dart' show FABInspectionsCopyWidget;
import 'package:flutter/material.dart';

class FABInspectionsCopyModel
    extends FlutterFlowModel<FABInspectionsCopyWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for nazvanie widget.
  FocusNode? nazvanieFocusNode;
  TextEditingController? nazvanieTextController;
  String? Function(BuildContext, String?)? nazvanieTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nazvanieFocusNode?.dispose();
    nazvanieTextController?.dispose();
  }
}
