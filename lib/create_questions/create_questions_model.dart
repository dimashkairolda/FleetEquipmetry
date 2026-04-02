import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'create_questions_widget.dart' show CreateQuestionsWidget;
import 'package:flutter/material.dart';

class CreateQuestionsModel extends FlutterFlowModel<CreateQuestionsWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for nazvanieOptions widget.
  FocusNode? nazvanieOptionsFocusNode;
  TextEditingController? nazvanieOptionsTextController;
  String? Function(BuildContext, String?)?
      nazvanieOptionsTextControllerValidator;
  String? _nazvanieOptionsTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  // State field(s) for opisanieOptions widget.
  FocusNode? opisanieOptionsFocusNode;
  TextEditingController? opisanieOptionsTextController;
  String? Function(BuildContext, String?)?
      opisanieOptionsTextControllerValidator;
  String? _opisanieOptionsTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Обязательное поле';
    }

    return null;
  }

  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue1;
  // State field(s) for nazvanieWithoutOptions widget.
  FocusNode? nazvanieWithoutOptionsFocusNode;
  TextEditingController? nazvanieWithoutOptionsTextController;
  String? Function(BuildContext, String?)?
      nazvanieWithoutOptionsTextControllerValidator;
  // State field(s) for opisanieWithoutOptions widget.
  FocusNode? opisanieWithoutOptionsFocusNode;
  TextEditingController? opisanieWithoutOptionsTextController;
  String? Function(BuildContext, String?)?
      opisanieWithoutOptionsTextControllerValidator;
  // State field(s) for CheckboxListTile widget.
  bool? checkboxListTileValue2;

  @override
  void initState(BuildContext context) {
    nazvanieOptionsTextControllerValidator =
        _nazvanieOptionsTextControllerValidator;
    opisanieOptionsTextControllerValidator =
        _opisanieOptionsTextControllerValidator;
  }

  @override
  void dispose() {
    nazvanieOptionsFocusNode?.dispose();
    nazvanieOptionsTextController?.dispose();

    opisanieOptionsFocusNode?.dispose();
    opisanieOptionsTextController?.dispose();

    nazvanieWithoutOptionsFocusNode?.dispose();
    nazvanieWithoutOptionsTextController?.dispose();

    opisanieWithoutOptionsFocusNode?.dispose();
    opisanieWithoutOptionsTextController?.dispose();
  }
}
