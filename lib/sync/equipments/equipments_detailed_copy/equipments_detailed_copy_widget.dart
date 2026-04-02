import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/profile/defects/f_a_bprofile/f_a_bprofile_widget.dart';
import '/profile/defects/maintenance_dots/maintenance_dots_widget.dart';
import '/sync/equipments/settings_copy/settings_copy_widget.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'equipments_detailed_copy_model.dart';
export 'equipments_detailed_copy_model.dart';

class EquipmentsDetailedCopyWidget extends StatefulWidget {
  const EquipmentsDetailedCopyWidget({
    super.key,
    this.json,
    required this.tab,
  });

  final dynamic json;
  final int? tab;

  static String routeName = 'EquipmentsDetailedCopy';
  static String routePath = '/equipmentsDetailedCopy';

  @override
  State<EquipmentsDetailedCopyWidget> createState() =>
      _EquipmentsDetailedCopyWidgetState();
}

class _EquipmentsDetailedCopyWidgetState
    extends State<EquipmentsDetailedCopyWidget> with TickerProviderStateMixin {
  late EquipmentsDetailedCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EquipmentsDetailedCopyModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      safeSetState(() {
        _model.tabBarController!.animateTo(
          widget!.tab!,
          duration: Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      });
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 9,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
      future: GetEquipsByIDCall.call(
        access: currentAuthenticationToken,
        id: widget!.json?.toString(),
        work: FFAppState().workspace,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
        final equipmentsDetailedCopyGetEquipsByIDResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await showModalBottomSheet(
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  enableDrag: false,
                  context: context,
                  builder: (context) {
                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      child: Padding(
                        padding: MediaQuery.viewInsetsOf(context),
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.4,
                          child: FABprofileWidget(
                            brand: valueOrDefault<String>(
                              getJsonField(
                                equipmentsDetailedCopyGetEquipsByIDResponse
                                    .jsonBody,
                                r'''$.brand_id.name''',
                              )?.toString(),
                              '-',
                            ),
                            model: valueOrDefault<String>(
                              getJsonField(
                                equipmentsDetailedCopyGetEquipsByIDResponse
                                    .jsonBody,
                                r'''$.model_id.name''',
                              )?.toString(),
                              '-',
                            ),
                            licenseplate: valueOrDefault<String>(
                              getJsonField(
                                equipmentsDetailedCopyGetEquipsByIDResponse
                                    .jsonBody,
                                r'''$.license_plate_number''',
                              )?.toString(),
                              '-',
                            ),
                            id: valueOrDefault<String>(
                              getJsonField(
                                equipmentsDetailedCopyGetEquipsByIDResponse
                                    .jsonBody,
                                r'''$.id''',
                              )?.toString(),
                              '-',
                            ),
                            lastmileage: functions.jsonToString(getJsonField(
                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                          .jsonBody,
                                      r'''$.mileage''',
                                    )) !=
                                    'ENGINE_TIME'
                                ? getJsonField(
                                    equipmentsDetailedCopyGetEquipsByIDResponse
                                        .jsonBody,
                                    r'''$.mileage.Value''',
                                  )
                                : 0,
                            gpsid: getJsonField(
                              equipmentsDetailedCopyGetEquipsByIDResponse
                                  .jsonBody,
                              r'''$.gps_id''',
                            ),
                            lastmotohour: functions.jsonToString(getJsonField(
                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                          .jsonBody,
                                      r'''$.mileage''',
                                    )) ==
                                    'ENGINE_TIME'
                                ? getJsonField(
                                    equipmentsDetailedCopyGetEquipsByIDResponse
                                        .jsonBody,
                                    r'''$.mileage.Value''',
                                  )
                                : 0,
                          ),
                        ),
                      ),
                    );
                  },
                ).then((value) => safeSetState(() {}));
              },
              backgroundColor: Color(0xFF3466E7),
              elevation: 8,
              child: Icon(
                Icons.add,
                color: FlutterFlowTheme.of(context).info,
                size: 24,
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF3466E7),
                  size: 30,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                valueOrDefault<String>(
                  '${getJsonField(
                    equipmentsDetailedCopyGetEquipsByIDResponse.jsonBody,
                    r'''$.brand_id.name''',
                  ).toString()} ${getJsonField(
                    equipmentsDetailedCopyGetEquipsByIDResponse.jsonBody,
                    r'''$.model_id.name''',
                  ).toString()}',
                  '-',
                ),
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'SFProText',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 17,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [],
              centerTitle: false,
            ),
            body: SafeArea(
              top: true,
              child: FutureBuilder<ApiCallResponse>(
                future: GetDefectsbyEquipIdCall.call(
                  access: currentAuthenticationToken,
                  ticketId: widget!.json?.toString(),
                  work: FFAppState().workspace,
                ),
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
                  final columnGetDefectsbyEquipIdResponse = snapshot.data!;

                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                        ),
                        child: Padding(
                          padding:
                              EdgeInsetsDirectional.fromSTEB(20, 10, 0, 10),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          getJsonField(
                                            equipmentsDetailedCopyGetEquipsByIDResponse
                                                .jsonBody,
                                            r'''$.avatar''',
                                          ).toString(),
                                          fit: BoxFit.contain,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(
                                            'assets/images/error_image.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        allowRotation: false,
                                        tag: getJsonField(
                                          equipmentsDetailedCopyGetEquipsByIDResponse
                                              .jsonBody,
                                          r'''$.avatar''',
                                        ).toString(),
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: getJsonField(
                                    equipmentsDetailedCopyGetEquipsByIDResponse
                                        .jsonBody,
                                    r'''$.avatar''',
                                  ).toString(),
                                  transitionOnUserGestures: true,
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      getJsonField(
                                        equipmentsDetailedCopyGetEquipsByIDResponse
                                            .jsonBody,
                                        r'''$.avatar''',
                                      ).toString(),
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(
                                        'assets/images/error_image.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 0, 0, 0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.6,
                                    decoration: BoxDecoration(),
                                    child: FutureBuilder<ApiCallResponse>(
                                      future: GPSTokenCall.call(),
                                      builder: (context, snapshot) {
                                        // Customize what your widget looks like when it's loading.
                                        if (!snapshot.hasData) {
                                          return Center(
                                            child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: CircularProgressIndicator(
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
                                        final columnGPSTokenResponse =
                                            snapshot.data!;

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipmentsDetailedCopyGetEquipsByIDResponse
                                                            .jsonBody,
                                                        r'''$.brand_id.name''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 17,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text: ' ',
                                                    style: TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipmentsDetailedCopyGetEquipsByIDResponse
                                                            .jsonBody,
                                                        r'''$.model_id.name''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 17,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' ',
                                                    style: TextStyle(),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipmentsDetailedCopyGetEquipsByIDResponse
                                                            .jsonBody,
                                                        r'''$.license_plate_number''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      color: Color(0xFF3466E7),
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 17,
                                                    ),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 15,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                            ),
                                            FutureBuilder<ApiCallResponse>(
                                              future: ObjectstatusCall.call(
                                                id: getJsonField(
                                                  equipmentsDetailedCopyGetEquipsByIDResponse
                                                      .jsonBody,
                                                  r'''$.gps_id''',
                                                ),
                                                access: GPSTokenCall.access(
                                                  columnGPSTokenResponse
                                                      .jsonBody,
                                                ),
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
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final richTextObjectstatusResponse =
                                                    snapshot.data!;

                                                return RichText(
                                                  textScaler:
                                                      MediaQuery.of(context)
                                                          .textScaler,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: 'Пробег: ',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                      TextSpan(
                                                        text: valueOrDefault<
                                                            String>(
                                                          functions.formatMileage(
                                                              ObjectstatusCall
                                                                  .mileage(
                                                            richTextObjectstatusResponse
                                                                .jsonBody,
                                                          )),
                                                          '-',
                                                        ),
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: 14,
                                                        ),
                                                      )
                                                    ],
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 15,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                  ),
                                                );
                                              },
                                            ),
                                            RichText(
                                              textScaler: MediaQuery.of(context)
                                                  .textScaler,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'Год: ',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          fontSize: 14,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        equipmentsDetailedCopyGetEquipsByIDResponse
                                                            .jsonBody,
                                                        r'''$.year''',
                                                      )?.toString(),
                                                      '-',
                                                    ),
                                                    style: TextStyle(
                                                      fontFamily: 'SFProText',
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                ],
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 15,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: FutureBuilder<ApiCallResponse>(
                            future: GPSTokenCall.call(),
                            builder: (context, snapshot) {
                              // Customize what your widget looks like when it's loading.
                              if (!snapshot.hasData) {
                                return Center(
                                  child: SizedBox(
                                    width: 50,
                                    height: 50,
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                      ),
                                    ),
                                  ),
                                );
                              }
                              final tabBarGPSTokenResponse = snapshot.data!;

                              return Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: FlutterFlowButtonTabBar(
                                      useToggleButtonStyle: false,
                                      isScrollable: true,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      unselectedLabelStyle:
                                          FlutterFlowTheme.of(context)
                                              .labelMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                      labelColor: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context).primary,
                                      backgroundColor: Color(0xFF2A61ED),
                                      borderWidth: 2,
                                      borderRadius: 8,
                                      elevation: 0,
                                      labelPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              10, 0, 10, 0),
                                      buttonMargin:
                                          EdgeInsetsDirectional.fromSTEB(
                                              8, 0, 8, 0),
                                      tabs: [
                                        Tab(
                                          text: 'Сведения',
                                        ),
                                        Tab(
                                          text: 'Журнал дефектов',
                                        ),
                                        Tab(
                                          text: 'История ремонтов',
                                        ),
                                        Tab(
                                          text: 'График обслуживания',
                                        ),
                                        Tab(
                                          text: 'Журнал расходов',
                                        ),
                                        Tab(
                                          text: 'История наработок',
                                        ),
                                        Tab(
                                          text: 'Местоположение',
                                        ),
                                        Tab(
                                          text: 'Ответственные',
                                        ),
                                        Tab(
                                          text: 'Вложения',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (i) async {
                                        [
                                          () async {},
                                          () async {},
                                          () async {},
                                          () async {},
                                          () async {},
                                          () async {},
                                          () async {},
                                          () async {},
                                          () async {}
                                        ][i]();
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      controller: _model.tabBarController,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(20, 10, 20, 70),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 0, 10, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        20,
                                                                        0,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Категория',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.5,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      getJsonField(
                                                                        equipmentsDetailedCopyGetEquipsByIDResponse
                                                                            .jsonBody,
                                                                        r'''$.classification_id.name''',
                                                                      )?.toString(),
                                                                      '-',
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          fontSize:
                                                                              15,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Компания',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.company_id.name''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Департамент',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.department_id.title''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Колонна',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.column.title''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Объект',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.sector.title''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'VIN',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.identification_number''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Серийный номер',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.4,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.serial_number''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Номер тех. паспорта',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    equipmentsDetailedCopyGetEquipsByIDResponse
                                                                        .jsonBody,
                                                                    r'''$.passport_number''',
                                                                  )?.toString(),
                                                                  '-',
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      fontSize:
                                                                          15,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                'Номер двигателя',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                              Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  getJsonField(
                                                                    equipmentsDetailedCopyGetEquipsByIDResponse
                                                                        .jsonBody,
                                                                    r'''$.engine_number''',
                                                                  )?.toString(),
                                                                  '-',
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .end,
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      fontSize:
                                                                          15,
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Divider(
                                                            thickness: 1,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        20),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Топливо',
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondaryText,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                Text(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    getJsonField(
                                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                                          .jsonBody,
                                                                      r'''$.fuel_type''',
                                                                    )?.toString(),
                                                                    '-',
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 10)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ].divide(SizedBox(height: 10)),
                                            ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            if (functions
                                                    .jsonToList(
                                                        columnGetDefectsbyEquipIdResponse
                                                            .jsonBody)
                                                    .length !=
                                                0) {
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 0, 10),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final defects =
                                                          columnGetDefectsbyEquipIdResponse
                                                              .jsonBody
                                                              .toList();

                                                      return SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
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
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    context
                                                                        .pushNamed(
                                                                      DetailedDefectsOfflineCopyWidget
                                                                          .routeName,
                                                                      queryParameters:
                                                                          {
                                                                        'id':
                                                                            serializeParam(
                                                                          getJsonField(
                                                                            defectsItem,
                                                                            r'''$.id''',
                                                                          ).toString(),
                                                                          ParamType
                                                                              .String,
                                                                        ),
                                                                        'storehousestatus':
                                                                            serializeParam(
                                                                          functions
                                                                                      .listlength(getJsonField(
                                                                                        defectsItem,
                                                                                        r'''$.storehouse_order_statuses''',
                                                                                        true,
                                                                                      ))
                                                                                      .toString() ==
                                                                                  '0'
                                                                              ? 'nul'
                                                                              : valueOrDefault<String>(
                                                                                  functions
                                                                                      .jsonToList(getJsonField(
                                                                                        defectsItem,
                                                                                        r'''$.storehouse_order_statuses''',
                                                                                      ))
                                                                                      .lastOrNull
                                                                                      ?.toString(),
                                                                                  'n',
                                                                                ),
                                                                          ParamType
                                                                              .String,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width,
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
                                                                        Column(
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
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              11,
                                                                              0,
                                                                              11,
                                                                              0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
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
                                                                                  'assets/images/Defect.png',
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                              Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                decoration: BoxDecoration(),
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Padding(
                                                                                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 1, 0),
                                                                                      child: Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Container(
                                                                                            decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(16),
                                                                                            ),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                                                                              child: Row(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                children: [
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                                                                                                    child: Container(
                                                                                                      width: MediaQuery.sizeOf(context).width * 0.022,
                                                                                                      height: MediaQuery.sizeOf(context).width * 0.022,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: functions.colorDefectCopyCopy(getJsonField(
                                                                                                          defectsItem,
                                                                                                          r'''$.status''',
                                                                                                        ).toString()),
                                                                                                        shape: BoxShape.circle,
                                                                                                      ),
                                                                                                    ),
                                                                                                  ),
                                                                                                  Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                                                                    child: Text(
                                                                                                      valueOrDefault<String>(
                                                                                                        functions.statusToRus(getJsonField(
                                                                                                          defectsItem,
                                                                                                          r'''$.status''',
                                                                                                        ).toString()),
                                                                                                        '-',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'SFProText',
                                                                                                            fontSize: 12,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Expanded(
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                                                                                              child: Text(
                                                                                                dateTimeFormat(
                                                                                                  "MMMMEEEEd",
                                                                                                  functions.stringToDate(getJsonField(
                                                                                                    defectsItem,
                                                                                                    r'''$.created_at''',
                                                                                                  ).toString()),
                                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                                ).maybeHandleOverflow(
                                                                                                  maxChars: 50,
                                                                                                ),
                                                                                                textAlign: TextAlign.end,
                                                                                                style: FlutterFlowTheme.of(context).titleMedium.override(
                                                                                                      fontFamily: 'SFProText',
                                                                                                      color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                      fontSize: 12,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                    Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 2),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              getJsonField(
                                                                                                defectsItem,
                                                                                                r'''$.title''',
                                                                                              ).toString(),
                                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    fontSize: 15,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.normal,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 5)).addToStart(SizedBox(height: 5)).addToEnd(SizedBox(height: 5)),
                                                                                ),
                                                                              ),
                                                                            ].divide(SizedBox(width: 5)),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          })
                                                              .divide(SizedBox(
                                                                  height: 5))
                                                              .addToStart(
                                                                  SizedBox(
                                                                      height:
                                                                          5)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return Align(
                                                alignment:
                                                    AlignmentDirectional(0, -1),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 20, 0, 0),
                                                  child: Text(
                                                    'Журнал дефектов пуст',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .headlineMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 20,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                        FutureBuilder<ApiCallResponse>(
                                          future: GetTicketsByEquipIdCall.call(
                                            access: currentAuthenticationToken,
                                            equip: widget!.json?.toString(),
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final containerGetTicketsByEquipIdResponse =
                                                snapshot.data!;

                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              child: Builder(
                                                builder: (context) {
                                                  if (containerGetTicketsByEquipIdResponse
                                                          .jsonBody !=
                                                      null) {
                                                    return Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 10, 0, 0),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Container(
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
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            1,
                                                                            0,
                                                                            0),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final defects =
                                                                        containerGetTicketsByEquipIdResponse
                                                                            .jsonBody
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
                                                                            defects[defectsIndex];
                                                                        return Align(
                                                                          alignment: AlignmentDirectional(
                                                                              0,
                                                                              0),
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
                                                                              context.pushNamed(
                              NaryadsOfflineWidget.routeName,
                              queryParameters: {
                                'json': serializeParam(
                                  defectsItem,
                                  ParamType.JSON,
                                ),
                              }.withoutNulls,
                            );
                                                                            },
                                                                            child:
                                                                                Container(
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
                                                                                          'assets/images/Defect.png',
                                                                                          fit: BoxFit.contain,
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
                                                                                                r'''$.title''',
                                                                                              ).toString().maybeHandleOverflow(
                                                                                                    maxChars: 35,
                                                                                                    replacement: '…',
                                                                                                  ),
                                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    fontSize: 17,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.28,
                                                                                            decoration: BoxDecoration(
                                                                                              color: functions.colorNaryadsCopy(getJsonField(
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
                                                                                                            functions.statusNaryads(getJsonField(
                                                                                                              defectsItem,
                                                                                                              r'''$.status''',
                                                                                                            ).toString()),
                                                                                                            '-',
                                                                                                          ),
                                                                                                          textAlign: TextAlign.center,
                                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                                fontFamily: 'SFProText',
                                                                                                                color: functions.colorNaryads(getJsonField(
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
                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                          children: [
                                                                                            Icon(
                                                                                              Icons.calendar_today_outlined,
                                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                                              size: 20,
                                                                                            ),
                                                                                            Expanded(
                                                                                              child: Text(
                                                                                                dateTimeFormat(
                                                                                                  "MMMMEEEEd",
                                                                                                  functions.stringToDate(getJsonField(
                                                                                                    defectsItem,
                                                                                                    r'''$.created_at''',
                                                                                                  ).toString()),
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
                                                                                  if (defectsItem != functions.jsonToList(containerGetTicketsByEquipIdResponse.jsonBody).lastOrNull)
                                                                                    Divider(
                                                                                      thickness: 2,
                                                                                      color: FlutterFlowTheme.of(context).warning,
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).addToStart(SizedBox(height: 15)).addToEnd(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, -1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 0),
                                                        child: Text(
                                                          'Отсутствуют история наработок',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
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
                                        FutureBuilder<ApiCallResponse>(
                                          future: (_model
                                                      .apiRequestCompleter1 ??=
                                                  Completer<ApiCallResponse>()
                                                    ..complete(
                                                        GetServiceMaintenanceCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      work: FFAppState()
                                                          .workspace,
                                                      page: '1',
                                                      status: () {
                                                        if (_model.state ==
                                                            'Скоро') {
                                                          return '&status=SOON';
                                                        } else if (_model
                                                                .state ==
                                                            'Просрочен') {
                                                          return '&status=EXPIRED';
                                                        } else if (_model
                                                                .state ==
                                                            'Выполнен') {
                                                          return '&status=COMPLETED';
                                                        } else if (_model
                                                                .state ==
                                                            'Пропущенные') {
                                                          return '&status=MISSED';
                                                        } else {
                                                          return '';
                                                        }
                                                      }(),
                                                      title:
                                                          '&equipment_id=${widget!.json?.toString()}',
                                                    )))
                                              .future,
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
                                            final servicemaintenanceGetServiceMaintenanceResponse =
                                                snapshot.data!;

                                            return SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 5, 0, 0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.1,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SingleChildScrollView(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.state =
                                                                        'Все';
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(() =>
                                                                        _model.apiRequestCompleter1 =
                                                                            null);
                                                                    await _model
                                                                        .waitForApiRequestCompleted1();
                                                                  },
                                                                  text: 'Все',
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 40,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    color: _model.state ==
                                                                            'Все'
                                                                        ? Color(
                                                                            0x1A3466E7)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color: _model.state == 'Все'
                                                                              ? Color(0xFF3466E7)
                                                                              : Color(0xFF8291B0),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.state =
                                                                        'Скоро';
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(() =>
                                                                        _model.apiRequestCompleter1 =
                                                                            null);
                                                                    await _model
                                                                        .waitForApiRequestCompleted1();
                                                                  },
                                                                  text: 'Скоро',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .circle,
                                                                    size: 15,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 40,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    iconColor:
                                                                        Color(
                                                                            0xFFFFC05B),
                                                                    color: _model.state ==
                                                                            'Скоро'
                                                                        ? Color(
                                                                            0x1A3466E7)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color: _model.state == 'Скоро'
                                                                              ? Color(0xFF3466E7)
                                                                              : Color(0xFF8291B0),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.state =
                                                                        'Просрочен';
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(() =>
                                                                        _model.apiRequestCompleter1 =
                                                                            null);
                                                                    await _model
                                                                        .waitForApiRequestCompleted1();
                                                                  },
                                                                  text:
                                                                      'Просрочен',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .circle_sharp,
                                                                    size: 15,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 40,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    iconColor:
                                                                        Color(
                                                                            0xFFDC0E0E),
                                                                    color: _model.state ==
                                                                            'Просрочен'
                                                                        ? Color(
                                                                            0x1A3466E7)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color: _model.state == 'Просрочен'
                                                                              ? Color(0xFF3466E7)
                                                                              : Color(0xFF8291B0),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.state =
                                                                        'Выполнен';
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(() =>
                                                                        _model.apiRequestCompleter1 =
                                                                            null);
                                                                    await _model
                                                                        .waitForApiRequestCompleted1();
                                                                  },
                                                                  text:
                                                                      'Выполнен',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .circle,
                                                                    size: 15,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 40,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    iconColor:
                                                                        Color(
                                                                            0xFF09BD26),
                                                                    color: _model.state ==
                                                                            'Выполнен'
                                                                        ? Color(
                                                                            0x1A3466E7)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color: _model.state == 'Выполнен'
                                                                              ? Color(0xFF3466E7)
                                                                              : Color(0xFF8291B0),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                FFButtonWidget(
                                                                  onPressed:
                                                                      () async {
                                                                    _model.state =
                                                                        'Пропущенные';
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(() =>
                                                                        _model.apiRequestCompleter1 =
                                                                            null);
                                                                    await _model
                                                                        .waitForApiRequestCompleted1();
                                                                  },
                                                                  text:
                                                                      'Пропущенные',
                                                                  icon: Icon(
                                                                    Icons
                                                                        .circle,
                                                                    size: 15,
                                                                  ),
                                                                  options:
                                                                      FFButtonOptions(
                                                                    height: 40,
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            16,
                                                                            0),
                                                                    iconPadding:
                                                                        EdgeInsetsDirectional.fromSTEB(
                                                                            0,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                    iconColor:
                                                                        Color(
                                                                            0xFFB2BBCE),
                                                                    color: _model.state ==
                                                                            'Пропущенные'
                                                                        ? Color(
                                                                            0x1A3466E7)
                                                                        : FlutterFlowTheme.of(context)
                                                                            .secondaryBackground,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color: _model.state == 'Пропущенные'
                                                                              ? Color(0xFF3466E7)
                                                                              : Color(0xFF8291B0),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                    elevation:
                                                                        0,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .divide(
                                                                      SizedBox(
                                                                          width:
                                                                              5))
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          width:
                                                                              10))
                                                                  .addToEnd(
                                                                      SizedBox(
                                                                          width:
                                                                              10)),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child:
                                                                SingleChildScrollView(
                                                              scrollDirection:
                                                                  Axis.horizontal,
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Builder(
                                                                    builder:
                                                                        (context) {
                                                                      if (_model.dropDownColumnValue !=
                                                                              null &&
                                                                          _model.dropDownColumnValue !=
                                                                              '') {
                                                                        return FlutterFlowIconButton(
                                                                          borderColor:
                                                                              Colors.transparent,
                                                                          borderRadius:
                                                                              20,
                                                                          borderWidth:
                                                                              1,
                                                                          buttonSize:
                                                                              MediaQuery.sizeOf(context).width * 0.1,
                                                                          icon:
                                                                              Icon(
                                                                            Icons.close,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          onPressed:
                                                                              () async {
                                                                            safeSetState(() {
                                                                              _model.dropDownColumnValueController?.reset();
                                                                              _model.dropDownColumnValue = null;
                                                                            });
                                                                          },
                                                                        );
                                                                      } else {
                                                                        return Container(
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                        );
                                                                      }
                                                                    },
                                                                  ),
                                                                  FlutterFlowDropDown<
                                                                      String>(
                                                                    controller: _model
                                                                            .dropDownColumnValueController ??=
                                                                        FormFieldController<
                                                                            String>(
                                                                      _model.dropDownColumnValue ??=
                                                                          '',
                                                                    ),
                                                                    options: List<
                                                                        String>.from([
                                                                      'Option 3'
                                                                    ]),
                                                                    optionLabels: [
                                                                      'Option 3'
                                                                    ],
                                                                    onChanged: (val) =>
                                                                        safeSetState(() =>
                                                                            _model.dropDownColumnValue =
                                                                                val),
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.4,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    textStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.readexPro(
                                                                            fontWeight:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                    hintText:
                                                                        'Колонна',
                                                                    icon: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_rounded,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size: 24,
                                                                    ),
                                                                    fillColor: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    elevation:
                                                                        2,
                                                                    borderColor:
                                                                        FlutterFlowTheme.of(context)
                                                                            .warning,
                                                                    borderWidth:
                                                                        1,
                                                                    borderRadius:
                                                                        8,
                                                                    margin: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            12,
                                                                            0,
                                                                            12,
                                                                            0),
                                                                    hidesUnderline:
                                                                        true,
                                                                    isOverButton:
                                                                        false,
                                                                    isSearchable:
                                                                        false,
                                                                    isMultiSelect:
                                                                        false,
                                                                  ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            10))
                                                                    .addToStart(
                                                                        SizedBox(
                                                                            width:
                                                                                5))
                                                                    .addToEnd(SizedBox(
                                                                        width:
                                                                            10)),
                                                              ),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToEnd(SizedBox(
                                                                height: 5)),
                                                      ),
                                                    ),
                                                  ),
                                                  Builder(
                                                    builder: (context) {
                                                      if (servicemaintenanceGetServiceMaintenanceResponse
                                                          .succeeded) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          10,
                                                                          0,
                                                                          10),
                                                              child: Container(
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
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          11,
                                                                          10,
                                                                          11,
                                                                          0),
                                                                  child:
                                                                      Builder(
                                                                    builder:
                                                                        (context) {
                                                                      final equipTRee = servicemaintenanceGetServiceMaintenanceResponse
                                                                          .jsonBody
                                                                          .toList();

                                                                      return SingleChildScrollView(
                                                                        primary:
                                                                            false,
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: List.generate(
                                                                              equipTRee.length,
                                                                              (equipTReeIndex) {
                                                                            final equipTReeItem =
                                                                                equipTRee[equipTReeIndex];
                                                                            return Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.015,
                                                                                      height: MediaQuery.sizeOf(context).height * 0.18,
                                                                                      decoration: BoxDecoration(
                                                                                        color: functions.colormaintenancetext(getJsonField(
                                                                                          equipTReeItem,
                                                                                          r'''$.status''',
                                                                                        ).toString()),
                                                                                        borderRadius: BorderRadius.circular(12),
                                                                                      ),
                                                                                    ),
                                                                                    InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        context.pushNamed(
                                                                                          MaintenanceDetailedWidget.routeName,
                                                                                          queryParameters: {
                                                                                            'id': serializeParam(
                                                                                              getJsonField(
                                                                                                equipTReeItem,
                                                                                                r'''$.id''',
                                                                                              ).toString(),
                                                                                              ParamType.String,
                                                                                            ),
                                                                                          }.withoutNulls,
                                                                                        );
                                                                                      },
                                                                                      child: Column(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                                        children: [
                                                                                          Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                                            children: [
                                                                                              Container(
                                                                                                decoration: BoxDecoration(),
                                                                                                child: Column(
                                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                  children: [
                                                                                                    Container(
                                                                                                      width: MediaQuery.sizeOf(context).width * 0.85,
                                                                                                      decoration: BoxDecoration(),
                                                                                                      child: RichText(
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
                                                                                                      width: MediaQuery.sizeOf(context).width * 0.85,
                                                                                                      decoration: BoxDecoration(),
                                                                                                      child: RichText(
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
                                                                                                      width: MediaQuery.sizeOf(context).width * 0.32,
                                                                                                      decoration: BoxDecoration(
                                                                                                        color: functions.colorCTObackground(getJsonField(
                                                                                                          equipTReeItem,
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
                                                                                                      mainAxisSize: MainAxisSize.max,
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
                                                                                                splashColor: Colors.transparent,
                                                                                                focusColor: Colors.transparent,
                                                                                                hoverColor: Colors.transparent,
                                                                                                highlightColor: Colors.transparent,
                                                                                                onTap: () async {
                                                                                                  await showModalBottomSheet(
                                                                                                    isScrollControlled: true,
                                                                                                    backgroundColor: Colors.transparent,
                                                                                                    enableDrag: false,
                                                                                                    context: context,
                                                                                                    builder: (context) {
                                                                                                      return GestureDetector(
                                                                                                        onTap: () {
                                                                                                          FocusScope.of(context).unfocus();
                                                                                                          FocusManager.instance.primaryFocus?.unfocus();
                                                                                                        },
                                                                                                        child: Padding(
                                                                                                          padding: MediaQuery.viewInsetsOf(context),
                                                                                                          child: Container(
                                                                                                            height: MediaQuery.sizeOf(context).height * 0.35,
                                                                                                            child: MaintenanceDotsWidget(
                                                                                                              id: getJsonField(
                                                                                                                equipTReeItem,
                                                                                                                r'''$.id''',
                                                                                                              ).toString(),
                                                                                                              status: getJsonField(
                                                                                                                equipTReeItem,
                                                                                                                r'''$.status''',
                                                                                                              ).toString(),
                                                                                                              nazvanie: getJsonField(
                                                                                                                equipTReeItem,
                                                                                                                r'''$.schedule_info.title''',
                                                                                                              ).toString(),
                                                                                                              equipinfo: getJsonField(
                                                                                                                equipTReeItem,
                                                                                                                r'''$.equipment_info''',
                                                                                                              ),
                                                                                                            ),
                                                                                                          ),
                                                                                                        ),
                                                                                                      );
                                                                                                    },
                                                                                                  ).then((value) => safeSetState(() {}));
                                                                                                },
                                                                                                child: Icon(
                                                                                                  Icons.more_vert,
                                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                                  size: 24,
                                                                                                ),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(width: 5)),
                                                                                ),
                                                                                Divider(
                                                                                  thickness: 2,
                                                                                  color: FlutterFlowTheme.of(context).warning,
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
                                                          ],
                                                        );
                                                      } else {
                                                        return Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.9,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
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
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.915,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: [
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.center,
                                                                          children:
                                                                              [
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
                                                                            Icon(
                                                                              Icons.more_vert,
                                                                              color: Color(0xFF8291B0),
                                                                              size: 24,
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
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children:
                                                                                [
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
                                                                          thickness:
                                                                              2,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).accent4,
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
                                        FutureBuilder<ApiCallResponse>(
                                          future: (_model
                                                      .apiRequestCompleter2 ??=
                                                  Completer<ApiCallResponse>()
                                                    ..complete(
                                                        GetExpenseJournalCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      page: _model.expensepage
                                                          .toString(),
                                                      work: FFAppState()
                                                          .workspace,
                                                      number:
                                                          'license_plate_number=${valueOrDefault<String>(
                                                        getJsonField(
                                                          equipmentsDetailedCopyGetEquipsByIDResponse
                                                              .jsonBody,
                                                          r'''$.license_plate_number''',
                                                        )?.toString(),
                                                        '-',
                                                      )}',
                                                      search: _model.textField12TextController
                                                                      .text !=
                                                                  null &&
                                                              _model.textField12TextController
                                                                      .text !=
                                                                  ''
                                                          ? '&nomenclature=${_model.textField12TextController.text}'
                                                          : '',
                                                      date: _model.expensedate !=
                                                                  null &&
                                                              _model.expensedate !=
                                                                  ''
                                                          ? '&startDate=${_model.expensedate}&endDate=${_model.expensedate}'
                                                          : '',
                                                      sum: _model.dropDownBrandValue !=
                                                                  null &&
                                                              _model.dropDownBrandValue !=
                                                                  ''
                                                          ? '&sum=${_model.dropDownBrandValue}'
                                                          : '&sum=asc',
                                                    )))
                                              .future,
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
                                            final container12GetExpenseJournalResponse =
                                                snapshot.data!;

                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              child: Builder(
                                                builder: (context) {
                                                  if (functions
                                                          .jsonToList(
                                                              getJsonField(
                                                            container12GetExpenseJournalResponse
                                                                .jsonBody,
                                                            r'''$.data[:]''',
                                                          ))
                                                          .length !=
                                                      0) {
                                                    return Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.14,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        5,
                                                                        0,
                                                                        0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          13,
                                                                          0,
                                                                          13,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.05,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                8,
                                                                                0,
                                                                                8,
                                                                                0),
                                                                            child:
                                                                                TextFormField(
                                                                              controller: _model.textField12TextController,
                                                                              focusNode: _model.textField12FocusNode,
                                                                              onChanged: (_) => EasyDebounce.debounce(
                                                                                '_model.textField12TextController',
                                                                                Duration(milliseconds: 0),
                                                                                () async {
                                                                                  safeSetState(() => _model.apiRequestCompleter2 = null);
                                                                                  await _model.waitForApiRequestCompleted2();
                                                                                },
                                                                              ),
                                                                              autofocus: false,
                                                                              obscureText: false,
                                                                              decoration: InputDecoration(
                                                                                labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: Color(0xFF99A2AD),
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                                hintText: 'Поиск',
                                                                                hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: Color(0xFF99A2AD),
                                                                                      fontSize: 15,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                                enabledBorder: InputBorder.none,
                                                                                focusedBorder: InputBorder.none,
                                                                                errorBorder: InputBorder.none,
                                                                                focusedErrorBorder: InputBorder.none,
                                                                                contentPadding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                                                                                prefixIcon: Icon(
                                                                                  Icons.search_rounded,
                                                                                  color: Color(0xFF99A2AD),
                                                                                ),
                                                                                suffixIcon: _model.textField12TextController!.text.isNotEmpty
                                                                                    ? InkWell(
                                                                                        onTap: () async {
                                                                                          _model.textField12TextController?.clear();
                                                                                          safeSetState(() => _model.apiRequestCompleter2 = null);
                                                                                          await _model.waitForApiRequestCompleted2();
                                                                                          safeSetState(() {});
                                                                                        },
                                                                                        child: Icon(
                                                                                          Icons.clear,
                                                                                          color: Color(0xFF99A2AD),
                                                                                          size: 15,
                                                                                        ),
                                                                                      )
                                                                                    : null,
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    font: GoogleFonts.readexPro(
                                                                                      fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                      fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                    ),
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                              validator: _model.textField12TextControllerValidator.asValidator(context),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    scrollDirection:
                                                                        Axis.horizontal,
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children:
                                                                          [
                                                                        Builder(
                                                                          builder:
                                                                              (context) {
                                                                            if ((_model.dropDownBrandValue != null && _model.dropDownBrandValue != '') ||
                                                                                (_model.expensedate != null && _model.expensedate != '')) {
                                                                              return FlutterFlowIconButton(
                                                                                borderColor: Colors.transparent,
                                                                                borderRadius: 20,
                                                                                borderWidth: 1,
                                                                                buttonSize: MediaQuery.sizeOf(context).width * 0.1,
                                                                                icon: Icon(
                                                                                  Icons.close,
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  size: 24,
                                                                                ),
                                                                                onPressed: () async {
                                                                                  safeSetState(() {
                                                                                    _model.dropDownBrandValueController?.reset();
                                                                                    _model.dropDownBrandValue = null;
                                                                                  });
                                                                                  _model.expensedate = null;
                                                                                  safeSetState(() {});
                                                                                  safeSetState(() => _model.apiRequestCompleter2 = null);
                                                                                  await _model.waitForApiRequestCompleted2();
                                                                                },
                                                                              );
                                                                            } else {
                                                                              return Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                ),
                                                                              );
                                                                            }
                                                                          },
                                                                        ),
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
                                                                            final _datePickedDate =
                                                                                await showDatePicker(
                                                                              context: context,
                                                                              initialDate: getCurrentTimestamp,
                                                                              firstDate: DateTime(1900),
                                                                              lastDate: DateTime(2050),
                                                                              builder: (context, child) {
                                                                                return wrapInMaterialDatePickerTheme(
                                                                                  context,
                                                                                  child!,
                                                                                  headerBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                  headerForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                  headerTextStyle: FlutterFlowTheme.of(context).headlineLarge.override(
                                                                                        font: GoogleFonts.outfit(
                                                                                          fontWeight: FontWeight.w600,
                                                                                          fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                        ),
                                                                                        fontSize: 32,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w600,
                                                                                        fontStyle: FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                                      ),
                                                                                  pickerBackgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  pickerForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  selectedDateTimeBackgroundColor: FlutterFlowTheme.of(context).primary,
                                                                                  selectedDateTimeForegroundColor: FlutterFlowTheme.of(context).info,
                                                                                  actionButtonForegroundColor: FlutterFlowTheme.of(context).primaryText,
                                                                                  iconSize: 24,
                                                                                );
                                                                              },
                                                                            );

                                                                            if (_datePickedDate !=
                                                                                null) {
                                                                              safeSetState(() {
                                                                                _model.datePicked = DateTime(
                                                                                  _datePickedDate.year,
                                                                                  _datePickedDate.month,
                                                                                  _datePickedDate.day,
                                                                                );
                                                                              });
                                                                            } else if (_model.datePicked !=
                                                                                null) {
                                                                              safeSetState(() {
                                                                                _model.datePicked = getCurrentTimestamp;
                                                                              });
                                                                            }
                                                                            if (!(_model.datePicked ==
                                                                                null)) {
                                                                              _model.expensedate = dateTimeFormat(
                                                                                "y-MM-dd",
                                                                                _model.datePicked,
                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                              );
                                                                              safeSetState(() {});
                                                                              safeSetState(() => _model.apiRequestCompleter2 = null);
                                                                              await _model.waitForApiRequestCompleted2();
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.4,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.04,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                              border: Border.all(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                width: 1,
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.calendar_today,
                                                                                    color: Color(0xFF8291B0),
                                                                                    size: 20,
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(-1, 0),
                                                                                    child: Text(
                                                                                      _model.expensedate != null && _model.expensedate != ''
                                                                                          ? dateTimeFormat(
                                                                                              "dd.MM.y",
                                                                                              functions.stringToDateTime(_model.expensedate!),
                                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                                            )
                                                                                          : 'Период',
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            font: GoogleFonts.readexPro(
                                                                                              fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                            ),
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                            fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        FlutterFlowDropDown<
                                                                            String>(
                                                                          controller: _model.dropDownBrandValueController ??=
                                                                              FormFieldController<String>(
                                                                            _model.dropDownBrandValue ??=
                                                                                '',
                                                                          ),
                                                                          options:
                                                                              List<String>.from([
                                                                            'asc',
                                                                            'desc'
                                                                          ]),
                                                                          optionLabels: [
                                                                            'По возрастанию',
                                                                            'По убыванию'
                                                                          ],
                                                                          onChanged:
                                                                              (val) async {
                                                                            safeSetState(() =>
                                                                                _model.dropDownBrandValue = val);
                                                                            safeSetState(() =>
                                                                                _model.apiRequestCompleter2 = null);
                                                                            await _model.waitForApiRequestCompleted2();
                                                                          },
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.4,
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.04,
                                                                          textStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.readexPro(
                                                                                  fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                          hintText:
                                                                              'Сумма',
                                                                          icon:
                                                                              Icon(
                                                                            Icons.keyboard_arrow_down_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            size:
                                                                                24,
                                                                          ),
                                                                          fillColor:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          elevation:
                                                                              2,
                                                                          borderColor:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                          borderWidth:
                                                                              1,
                                                                          borderRadius:
                                                                              8,
                                                                          margin: EdgeInsetsDirectional.fromSTEB(
                                                                              12,
                                                                              0,
                                                                              12,
                                                                              0),
                                                                          hidesUnderline:
                                                                              true,
                                                                          isOverButton:
                                                                              false,
                                                                          isSearchable:
                                                                              false,
                                                                          isMultiSelect:
                                                                              false,
                                                                        ),
                                                                      ].divide(SizedBox(width: 10)).addToStart(SizedBox(width: 5)).addToEnd(
                                                                              SizedBox(width: 10)),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          13,
                                                                          0,
                                                                          13,
                                                                          0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.93,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Text(
                                                                          'Общая сумма:${functions.roundToTwoDecimals(getJsonField(
                                                                            container12GetExpenseJournalResponse.jsonBody,
                                                                            r'''$.expenses_total''',
                                                                          ))} ₸',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w600,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.5,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child:
                                                              SingleChildScrollView(
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final responsible =
                                                                        getJsonField(
                                                                      container12GetExpenseJournalResponse
                                                                          .jsonBody,
                                                                      r'''$.data''',
                                                                    ).toList();

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          responsible
                                                                              .length,
                                                                          (responsibleIndex) {
                                                                        final responsibleItem =
                                                                            responsible[responsibleIndex];
                                                                        return Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.93,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                            borderRadius:
                                                                                BorderRadius.circular(6),
                                                                          ),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                7,
                                                                                5,
                                                                                7,
                                                                                5),
                                                                            child:
                                                                                Column(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Row(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          children: [
                                                                                            Text(
                                                                                              '${valueOrDefault<String>(
                                                                                                getJsonField(
                                                                                                  responsibleItem,
                                                                                                  r'''$.sum''',
                                                                                                )?.toString(),
                                                                                                '0',
                                                                                              )} ₸',
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: Color(0xFF07971F),
                                                                                                    fontSize: 14,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                            ),
                                                                                            Align(
                                                                                              alignment: AlignmentDirectional(0, 0),
                                                                                              child: Container(
                                                                                                height: MediaQuery.sizeOf(context).height * 0.03,
                                                                                                decoration: BoxDecoration(
                                                                                                  color: Color(0xFFEDF1FD),
                                                                                                  borderRadius: BorderRadius.circular(30),
                                                                                                  shape: BoxShape.rectangle,
                                                                                                ),
                                                                                                child: Align(
                                                                                                  alignment: AlignmentDirectional(0, 0),
                                                                                                  child: Padding(
                                                                                                    padding: EdgeInsetsDirectional.fromSTEB(7, 0, 7, 0),
                                                                                                    child: Text(
                                                                                                      '${getJsonField(
                                                                                                        responsibleItem,
                                                                                                        r'''$.amount''',
                                                                                                      ).toString()} ${getJsonField(
                                                                                                        responsibleItem,
                                                                                                        r'''$.unit_of_measurement''',
                                                                                                      ).toString()}',
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'SFProText',
                                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                                            fontSize: 12,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ].divide(SizedBox(width: 10)),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Builder(
                                                                                        builder: (context) {
                                                                                          if (FFAppState().workspace == '67b6ce38d2658e6461852374') {
                                                                                            return Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Дата списания:',
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
                                                                                                        "dd.MM.y",
                                                                                                        functions.stringToDateTime(getJsonField(
                                                                                                          responsibleItem,
                                                                                                          r'''$.write_off_date''',
                                                                                                        ).toString()),
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
                                                                                            );
                                                                                          } else {
                                                                                            return Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Дата:',
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
                                                                                                        "dd.MM.y",
                                                                                                        functions.stringToDateTime(getJsonField(
                                                                                                          responsibleItem,
                                                                                                          r'''$.date''',
                                                                                                        ).toString()),
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
                                                                                            );
                                                                                          }
                                                                                        },
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.43,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              'Номерклатура:',
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
                                                                                                getJsonField(
                                                                                                  responsibleItem,
                                                                                                  r'''$.nomenclature''',
                                                                                                )?.toString(),
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
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            if (FFAppState().workspace == '67b6ce38d2658e6461852374') {
                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Код:',
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
                                                                                                      getJsonField(
                                                                                                        responsibleItem,
                                                                                                        r'''$.cost_center_name''',
                                                                                                      )?.toString(),
                                                                                                      '-',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: Color(0xFF667085),
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            } else {
                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Тип:',
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
                                                                                                      getJsonField(
                                                                                                        responsibleItem,
                                                                                                        r'''$.repair_method''',
                                                                                                      )?.toString(),
                                                                                                      '-',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: Color(0xFF667085),
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.43,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              'Склад автосервис:',
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
                                                                                                getJsonField(
                                                                                                  responsibleItem,
                                                                                                  r'''$.warehouse_car_service''',
                                                                                                )?.toString(),
                                                                                                '-',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: Color(0xFF667085),
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 5),
                                                                                  child: Row(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    children: [
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Builder(
                                                                                          builder: (context) {
                                                                                            if (FFAppState().workspace == '67b6ce38d2658e6461852374') {
                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Организация поставщик:',
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
                                                                                                      getJsonField(
                                                                                                        responsibleItem,
                                                                                                        r'''$.provider_name''',
                                                                                                      )?.toString(),
                                                                                                      '-',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: Color(0xFF667085),
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            } else {
                                                                                              return Column(
                                                                                                mainAxisSize: MainAxisSize.max,
                                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Организация:',
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
                                                                                                      getJsonField(
                                                                                                        responsibleItem,
                                                                                                        r'''$.organization''',
                                                                                                      )?.toString(),
                                                                                                      '-',
                                                                                                    ),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: Color(0xFF667085),
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ],
                                                                                              );
                                                                                            }
                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                      Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.43,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Column(
                                                                                          mainAxisSize: MainAxisSize.max,
                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                          children: [
                                                                                            Text(
                                                                                              'Стоимость:',
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
                                                                                                getJsonField(
                                                                                                  responsibleItem,
                                                                                                  r'''$.price''',
                                                                                                )?.toString(),
                                                                                                '0',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
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
                                                                          ),
                                                                        );
                                                                      }).divide(SizedBox(height: 10)).addToStart(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                                if (functions
                                                                        .jsonToList(
                                                                            getJsonField(
                                                                          container12GetExpenseJournalResponse
                                                                              .jsonBody,
                                                                          r'''$.data''',
                                                                        ))
                                                                        .length >=
                                                                    10)
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            11,
                                                                            0,
                                                                            11,
                                                                            15),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              5,
                                                                              0,
                                                                              5),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.8,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                FFButtonWidget(
                                                                              onPressed: () async {
                                                                                _model.expensepage = _model.expensepage + 10;
                                                                                safeSetState(() {});
                                                                                HapticFeedback.lightImpact();
                                                                                safeSetState(() => _model.apiRequestCompleter2 = null);
                                                                                await _model.waitForApiRequestCompleted2();
                                                                              },
                                                                              text: 'Смотреть еще',
                                                                              icon: Icon(
                                                                                Icons.keyboard_double_arrow_down_outlined,
                                                                                size: 16,
                                                                              ),
                                                                              options: FFButtonOptions(
                                                                                height: 40,
                                                                                padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                                                                                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: FlutterFlowTheme.of(context).alternate,
                                                                                      fontSize: 14,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                                elevation: 0,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  } else {
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, -1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 0),
                                                        child: Text(
                                                          'Отсутствуют расходы',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
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
                                        FutureBuilder<ApiCallResponse>(
                                          future: GetMileagesCall.call(
                                            access: currentAuthenticationToken,
                                            id: widget!.json?.toString(),
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                            final containerGetMileagesResponse =
                                                snapshot.data!;

                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                              ),
                                              child: Builder(
                                                builder: (context) {
                                                  if (containerGetMileagesResponse
                                                          .jsonBody !=
                                                      null) {
                                                    return Builder(
                                                      builder: (context) {
                                                        final responsible =
                                                            containerGetMileagesResponse
                                                                .jsonBody
                                                                .toList();

                                                        return SingleChildScrollView(
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: List.generate(
                                                                    responsible
                                                                        .length,
                                                                    (responsibleIndex) {
                                                              final responsibleItem =
                                                                  responsible[
                                                                      responsibleIndex];
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onLongPress:
                                                                    () async {
                                                                  await showModalBottomSheet(
                                                                    isScrollControlled:
                                                                        true,
                                                                    backgroundColor:
                                                                        Color(
                                                                            0xFF5E6A70),
                                                                    enableDrag:
                                                                        false,
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          FocusScope.of(context)
                                                                              .unfocus();
                                                                          FocusManager
                                                                              .instance
                                                                              .primaryFocus
                                                                              ?.unfocus();
                                                                        },
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              MediaQuery.viewInsetsOf(context),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.11,
                                                                            child:
                                                                                SettingsCopyWidget(
                                                                              id: getJsonField(
                                                                                responsibleItem,
                                                                                r'''$.id''',
                                                                              ).toString(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  ).then((value) =>
                                                                      safeSetState(
                                                                          () {}));
                                                                },
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.933,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(6),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children:
                                                                          [
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.42,
                                                                              decoration: BoxDecoration(),
                                                                              child: Text(
                                                                                dateTimeFormat(
                                                                                  "EEEE, d MMMM H:mm",
                                                                                  functions.addgmt5(functions.stringToDate(getJsonField(
                                                                                    responsibleItem,
                                                                                    r'''$.created_at''',
                                                                                  ).toString())),
                                                                                  locale: FFLocalizations.of(context).languageCode,
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: Color(0xFF696D6E),
                                                                                      fontSize: 14,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Align(
                                                                              alignment: AlignmentDirectional(0, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.45,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  functions.gpsorroot(getJsonField(
                                                                                    responsibleItem,
                                                                                    r'''$.source''',
                                                                                  ).toString()),
                                                                                  textAlign: TextAlign.end,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        color: Color(0xFF696D6E),
                                                                                        fontSize: 14,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        RichText(
                                                                          textScaler:
                                                                              MediaQuery.of(context).textScaler,
                                                                          text:
                                                                              TextSpan(
                                                                            children: [
                                                                              TextSpan(
                                                                                text: getJsonField(
                                                                                  responsibleItem,
                                                                                  r'''$.value''',
                                                                                ).toString(),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: FlutterFlowTheme.of(context).primaryText,
                                                                                      fontSize: 16,
                                                                                      letterSpacing: 0.0,
                                                                                    ),
                                                                              ),
                                                                              TextSpan(
                                                                                text: ' ',
                                                                                style: TextStyle(),
                                                                              ),
                                                                              TextSpan(
                                                                                text: functions.kmorhours(getJsonField(
                                                                                  responsibleItem,
                                                                                  r'''$.type''',
                                                                                ).toString()),
                                                                                style: TextStyle(),
                                                                              )
                                                                            ],
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).primaryText,
                                                                                  fontSize: 16,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ].divide(SizedBox(height: 3)).addToStart(SizedBox(height: 3)).addToEnd(
                                                                              SizedBox(height: 3)),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            })
                                                                .divide(
                                                                    SizedBox(
                                                                        height:
                                                                            10))
                                                                .addToStart(
                                                                    SizedBox(
                                                                        height:
                                                                            10)),
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  } else {
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, -1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 0),
                                                        child: Text(
                                                          'Отсутствуют история наработок',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
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
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: FutureBuilder<ApiCallResponse>(
                                            future: ObjectstatusCall.call(
                                              id: getJsonField(
                                                equipmentsDetailedCopyGetEquipsByIDResponse
                                                    .jsonBody,
                                                r'''$.gps_id''',
                                              ),
                                              access: GPSTokenCall.access(
                                                tabBarGPSTokenResponse.jsonBody,
                                              ),
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
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              final conditionalBuilderObjectstatusResponse =
                                                  snapshot.data!;

                                              return Builder(
                                                builder: (context) {
                                                  if ((getJsonField(
                                                            equipmentsDetailedCopyGetEquipsByIDResponse
                                                                .jsonBody,
                                                            r'''$.gps_id''',
                                                          ) !=
                                                          null) ||
                                                      (getJsonField(
                                                            (_model.apiResult030
                                                                    ?.jsonBody ??
                                                                ''),
                                                            r'''$''',
                                                          ) ==
                                                          null)) {
                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20,
                                                                        10,
                                                                        20,
                                                                        0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                      .sizeOf(
                                                                          context)
                                                                  .width,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.4,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                final _googleMapMarker = functions
                                                                    .formattedLatLon(
                                                                        ObjectstatusCall
                                                                            .lat(
                                                                          conditionalBuilderObjectstatusResponse
                                                                              .jsonBody,
                                                                        )!,
                                                                        ObjectstatusCall
                                                                            .lan(
                                                                          conditionalBuilderObjectstatusResponse
                                                                              .jsonBody,
                                                                        )!);
                                                                return FlutterFlowGoogleMap(
                                                                  controller: _model
                                                                      .googleMapsController,
                                                                  onCameraIdle:
                                                                      (latLng) =>
                                                                          _model.googleMapsCenter =
                                                                              latLng,
                                                                  initialLocation: _model
                                                                          .googleMapsCenter ??=
                                                                      functions.formattedLatLon(
                                                                          ObjectstatusCall.lat(
                                                                            conditionalBuilderObjectstatusResponse.jsonBody,
                                                                          )!,
                                                                          ObjectstatusCall.lan(
                                                                            conditionalBuilderObjectstatusResponse.jsonBody,
                                                                          )!),
                                                                  markers: [
                                                                    FlutterFlowMarker(
                                                                      _googleMapMarker
                                                                          .serialize(),
                                                                      _googleMapMarker,
                                                                    ),
                                                                  ],
                                                                  markerColor:
                                                                      GoogleMarkerColor
                                                                          .red,
                                                                  mapType: MapType
                                                                      .hybrid,
                                                                  style: GoogleMapStyle
                                                                      .standard,
                                                                  initialZoom:
                                                                      12,
                                                                  allowInteraction:
                                                                      true,
                                                                  allowZoom:
                                                                      true,
                                                                  showZoomControls:
                                                                      true,
                                                                  showLocation:
                                                                      true,
                                                                  showCompass:
                                                                      false,
                                                                  showMapToolbar:
                                                                      false,
                                                                  showTraffic:
                                                                      false,
                                                                  centerMapOnMarkerTap:
                                                                      true,
                                                                );
                                                              }),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20,
                                                                        10,
                                                                        20,
                                                                        70),
                                                            child: Container(
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
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                child: Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              20,
                                                                              0,
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.5,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              'Скорость',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.3,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                ObjectstatusCall.speed(
                                                                                  conditionalBuilderObjectstatusResponse.jsonBody,
                                                                                ),
                                                                                '-',
                                                                              ),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Divider(
                                                                      thickness:
                                                                          1,
                                                                      color: Color(
                                                                          0xFFD9D9D9),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.5,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Средняя скорость',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.3,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              RichText(
                                                                            textScaler:
                                                                                MediaQuery.of(context).textScaler,
                                                                            text:
                                                                                TextSpan(
                                                                              children: [
                                                                                TextSpan(
                                                                                  text: valueOrDefault<String>(
                                                                                    ObjectstatusCall.avgspeed(
                                                                                      conditionalBuilderObjectstatusResponse.jsonBody,
                                                                                    ),
                                                                                    '-',
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        fontSize: 15,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                )
                                                                              ],
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      thickness:
                                                                          1,
                                                                      color: Color(
                                                                          0xFFD9D9D9),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.5,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Максимальная скорость',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.3,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              ObjectstatusCall.maxspeed(
                                                                                conditionalBuilderObjectstatusResponse.jsonBody,
                                                                              ),
                                                                              '-',
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      thickness:
                                                                          1,
                                                                      color: Color(
                                                                          0xFFD9D9D9),
                                                                    ),
                                                                    Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceBetween,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.5,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            'Расход бензина, л/км',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).alternate,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.3,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              ObjectstatusCall.fuelperkm(
                                                                                conditionalBuilderObjectstatusResponse.jsonBody,
                                                                              ),
                                                                              '-',
                                                                            ),
                                                                            textAlign:
                                                                                TextAlign.end,
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 15,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Divider(
                                                                      thickness:
                                                                          1,
                                                                      color: Color(
                                                                          0xFFD9D9D9),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              20),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.5,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              'Моточасы',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).alternate,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.3,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                ObjectstatusCall.moto(
                                                                                  conditionalBuilderObjectstatusResponse.jsonBody,
                                                                                ),
                                                                                '-',
                                                                              ),
                                                                              textAlign: TextAlign.end,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      height:
                                                                          10)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  } else {
                                                    return Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, -1),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(0, 20,
                                                                    0, 0),
                                                        child: Text(
                                                          'Отсутствуют данные с GPS',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .headlineMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                fontSize: 20,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              if (getJsonField(
                                                    equipmentsDetailedCopyGetEquipsByIDResponse
                                                        .jsonBody,
                                                    r'''$.responsible_employees''',
                                                  ) !=
                                                  null) {
                                                return Builder(
                                                  builder: (context) {
                                                    final responsible =
                                                        getJsonField(
                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                          .jsonBody,
                                                      r'''$.responsible_employees''',
                                                    ).toList();

                                                    return SingleChildScrollView(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: List.generate(
                                                                responsible
                                                                    .length,
                                                                (responsibleIndex) {
                                                          final responsibleItem =
                                                              responsible[
                                                                  responsibleIndex];
                                                          return Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.933,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          5,
                                                                          0,
                                                                          5),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            20,
                                                                            0,
                                                                            15,
                                                                            0),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.097,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.097,
                                                                      clipBehavior:
                                                                          Clip.antiAlias,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                      ),
                                                                      child: Image
                                                                          .asset(
                                                                        'assets/images/Icon-User.png',
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Column(
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
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          '${getJsonField(
                                                                            responsibleItem,
                                                                            r'''$.name.first''',
                                                                          ).toString()} ${getJsonField(
                                                                            responsibleItem,
                                                                            r'''$.name.last''',
                                                                          ).toString()}',
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).primaryText,
                                                                              fontSize: 15,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      SelectionArea(
                                                                          child:
                                                                              Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            responsibleItem,
                                                                            r'''$.email''',
                                                                          )?.toString(),
                                                                          'example@gmail.com',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              fontSize: 13,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      )),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                            .divide(SizedBox(
                                                                height: 10))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height:
                                                                        10)),
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0, -1),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 20, 0, 0),
                                                    child: Text(
                                                      'Отсутствуют ответственные',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .headlineMedium
                                                          .override(
                                                            fontFamily:
                                                                'SFProText',
                                                            fontSize: 20,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        11.5, 15, 11.5, 0),
                                                child: Builder(
                                                  builder: (context) {
                                                    final todo = getJsonField(
                                                      equipmentsDetailedCopyGetEquipsByIDResponse
                                                          .jsonBody,
                                                      r'''$.media''',
                                                    ).toList();

                                                    return GridView.builder(
                                                      padding: EdgeInsets.zero,
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 3,
                                                        crossAxisSpacing: 10,
                                                        mainAxisSpacing: 10,
                                                        childAspectRatio: 1,
                                                      ),
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      itemCount: todo.length,
                                                      itemBuilder:
                                                          (context, todoIndex) {
                                                        final todoItem =
                                                            todo[todoIndex];
                                                        return Builder(
                                                          builder: (context) {
                                                            if ((functions.getFileExtension(
                                                                        todoItem
                                                                            .toString()) ==
                                                                    'jpg') ||
                                                                (functions.getFileExtension(
                                                                        todoItem
                                                                            .toString()) ==
                                                                    'png')) {
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    PageTransition(
                                                                      type: PageTransitionType
                                                                          .fade,
                                                                      child:
                                                                          FlutterFlowExpandedImageView(
                                                                        image: Image
                                                                            .network(
                                                                          todoItem
                                                                              .toString(),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                          errorBuilder: (context, error, stackTrace) =>
                                                                              Image.asset(
                                                                            'assets/images/error_image.png',
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                        allowRotation:
                                                                            false,
                                                                        tag: todoItem
                                                                            .toString(),
                                                                        useHeroAnimation:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Hero(
                                                                  tag: todoItem
                                                                      .toString(),
                                                                  transitionOnUserGestures:
                                                                      true,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .network(
                                                                      todoItem
                                                                          .toString(),
                                                                      width:
                                                                          300,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorBuilder: (context,
                                                                              error,
                                                                              stackTrace) =>
                                                                          Image
                                                                              .asset(
                                                                        'assets/images/error_image.png',
                                                                        width:
                                                                            300,
                                                                        height:
                                                                            200,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            } else {
                                                              return InkWell(
                                                                splashColor: Colors
                                                                    .transparent,
                                                                focusColor: Colors
                                                                    .transparent,
                                                                hoverColor: Colors
                                                                    .transparent,
                                                                highlightColor:
                                                                    Colors
                                                                        .transparent,
                                                                onTap:
                                                                    () async {
                                                                  context
                                                                      .pushNamed(
                                                                    PdfviewerWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'title':
                                                                          serializeParam(
                                                                        'Вложение',
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'viewer':
                                                                          serializeParam(
                                                                        todoItem
                                                                            .toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'extension':
                                                                          serializeParam(
                                                                        functions
                                                                            .getFileExtension(todoItem.toString()),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .insert_drive_file,
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        size:
                                                                            50,
                                                                      ),
                                                                      Text(
                                                                        functions
                                                                            .extractFileName(todoItem.toString()),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.bold,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ],
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
