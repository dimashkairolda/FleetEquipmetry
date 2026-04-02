import '/flutter_flow/flutter_flow_util.dart';
import 'choose_drive_widget.dart' show ChooseDriveWidget;
import 'package:flutter/material.dart';

class ChooseDriveModel extends FlutterFlowModel<ChooseDriveWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  int end = 10;

  ///  State fields for stateful widgets in this page.

  // State field(s) for Column111 widget.
  ScrollController? column111ScrollController;
  // State field(s) for TextField12 widget.
  FocusNode? textField12FocusNode;
  TextEditingController? textField12TextController;
  String? Function(BuildContext, String?)? textField12TextControllerValidator;
  // State field(s) for Column222 widget.
  ScrollController? column222ScrollController;
  // State field(s) for Column444 widget.
  ScrollController? column444ScrollController;

  @override
  void initState(BuildContext context) {
    column111ScrollController = ScrollController();
    column222ScrollController = ScrollController();
    column444ScrollController = ScrollController();
  }

  @override
  void dispose() {
    column111ScrollController?.dispose();
    textField12FocusNode?.dispose();
    textField12TextController?.dispose();

    column222ScrollController?.dispose();
    column444ScrollController?.dispose();
  }
}
