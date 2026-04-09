import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/bottom_nav_primary_tab_scope.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/profile/defects/maintenance_dots/maintenance_dots_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'maintenance_model.dart';
export 'maintenance_model.dart';

class MaintenanceWidget extends StatefulWidget {
  const MaintenanceWidget({super.key});

  static String routeName = 'Maintenance';
  static String routePath = '/maintenance';

  @override
  State<MaintenanceWidget> createState() => _MaintenanceWidgetState();
}

class _MaintenanceWidgetState extends State<MaintenanceWidget> {
  late MaintenanceModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MaintenanceModel());

    _model.textField12TextController ??= TextEditingController();
    _model.textField12FocusNode ??= FocusNode();

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
      future: _model
          .maintenance(
        requestFn: () => GetServiceMaintenanceCall.call(
          access: currentAuthenticationToken,
          work: FFAppState().workspace,
          page: _model.page.toString(),
          status: () {
            if (_model.state == 'Скоро') {
              return '&status=SOON';
            } else if (_model.state == 'Просрочен') {
              return '&status=EXPIRED';
            } else if (_model.state == 'Выполнен') {
              return '&status=COMPLETED';
            } else if (_model.state == 'Пропущенные') {
              return '&status=MISSED';
            } else {
              return '';
            }
          }(),
          title: _model.textField12TextController.text != null &&
                  _model.textField12TextController.text != ''
              ? '&license_plate_number=${_model.textField12TextController.text}'
              : '',
          classification: _model.dropDownClassficationValue != null &&
                  _model.dropDownClassficationValue != ''
              ? '&classification_id=${_model.dropDownClassficationValue}'
              : '',
        ),
      )
          .then((result) {
        _model.apiRequestCompleted2 = true;
        return result;
      }),
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
        final maintenanceGetServiceMaintenanceResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: BottomNavPrimaryTabScope.isPrimaryTabOf(context)
                  ? null
                  : InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.safePop();
                      },
                      child: Icon(
                        Icons.chevron_left_sharp,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24,
                      ),
                    ),
              title: Text(
                'График обслуживания',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              actions: [
                FlutterFlowIconButton(
                  borderRadius: 20,
                  borderWidth: 1,
                  buttonSize: 40,
                  icon: Icon(
                    Icons.replay_outlined,
                    color: FlutterFlowTheme.of(context).primaryText,
                    size: 24,
                  ),
                  onPressed: () async {
                    safeSetState(() {
                      _model.clearMaintenanceCache();
                      _model.apiRequestCompleted2 = false;
                    });
                    await _model.waitForApiRequestCompleted2();
                  },
                ),
              ],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: FutureBuilder<ApiCallResponse>(
                future: (_model
                        .apiRequestCompleter1 ??= Completer<ApiCallResponse>()
                      ..complete(GetServiceMaintenanceCountCall.call(
                        access: currentAuthenticationToken,
                        work: FFAppState().workspace,
                        page: _model.page.toString(),
                        status: () {
                          if (_model.state == 'Скоро') {
                            return '&status=SOON';
                          } else if (_model.state == 'Просрочен') {
                            return '&status=EXPIRED';
                          } else if (_model.state == 'Выполнен') {
                            return '&status=COMPLETED';
                          } else if (_model.state == 'Пропущенные') {
                            return '&status=MISSED';
                          } else {
                            return '';
                          }
                        }(),
                        title: _model.textField12TextController.text != null &&
                                _model.textField12TextController.text != ''
                            ? '&license_plate_number=${_model.textField12TextController.text}'
                            : '',
                        classification: _model.dropDownClassficationValue !=
                                    null &&
                                _model.dropDownClassficationValue != ''
                            ? '&classification_id=${_model.dropDownClassficationValue}'
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
                  final columnGetServiceMaintenanceCountResponse =
                      snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.15,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    11, 0, 11, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.042,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _model
                                                .textField12TextController,
                                            focusNode:
                                                _model.textField12FocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.textField12TextController',
                                              Duration(milliseconds: 0),
                                              () async {
                                                safeSetState(() {
                                                  _model
                                                      .clearMaintenanceCache();
                                                  _model.apiRequestCompleted2 =
                                                      false;
                                                });
                                                await _model
                                                    .waitForApiRequestCompleted2();
                                                safeSetState(() => _model
                                                        .apiRequestCompleter1 =
                                                    null);
                                                await _model
                                                    .waitForApiRequestCompleted1();
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            Color(0xFF99A2AD),
                                                        fontSize: 15,
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'Поиск по гос. номеру',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            Color(0xFF99A2AD),
                                                        fontSize: 15,
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(0, 3, 0, 0),
                                              prefixIcon: Icon(
                                                Icons.search_rounded,
                                                color: Color(0xFF99A2AD),
                                              ),
                                              suffixIcon: _model
                                                      .textField12TextController!
                                                      .text
                                                      .isNotEmpty
                                                  ? InkWell(
                                                      onTap: () async {
                                                        _model
                                                            .textField12TextController
                                                            ?.clear();
                                                        safeSetState(() {
                                                          _model
                                                              .clearMaintenanceCache();
                                                          _model.apiRequestCompleted2 =
                                                              false;
                                                        });
                                                        await _model
                                                            .waitForApiRequestCompleted2();
                                                        safeSetState(() => _model
                                                                .apiRequestCompleter1 =
                                                            null);
                                                        await _model
                                                            .waitForApiRequestCompleted1();
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.clear,
                                                        color:
                                                            Color(0xFF99A2AD),
                                                        size: 15,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.readexPro(
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
                                            validator: _model
                                                .textField12TextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.state = 'Все';
                                        _model.page = 1;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.clearMaintenanceCache();
                                          _model.apiRequestCompleted2 = false;
                                        });
                                        await _model
                                            .waitForApiRequestCompleted2();
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      },
                                      text: 'Все',
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        color: _model.state == 'Все'
                                            ? Color(0x1A3466E7)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: _model.state == 'Все'
                                                  ? Color(0xFF3466E7)
                                                  : Color(0xFF8291B0),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.state = 'Скоро';
                                        _model.page = 1;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.clearMaintenanceCache();
                                          _model.apiRequestCompleted2 = false;
                                        });
                                        await _model
                                            .waitForApiRequestCompleted2();
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      },
                                      text: 'Скоро',
                                      icon: Icon(
                                        Icons.circle,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        iconColor: Color(0xFFFFC05B),
                                        color: _model.state == 'Скоро'
                                            ? Color(0x1A3466E7)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: _model.state == 'Скоро'
                                                  ? Color(0xFF3466E7)
                                                  : Color(0xFF8291B0),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.state = 'Просрочен';
                                        _model.page = 1;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.clearMaintenanceCache();
                                          _model.apiRequestCompleted2 = false;
                                        });
                                        await _model
                                            .waitForApiRequestCompleted2();
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      },
                                      text: 'Просрочен',
                                      icon: Icon(
                                        Icons.circle_sharp,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        iconColor: Color(0xFFDC0E0E),
                                        color: _model.state == 'Просрочен'
                                            ? Color(0x1A3466E7)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: _model.state == 'Просрочен'
                                                  ? Color(0xFF3466E7)
                                                  : Color(0xFF8291B0),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.state = 'Выполнен';
                                        _model.page = 1;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.clearMaintenanceCache();
                                          _model.apiRequestCompleted2 = false;
                                        });
                                        await _model
                                            .waitForApiRequestCompleted2();
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      },
                                      text: 'Выполнен',
                                      icon: Icon(
                                        Icons.circle,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        iconColor: Color(0xFF09BD26),
                                        color: _model.state == 'Выполнен'
                                            ? Color(0x1A3466E7)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color: _model.state == 'Выполнен'
                                                  ? Color(0xFF3466E7)
                                                  : Color(0xFF8291B0),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    FFButtonWidget(
                                      onPressed: () async {
                                        _model.state = 'Пропущенные';
                                        _model.page = 1;
                                        safeSetState(() {});
                                        safeSetState(() {
                                          _model.clearMaintenanceCache();
                                          _model.apiRequestCompleted2 = false;
                                        });
                                        await _model
                                            .waitForApiRequestCompleted2();
                                        safeSetState(() =>
                                            _model.apiRequestCompleter1 = null);
                                        await _model
                                            .waitForApiRequestCompleted1();
                                      },
                                      text: 'Пропущенные',
                                      icon: Icon(
                                        Icons.circle,
                                        size: 15,
                                      ),
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            16, 0, 16, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        iconColor: Color(0xFFB2BBCE),
                                        color: _model.state == 'Пропущенные'
                                            ? Color(0x1A3466E7)
                                            : FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .fontStyle,
                                              ),
                                              color:
                                                  _model.state == 'Пропущенные'
                                                      ? Color(0xFF3466E7)
                                                      : Color(0xFF8291B0),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                        elevation: 0,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(width: 5))
                                      .addToStart(SizedBox(width: 10))
                                      .addToEnd(SizedBox(width: 10)),
                                ),
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (_model.dropDownClassficationValue !=
                                                  null &&
                                              _model.dropDownClassficationValue !=
                                                  '') {
                                            return FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 20,
                                              borderWidth: 1,
                                              buttonSize:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.1,
                                              icon: Icon(
                                                Icons.close,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                safeSetState(() {
                                                  _model
                                                      .dropDownClassficationValueController
                                                      ?.reset();
                                                  _model.dropDownClassficationValue =
                                                      null;
                                                });
                                                safeSetState(() {
                                                  _model
                                                      .clearMaintenanceCache();
                                                  _model.apiRequestCompleted2 =
                                                      false;
                                                });
                                                await _model
                                                    .waitForApiRequestCompleted2();
                                                safeSetState(() => _model
                                                        .apiRequestCompleter1 =
                                                    null);
                                                await _model
                                                    .waitForApiRequestCompleted1();
                                              },
                                            );
                                          } else {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      FutureBuilder<ApiCallResponse>(
                                        future: GetClassificationsCall.call(
                                          access: currentAuthenticationToken,
                                          work: FFAppState().workspace,
                                        ),
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
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                  ),
                                                ),
                                              ),
                                            );
                                          }
                                          final conditionalBuilderGetClassificationsResponse =
                                              snapshot.data!;

                                          return Builder(
                                            builder: (context) {
                                              if (functions
                                                      .jsonToList(getJsonField(
                                                        conditionalBuilderGetClassificationsResponse
                                                            .jsonBody,
                                                        r'''$''',
                                                      ))
                                                      .length !=
                                                  0) {
                                                return FlutterFlowDropDown<
                                                    String>(
                                                  controller: _model
                                                          .dropDownClassficationValueController ??=
                                                      FormFieldController<
                                                          String>(
                                                    _model.dropDownClassficationValue ??=
                                                        '',
                                                  ),
                                                  options: List<String>.from(
                                                      (getJsonField(
                                                    conditionalBuilderGetClassificationsResponse
                                                        .jsonBody,
                                                    r'''$[:].id''',
                                                    true,
                                                  ) as List?)!
                                                          .map<String>((e) =>
                                                              e.toString())
                                                          .toList()
                                                          .cast<String>()),
                                                  optionLabels: (getJsonField(
                                                    conditionalBuilderGetClassificationsResponse
                                                        .jsonBody,
                                                    r'''$[:].name''',
                                                    true,
                                                  ) as List?)!
                                                      .map<String>(
                                                          (e) => e.toString())
                                                      .toList()
                                                      .cast<String>(),
                                                  onChanged: (val) async {
                                                    safeSetState(() => _model
                                                            .dropDownClassficationValue =
                                                        val);
                                                    safeSetState(() {
                                                      _model
                                                          .clearMaintenanceCache();
                                                      _model.apiRequestCompleted2 =
                                                          false;
                                                    });
                                                    await _model
                                                        .waitForApiRequestCompleted2();
                                                    safeSetState(() => _model
                                                            .apiRequestCompleter1 =
                                                        null);
                                                    await _model
                                                        .waitForApiRequestCompleted1();
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
                                                  hintText: 'Категория',
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
                                                );
                                              } else {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
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
                                        .addToStart(SizedBox(width: 5))
                                        .addToEnd(SizedBox(width: 10)),
                                  ),
                                ),
                              ),
                            ]
                                .divide(SizedBox(height: 5))
                                .addToEnd(SizedBox(height: 5)),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            if (maintenanceGetServiceMaintenanceResponse
                                .succeeded) {
                              return Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 10, 0, 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11, 10, 11, 0),
                                        child: Builder(
                                          builder: (context) {
                                            final equipTRee =
                                                maintenanceGetServiceMaintenanceResponse
                                                    .jsonBody
                                                    .toList();

                                            return SingleChildScrollView(
                                              primary: false,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: List.generate(
                                                    equipTRee.length,
                                                    (equipTReeIndex) {
                                                  final equipTReeItem =
                                                      equipTRee[equipTReeIndex];
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.015,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.18,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: functions
                                                                  .colormaintenancetext(
                                                                      getJsonField(
                                                                equipTReeItem,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          12),
                                                            ),
                                                          ),
                                                          InkWell(
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
                                                              context.pushNamed(
                                                                MaintenanceDetailedWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'id':
                                                                      serializeParam(
                                                                    getJsonField(
                                                                      equipTReeItem,
                                                                      r'''$.id''',
                                                                    ).toString(),
                                                                    ParamType
                                                                        .String,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.85,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.schedule_info.title''',
                                                                                    ).toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'SFProText',
                                                                                      fontWeight: FontWeight.w600,
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  )
                                                                                ],
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 16,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.bold,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.85,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                RichText(
                                                                              textScaler: MediaQuery.of(context).textScaler,
                                                                              text: TextSpan(
                                                                                children: [
                                                                                  TextSpan(
                                                                                    text: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.equipment_info.brand_id.name''',
                                                                                    ).toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontWeight: FontWeight.w500,
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: ' ',
                                                                                    style: TextStyle(),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.equipment_info.model_id.name''',
                                                                                    ).toString(),
                                                                                    style: TextStyle(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: ' • ',
                                                                                    style: TextStyle(),
                                                                                  ),
                                                                                  TextSpan(
                                                                                    text: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.equipment_info.license_plate_number''',
                                                                                    ).toString(),
                                                                                    style: TextStyle(),
                                                                                  )
                                                                                ],
                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                      fontSize: 13,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.32,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: functions.colormaintenancebackgroundCopy(getJsonField(
                                                                                equipTReeItem,
                                                                                r'''$.status''',
                                                                              ).toString()),
                                                                              borderRadius: BorderRadius.circular(4),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Align(
                                                                                      alignment: AlignmentDirectional(0, 0),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                                                        child: Text(
                                                                                          valueOrDefault<String>(
                                                                                            functions.statusMaintenance(getJsonField(
                                                                                              equipTReeItem,
                                                                                              r'''$.status''',
                                                                                            ).toString()),
                                                                                            '-',
                                                                                          ),
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: functions.colormaintenancetext(getJsonField(
                                                                                                  equipTReeItem,
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
                                                                          Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.42,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Когда выполнить:',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: Color(0xFF667085),
                                                                                                fontSize: 13,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          '${valueOrDefault<String>(
                                                                                            getJsonField(
                                                                                              equipTReeItem,
                                                                                              r'''$.target_value''',
                                                                                            )?.toString(),
                                                                                            '-',
                                                                                          )} км',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: Color(0xFF667085),
                                                                                                fontSize: 13,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.42,
                                                                                    decoration: BoxDecoration(),
                                                                                    child: Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Текущая наработка:',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: Color(0xFF667085),
                                                                                                fontSize: 13,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.w600,
                                                                                              ),
                                                                                        ),
                                                                                        Text(
                                                                                          '${valueOrDefault<String>(
                                                                                            getJsonField(
                                                                                              equipTReeItem,
                                                                                              r'''$.current_value''',
                                                                                            )?.toString(),
                                                                                            '-',
                                                                                          )} км',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: Color(0xFF667085),
                                                                                                fontSize: 13,
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                                child: Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.42,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Периодичность:',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'SFProText',
                                                                                                  color: Color(0xFF667085),
                                                                                                  fontSize: 13,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.42,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              '${valueOrDefault<String>(
                                                                                                getJsonField(
                                                                                                  equipTReeItem,
                                                                                                  r'''$.schedule_info.interval_value''',
                                                                                                )?.toString(),
                                                                                                '-',
                                                                                              )} км',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: Color(0xFF667085),
                                                                                                    fontSize: 13,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.42,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Text(
                                                                                            'Дата выполнения:',
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'SFProText',
                                                                                                  color: Color(0xFF667085),
                                                                                                  fontSize: 13,
                                                                                                  letterSpacing: 0.0,
                                                                                                  fontWeight: FontWeight.w600,
                                                                                                ),
                                                                                          ),
                                                                                          Text(
                                                                                            valueOrDefault<String>(
                                                                                              dateTimeFormat(
                                                                                                "dd.MM.y H:mm",
                                                                                                functions.stringToDate(valueOrDefault<String>(
                                                                                                  getJsonField(
                                                                                                    equipTReeItem,
                                                                                                    r'''$.completed_at''',
                                                                                                  )?.toString(),
                                                                                                  '-',
                                                                                                )),
                                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                                              ),
                                                                                              '-',
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'SFProText',
                                                                                                  color: Color(0xFF667085),
                                                                                                  fontSize: 13,
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
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
                                                                        await showModalBottomSheet(
                                                                          isScrollControlled:
                                                                              true,
                                                                          backgroundColor:
                                                                              Colors.transparent,
                                                                          enableDrag:
                                                                              false,
                                                                          context:
                                                                              context,
                                                                          builder:
                                                                              (context) {
                                                                            return GestureDetector(
                                                                              onTap: () {
                                                                                FocusScope.of(context).unfocus();
                                                                                FocusManager.instance.primaryFocus?.unfocus();
                                                                              },
                                                                              child: Padding(
                                                                                padding: MediaQuery.viewInsetsOf(context),
                                                                                child: Container(
                                                                                  height: MediaQuery.sizeOf(context).height * 0.4,
                                                                                  child: MaintenanceDotsWidget(
                                                                                    id: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.id''',
                                                                                    ).toString(),
                                                                                    status: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.status''',
                                                                                    ).toString(),
                                                                                    equipinfo: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.equipment_info''',
                                                                                    ),
                                                                                    nazvanie: getJsonField(
                                                                                      equipTReeItem,
                                                                                      r'''$.schedule_info.title''',
                                                                                    ).toString(),
                                                                                    json: equipTReeItem,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            );
                                                                          },
                                                                        ).then((value) =>
                                                                            safeSetState(() {}));
                                                                      },
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .more_vert,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryText,
                                                                        size:
                                                                            24,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(
                                                            SizedBox(width: 5)),
                                                      ),
                                                      Divider(
                                                        thickness: 2,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                      ),
                                                    ],
                                                  );
                                                }),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      if ((functions
                                                  .divideUntilLessThanThousand(
                                                      functions.stringtoint(
                                                          getJsonField(
                                                    columnGetServiceMaintenanceCountResponse
                                                        .jsonBody,
                                                    r'''$.count''',
                                                  ).toString()))
                                                  .toString() ==
                                              '0') ||
                                          (functions.stringtoint(getJsonField(
                                                columnGetServiceMaintenanceCountResponse
                                                    .jsonBody,
                                                r'''$.count''',
                                              ).toString()) <
                                              10)) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                          ),
                                        );
                                      } else {
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10, 10, 10, 15),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  if (_model.page <= 1) {
                                                    return;
                                                  }

                                                  _model.page =
                                                      _model.page + -1;
                                                  safeSetState(() {});
                                                  safeSetState(() {
                                                    _model
                                                        .clearMaintenanceCache();
                                                    _model.apiRequestCompleted2 =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForApiRequestCompleted2(
                                                          minWait: 500);
                                                },
                                                text: 'Назад',
                                                icon: Icon(
                                                  Icons.chevron_left,
                                                  size: 15,
                                                ),
                                                options: FFButtonOptions(
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 0, 16, 0),
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  elevation: 0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              Text(
                                                '${_model.page.toString()} из ${functions.divideUntilLessThanThousand(functions.stringtoint(getJsonField(
                                                      columnGetServiceMaintenanceCountResponse
                                                          .jsonBody,
                                                      r'''$.count''',
                                                    ).toString())).toString()}',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 16,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                              ),
                                              FFButtonWidget(
                                                onPressed: () async {
                                                  _model.page = _model.page + 1;
                                                  safeSetState(() {});
                                                  safeSetState(() {
                                                    _model
                                                        .clearMaintenanceCache();
                                                    _model.apiRequestCompleted2 =
                                                        false;
                                                  });
                                                  await _model
                                                      .waitForApiRequestCompleted2(
                                                          minWait: 500);
                                                },
                                                text: 'Вперед',
                                                icon: Icon(
                                                  Icons.chevron_right,
                                                  size: 15,
                                                ),
                                                options: FFButtonOptions(
                                                  height: 40,
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(16, 0, 16, 0),
                                                  iconAlignment:
                                                      IconAlignment.end,
                                                  iconPadding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(0, 0, 0, 0),
                                                  iconColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  elevation: 0,
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primary,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Container(
                                height: MediaQuery.sizeOf(context).height * 0.9,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 5, 0, 5),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.915,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    decoration: BoxDecoration(
                                                      color: Color(0xFFC6C9CF),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.7,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.5,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.02,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(height: 5)),
                                                  ),
                                                  Icon(
                                                    Icons.more_vert,
                                                    color: Color(0xFF8291B0),
                                                    size: 24,
                                                  ),
                                                ].divide(SizedBox(width: 5)),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 5),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.838,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.02,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFFC6C9CF),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                  ]
                                                      .divide(
                                                          SizedBox(height: 5))
                                                      .addToStart(
                                                          SizedBox(height: 5)),
                                                ),
                                              ),
                                              Divider(
                                                thickness: 2,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .accent4,
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
