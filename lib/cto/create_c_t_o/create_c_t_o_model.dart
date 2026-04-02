import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_c_t_o_widget.dart' show CreateCTOWidget;
import 'package:flutter/material.dart';

class CreateCTOModel extends FlutterFlowModel<CreateCTOWidget> {
  ///  Local state fields for this page.

  bool isEdit = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Backend Call - API (CTOCreate)] action in Container widget.
  ApiCallResponse? apiResultusr;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for nazvanie widget.
  FocusNode? nazvanieFocusNode;
  TextEditingController? nazvanieTextController;
  String? Function(BuildContext, String?)? nazvanieTextControllerValidator;
  // State field(s) for type widget.
  String? typeValue;
  FormFieldController<String>? typeValueController;
  // State field(s) for acceptor widget.
  String? acceptorValue;
  FormFieldController<String>? acceptorValueController;
  // State field(s) for CT widget.
  String? ctValue;
  FormFieldController<String>? ctValueController;
  DateTime? datePicked;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue;
  // State field(s) for name widget.
  FocusNode? nameFocusNode1;
  TextEditingController? nameTextController1;
  String? Function(BuildContext, String?)? nameTextController1Validator;
  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode1;
  TextEditingController? attributeTextController1;
  String? Function(BuildContext, String?)? attributeTextController1Validator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;
  // State field(s) for DropDown1 widget.
  String? dropDown1Value;
  FormFieldController<String>? dropDown1ValueController;
  // State field(s) for comment widget.
  FocusNode? commentFocusNode;
  TextEditingController? commentTextController;
  String? Function(BuildContext, String?)? commentTextControllerValidator;
  // State field(s) for name widget.
  FocusNode? nameFocusNode2;
  TextEditingController? nameTextController2;
  String? Function(BuildContext, String?)? nameTextController2Validator;
  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode2;
  TextEditingController? attributeTextController2;
  String? Function(BuildContext, String?)? attributeTextController2Validator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    nazvanieFocusNode?.dispose();
    nazvanieTextController?.dispose();

    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    attributeFocusNode1?.dispose();
    attributeTextController1?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();

    commentFocusNode?.dispose();
    commentTextController?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();

    attributeFocusNode2?.dispose();
    attributeTextController2?.dispose();
  }
}
