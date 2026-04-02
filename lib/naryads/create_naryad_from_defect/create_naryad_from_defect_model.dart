import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_naryad_from_defect_widget.dart'
    show CreateNaryadFromDefectWidget;
import 'package:flutter/material.dart';

class CreateNaryadFromDefectModel
    extends FlutterFlowModel<CreateNaryadFromDefectWidget> {
  ///  Local state fields for this page.

  DateTime? date;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nazvanie widget.
  FocusNode? nazvanieFocusNode;
  TextEditingController? nazvanieTextController;
  String? Function(BuildContext, String?)? nazvanieTextControllerValidator;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue;
  FormFieldController<List<String>>? dropDownValueController;
  // State field(s) for acceptor widget.
  String? acceptorValue;
  FormFieldController<String>? acceptorValueController;
  DateTime? datePicked;
  // State field(s) for mestoremonta widget.
  FocusNode? mestoremontaFocusNode;
  TextEditingController? mestoremontaTextController;
  String? Function(BuildContext, String?)? mestoremontaTextControllerValidator;
  // Stores action output result for [Backend Call - API (CreateNaryads)] action in Container widget.
  ApiCallResponse? apiResult20i;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    nazvanieFocusNode?.dispose();
    nazvanieTextController?.dispose();

    mestoremontaFocusNode?.dispose();
    mestoremontaTextController?.dispose();
  }
}
