import '/flutter_flow/flutter_flow_util.dart';
import 'add_raboty_widget.dart' show AddRabotyWidget;
import 'package:flutter/material.dart';

class AddRabotyModel extends FlutterFlowModel<AddRabotyWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for sum widget.
  FocusNode? sumFocusNode;
  TextEditingController? sumTextController;
  String? Function(BuildContext, String?)? sumTextControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    sumFocusNode?.dispose();
    sumTextController?.dispose();
  }
}
