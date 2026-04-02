import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'create_naryad_maintenance_widget.dart'
    show CreateNaryadMaintenanceWidget;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CreateNaryadMaintenanceModel
    extends FlutterFlowModel<CreateNaryadMaintenanceWidget> {
  ///  Local state fields for this page.

  DateTime? time;

  bool isEdit = false;

  ///  State fields for stateful widgets in this page.

  // Stores action output result for [Backend Call - API (CreateNaryads)] action in Container widget.
  ApiCallResponse? apiResult20i;
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

    mestoremontaFocusNode?.dispose();
    mestoremontaTextController?.dispose();

    nameFocusNode1?.dispose();
    nameTextController1?.dispose();

    attributeFocusNode1?.dispose();
    attributeTextController1?.dispose();

    amountFocusNode?.dispose();
    amountTextController?.dispose();

    nameFocusNode2?.dispose();
    nameTextController2?.dispose();

    attributeFocusNode2?.dispose();
    attributeTextController2?.dispose();
  }
}
