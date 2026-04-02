import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'kp_widget.dart' show KpWidget;
import 'package:flutter/material.dart';

class KpModel extends FlutterFlowModel<KpWidget> {
  ///  State fields for stateful widgets in this component.

  final formKey = GlobalKey<FormState>();
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'parameter1 is required';
    }

    return null;
  }

  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode;
  TextEditingController? attributeTextController;
  String? Function(BuildContext, String?)? attributeTextControllerValidator;
  String? _attributeTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'parameter2 is required';
    }

    return null;
  }

  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  String? _amountTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'parameter3 is required';
    }

    return null;
  }

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for price widget.
  FocusNode? priceFocusNode;
  TextEditingController? priceTextController;
  String? Function(BuildContext, String?)? priceTextControllerValidator;
  String? _priceTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'parameter5 is required';
    }

    return null;
  }

  // State field(s) for sum widget.
  FocusNode? sumFocusNode;
  TextEditingController? sumTextController;
  String? Function(BuildContext, String?)? sumTextControllerValidator;
  // State field(s) for comment widget.
  FocusNode? commentFocusNode;
  TextEditingController? commentTextController;
  String? Function(BuildContext, String?)? commentTextControllerValidator;

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    attributeTextControllerValidator = _attributeTextControllerValidator;
    amountTextControllerValidator = _amountTextControllerValidator;
    priceTextControllerValidator = _priceTextControllerValidator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    attributeFocusNode?.dispose();
    attributeTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();

    priceFocusNode?.dispose();
    priceTextController?.dispose();

    sumFocusNode?.dispose();
    sumTextController?.dispose();

    commentFocusNode?.dispose();
    commentTextController?.dispose();
  }
}
