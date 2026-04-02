import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'procurement_detailed_widget.dart' show ProcurementDetailedWidget;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProcurementDetailedModel
    extends FlutterFlowModel<ProcurementDetailedWidget> {
  ///  Local state fields for this page.

  List<dynamic> parameters = [];
  void addToParameters(dynamic item) => parameters.add(item);
  void removeFromParameters(dynamic item) => parameters.remove(item);
  void removeAtIndexFromParameters(int index) => parameters.removeAt(index);
  void insertAtIndexInParameters(int index, dynamic item) =>
      parameters.insert(index, item);
  void updateParametersAtIndex(int index, Function(dynamic) updateFn) =>
      parameters[index] = updateFn(parameters[index]);

  int xarakteristic = 0;

  dynamic catalogId;

  ///  State fields for stateful widgets in this page.

  // State field(s) for TabBar widget.
  TabController? tabBarController;
  int get tabBarCurrentIndex =>
      tabBarController != null ? tabBarController!.index : 0;
  int get tabBarPreviousIndex =>
      tabBarController != null ? tabBarController!.previousIndex : 0;

  Completer<ApiCallResponse>? apiRequestCompleter;
  // Stores action output result for [Backend Call - API (Role)] action in Button widget.
  ApiCallResponse? apiResult35r;
  // Stores action output result for [Backend Call - API (Warehouse)] action in Button widget.
  ApiCallResponse? apiResult35r2;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    tabBarController?.dispose();
  }

  /// Additional helper methods.
  Future waitForApiRequestCompleted({
    double minWait = 0,
    double maxWait = double.infinity,
  }) async {
    final stopwatch = Stopwatch()..start();
    while (true) {
      await Future.delayed(Duration(milliseconds: 50));
      final timeElapsed = stopwatch.elapsedMilliseconds;
      final requestComplete = apiRequestCompleter?.isCompleted ?? false;
      if (timeElapsed > maxWait || (requestComplete && timeElapsed > minWait)) {
        break;
      }
    }
  }
}
