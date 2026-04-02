import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'create_defect_copy_widget.dart' show CreateDefectCopyWidget;
import 'package:flutter/material.dart';

class CreateDefectCopyModel extends FlutterFlowModel<CreateDefectCopyWidget> {
  ///  Local state fields for this page.

  bool isEdit = false;

  String? ad;

  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in CreateDefectCopy widget.
  bool? qqq;
  // Stores action output result for [Custom Action - checkInternetConnectivity] action in Container widget.
  bool? aasd;
  // Stores action output result for [Backend Call - API (CreateEquipment)] action in Container widget.
  ApiCallResponse? qw2;
  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  // State field(s) for classifications widget.
  String? classificationsValue;
  FormFieldController<String>? classificationsValueController;
  // State field(s) for brands widget.
  String? brandsValue;
  FormFieldController<String>? brandsValueController;
  // State field(s) for model widget.
  String? modelValue;
  FormFieldController<String>? modelValueController;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for technumber widget.
  FocusNode? technumberFocusNode;
  TextEditingController? technumberTextController;
  String? Function(BuildContext, String?)? technumberTextControllerValidator;
  // State field(s) for licence widget.
  FocusNode? licenceFocusNode;
  TextEditingController? licenceTextController;
  String? Function(BuildContext, String?)? licenceTextControllerValidator;
  // State field(s) for year widget.
  FocusNode? yearFocusNode;
  TextEditingController? yearTextController;
  String? Function(BuildContext, String?)? yearTextControllerValidator;
  // State field(s) for fueltype widget.
  String? fueltypeValue;
  FormFieldController<String>? fueltypeValueController;
  // State field(s) for avgrasxod widget.
  FocusNode? avgrasxodFocusNode;
  TextEditingController? avgrasxodTextController;
  String? Function(BuildContext, String?)? avgrasxodTextControllerValidator;
  bool isDataUploading_wwwd = false;
  FFUploadedFile uploadedLocalFile_wwwd =
      FFUploadedFile(bytes: Uint8List.fromList([]));

  // Stores action output result for [Backend Call - API (UploadPhotos)] action in Container1 widget.
  ApiCallResponse? apiResultsy6;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
    technumberFocusNode?.dispose();
    technumberTextController?.dispose();

    licenceFocusNode?.dispose();
    licenceTextController?.dispose();

    yearFocusNode?.dispose();
    yearTextController?.dispose();

    avgrasxodFocusNode?.dispose();
    avgrasxodTextController?.dispose();
  }
}
