import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'send_invoice_widget.dart' show SendInvoiceWidget;
import 'package:flutter/material.dart';

class SendInvoiceModel extends FlutterFlowModel<SendInvoiceWidget> {
  ///  Local state fields for this component.

  InvoicesStruct? asd;
  void updateAsdStruct(Function(InvoicesStruct) updateFn) {
    updateFn(asd ??= InvoicesStruct());
  }

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue2;
  FormFieldController<List<String>>? dropDownValueController2;
  // Stores action output result for [Backend Call - API (SendInvoice)] action in Button widget.
  ApiCallResponse? apiResultot1;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
