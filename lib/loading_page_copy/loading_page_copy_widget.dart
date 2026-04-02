import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'loading_page_copy_model.dart';
export 'loading_page_copy_model.dart';

class LoadingPageCopyWidget extends StatefulWidget {
  const LoadingPageCopyWidget({super.key});

  static String routeName = 'loadingPageCopy';
  static String routePath = '/loadingPageCopy';

  @override
  State<LoadingPageCopyWidget> createState() => _LoadingPageCopyWidgetState();
}

class _LoadingPageCopyWidgetState extends State<LoadingPageCopyWidget> {
  late LoadingPageCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoadingPageCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        Future(() async {
          _model.apiResult1d7 = await GetClassificationsAllCall.call(
            access: currentAuthenticationToken,
            work: FFAppState().workspace,
          );

          if ((_model.apiResult1d7?.succeeded ?? true)) {
            FFAppState().classificationsPark =
                (_model.apiResult1d7?.jsonBody ?? '').toList().cast<dynamic>();
            safeSetState(() {});
          }
        }),
        Future(() async {
          _model.apiResult1d71 = await GetBrandsAllCall.call(
            work: FFAppState().workspace,
            access: currentAuthenticationToken,
          );

          if ((_model.apiResult1d71?.succeeded ?? true)) {
            FFAppState().brands =
                (_model.apiResult1d71?.jsonBody ?? '').toList().cast<dynamic>();
            safeSetState(() {});
          }
        }),
        Future(() async {
          _model.apiResultnkk = await GetModelsAllCall.call(
            access: currentAuthenticationToken,
            work: FFAppState().workspace,
          );

          if ((_model.apiResultnkk?.succeeded ?? true)) {
            FFAppState().models =
                (_model.apiResultnkk?.jsonBody ?? '').toList().cast<dynamic>();
            safeSetState(() {});
          }
        }),
      ]);
      if (Navigator.of(context).canPop()) {
        context.pop();
      }
      context.pushNamed(CreateDefectCopyWidget.routeName);
    });

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.sizeOf(context).width * 1.0,
            height: MediaQuery.sizeOf(context).height * 1.0,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/jsons/clock-loading.json',
                  width: MediaQuery.sizeOf(context).width * 0.25,
                  height: MediaQuery.sizeOf(context).height * 0.2,
                  fit: BoxFit.contain,
                  animate: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
