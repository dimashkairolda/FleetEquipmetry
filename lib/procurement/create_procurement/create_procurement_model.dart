import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'create_procurement_widget.dart' show CreateProcurementWidget;
import 'package:flutter/material.dart';

class CreateProcurementModel extends FlutterFlowModel<CreateProcurementWidget> {
  ///  Local state fields for this page.

  bool isEdit = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in CreateProcurement widget.
  bool? qqq;
  // Stores action output result for [Backend Call - API (CreateDefectAllIncluded)] action in Button widget.
  ApiCallResponse? apiResult5a2;
  ApiCallResponse? apiResult5a23;
  ApiCallResponse? apiResult5a234;
  ApiCallResponse? procurementParameterResponse;
  String selectedFlowType = 'WITH_BUYER';
  bool flowManualKp = true;
  bool flowIntegrationWithEds = false;
  String flowWarehouseModeType = 'FULL';
  // Approvers for publication approval flow
  List<String> approverIds = [];
  String? selectedApproverId;
  FormListFieldController<String>? approverIdsController;
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
  String? _nazvanieTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  // State field(s) for zakup widget.
  String? zakupValue;
  FormFieldController<String>? zakupValueController;
  DateTime? datePicked;
  // Блок согласования убран.
  // State field(s) for comment widget.
  FocusNode? commentFocusNode;
  TextEditingController? commentTextController;
  String? Function(BuildContext, String?)? commentTextControllerValidator;
  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  // State field(s) for attribute widget.
  FocusNode? attributeFocusNode;
  TextEditingController? attributeTextController;
  String? Function(BuildContext, String?)? attributeTextControllerValidator;
  // State field(s) for amount widget.
  FocusNode? amountFocusNode;
  TextEditingController? amountTextController;
  String? Function(BuildContext, String?)? amountTextControllerValidator;

  @override
  void initState(BuildContext context) {
    nazvanieTextControllerValidator = _nazvanieTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    nazvanieFocusNode?.dispose();
    nazvanieTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    commentFocusNode?.dispose();
    commentTextController?.dispose();

    nameFocusNode?.dispose();
    nameTextController?.dispose();

    attributeFocusNode?.dispose();
    attributeTextController?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();
  }
}
