import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'invoices_detailed_widget.dart' show InvoicesDetailedWidget;
import 'package:flutter/material.dart';

class InvoicesDetailedModel extends FlutterFlowModel<InvoicesDetailedWidget> {
  ///  Local state fields for this component.

  StorehouseStruct? asd;
  void updateAsdStruct(Function(StorehouseStruct) updateFn) {
    updateFn(asd ??= StorehouseStruct());
  }

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
