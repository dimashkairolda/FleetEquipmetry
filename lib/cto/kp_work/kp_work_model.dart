import '/flutter_flow/flutter_flow_util.dart';
import 'kp_work_widget.dart' show KpWorkWidget;
import 'package:flutter/material.dart';

class KpWorkModel extends FlutterFlowModel<KpWorkWidget> {
  ///  State fields for stateful widgets in this component.

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode;
  TextEditingController? attributeTextController;
  String? Function(BuildContext, String?)? attributeTextControllerValidator;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  // State field(s) for summa widget.
  FocusNode? summaFocusNode;
  TextEditingController? summaTextController;
  String? Function(BuildContext, String?)? summaTextControllerValidator;
  // State field(s) for comment widget.
  FocusNode? commentFocusNode;
  TextEditingController? commentTextController;
  String? Function(BuildContext, String?)? commentTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    attributeFocusNode?.dispose();
    attributeTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    summaFocusNode?.dispose();
    summaTextController?.dispose();

    commentFocusNode?.dispose();
    commentTextController?.dispose();
  }
}
