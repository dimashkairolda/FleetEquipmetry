import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'approvement_detailed_model.dart';
export 'approvement_detailed_model.dart';

class ApprovementDetailedWidget extends StatefulWidget {
  const ApprovementDetailedWidget({
    super.key,
    required this.id,
  });

  final String? id;

  static String routeName = 'approvementDetailed';
  static String routePath = '/approvementDetailed';

  @override
  State<ApprovementDetailedWidget> createState() =>
      _ApprovementDetailedWidgetState();
}

class _ApprovementDetailedWidgetState extends State<ApprovementDetailedWidget> {
  late ApprovementDetailedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApprovementDetailedModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<ApiCallResponse>(
      future: GetApprovementDetailedCall.call(
        token: currentAuthenticationToken,
        id: widget!.id,
        work: FFAppState().workspace,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ),
          );
        }
        final approvementDetailedGetStoreHouseDetailedResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: SafeArea(
              top: true,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: custom_widgets.MobileApprovalPage(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  authToken: currentAuthenticationToken!,
                  currentUserId: getJsonField(
                    FFAppState().result,
                    r'''$.user.id''',
                  ).toString(),
                  approvalData:
                      approvementDetailedGetStoreHouseDetailedResponse.jsonBody,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
