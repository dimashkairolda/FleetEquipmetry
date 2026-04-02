import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/naryads/edit_naryad_sheet/edit_naryad_sheet_widget.dart';
import '/naryads/naryads_comment/naryads_comment_widget.dart';
import 'dart:ui';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'naryads_offline_model.dart';
export 'naryads_offline_model.dart';

class NaryadsOfflineWidget extends StatefulWidget {
  const NaryadsOfflineWidget({
    super.key,
    this.json,
  });

  final dynamic json;

  static String routeName = 'NaryadsOffline';
  static String routePath = '/naryadsOffline';

  @override
  State<NaryadsOfflineWidget> createState() => _NaryadsOfflineWidgetState();
}

class _NaryadsOfflineWidgetState extends State<NaryadsOfflineWidget>
    with TickerProviderStateMixin {
  late NaryadsOfflineModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NaryadsOfflineModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.apiResultytd = await GetDefectsbyTicketIdCall.call(
        access: currentAuthenticationToken,
        work: FFAppState().workspace,
        ticketId: getJsonField(
          widget!.json,
          r'''$.id''',
        ).toString(),
      );

      if ((_model.apiResultytd?.succeeded ?? true)) {
        _model.defectss = (_model.apiResultytd?.jsonBody ?? '');
        safeSetState(() {});
      }
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 5,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
      future: GetNaryadsByIdCall.call(
        access: currentAuthenticationToken,
        id: getJsonField(
          widget!.json,
          r'''$.id''',
        ).toString(),
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
        final naryadsOfflineGetNaryadsByIdResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
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
                  context.safePop();

                  safeSetState(() {});
                },
              ),
              title: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Информация о наряде',
                    style: FlutterFlowTheme.of(context).titleLarge.override(
                          fontFamily: 'SFProText',
                          color: FlutterFlowTheme.of(context).primary,
                          fontSize: 18,
                          letterSpacing: 0.0,
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
                                height:
                                    MediaQuery.sizeOf(context).height * 0.15,
                                child: EditNaryadSheetWidget(
                                  spareparts: (getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.inventory_items''',
                                    true,
                                  )
                                              ?.toList()
                                              .map<SparePartsStruct?>(
                                                  SparePartsStruct.maybeFromMap)
                                              .toList()
                                          as Iterable<SparePartsStruct?>)
                                      .withoutNulls,
                                  todo: (getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.todo''',
                                    true,
                                  )
                                          ?.toList()
                                          .map<TodoStruct?>(
                                              TodoStruct.maybeFromMap)
                                          .toList() as Iterable<TodoStruct?>)
                                      .withoutNulls,
                                  defectid: getJsonField(
                                    _model.defectss,
                                    r'''$[0].id''',
                                  ).toString(),
                                  equipmentid: getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.subject.id''',
                                  ).toString(),
                                  equipname: '${getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.subject.brand_id.name''',
                                  ).toString()} ${getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.subject.model_id.name''',
                                  ).toString()} ${getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.subject.license_plate_number''',
                                  ).toString()}',
                                  equiplicenseplatenumber: getJsonField(
                                    _model.defectss,
                                    r'''$[0].license_plate_number''',
                                  ).toString(),
                                  mesto: getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.location''',
                                  ).toString(),
                                  assignee: (getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.assignees_info[:].id''',
                                    true,
                                  ) as List?)
                                      ?.map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  acceptor: getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.acceptor_user_id''',
                                  ).toString(),
                                  date: getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.created_at''',
                                  ).toString(),
                                  name: getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.title''',
                                  ).toString(),
                                  defectname: getJsonField(
                                    _model.defectss,
                                    r'''$[0].title''',
                                  ).toString(),
                                  defectstatus: getJsonField(
                                    _model.defectss,
                                    r'''$[0].status''',
                                  ).toString(),
                                  defectdate: getJsonField(
                                    _model.defectss,
                                    r'''$[0].created_at''',
                                  ).toString(),
                                  naryadid: getJsonField(
                                    naryadsOfflineGetNaryadsByIdResponse
                                        .jsonBody,
                                    r'''$.id''',
                                  ).toString(),
                                  naryadstatus: valueOrDefault<String>(
                                    functions.statusNaryads(getJsonField(
                                      naryadsOfflineGetNaryadsByIdResponse
                                          .jsonBody,
                                      r'''$.status''',
                                    ).toString()),
                                    '-',
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
                      color: FlutterFlowTheme.of(context).primary,
                      size: 24,
                    ),
                  ),
                ],
              ),
              actions: [],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: FutureBuilder<ApiCallResponse>(
                future: GetDefectsbyTicketIdCall.call(
                  access: currentAuthenticationToken,
                  ticketId: getJsonField(
                    widget!.json,
                    r'''$.id''',
                  ).toString(),
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
                  final columnGetDefectsbyTicketIdResponse = snapshot.data!;

                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0, 15, 0, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 10, 0, 10),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment:
                                                    AlignmentDirectional(-1, 0),
                                                child: Text(
                                                  getJsonField(
                                                    naryadsOfflineGetNaryadsByIdResponse
                                                        .jsonBody,
                                                    r'''$.title''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 17,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          20, 0, 0, 0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: functions.colorNaryadsCopy(
                                                  getJsonField(
                                                naryadsOfflineGetNaryadsByIdResponse
                                                    .jsonBody,
                                                r'''$.status''',
                                              ).toString()),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 5, 0, 5),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5, 0, 5, 0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            functions
                                                                .statusNaryads(
                                                                    getJsonField(
                                                              naryadsOfflineGetNaryadsByIdResponse
                                                                  .jsonBody,
                                                              r'''$.status''',
                                                            ).toString()),
                                                            '-',
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: functions
                                                                    .colorNaryads(
                                                                        getJsonField(
                                                                  naryadsOfflineGetNaryadsByIdResponse
                                                                      .jsonBody,
                                                                  r'''$.status''',
                                                                ).toString()),
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
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
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.65,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment(0, 0),
                                    child: TabBar(
                                      isScrollable: true,
                                      tabAlignment: TabAlignment.center,
                                      labelColor:
                                          FlutterFlowTheme.of(context).primary,
                                      unselectedLabelColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .titleMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w600,
                                          ),
                                      unselectedLabelStyle:
                                          FlutterFlowTheme.of(context)
                                              .titleMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 13,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                      indicatorColor:
                                          FlutterFlowTheme.of(context).primary,
                                      tabs: [
                                        Tab(
                                          text: 'Основные',
                                        ),
                                        Tab(
                                          text: 'Источник',
                                        ),
                                        Tab(
                                          text: 'Список ТМЦ',
                                        ),
                                        Tab(
                                          text: 'Список работ',
                                        ),
                                        Tab(
                                          text: 'Исполнители',
                                        ),
                                      ],
                                      controller: _model.tabBarController,
                                      onTap: (i) async {
                                        [
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
                                                      .fromSTEB(
                                                          11.5, 8, 11.5, 0),
                                                  child: Container(
                                                    width: double.infinity,
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
                                                                  0, 16, 0, 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          0, 0),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/Icon-Car.png',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.08,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.04,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.65,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1,
                                                                              -1),
                                                                          child:
                                                                              Padding(
                                                                            padding: EdgeInsetsDirectional.fromSTEB(
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                3),
                                                                            child:
                                                                                Text(
                                                                              'Техника',
                                                                              textAlign: TextAlign.start,
                                                                              style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 14,
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.08,
                                                                                height: MediaQuery.sizeOf(context).width * 0.08,
                                                                                clipBehavior: Clip.antiAlias,
                                                                                decoration: BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: Image.network(
                                                                                  getJsonField(
                                                                                    widget!.json,
                                                                                    r'''$.subject.avatar''',
                                                                                  ).toString(),
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                    'assets/images/error_image.png',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.65,
                                                                              decoration: BoxDecoration(),
                                                                              child: InkWell(
                                                                                splashColor: Colors.transparent,
                                                                                focusColor: Colors.transparent,
                                                                                hoverColor: Colors.transparent,
                                                                                highlightColor: Colors.transparent,
                                                                                onTap: () async {
                                                                                  context.pushNamed(
                                                                                    EquipmentsDetailedCopyWidget.routeName,
                                                                                    queryParameters: {
                                                                                      'tab': serializeParam(
                                                                                        0,
                                                                                        ParamType.int,
                                                                                      ),
                                                                                      'json': serializeParam(
                                                                                        getJsonField(
                                                                                          naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                          r'''$.subject.id''',
                                                                                        ),
                                                                                        ParamType.JSON,
                                                                                      ),
                                                                                    }.withoutNulls,
                                                                                  );
                                                                                },
                                                                                child: RichText(
                                                                                  textScaler: MediaQuery.of(context).textScaler,
                                                                                  text: TextSpan(
                                                                                    children: [
                                                                                      TextSpan(
                                                                                        text: valueOrDefault<String>(
                                                                                          getJsonField(
                                                                                            naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                            r'''$.subject.brand_id.name''',
                                                                                          )?.toString(),
                                                                                          '-',
                                                                                        ),
                                                                                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                              fontFamily: 'SFProText',
                                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                                              fontSize: 15,
                                                                                              letterSpacing: 0.0,
                                                                                              fontWeight: FontWeight.normal,
                                                                                            ),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: ' ',
                                                                                        style: TextStyle(),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: valueOrDefault<String>(
                                                                                          getJsonField(
                                                                                            naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                            r'''$.subject.model_id.name''',
                                                                                          )?.toString(),
                                                                                          '-',
                                                                                        ),
                                                                                        style: TextStyle(),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: ' ',
                                                                                        style: TextStyle(),
                                                                                      ),
                                                                                      TextSpan(
                                                                                        text: valueOrDefault<String>(
                                                                                          getJsonField(
                                                                                            naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                            r'''$.subject.license_plate_number''',
                                                                                          )?.toString(),
                                                                                          '-',
                                                                                        ),
                                                                                        style: TextStyle(),
                                                                                      )
                                                                                    ],
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'SFProText',
                                                                                          color: FlutterFlowTheme.of(context).primary,
                                                                                          fontSize: 15,
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.normal,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        20,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-Gauge.png',
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.08,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Пробег',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child: FutureBuilder<
                                                                            ApiCallResponse>(
                                                                          future:
                                                                              GetMileagesCall.call(
                                                                            access:
                                                                                currentAuthenticationToken,
                                                                            id: getJsonField(
                                                                                      naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                      r'''$.subject.id''',
                                                                                    ) !=
                                                                                    null
                                                                                ? getJsonField(
                                                                                    naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                    r'''$.subject.id''',
                                                                                  ).toString()
                                                                                : getJsonField(
                                                                                    widget!.json,
                                                                                    r'''$.subject.subject_id''',
                                                                                  ).toString(),
                                                                            work:
                                                                                FFAppState().workspace,
                                                                          ),
                                                                          builder:
                                                                              (context, snapshot) {
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
                                                                            final textGetMileagesResponse =
                                                                                snapshot.data!;

                                                                            return Text(
                                                                              valueOrDefault<String>(
                                                                                '${valueOrDefault<String>(
                                                                                  getJsonField(
                                                                                    functions.jsonToList(textGetMileagesResponse.jsonBody).firstOrNull,
                                                                                    r'''$.value''',
                                                                                  )?.toString(),
                                                                                  '-',
                                                                                )} км',
                                                                                '-',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            );
                                                                          },
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        20,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-MapPin_(1).png',
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.08,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Место ремонта',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          getJsonField(
                                                                            naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                            r'''$.location''',
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                fontSize: 15,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        20,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-User.png',
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.08,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.75,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Автор',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                            r'''$.user''',
                                                                          )?.toString(),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        20,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-User.png',
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.08,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.75,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Приемщик',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                            r'''$.acceptor''',
                                                                          )?.toString(),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyLarge
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 14,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        20,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-CalendarBlank.png',
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.08,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Датa и время создания ',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            dateTimeFormat(
                                                                              "EEEE, d MMMM H:mm",
                                                                              functions.addgmt5(functions.stringToDateTime(getJsonField(
                                                                                naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                r'''$.created_at''',
                                                                              ).toString())),
                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                            ),
                                                                            '-',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        20,
                                                                        16,
                                                                        0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-CalendarBlank.png',
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.08,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.04,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          0,
                                                                          0,
                                                                          0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          'Датa и время выполнения',
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodySmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            dateTimeFormat(
                                                                              "dd.MM.y",
                                                                              functions.addgmt5(functions.stringToDateTime(getJsonField(
                                                                                naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                r'''$.target_date''',
                                                                              ).toString())),
                                                                              locale: FFLocalizations.of(context).languageCode,
                                                                            ),
                                                                            '-',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyLarge
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                fontSize: 14,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          11.5, 8, 11.5, 8),
                                                  child: Container(
                                                    width: double.infinity,
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
                                                                  0, 16, 0, 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'Комментарии',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    fontSize:
                                                                        17,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                          Builder(
                                                            builder:
                                                                (context) =>
                                                                    Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          16,
                                                                          0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  await showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Dialog(
                                                                        elevation:
                                                                            0,
                                                                        insetPadding:
                                                                            EdgeInsets.zero,
                                                                        backgroundColor:
                                                                            Colors.transparent,
                                                                        alignment:
                                                                            AlignmentDirectional(0, 0).resolve(Directionality.of(context)),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(dialogContext).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.25,
                                                                            child:
                                                                                NaryadsCommentWidget(
                                                                              id: getJsonField(
                                                                                widget!.json,
                                                                                r'''$.id''',
                                                                              ).toString(),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                                text:
                                                                    'Добавить комментарий',
                                                                icon: Icon(
                                                                  Icons.add,
                                                                  size: 15,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width,
                                                                  height: 40,
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16,
                                                                          0,
                                                                          16,
                                                                          0),
                                                                  iconPadding:
                                                                      EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryBackground,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                  elevation: 0,
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 15)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    11.5, 8, 11.5, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 16, 0, 16),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16,
                                                                      0, 0, 0),
                                                          child: Text(
                                                            'Дефекты',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        Builder(
                                                          builder: (context) {
                                                            if (getJsonField(
                                                                  _model
                                                                      .defectss,
                                                                  r'''$[:]''',
                                                                ) !=
                                                                null) {
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child: Builder(
                                                                  builder:
                                                                      (context) {
                                                                    final defects =
                                                                        getJsonField(
                                                                      _model
                                                                          .defectss,
                                                                      r'''$''',
                                                                    ).toList();

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
                                                                                DetailedDefectsOfflineCopyWidget.routeName,
                                                                                queryParameters: {
                                                                                  'id': serializeParam(
                                                                                    getJsonField(
                                                                                      defectsItem,
                                                                                      r'''$.id''',
                                                                                    ).toString(),
                                                                                    ParamType.String,
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
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                                                            width: MediaQuery.sizeOf(context).width * 0.25,
                                                                                            decoration: BoxDecoration(
                                                                                              color: functions.colorDefectCopy(getJsonField(
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
                                                                                                            color: functions.colorDefectCopyCopy(getJsonField(
                                                                                                              defectsItem,
                                                                                                              r'''$.status''',
                                                                                                            ).toString()),
                                                                                                            fontSize: 12,
                                                                                                            letterSpacing: 0.0,
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
                                                                                  if (defectsItem != functions.jsonToList(columnGetDefectsbyTicketIdResponse.jsonBody).lastOrNull)
                                                                                    Divider(
                                                                                      thickness: 2,
                                                                                      color: FlutterFlowTheme.of(context).accent4,
                                                                                    ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        );
                                                                      }).divide(SizedBox(
                                                                          height:
                                                                              5)),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            } else {
                                                              return Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            16,
                                                                            0,
                                                                            0,
                                                                            0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Text(
                                                                    '-',
                                                                    style: FlutterFlowTheme.of(
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
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontWeight,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              );
                                                            }
                                                          },
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    11.5, 8, 11.5, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
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
                                                                  0, 16, 0, 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        11.5,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'ТМЦ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    fontSize:
                                                                        16,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        11.5,
                                                                        0,
                                                                        11.5,
                                                                        0),
                                                            child: Builder(
                                                              builder:
                                                                  (context) {
                                                                final todo =
                                                                    getJsonField(
                                                                  naryadsOfflineGetNaryadsByIdResponse
                                                                      .jsonBody,
                                                                  r'''$.inventory_items''',
                                                                ).toList();

                                                                return Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  children: List
                                                                      .generate(
                                                                          todo.length,
                                                                          (todoIndex) {
                                                                    final todoItem =
                                                                        todo[
                                                                            todoIndex];
                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryBackground,
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children:
                                                                                [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(-1, 0),
                                                                                child: Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Text(
                                                                                    valueOrDefault<String>(
                                                                                      getJsonField(
                                                                                        todoItem,
                                                                                        r'''$.title''',
                                                                                      )?.toString(),
                                                                                      '-',
                                                                                    ),
                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                          fontFamily: 'SFProText',
                                                                                          letterSpacing: 0.0,
                                                                                          fontWeight: FontWeight.bold,
                                                                                        ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: AlignmentDirectional(-1, 0),
                                                                                    child: Container(
                                                                                      width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                      decoration: BoxDecoration(),
                                                                                      child: Padding(
                                                                                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                                                        child: RichText(
                                                                                          textScaler: MediaQuery.of(context).textScaler,
                                                                                          text: TextSpan(
                                                                                            children: [
                                                                                              TextSpan(
                                                                                                text: valueOrDefault<String>(
                                                                                                  getJsonField(
                                                                                                    todoItem,
                                                                                                    r'''$.product_article''',
                                                                                                  )?.toString(),
                                                                                                  '-',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'SFProText',
                                                                                                      color: Color(0xFF8291B0),
                                                                                                      fontSize: 12,
                                                                                                      letterSpacing: 0.0,
                                                                                                    ),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: ' · ',
                                                                                                style: TextStyle(
                                                                                                  color: Color(0xFF8291B0),
                                                                                                ),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: valueOrDefault<String>(
                                                                                                  getJsonField(
                                                                                                    todoItem,
                                                                                                    r'''$.quantity''',
                                                                                                  )?.toString(),
                                                                                                  '-',
                                                                                                ),
                                                                                                style: TextStyle(
                                                                                                  color: Color(0xFF8291B0),
                                                                                                ),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: 'шт',
                                                                                                style: TextStyle(
                                                                                                  color: Color(0xFF8291B0),
                                                                                                ),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: ' · ',
                                                                                                style: TextStyle(),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: valueOrDefault<String>(
                                                                                                  getJsonField(
                                                                                                    todoItem,
                                                                                                    r'''$.price''',
                                                                                                  )?.toString(),
                                                                                                  '-',
                                                                                                ),
                                                                                                style: TextStyle(),
                                                                                              ),
                                                                                              TextSpan(
                                                                                                text: 'тг',
                                                                                                style: TextStyle(),
                                                                                              )
                                                                                            ],
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'SFProText',
                                                                                                  color: Color(0xFF8291B0),
                                                                                                  fontSize: 12,
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ].divide(SizedBox(height: 3)).addToEnd(SizedBox(height: 2)),
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          thickness:
                                                                              1,
                                                                          color:
                                                                              Color(0xFFE9ECEF),
                                                                        ),
                                                                      ],
                                                                    );
                                                                  }).addToStart(
                                                                      SizedBox(
                                                                          height:
                                                                              10)),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    11.5, 8, 11.5, 0),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Container(
                                                    width: double.infinity,
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
                                                                  0, 16, 0, 16),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        11.5,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Text(
                                                              'Список работ',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    fontSize:
                                                                        16,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                            ),
                                                          ),
                                                          if (getJsonField(
                                                                naryadsOfflineGetNaryadsByIdResponse
                                                                    .jsonBody,
                                                                r'''$''',
                                                              ) !=
                                                              null)
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          11.5,
                                                                          0,
                                                                          11.5,
                                                                          0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final todo =
                                                                      getJsonField(
                                                                    naryadsOfflineGetNaryadsByIdResponse
                                                                        .jsonBody,
                                                                    r'''$.todo''',
                                                                  ).toList();

                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: List.generate(
                                                                        todo.length,
                                                                        (todoIndex) {
                                                                      final todoItem =
                                                                          todo[
                                                                              todoIndex];
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1, 0),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                getJsonField(
                                                                                                  todoItem,
                                                                                                  r'''$.title''',
                                                                                                )?.toString(),
                                                                                                '-',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    fontSize: 13,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.bold,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1, 0),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.1,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                                                              child: RichText(
                                                                                                textScaler: MediaQuery.of(context).textScaler,
                                                                                                text: TextSpan(
                                                                                                  children: [
                                                                                                    TextSpan(
                                                                                                      text: valueOrDefault<String>(
                                                                                                        getJsonField(
                                                                                                          todoItem,
                                                                                                          r'''$.quantity''',
                                                                                                        )?.toString(),
                                                                                                        '-',
                                                                                                      ),
                                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                            fontFamily: 'SFProText',
                                                                                                            color: Color(0xFF8291B0),
                                                                                                            fontSize: 14,
                                                                                                            letterSpacing: 0.0,
                                                                                                          ),
                                                                                                    ),
                                                                                                    TextSpan(
                                                                                                      text: 'шт',
                                                                                                      style: TextStyle(),
                                                                                                    )
                                                                                                  ],
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'SFProText',
                                                                                                        color: Color(0xFF8291B0),
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Theme(
                                                                                          data: ThemeData(
                                                                                            checkboxTheme: CheckboxThemeData(
                                                                                              visualDensity: VisualDensity.compact,
                                                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                                                              shape: RoundedRectangleBorder(
                                                                                                borderRadius: BorderRadius.circular(4),
                                                                                              ),
                                                                                            ),
                                                                                            unselectedWidgetColor: FlutterFlowTheme.of(context).alternate,
                                                                                          ),
                                                                                          child: Checkbox(
                                                                                            value: _model.checkboxValueMap[todoItem] ??= functions.ifnulltofalse(getJsonField(
                                                                                              todoItem,
                                                                                              r'''$.done''',
                                                                                            )),
                                                                                            onChanged: (newValue) async {
                                                                                              safeSetState(() => _model.checkboxValueMap[todoItem] = newValue!);
                                                                                              if (newValue!) {
                                                                                                _model.apiResultrrzCopy = await NaryadTaskCall.call(
                                                                                                  access: currentAuthenticationToken,
                                                                                                  id: getJsonField(
                                                                                                    naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                                    r'''$.id''',
                                                                                                  ).toString(),
                                                                                                  work: FFAppState().workspace,
                                                                                                  taskid: todoIndex,
                                                                                                  variable: true,
                                                                                                );

                                                                                                safeSetState(() {});
                                                                                              } else {
                                                                                                _model.apiResultrrz = await NaryadTaskCall.call(
                                                                                                  access: currentAuthenticationToken,
                                                                                                  id: getJsonField(
                                                                                                    naryadsOfflineGetNaryadsByIdResponse.jsonBody,
                                                                                                    r'''$.id''',
                                                                                                  ).toString(),
                                                                                                  work: FFAppState().workspace,
                                                                                                  taskid: todoIndex,
                                                                                                  variable: false,
                                                                                                );

                                                                                                safeSetState(() {});
                                                                                              }
                                                                                            },
                                                                                            side: (FlutterFlowTheme.of(context).alternate != null)
                                                                                                ? BorderSide(
                                                                                                    width: 2,
                                                                                                    color: FlutterFlowTheme.of(context).alternate!,
                                                                                                  )
                                                                                                : null,
                                                                                            activeColor: FlutterFlowTheme.of(context).primary,
                                                                                            checkColor: FlutterFlowTheme.of(context).info,
                                                                                          ),
                                                                                        ),
                                                                                        Text(
                                                                                          'Выполнено',
                                                                                          style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                fontFamily: 'SFProText',
                                                                                                letterSpacing: 0.0,
                                                                                              ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        if (getJsonField(
                                                                                              todoItem,
                                                                                              r'''$.done_by_info.title''',
                                                                                            ) !=
                                                                                            null)
                                                                                          RichText(
                                                                                            textScaler: MediaQuery.of(context).textScaler,
                                                                                            text: TextSpan(
                                                                                              children: [
                                                                                                TextSpan(
                                                                                                  text: getJsonField(
                                                                                                    todoItem,
                                                                                                    r'''$.done_by_info.title''',
                                                                                                  ).toString(),
                                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                        fontFamily: 'SFProText',
                                                                                                        color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                        letterSpacing: 0.0,
                                                                                                      ),
                                                                                                ),
                                                                                                TextSpan(
                                                                                                  text: ' · ',
                                                                                                  style: TextStyle(),
                                                                                                ),
                                                                                                TextSpan(
                                                                                                  text: valueOrDefault<String>(
                                                                                                    dateTimeFormat(
                                                                                                      "dd.MM.y H:mm",
                                                                                                      functions.addgmt5(functions.stringToDateTime(getJsonField(
                                                                                                        todoItem,
                                                                                                        r'''$.done_at''',
                                                                                                      ).toString())),
                                                                                                      locale: FFLocalizations.of(context).languageCode,
                                                                                                    ),
                                                                                                    '-',
                                                                                                  ),
                                                                                                  style: TextStyle(),
                                                                                                )
                                                                                              ],
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                      ],
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 3)),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                1,
                                                                            color:
                                                                                Color(0xFFE9ECEF),
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }).addToStart(
                                                                        SizedBox(
                                                                            height:
                                                                                10)),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                        ].divide(SizedBox(
                                                            height: 5)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    11.5, 8, 11.5, 0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                0, 16, 0, 16),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      11.5,
                                                                      0,
                                                                      0,
                                                                      0),
                                                          child: Text(
                                                            'Исполнители',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 16,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      11.5,
                                                                      0,
                                                                      11.5,
                                                                      0),
                                                          child: Builder(
                                                            builder: (context) {
                                                              final todo =
                                                                  getJsonField(
                                                                naryadsOfflineGetNaryadsByIdResponse
                                                                    .jsonBody,
                                                                r'''$.assignees_info''',
                                                              ).toList();

                                                              return Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: List.generate(
                                                                    todo.length,
                                                                    (todoIndex) {
                                                                  final todoItem =
                                                                      todo[
                                                                          todoIndex];
                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Container(
                                                                        width: MediaQuery.sizeOf(context)
                                                                            .width,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondaryBackground,
                                                                        ),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children:
                                                                              [
                                                                            Align(
                                                                              alignment: AlignmentDirectional(-1, 0),
                                                                              child: Container(
                                                                                width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                decoration: BoxDecoration(),
                                                                                child: Text(
                                                                                  valueOrDefault<String>(
                                                                                    getJsonField(
                                                                                      todoItem,
                                                                                      r'''$.title''',
                                                                                    )?.toString(),
                                                                                    '-',
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.bold,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ].divide(SizedBox(height: 3)).addToEnd(SizedBox(height: 2)),
                                                                        ),
                                                                      ),
                                                                      Divider(
                                                                        thickness:
                                                                            1,
                                                                        color: Color(
                                                                            0xFFE9ECEF),
                                                                      ),
                                                                    ],
                                                                  );
                                                                }).addToStart(
                                                                    SizedBox(
                                                                        height:
                                                                            10)),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ].divide(
                                                          SizedBox(height: 5)),
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
                                ],
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional(0, 0.7),
                              child: Builder(
                                builder: (context) {
                                  if (valueOrDefault<String>(
                                        functions.statusNaryads(getJsonField(
                                          naryadsOfflineGetNaryadsByIdResponse
                                              .jsonBody,
                                          r'''$.status''',
                                        ).toString()),
                                        '-',
                                      ) ==
                                      'Запланирован') {
                                    return Visibility(
                                      visible: functions.nameInList(
                                          getJsonField(
                                            naryadsOfflineGetNaryadsByIdResponse
                                                .jsonBody,
                                            r'''$.assignees_info''',
                                            true,
                                          )!,
                                          '${getJsonField(
                                            FFAppState().result,
                                            r'''$.user.name.first''',
                                          ).toString()} ${getJsonField(
                                            FFAppState().result,
                                            r'''$.user.name.last''',
                                          ).toString()}'),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0, 11.5, 0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            var confirmDialogResponse =
                                                await showDialog<bool>(
                                                      context: context,
                                                      builder:
                                                          (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Наряд'),
                                                          content: Text(
                                                              'Вы уверены что хотите начать наряд?'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      false),
                                                              child: Text(
                                                                  'Отмена'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () =>
                                                                  Navigator.pop(
                                                                      alertDialogContext,
                                                                      true),
                                                              child: Text(
                                                                  'Начать'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ??
                                                    false;
                                            if (confirmDialogResponse) {
                                              _model.apiResult7 =
                                                  await NaryadsStartCall.call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: getJsonField(
                                                  naryadsOfflineGetNaryadsByIdResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ).toString(),
                                                work: FFAppState().workspace,
                                              );
                                            } else {
                                              Navigator.pop(context);
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Начать',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.06,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    24, 0, 24, 0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 0, 0, 0),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color: Colors.white,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                    ),
                                            elevation: 3,
                                            borderSide: BorderSide(
                                              color: Colors.transparent,
                                              width: 1,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (valueOrDefault<String>(
                                        functions.statusNaryads(getJsonField(
                                          naryadsOfflineGetNaryadsByIdResponse
                                              .jsonBody,
                                          r'''$.status''',
                                        ).toString()),
                                        '-',
                                      ) ==
                                      'В работе') {
                                    return Container(
                                      decoration: BoxDecoration(),
                                      child: Visibility(
                                        visible: functions.nameInList(
                                            getJsonField(
                                              naryadsOfflineGetNaryadsByIdResponse
                                                  .jsonBody,
                                              r'''$.assignees_info''',
                                              true,
                                            )!,
                                            '${getJsonField(
                                              FFAppState().result,
                                              r'''$.user.name.first''',
                                            ).toString()} ${getJsonField(
                                              FFAppState().result,
                                              r'''$.user.name.last''',
                                            ).toString()}'),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  11.5, 0, 11.5, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              FlutterFlowIconButton(
                                                borderColor: Colors.transparent,
                                                borderRadius: 8,
                                                borderWidth: 1,
                                                buttonSize:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.13,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiary,
                                                icon: Icon(
                                                  Icons.pause,
                                                  color: Colors.white,
                                                  size: 35,
                                                ),
                                                onPressed: () async {
                                                  _model.apiResult72432 =
                                                      await NaryadsPauseCall
                                                          .call(
                                                    access:
                                                        currentAuthenticationToken,
                                                    id: getJsonField(
                                                      naryadsOfflineGetNaryadsByIdResponse
                                                          .jsonBody,
                                                      r'''$.id''',
                                                    ).toString(),
                                                    work:
                                                        FFAppState().workspace,
                                                  );

                                                  safeSetState(() {});
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else if (valueOrDefault<String>(
                                        functions.statusNaryads(getJsonField(
                                          naryadsOfflineGetNaryadsByIdResponse
                                              .jsonBody,
                                          r'''$.status''',
                                        ).toString()),
                                        '-',
                                      ) ==
                                      'Приостановлен') {
                                    return Visibility(
                                      visible: functions.nameInList(
                                          getJsonField(
                                            naryadsOfflineGetNaryadsByIdResponse
                                                .jsonBody,
                                            r'''$.assignees_info''',
                                            true,
                                          )!,
                                          '${getJsonField(
                                            FFAppState().result,
                                            r'''$.user.name.first''',
                                          ).toString()} ${getJsonField(
                                            FFAppState().result,
                                            r'''$.user.name.last''',
                                          ).toString()}'),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0, 11.5, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 8,
                                              borderWidth: 1,
                                              buttonSize:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.13,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              icon: Icon(
                                                Icons.play_arrow,
                                                color: Colors.white,
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                _model.apiResult724811 =
                                                    await NaryadsStartCall.call(
                                                  access:
                                                      currentAuthenticationToken,
                                                  id: getJsonField(
                                                    naryadsOfflineGetNaryadsByIdResponse
                                                        .jsonBody,
                                                    r'''$.id''',
                                                  ).toString(),
                                                  work: FFAppState().workspace,
                                                );

                                                safeSetState(() {});
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else if (valueOrDefault<String>(
                                        functions.statusNaryads(getJsonField(
                                          naryadsOfflineGetNaryadsByIdResponse
                                              .jsonBody,
                                          r'''$.status''',
                                        ).toString()),
                                        '-',
                                      ) ==
                                      'На приемке') {
                                    return Visibility(
                                      visible: functions.isReversedNameMatch(
                                          '${getJsonField(
                                            FFAppState().result,
                                            r'''$.user.name.first''',
                                          ).toString()} ${getJsonField(
                                            FFAppState().result,
                                            r'''$.user.name.last''',
                                          ).toString()}',
                                          getJsonField(
                                            naryadsOfflineGetNaryadsByIdResponse
                                                .jsonBody,
                                            r'''$.acceptor''',
                                          ).toString()),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 0, 11.5, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            FFButtonWidget(
                                              onPressed: () async {
                                                _model.apiResult72472 =
                                                    await NaryadsFinalizeCall
                                                        .call(
                                                  access:
                                                      currentAuthenticationToken,
                                                  id: getJsonField(
                                                    naryadsOfflineGetNaryadsByIdResponse
                                                        .jsonBody,
                                                    r'''$.id''',
                                                  ).toString(),
                                                  work: FFAppState().workspace,
                                                );

                                                FFAppState().sendDefectCounter =
                                                    0;
                                                safeSetState(() {});
                                                while (FFAppState()
                                                        .sendDefectCounter <
                                                    functions
                                                        .jsonToList(
                                                            columnGetDefectsbyTicketIdResponse
                                                                .jsonBody)
                                                        .length) {
                                                  _model.apiResult4573 =
                                                      await StatusfixedCall
                                                          .call(
                                                    access:
                                                        currentAuthenticationToken,
                                                    work:
                                                        FFAppState().workspace,
                                                    id: getJsonField(
                                                      functions
                                                          .jsonToList(
                                                              columnGetDefectsbyTicketIdResponse
                                                                  .jsonBody)
                                                          .elementAtOrNull(
                                                              FFAppState()
                                                                  .sendDefectCounter),
                                                      r'''$.id''',
                                                    ).toString(),
                                                  );

                                                  FFAppState()
                                                          .sendDefectCounter =
                                                      FFAppState()
                                                              .sendDefectCounter +
                                                          1;
                                                  safeSetState(() {});
                                                }

                                                safeSetState(() {});
                                              },
                                              text: 'Принять',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.45,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.06,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(24, 0, 24, 0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color: Color(0xFF07971F),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                elevation: 3,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed: () async {
                                                _model.apiResult7240 =
                                                    await NaryadsRejectCall
                                                        .call(
                                                  access:
                                                      currentAuthenticationToken,
                                                  id: getJsonField(
                                                    naryadsOfflineGetNaryadsByIdResponse
                                                        .jsonBody,
                                                    r'''$.id''',
                                                  ).toString(),
                                                  work: FFAppState().workspace,
                                                );

                                                safeSetState(() {});
                                              },
                                              text: 'Отклонить',
                                              options: FFButtonOptions(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.45,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.06,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(24, 0, 24, 0),
                                                iconPadding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0, 0, 0, 0),
                                                color: Color(0xFFDC0E0E),
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: Colors.white,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                elevation: 3,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
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
                            ),
                          ],
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
