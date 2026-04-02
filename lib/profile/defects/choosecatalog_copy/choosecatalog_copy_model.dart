import '/flutter_flow/flutter_flow_data_table.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'choosecatalog_copy_widget.dart' show ChoosecatalogCopyWidget;
import 'package:flutter/material.dart';

class ChoosecatalogCopyModel extends FlutterFlowModel<ChoosecatalogCopyWidget> {
  ///  Local state fields for this page.

  dynamic content;

  ///  State fields for stateful widgets in this page.

  // State field(s) for PaginatedDataTable widget.
  final paginatedDataTableController =
      FlutterFlowDataTableController<dynamic>();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    paginatedDataTableController.dispose();
  }
}
