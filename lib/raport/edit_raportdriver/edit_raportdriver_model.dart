import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'edit_raportdriver_widget.dart' show EditRaportdriverWidget;
import 'package:flutter/material.dart';

class EditRaportdriverModel extends FlutterFlowModel<EditRaportdriverWidget> {
  ///  Local state fields for this component.

  List<int> count = [];
  void addToCount(int item) => count.add(item);
  void removeFromCount(int item) => count.remove(item);
  void removeAtIndexFromCount(int index) => count.removeAt(index);
  void insertAtIndexInCount(int index, int item) => count.insert(index, item);
  void updateCountAtIndex(int index, Function(int) updateFn) =>
      count[index] = updateFn(count[index]);

  DateTime? futuredate;

  ///  State fields for stateful widgets in this component.

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  DateTime? datePicked1;
  DateTime? datePicked2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
