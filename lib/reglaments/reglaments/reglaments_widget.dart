import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/bottom_nav_primary_tab_scope.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'reglaments_model.dart';
export 'reglaments_model.dart';

class ReglamentsWidget extends StatefulWidget {
  const ReglamentsWidget({super.key});

  static String routeName = 'Reglaments';
  static String routePath = '/reglaments';

  @override
  State<ReglamentsWidget> createState() => _ReglamentsWidgetState();
}

class _ReglamentsWidgetState extends State<ReglamentsWidget> {
  late ReglamentsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReglamentsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.authResponse1 = await AuthCall.call(
        username: FFAppState().rememberEmail,
        password: FFAppState().rememberPassword,
      );

      GoRouter.of(context).prepareAuthEvent();
      await authManager.signIn(
        authenticationToken: AuthCall.accesstoken(
          (_model.authResponse1?.jsonBody ?? ''),
        ),
      );
      safeSetState(() => _model.apiRequestCompleter4 = null);
      await _model.waitForApiRequestCompleted4();
      safeSetState(() {
        FFAppState().clearFormsReglamentCache();
        _model.apiRequestCompleted1 = false;
      });
      await _model.waitForApiRequestCompleted1();
      safeSetState(() {
        FFAppState().clearEquipsReglamentCache();
        _model.apiRequestCompleted2 = false;
      });
      await _model.waitForApiRequestCompleted2();
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

    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter4 ??= Completer<ApiCallResponse>()
            ..complete(GetReglamentsAPICall.call(
              access: currentAuthenticationToken,
              work: FFAppState().workspace,
              page: _model.page.toString(),
              period: _model.dropDownPeriodValue != null &&
                      _model.dropDownPeriodValue != ''
                  ? '&period=${_model.dropDownPeriodValue}'
                  : '',
              regulationform: _model.dropDownFormValue != null &&
                      _model.dropDownFormValue != ''
                  ? '&regulation_form_id=${_model.dropDownFormValue}'
                  : '',
              equipment: _model.dropDownEquipmentValue != null &&
                      _model.dropDownEquipmentValue != ''
                  ? '&equipment_id=${_model.dropDownEquipmentValue}'
                  : '',
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
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
        final reglamentsGetReglamentsAPIResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading:
                  !BottomNavPrimaryTabScope.isPrimaryTabOf(context),
              title: Container(
                decoration: BoxDecoration(),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      FFButtonWidget(
                        onPressed: () async {
                          _model.state = 'ON_THE_WAY';
                          safeSetState(() {});
                          safeSetState(
                              () => _model.apiRequestCompleter3 = null);
                          await _model.waitForApiRequestCompleted3();
                        },
                        text: 'На подходе',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: _model.state == 'ON_THE_WAY'
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: _model.state == 'ON_THE_WAY'
                                    ? Colors.white
                                    : FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          _model.state = 'IN_PROGRESS';
                          safeSetState(() {});
                          safeSetState(
                              () => _model.apiRequestCompleter4 = null);
                          await _model.waitForApiRequestCompleted4();
                        },
                        text: 'В процессе',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: _model.state == 'IN_PROGRESS'
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: _model.state == 'IN_PROGRESS'
                                    ? Colors.white
                                    : FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          _model.state = 'PASSED';
                          safeSetState(() {});
                          safeSetState(
                              () => _model.apiRequestCompleter4 = null);
                          await _model.waitForApiRequestCompleted4();
                        },
                        text: 'Пройден',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: _model.state == 'PASSED'
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: _model.state == 'PASSED'
                                    ? Colors.white
                                    : FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      FFButtonWidget(
                        onPressed: () async {
                          _model.state = 'EXPIRED';
                          safeSetState(() {});
                          safeSetState(
                              () => _model.apiRequestCompleter3 = null);
                          await _model.waitForApiRequestCompleted3();
                        },
                        text: 'Просроченные',
                        options: FFButtonOptions(
                          height: 40,
                          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                          iconPadding:
                              EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                          color: _model.state == 'EXPIRED'
                              ? FlutterFlowTheme.of(context).primary
                              : FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                          textStyle: FlutterFlowTheme.of(context)
                              .titleSmall
                              .override(
                                font: GoogleFonts.readexPro(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .fontStyle,
                                ),
                                color: _model.state == 'EXPIRED'
                                    ? Colors.white
                                    : FlutterFlowTheme.of(context).primaryText,
                                letterSpacing: 0.0,
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                          elevation: 0,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ].divide(SizedBox(width: 10)),
                  ),
                ),
              ),
              actions: [],
              centerTitle: false,
            ),
            body: SafeArea(
              top: true,
              child: FutureBuilder<ApiCallResponse>(
                future: (_model.apiRequestCompleter3 ??=
                        Completer<ApiCallResponse>()
                          ..complete(GetReglamentsAPIScheduleCall.call(
                            access: currentAuthenticationToken,
                            page: _model.page.toString(),
                            work: FFAppState().workspace,
                            period: _model.dropDownPeriodValue != null &&
                                    _model.dropDownPeriodValue != ''
                                ? '&period=${_model.dropDownPeriodValue}'
                                : '',
                            regulationform: _model.dropDownFormValue != null &&
                                    _model.dropDownFormValue != ''
                                ? '&regulation_form_id=${_model.dropDownFormValue}'
                                : '',
                            equipment: _model.dropDownEquipmentValue != null &&
                                    _model.dropDownEquipmentValue != ''
                                ? '&equipment_id=${_model.dropDownEquipmentValue}'
                                : '',
                            status: (_model.state == 'ON_THE_WAY') ||
                                    (_model.state == 'EXPIRED')
                                ? '&status=${_model.state}'
                                : '',
                          )))
                    .future,
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    );
                  }
                  final containerGetReglamentsAPIScheduleResponse =
                      snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        if (functions
                                .getAclValue(FFAppState().result,
                                    '/api/v1/workspace/regulation/history/preview')
                                .toString() !=
                            '111') {
                          return InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              safeSetState(
                                  () => _model.apiRequestCompleter4 = null);
                              await _model.waitForApiRequestCompleted4();
                              safeSetState(
                                  () => _model.apiRequestCompleter3 = null);
                              await _model.waitForApiRequestCompleted3();
                            },
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Builder(
                                                  builder: (context) {
                                                    if ((_model.dropDownEquipmentValue != null && _model.dropDownEquipmentValue != '') ||
                                                        (_model.dropDownFormValue !=
                                                                null &&
                                                            _model.dropDownFormValue !=
                                                                '') ||
                                                        (_model.dropDownPeriodValue !=
                                                                null &&
                                                            _model.dropDownPeriodValue !=
                                                                '')) {
                                                      return FlutterFlowIconButton(
                                                        borderColor:
                                                            Colors.transparent,
                                                        borderRadius: 20,
                                                        borderWidth: 1,
                                                        buttonSize:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.1,
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          size: 24,
                                                        ),
                                                        onPressed: () async {
                                                          safeSetState(() {
                                                            _model
                                                                .dropDownFormValueController
                                                                ?.reset();
                                                            _model
                                                                .dropDownPeriodValueController
                                                                ?.reset();
                                                            _model
                                                                .dropDownEquipmentValueController
                                                                ?.reset();
                                                          });
                                                          _model.page = 10;
                                                          safeSetState(() {});
                                                          safeSetState(() =>
                                                              _model.apiRequestCompleter3 =
                                                                  null);
                                                          await _model
                                                              .waitForApiRequestCompleted3();
                                                          safeSetState(() =>
                                                              _model.apiRequestCompleter4 =
                                                                  null);
                                                          await _model
                                                              .waitForApiRequestCompleted4();
                                                        },
                                                      );
                                                    } else {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                FutureBuilder<ApiCallResponse>(
                                                  future: FFAppState()
                                                      .formsReglament(
                                                    requestFn: () =>
                                                        GetReglamentFormsCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      work: FFAppState()
                                                          .workspace,
                                                    ),
                                                  )
                                                      .then((result) {
                                                    _model.apiRequestCompleted1 =
                                                        true;
                                                    return result;
                                                  }),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final conditionalBuilderGetReglamentFormsResponse =
                                                        snapshot.data!;

                                                    return Builder(
                                                      builder: (context) {
                                                        if (functions
                                                                .jsonToList(
                                                                    getJsonField(
                                                                  conditionalBuilderGetReglamentFormsResponse
                                                                      .jsonBody,
                                                                  r'''$''',
                                                                ))
                                                                .length !=
                                                            0) {
                                                          return FlutterFlowDropDown<
                                                              String>(
                                                            controller: _model
                                                                    .dropDownFormValueController ??=
                                                                FormFieldController<
                                                                    String>(
                                                              _model.dropDownFormValue ??=
                                                                  '',
                                                            ),
                                                            options: List<
                                                                    String>.from(
                                                                (getJsonField(
                                                              conditionalBuilderGetReglamentFormsResponse
                                                                  .jsonBody,
                                                              r'''$[:].id''',
                                                              true,
                                                            ) as List?)!
                                                                    .map<String>(
                                                                        (e) => e
                                                                            .toString())
                                                                    .toList()
                                                                    .cast<
                                                                        String>()),
                                                            optionLabels:
                                                                (getJsonField(
                                                              conditionalBuilderGetReglamentFormsResponse
                                                                  .jsonBody,
                                                              r'''$[:].title''',
                                                              true,
                                                            ) as List?)!
                                                                    .map<String>(
                                                                        (e) => e
                                                                            .toString())
                                                                    .toList()
                                                                    .cast<
                                                                        String>(),
                                                            onChanged:
                                                                (val) async {
                                                              safeSetState(() =>
                                                                  _model.dropDownFormValue =
                                                                      val);
                                                              safeSetState(() =>
                                                                  _model.apiRequestCompleter4 =
                                                                      null);
                                                              await _model
                                                                  .waitForApiRequestCompleted4();
                                                              safeSetState(() =>
                                                                  _model.apiRequestCompleter3 =
                                                                      null);
                                                              await _model
                                                                  .waitForApiRequestCompleted3();
                                                            },
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.04,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                            hintText: 'Формы',
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24,
                                                            ),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            elevation: 2,
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            borderWidth: 1,
                                                            borderRadius: 8,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12,
                                                                        0,
                                                                        12,
                                                                        0),
                                                            hidesUnderline:
                                                                true,
                                                            isOverButton: false,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          );
                                                        } else {
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                                FlutterFlowDropDown<String>(
                                                  controller: _model
                                                          .dropDownPeriodValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.dropDownPeriodValue ??=
                                                        '',
                                                  ),
                                                  options: List<String>.from([
                                                    'daily',
                                                    'weekly',
                                                    'monthly',
                                                    'yearly'
                                                  ]),
                                                  optionLabels: [
                                                    'Ежедневно',
                                                    'Еженедельно',
                                                    'Ежемесячно',
                                                    'Ежегодно'
                                                  ],
                                                  onChanged: (val) async {
                                                    safeSetState(() => _model
                                                            .dropDownPeriodValue =
                                                        val);
                                                    safeSetState(() => _model
                                                            .apiRequestCompleter4 =
                                                        null);
                                                    await _model
                                                        .waitForApiRequestCompleted4();
                                                    safeSetState(() => _model
                                                            .apiRequestCompleter3 =
                                                        null);
                                                    await _model
                                                        .waitForApiRequestCompleted3();
                                                  },
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.4,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.04,
                                                  textStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            font: GoogleFonts
                                                                .readexPro(
                                                              fontWeight:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontWeight,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                            ),
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                  hintText: 'Период',
                                                  icon: Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryText,
                                                    size: 24,
                                                  ),
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                  elevation: 2,
                                                  borderColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .warning,
                                                  borderWidth: 1,
                                                  borderRadius: 8,
                                                  margin: EdgeInsetsDirectional
                                                      .fromSTEB(12, 0, 12, 0),
                                                  hidesUnderline: true,
                                                  isOverButton: false,
                                                  isSearchable: false,
                                                  isMultiSelect: false,
                                                ),
                                                FutureBuilder<ApiCallResponse>(
                                                  future: FFAppState()
                                                      .equipsReglament(
                                                    requestFn: () =>
                                                        GetEquipmentsReglamentCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      work: FFAppState()
                                                          .workspace,
                                                    ),
                                                  )
                                                      .then((result) {
                                                    _model.apiRequestCompleted2 =
                                                        true;
                                                    return result;
                                                  }),
                                                  builder: (context, snapshot) {
                                                    // Customize what your widget looks like when it's loading.
                                                    if (!snapshot.hasData) {
                                                      return Center(
                                                        child: SizedBox(
                                                          width: 50,
                                                          height: 50,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                    Color>(
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    final conditionalBuilderGetEquipmentsReglamentResponse =
                                                        snapshot.data!;

                                                    return Builder(
                                                      builder: (context) {
                                                        if (functions
                                                                .jsonToList(
                                                                    getJsonField(
                                                                  conditionalBuilderGetEquipmentsReglamentResponse
                                                                      .jsonBody,
                                                                  r'''$''',
                                                                ))
                                                                .length !=
                                                            0) {
                                                          return FlutterFlowDropDown<
                                                              String>(
                                                            controller: _model
                                                                    .dropDownEquipmentValueController ??=
                                                                FormFieldController<
                                                                    String>(
                                                              _model.dropDownEquipmentValue ??=
                                                                  '',
                                                            ),
                                                            options: List<
                                                                    String>.from(
                                                                (getJsonField(
                                                              conditionalBuilderGetEquipmentsReglamentResponse
                                                                  .jsonBody,
                                                              r'''$[:].id''',
                                                              true,
                                                            ) as List?)!
                                                                    .map<String>(
                                                                        (e) => e
                                                                            .toString())
                                                                    .toList()
                                                                    .cast<
                                                                        String>()),
                                                            optionLabels:
                                                                (getJsonField(
                                                              conditionalBuilderGetEquipmentsReglamentResponse
                                                                  .jsonBody,
                                                              r'''$[:].title''',
                                                              true,
                                                            ) as List?)!
                                                                    .map<String>(
                                                                        (e) => e
                                                                            .toString())
                                                                    .toList()
                                                                    .cast<
                                                                        String>(),
                                                            onChanged:
                                                                (val) async {
                                                              safeSetState(() =>
                                                                  _model.dropDownEquipmentValue =
                                                                      val);
                                                              safeSetState(() =>
                                                                  _model.apiRequestCompleter4 =
                                                                      null);
                                                              await _model
                                                                  .waitForApiRequestCompleted4();
                                                              safeSetState(() =>
                                                                  _model.apiRequestCompleter3 =
                                                                      null);
                                                              await _model
                                                                  .waitForApiRequestCompleted3();
                                                            },
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.4,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.04,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .readexPro(
                                                                        fontWeight: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontWeight,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                            hintText: 'Техника',
                                                            icon: Icon(
                                                              Icons
                                                                  .keyboard_arrow_down_rounded,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              size: 24,
                                                            ),
                                                            fillColor: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            elevation: 2,
                                                            borderColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            borderWidth: 1,
                                                            borderRadius: 8,
                                                            margin:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        12,
                                                                        0,
                                                                        12,
                                                                        0),
                                                            hidesUnderline:
                                                                true,
                                                            isOverButton: false,
                                                            isSearchable: false,
                                                            isMultiSelect:
                                                                false,
                                                          );
                                                        } else {
                                                          return Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                ),
                                              ]
                                                  .divide(SizedBox(width: 10))
                                                  .addToStart(
                                                      SizedBox(width: 5))
                                                  .addToEnd(
                                                      SizedBox(width: 10)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if ((_model.state == 'IN_PROGRESS') ||
                                          (_model.state == 'PASSED')) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.68,
                                              decoration: BoxDecoration(),
                                              child: RefreshIndicator(
                                                key: Key(
                                                    'RefreshIndicator_mighzz7j'),
                                                onRefresh: () async {
                                                  safeSetState(() => _model
                                                          .apiRequestCompleter4 =
                                                      null);
                                                  await _model
                                                      .waitForApiRequestCompleted4();
                                                },
                                                child: SingleChildScrollView(
                                                  physics:
                                                      const AlwaysScrollableScrollPhysics(),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: Builder(
                                                          builder: (context) {
                                                            final defects = functions
                                                                .filterReglament(
                                                                    reglamentsGetReglamentsAPIResponse
                                                                        .jsonBody,
                                                                    _model
                                                                        .state)
                                                                .toList();

                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: List.generate(
                                                                      defects
                                                                          .length,
                                                                      (defectsIndex) {
                                                                final defectsItem =
                                                                    defects[
                                                                        defectsIndex];
                                                                return Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      _model.apiResultui1 =
                                                                          await GetDetailedReglamentCall
                                                                              .call(
                                                                        access:
                                                                            currentAuthenticationToken,
                                                                        id: getJsonField(
                                                                          defectsItem,
                                                                          r'''$.id''',
                                                                        ).toString(),
                                                                        work: FFAppState()
                                                                            .workspace,
                                                                      );

                                                                      if ((_model
                                                                              .apiResultui1
                                                                              ?.succeeded ??
                                                                          true)) {
                                                                        FFAppState()
                                                                            .ReglamentDetailed = (getJsonField(
                                                                          (_model.apiResultui1?.jsonBody ??
                                                                              ''),
                                                                          r'''$.structure''',
                                                                          true,
                                                                        )!
                                                                                .toList()
                                                                                .map<StructureStruct?>(StructureStruct.maybeFromMap)
                                                                                .toList() as Iterable<StructureStruct?>)
                                                                            .withoutNulls
                                                                            .toList()
                                                                            .cast<StructureStruct>();
                                                                        safeSetState(
                                                                            () {});
                                                                      }

                                                                      context
                                                                          .pushNamed(
                                                                        ReglamentsDetailedWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'id':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              defectsItem,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );

                                                                      safeSetState(
                                                                          () {});
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.915,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                clipBehavior: Clip.antiAlias,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Image.asset(
                                                                                  'assets/images/ChatGPT_Image_3_._2025_.,_15_30_21.png',
                                                                                  fit: BoxFit.cover,
                                                                                ),
                                                                              ),
                                                                              Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Text(
                                                                                      getJsonField(
                                                                                        defectsItem,
                                                                                        r'''$.schedule.form.title''',
                                                                                      ).toString(),
                                                                                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                            fontFamily: 'SFProText',
                                                                                            fontSize: 16,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: RichText(
                                                                                      textScaler: MediaQuery.of(context).textScaler,
                                                                                      text: TextSpan(
                                                                                        children: [
                                                                                          TextSpan(
                                                                                            text: getJsonField(
                                                                                              defectsItem,
                                                                                              r'''$.schedule.equipment.title''',
                                                                                            ).toString(),
                                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                  fontFamily: 'SFProText',
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  fontSize: 15,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.normal,
                                                                                                ),
                                                                                          )
                                                                                        ],
                                                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              fontSize: 15,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.normal,
                                                                                            ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(height: 5)),
                                                                              ),
                                                                              
                                                                            ].divide(SizedBox(width: 5)),
                                                                          ),
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                5),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.min,
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                      decoration: BoxDecoration(
                                                                                        color: functions.statusReglamentBGColor(getJsonField(
                                                                                          defectsItem,
                                                                                          r'''$.status''',
                                                                                        ).toString()),
                                                                                        borderRadius: BorderRadius.circular(4),
                                                                                      ),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                                          children: [
                                                                                            Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                                                                  child: Text(
                                                                                                    valueOrDefault<String>(
                                                                                                      functions.statusReglament(getJsonField(
                                                                                                        defectsItem,
                                                                                                        r'''$.status''',
                                                                                                      ).toString()),
                                                                                                      '-',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: functions.statusReglamentTextColor(getJsonField(
                                                                                                            defectsItem,
                                                                                                            r'''$.status''',
                                                                                                          ).toString()),
                                                                                                          fontSize: 12,
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      valueOrDefault<String>(
                                                                                        functions.periodReglament(getJsonField(
                                                                                          defectsItem,
                                                                                          r'''$.schedule.form.period.period''',
                                                                                        ).toString()),
                                                                                        '-',
                                                                                      ),
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'SFProText',
                                                                                            letterSpacing: 0.0,
                                                                                          ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                if (valueOrDefault<String>(
                                                                                      functions.statusReglament(getJsonField(
                                                                                        defectsItem,
                                                                                        r'''$.status''',
                                                                                      ).toString()),
                                                                                      '-',
                                                                                    ) ==
                                                                                    'Пройден')
                                                                                  Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: [
                                                                                      FaIcon(
                                                                                        FontAwesomeIcons.calendarCheck,
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        size: 20,
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Text(
                                                                                          dateTimeFormat(
                                                                                            "dd.MM.y H:mm",
                                                                                            functions.addgmt5(functions.stringToDate(getJsonField(
                                                                                              defectsItem,
                                                                                              r'''$.finished_at''',
                                                                                            ).toString())),
                                                                                            locale: FFLocalizations.of(context).languageCode,
                                                                                          ).maybeHandleOverflow(
                                                                                            maxChars: 50,
                                                                                          ),
                                                                                          textAlign: TextAlign.start,
                                                                                          style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                fontSize: 12,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(width: 5)),
                                                                                  ),
                                                                              ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                            ),
                                                                          ),
                                                                          if (defectsItem !=
                                                                              functions.jsonToList(reglamentsGetReglamentsAPIResponse.jsonBody).lastOrNull)
                                                                            Divider(
                                                                              thickness: 2,
                                                                              color: FlutterFlowTheme.of(context).accent4,
                                                                            ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              })
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          height:
                                                                              15))
                                                                  .addToEnd(
                                                                      SizedBox(
                                                                          height:
                                                                              10)),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                      if (functions
                                                              .filterReglament(
                                                                  reglamentsGetReglamentsAPIResponse
                                                                      .jsonBody,
                                                                  _model.state)
                                                              .length >=
                                                          10)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      11,
                                                                      0,
                                                                      11,
                                                                      15),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              _model.page =
                                                                  _model.page +
                                                                      10;
                                                              safeSetState(
                                                                  () {});
                                                              HapticFeedback
                                                                  .lightImpact();
                                                              safeSetState(() =>
                                                                  _model.apiRequestCompleter4 =
                                                                      null);
                                                              await _model
                                                                  .waitForApiRequestCompleted4();
                                                            },
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.4,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              5,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                5,
                                                                                0),
                                                                            child:
                                                                                Text(
                                                                              'Тағы көрсету',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Icon(
                                                                            Icons.keyboard_double_arrow_down_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      } else if ((_model.state ==
                                              'ON_THE_WAY') ||
                                          (_model.state == 'EXPIRED')) {
                                        return RefreshIndicator(
                                          key: Key('RefreshIndicator_jpbpsyhz'),
                                          onRefresh: () async {
                                            safeSetState(() => _model
                                                .apiRequestCompleter3 = null);
                                            await _model
                                                .waitForApiRequestCompleted3();
                                          },
                                          child: SingleChildScrollView(
                                            physics:
                                                const AlwaysScrollableScrollPhysics(),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.68,
                                                  decoration: BoxDecoration(),
                                                  child: SingleChildScrollView(
                                                    primary: false,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Builder(
                                                          builder: (context) {
                                                            if (containerGetReglamentsAPIScheduleResponse
                                                                .succeeded) {
                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Container(
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10),
                                                                    ),
                                                                    child:
                                                                        Builder(
                                                                      builder:
                                                                          (context) {
                                                                        final defects = functions
                                                                            .filterbyPerformer(
                                                                                containerGetReglamentsAPIScheduleResponse.jsonBody,
                                                                                getJsonField(
                                                                                  FFAppState().result,
                                                                                  r'''$.user.id''',
                                                                                ).toString())
                                                                            .toList();

                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              defects.length,
                                                                              (defectsIndex) {
                                                                            final defectsItem =
                                                                                defects[defectsIndex];
                                                                            return Align(
                                                                              alignment: AlignmentDirectional(0, 0),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  var confirmDialogResponse = await showDialog<bool>(
                                                                                        context: context,
                                                                                        builder: (alertDialogContext) {
                                                                                          return AlertDialog(
                                                                                            title: Text('Әрекетті растаңыз'),
                                                                                            content: Text('Инспекцияны бастағыңыз келетініне сенімдісіз бе?'),
                                                                                            actions: [
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext, false),
                                                                                                child: Text('Болдырмау'),
                                                                                              ),
                                                                                              TextButton(
                                                                                                onPressed: () => Navigator.pop(alertDialogContext, true),
                                                                                                child: Text('Иә, бастау'),
                                                                                              ),
                                                                                            ],
                                                                                          );
                                                                                        },
                                                                                      ) ??
                                                                                      false;
                                                                                  if (confirmDialogResponse) {
                                                                                    _model.apiResultui1er = await StartReglamentCall.call(
                                                                                      access: currentAuthenticationToken,
                                                                                      work: FFAppState().workspace,
                                                                                      bodyJson: defectsItem,
                                                                                    );

                                                                                    if ((_model.apiResultui1er?.succeeded ?? true)) {
                                                                                      FFAppState().ReglamentDetailed = (getJsonField(
                                                                                        (_model.apiResultui1er?.jsonBody ?? ''),
                                                                                        r'''$.structure''',
                                                                                        true,
                                                                                      )!
                                                                                              .toList()
                                                                                              .map<StructureStruct?>(StructureStruct.maybeFromMap)
                                                                                              .toList() as Iterable<StructureStruct?>)
                                                                                          .withoutNulls
                                                                                          .toList()
                                                                                          .cast<StructureStruct>();
                                                                                      safeSetState(() {});
                                                                                    }

                                                                                    context.pushNamed(
                                                                                      ReglamentsDetailedWidget.routeName,
                                                                                      queryParameters: {
                                                                                        'id': serializeParam(
                                                                                          getJsonField(
                                                                                            (_model.apiResultui1er?.jsonBody ?? ''),
                                                                                            r'''$.id''',
                                                                                          ).toString(),
                                                                                          ParamType.String,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  }

                                                                                  safeSetState(() {});
                                                                                },
                                                                                child: Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.915,
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                            height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                            clipBehavior: Clip.antiAlias,
                                                                                            decoration: BoxDecoration(
                                                                                              shape: BoxShape.circle,
                                                                                            ),
                                                                                            child: Image.asset(
                                                                                              'assets/images/ChatGPT_Image_3_._2025_.,_15_30_21.png',
                                                                                              fit: BoxFit.cover,
                                                                                            ),
                                                                                          ),
                                                                                          Column(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                                decoration: BoxDecoration(),
                                                                                                child: Text(
                                                                                                  getJsonField(
                                                                                                    defectsItem,
                                                                                                    r'''$.form.title''',
                                                                                                  ).toString(),
                                                                                                  style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                        fontFamily: 'SFProText',
                                                                                                        fontSize: 16,
                                                                                                        letterSpacing: 0.0,
                                                                                                        fontWeight: FontWeight.w600,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                              Container(
                                                                                                width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                                decoration: BoxDecoration(),
                                                                                                child: RichText(
                                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                                  text: TextSpan(
                                                                                                    children: [
                                                                                                      TextSpan(
                                                                                                        text: getJsonField(
                                                                                                          defectsItem,
                                                                                                          r'''$.equipment.title''',
                                                                                                        ).toString(),
                                                                                                        style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                              fontFamily: 'SFProText',
                                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                              fontSize: 15,
                                                                                                              letterSpacing: 0.0,
                                                                                                              fontWeight: FontWeight.normal,
                                                                                                            ),
                                                                                                      )
                                                                                                    ],
                                                                                                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          fontSize: 15,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ].divide(SizedBox(height: 5)),
                                                                                          ),
                                                                                          
                                                                                        ].divide(SizedBox(width: 5)),
                                                                                      ),
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.min,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                              children: [
                                                                                                Container(
                                                                                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                                  decoration: BoxDecoration(
                                                                                                    color: functions.statusReglamentBGColor(getJsonField(
                                                                                                      defectsItem,
                                                                                                      r'''$.status''',
                                                                                                    ).toString()),
                                                                                                    borderRadius: BorderRadius.circular(4),
                                                                                                  ),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                                                                                    child: Row(
                                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                                      children: [
                                                                                                        Container(
                                                                                                          width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                                          decoration: BoxDecoration(),
                                                                                                          child: Align(
                                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                                            child: Padding(
                                                                                                              padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                                                                              child: Text(
                                                                                                                valueOrDefault<String>(
                                                                                                                  functions.statusReglament(getJsonField(
                                                                                                                    defectsItem,
                                                                                                                    r'''$.status''',
                                                                                                                  ).toString()),
                                                                                                                  '-',
                                                                                                                ),
                                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                      fontFamily: 'SFProText',
                                                                                                                      color: functions.statusReglamentTextColor(getJsonField(
                                                                                                                        defectsItem,
                                                                                                                        r'''$.status''',
                                                                                                                      ).toString()),
                                                                                                                      fontSize: 12,
                                                                                                                      letterSpacing: 0.0,
                                                                                                                    ),
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                Text(
                                                                                                  valueOrDefault<String>(
                                                                                                    functions.periodReglament(getJsonField(
                                                                                                      defectsItem,
                                                                                                      r'''$.form.period.period''',
                                                                                                    ).toString()),
                                                                                                    '-',
                                                                                                  ),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'SFProText',
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                            Row(
                                                                                              mainAxisSize: MainAxisSize.max,
                                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                                              children: [
                                                                                                Icon(
                                                                                                  Icons.calendar_today,
                                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                  size: 20,
                                                                                                ),
                                                                                                Expanded(
                                                                                                  child: Text(
                                                                                                    dateTimeFormat(
                                                                                                      "dd.MM.y H:mm",
                                                                                                      functions.addgmt5(functions.stringToDate(getJsonField(
                                                                                                        defectsItem,
                                                                                                        r'''$.start_time''',
                                                                                                      ).toString())),
                                                                                                      locale: FFLocalizations.of(context).languageCode,
                                                                                                    ).maybeHandleOverflow(
                                                                                                      maxChars: 50,
                                                                                                    ),
                                                                                                    textAlign: TextAlign.start,
                                                                                                    style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                          fontSize: 12,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ].divide(SizedBox(width: 5)),
                                                                                            ),
                                                                                          ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                        ),
                                                                                      ),
                                                                                      if (defectsItem != functions.jsonToList(reglamentsGetReglamentsAPIResponse.jsonBody).lastOrNull)
                                                                                        Divider(
                                                                                          thickness: 2,
                                                                                          color: FlutterFlowTheme.of(context).accent4,
                                                                                        ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }).addToStart(SizedBox(height: 15)).addToEnd(
                                                                              SizedBox(height: 10)),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                  if (functions
                                                                          .jsonToList(
                                                                              reglamentsGetReglamentsAPIResponse.jsonBody)
                                                                          .length >=
                                                                      10)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              11,
                                                                              0,
                                                                              11,
                                                                              15),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.page =
                                                                              _model.page + 10;
                                                                          safeSetState(
                                                                              () {});
                                                                          HapticFeedback
                                                                              .lightImpact();
                                                                          safeSetState(() =>
                                                                              _model.apiRequestCompleter3 = null);
                                                                          await _model
                                                                              .waitForApiRequestCompleted3();
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.4,
                                                                                decoration: BoxDecoration(),
                                                                                child: Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                                                                                        child: Text(
                                                                                          'Тағы көрсету',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                font: GoogleFonts.readexPro(
                                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                                ),
                                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                      Icon(
                                                                                        Icons.keyboard_double_arrow_down_rounded,
                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                        size: 24,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ],
                                                              );
                                                            } else {
                                                              return Container(
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.9,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            5,
                                                                            0,
                                                                            5),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.915,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                  
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                  
                                                                                  
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                  
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                  
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.12,
                                                                                    decoration: BoxDecoration(
                                                                                      color: Color(0xFFC6C9CF),
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                        height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                        decoration: BoxDecoration(
                                                                                          color: Color(0xFFC6C9CF),
                                                                                          borderRadius: BorderRadius.circular(10),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 5)),
                                                                                  ),
                                                                                  
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.838,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.02,
                                                                                      decoration: BoxDecoration(
                                                                                        color: Color(0xFFC6C9CF),
                                                                                        borderRadius: BorderRadius.circular(10),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                              Divider(
                                                                                thickness: 2,
                                                                                color: FlutterFlowTheme.of(context).accent4,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            width: MediaQuery.sizeOf(context).width,
                            height: MediaQuery.sizeOf(context).height,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Text(
                                'Модуль \"Регламенты\" недоступен',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      fontSize: 16,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
