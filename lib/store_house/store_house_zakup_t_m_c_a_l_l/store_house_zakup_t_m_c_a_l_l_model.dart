import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'store_house_zakup_t_m_c_a_l_l_widget.dart'
    show StoreHouseZakupTMCALLWidget;
import 'package:flutter/material.dart';

class StoreHouseZakupTMCALLModel
    extends FlutterFlowModel<StoreHouseZakupTMCALLWidget> {
  ///  Local state fields for this page.

  bool tmc = false;

  ///  State fields for stateful widgets in this page.

  DateTime? datePicked;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // Stores action output result for [Backend Call - API (OutOfStock TMC)] action in Button widget.
  ApiCallResponse? apiResultrlk;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
