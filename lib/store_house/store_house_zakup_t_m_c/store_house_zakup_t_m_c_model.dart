import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/store_house/zakup_t_m_c/zakup_t_m_c_widget.dart';
import 'store_house_zakup_t_m_c_widget.dart' show StoreHouseZakupTMCWidget;
import 'package:flutter/material.dart';

class StoreHouseZakupTMCModel
    extends FlutterFlowModel<StoreHouseZakupTMCWidget> {
  ///  Local state fields for this page.

  bool tmc = false;

  ///  State fields for stateful widgets in this page.

  // Model for ZakupTMC component.
  late ZakupTMCModel zakupTMCModel;
  // Stores action output result for [Backend Call - API (OutOfStock TMC)] action in Button widget.
  ApiCallResponse? apiResultrlk;

  @override
  void initState(BuildContext context) {
    zakupTMCModel = createModel(context, () => ZakupTMCModel());
  }

  @override
  void dispose() {
    zakupTMCModel.dispose();
  }
}
