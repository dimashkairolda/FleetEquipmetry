import 'package:Equipmetry/backend/api_requests/api_manager.dart';

import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'compare_offers_widget.dart' show CompareOffersWidget;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CompareOffersModel extends FlutterFlowModel<CompareOffersWidget> {
  ///  Local state fields for this page.

  bool isShowFullList = true;

  int end = 10;
  ApiCallResponse? apiResult5a23;
  ApiCallResponse? apiResult5a234;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}
}
