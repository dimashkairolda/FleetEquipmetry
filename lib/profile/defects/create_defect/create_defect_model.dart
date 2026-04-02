import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_defect_widget.dart' show CreateDefectWidget;
import 'package:flutter/material.dart';

class CreateDefectModel extends FlutterFlowModel<CreateDefectWidget> {
  ///  Local state fields for this page.

  bool isEdit = false;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in CreateDefect widget.
  bool? qqq;
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in Container widget.
  bool? aasd;
  // Stores action output result for [Backend Call - API (CreateDefectAllIncluded)] action in Container widget.
  ApiCallResponse? aa;
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

  // State field(s) for opisanie widget.
  FocusNode? opisanieFocusNode;
  TextEditingController? opisanieTextController;
  String? Function(BuildContext, String?)? opisanieTextControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue1;
  FormFieldController<String>? dropDownValueController1;
  DateTime? datePicked;
  // State field(s) for DropDown widget.
  List<String>? dropDownValue2;
  FormFieldController<List<String>>? dropDownValueController2;
  // State field(s) for probeg widget.
  FocusNode? probegFocusNode;
  TextEditingController? probegTextController;
  String? Function(BuildContext, String?)? probegTextControllerValidator;
  // State field(s) for moto widget.
  FocusNode? motoFocusNode;
  TextEditingController? motoTextController;
  String? Function(BuildContext, String?)? motoTextControllerValidator;
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
  bool isDataUploading_wwwdw2 = false;
  FFUploadedFile uploadedLocalFile_wwwdw2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (UploadPhotos)] action in Container1 widget.
  ApiCallResponse? apiResultsy6;

  @override
  void initState(BuildContext context) {
    nazvanieTextControllerValidator = _nazvanieTextControllerValidator;
  }

  @override
  void dispose() {
    tabBarController?.dispose();
    nazvanieFocusNode?.dispose();
    nazvanieTextController?.dispose();

    opisanieFocusNode?.dispose();
    opisanieTextController?.dispose();

    probegFocusNode?.dispose();
    probegTextController?.dispose();

    motoFocusNode?.dispose();
    motoTextController?.dispose();

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
