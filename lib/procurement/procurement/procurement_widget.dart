import 'package:Equipmetry/procurement/create_procurement/create_procurement_widget.dart';
import 'package:Equipmetry/procurement/procurement_detailed/procurement_detailed_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/bottom_nav_primary_tab_scope.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'procurement_model.dart';
export 'procurement_model.dart';

class ProcurementWidget extends StatefulWidget {
  const ProcurementWidget({super.key});

  static String routeName = 'Procurement';
  static String routePath = '/procurement';

  @override
  State<ProcurementWidget> createState() => _ProcurementWidgetState();
}

class _ProcurementWidgetState extends State<ProcurementWidget>
    with TickerProviderStateMixin {
  late ProcurementModel _model;
  late TabController _tabController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProcurementModel());

    _model.textField12TextController ??= TextEditingController();
    _model.textField12FocusNode ??= FocusNode();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        safeSetState(() {});
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
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
        floatingActionButton: Visibility(
          visible: FFAppState().STO != 'Поставщик',
          child: FloatingActionButton(
            onPressed: () async {
              context.pushNamed(CreateProcurementWidget.routeName);
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8,
            child: Icon(
              Icons.add_rounded,
              color: FlutterFlowTheme.of(context).info,
              size: 24,
            ),
          ),
        ),
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
                    context.goNamed(ProfilePageWidget.routeName);
                  },
                  child: Icon(
                    Icons.chevron_left,
                    color: FlutterFlowTheme.of(context).secondaryText,
                    size: 24,
                  ),
                ),
          title: Text(
            'Доска объявлений',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 18,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(11, 0, 11, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              height:
                                  MediaQuery.sizeOf(context).height * 0.042,
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    8, 0, 8, 0),
                                child: TextFormField(
                                  controller:
                                      _model.textField12TextController,
                                  focusNode: _model.textField12FocusNode,
                                  onChanged: (_) => EasyDebounce.debounce(
                                    '_model.textField12TextController',
                                    Duration(milliseconds: 0),
                                    () async {
                                      safeSetState(() => _model
                                          .apiRequestCompleter2 = null);
                                      await _model
                                          .waitForApiRequestCompleted2();
                                      safeSetState(() => _model
                                          .apiRequestCompleter1 = null);
                                      await _model
                                          .waitForApiRequestCompleted1();
                                      safeSetState(() => _model
                                          .awaitingRequestCompleter = null);
                                      await _model
                                          .waitForAwaitingRequestCompleted();
                                      safeSetState(() => _model
                                          .awaitingCountCompleter = null);
                                      await _model
                                          .waitForAwaitingCountCompleted();
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
                                              color: Color(0xFF99A2AD),
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                            ),
                                    hintText: 'Поиск',
                                    hintStyle:
                                        FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'SFProText',
                                              color: Color(0xFF99A2AD),
                                              fontSize: 15,
                                              letterSpacing: 0.0,
                                            ),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                    errorBorder: InputBorder.none,
                                    focusedErrorBorder: InputBorder.none,
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
                                              safeSetState(() => _model
                                                      .apiRequestCompleter2 =
                                                  null);
                                              await _model
                                                  .waitForApiRequestCompleted2();
                                              safeSetState(() => _model
                                                      .apiRequestCompleter1 =
                                                  null);
                                              await _model
                                                  .waitForApiRequestCompleted1();
                                              safeSetState(() => _model
                                                      .awaitingRequestCompleter =
                                                  null);
                                              await _model
                                                  .waitForAwaitingRequestCompleted();
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
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        letterSpacing: 0.0,
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
                  ]
                      .divide(SizedBox(height: 5))
                      .addToStart(SizedBox(height: 5))
                      .addToEnd(SizedBox(height: 5)),
                ),
              ),
              if (FFAppState().STO != 'Поставщик')
                Container(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  child: TabBar(
                    controller: _tabController,
                    labelColor: FlutterFlowTheme.of(context).primary,
                    unselectedLabelColor:
                        FlutterFlowTheme.of(context).secondaryText,
                    labelStyle:
                        FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SFProText',
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w600,
                            ),
                    unselectedLabelStyle:
                        FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SFProText',
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                            ),
                    indicatorColor: FlutterFlowTheme.of(context).primary,
                    indicatorWeight: 2.0,
                    tabs: [
                      Tab(text: 'Активные заявки'),
                      Tab(text: 'Ожидают публикации'),
                    ],
                  ),
                ),
              Expanded(
                child: FFAppState().STO == 'Поставщик'
                    ? _buildActiveTab()
                    : TabBarView(
                        controller: _tabController,
                        children: [
                          _buildActiveTab(),
                          _buildAwaitingTab(),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveTab() {
    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter2 ??= Completer<ApiCallResponse>()
            ..complete(GetProcurementCall.call(
              token: currentAuthenticationToken,
              work: FFAppState().workspace,
              search: _model.textField12TextController.text != ''
                  ? '&search=${functions.encodeToUrlComponent(_model.textField12TextController.text)}'
                  : '',
              page: _model.page,
            )))
          .future,
      builder: (context, snapshot) {
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
        final procurementGetStoreHouseResponse = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    child: Builder(
                      builder: (context) {
                        final storehouse =
                            procurementGetStoreHouseResponse.jsonBody.toList();

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              List.generate(storehouse.length, (storehouseIndex) {
                            final storehouseItem = storehouse[storehouseIndex];
                            return _buildProcurementCard(
                              storehouseItem,
                              showPublishButton: false,
                            );
                          }),
                        );
                      },
                    ),
                  ),
                ],
              ),
              FutureBuilder<ApiCallResponse>(
                future: (_model.apiRequestCompleter1 ??=
                        Completer<ApiCallResponse>()
                          ..complete(GetProcurementCountCall.call(
                            token: currentAuthenticationToken,
                            page: _model.page,
                            work: FFAppState().workspace,
                            search: _model.textField12TextController.text != ''
                                ? '&search=${functions.encodeToUrlComponent(_model.textField12TextController.text)}'
                                : '',
                          )))
                    .future,
                builder: (context, snapshot) {
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
                  final conditionalBuilderGetDefectsAPIResponse = snapshot.data!;

                  return Builder(
                    builder: (context) {
                      if (functions
                              .jsonToList(
                                  procurementGetStoreHouseResponse.jsonBody)
                              .length <
                          10) {
                        return Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        );
                      } else {
                        return _buildPagination(
                          currentPage: _model.page,
                          totalCount: functions.divideUntilLessThanThousand(
                              functions.stringtoint(getJsonField(
                            conditionalBuilderGetDefectsAPIResponse.jsonBody,
                            r'''$.count''',
                          ).toString())),
                          onBack: () async {
                            if (_model.page <= 1) return;
                            _model.page = _model.page + -1;
                            safeSetState(() {});
                            safeSetState(
                                () => _model.apiRequestCompleter2 = null);
                            await _model.waitForApiRequestCompleted2();
                            safeSetState(
                                () => _model.apiRequestCompleter2 = null);
                            await _model.waitForApiRequestCompleted2(
                                minWait: 500);
                          },
                          onForward: () async {
                            _model.page = _model.page + 1;
                            safeSetState(() {});
                            safeSetState(
                                () => _model.apiRequestCompleter2 = null);
                            await _model.waitForApiRequestCompleted2();
                            safeSetState(
                                () => _model.apiRequestCompleter1 = null);
                            await _model.waitForApiRequestCompleted1(
                                minWait: 500);
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAwaitingTab() {
    return FutureBuilder<ApiCallResponse>(
      future: (_model.awaitingRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(GetProcurementAwaitingCall.call(
              token: currentAuthenticationToken,
              work: FFAppState().workspace,
              search: _model.textField12TextController.text != ''
                  ? '&search=${functions.encodeToUrlComponent(_model.textField12TextController.text)}'
                  : '',
              page: _model.awaitingPage,
            )))
          .future,
      builder: (context, snapshot) {
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
        final awaitingResponse = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).primaryBackground,
                ),
                child: Builder(
                  builder: (context) {
                    final awaitingList = awaitingResponse.jsonBody.toList();

                    if (awaitingList.isEmpty) {
                      return Padding(
                        padding: EdgeInsets.all(24),
                        child: Center(
                          child: Text(
                            'Нет заявок ожидающих публикации',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      );
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(awaitingList.length,
                          (awaitingIndex) {
                        final awaitingItem = awaitingList[awaitingIndex];
                        return _buildProcurementCard(
                          awaitingItem,
                          showPublishButton:
                              getJsonField(
                                    awaitingItem,
                                    r'''$.flow_type''',
                                  ).toString().contains('WITH_BUYER') &&
                                  getJsonField(
                                        awaitingItem,
                                        r'''$.buyer.id''',
                                      ).toString() ==
                                      getJsonField(
                                        FFAppState().result,
                                        r'''$.user.id''',
                                      ).toString(),
                        );
                      }),
                    );
                  },
                ),
              ),
              FutureBuilder<ApiCallResponse>(
                future: (_model.awaitingCountCompleter ??=
                        Completer<ApiCallResponse>()
                          ..complete(GetProcurementAwaitingCountCall.call(
                            token: currentAuthenticationToken,
                            page: _model.awaitingPage,
                            work: FFAppState().workspace,
                            search: _model.textField12TextController.text != ''
                                ? '&search=${functions.encodeToUrlComponent(_model.textField12TextController.text)}'
                                : '',
                          )))
                    .future,
                builder: (context, snapshot) {
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
                  final countResponse = snapshot.data!;

                  return Builder(
                    builder: (context) {
                      if (functions
                              .jsonToList(awaitingResponse.jsonBody)
                              .length <
                          10) {
                        return Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                        );
                      } else {
                        return _buildPagination(
                          currentPage: _model.awaitingPage,
                          totalCount: functions.divideUntilLessThanThousand(
                              functions.stringtoint(getJsonField(
                            countResponse.jsonBody,
                            r'''$.count''',
                          ).toString())),
                          onBack: () async {
                            if (_model.awaitingPage <= 1) return;
                            _model.awaitingPage = _model.awaitingPage - 1;
                            safeSetState(() {});
                            safeSetState(
                                () => _model.awaitingRequestCompleter = null);
                            await _model.waitForAwaitingRequestCompleted();
                            safeSetState(
                                () => _model.awaitingCountCompleter = null);
                            await _model.waitForAwaitingCountCompleted(
                                minWait: 500);
                          },
                          onForward: () async {
                            _model.awaitingPage = _model.awaitingPage + 1;
                            safeSetState(() {});
                            safeSetState(
                                () => _model.awaitingRequestCompleter = null);
                            await _model.waitForAwaitingRequestCompleted();
                            safeSetState(
                                () => _model.awaitingCountCompleter = null);
                            await _model.waitForAwaitingCountCompleted(
                                minWait: 500);
                          },
                        );
                      }
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProcurementCard(
    dynamic storehouseItem, {
    bool showPublishButton = false,
  }) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          context.pushNamed(
            ProcurementDetailedWidget.routeName,
            queryParameters: {
              'id': serializeParam(
                getJsonField(
                  storehouseItem,
                  r'''$.id''',
                ).toString(),
                ParamType.String,
              ),
            }.withoutNulls,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                color: Color(0x33000000),
                offset: Offset(0, 2),
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(16, 15, 16, 15),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.3,
                      decoration: BoxDecoration(),
                      child: Text(
                        'RFQ${getJsonField(
                          storehouseItem,
                          r'''$.short_id''',
                        ).toString()}',
                        style:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontSize: 12,
                                  letterSpacing: 0.0,
                                ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: functions.coloProcumentBG(getJsonField(
                            storehouseItem,
                            r'''$.status''',
                          ).toString()),
                          borderRadius: BorderRadius.circular(10),
                          shape: BoxShape.rectangle,
                        ),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(10, 5, 10, 5),
                            child: Text(
                              valueOrDefault<String>(
                                functions.procurementStatus(getJsonField(
                                  storehouseItem,
                                  r'''$.status''',
                                ).toString()),
                                '-',
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyLarge
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: Colors.white,
                                    fontSize: 13,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ].divide(SizedBox(width: 5)),
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  decoration: BoxDecoration(),
                  child: Text(
                    getJsonField(
                      storehouseItem,
                      r'''$.title''',
                    ).toString(),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          color: FlutterFlowTheme.of(context).primaryText,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                if (functions
                        .jsonToList(getJsonField(
                          storehouseItem,
                          r'''$.equipments''',
                        ))
                        .length >
                    0)
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsetsDirectional.fromSTEB(
                                            10, 0, 5, 0),
                                    child: Icon(
                                      Icons.directions_car,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      size: 20,
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 5, 10, 5),
                                      child: Text(
                                        getJsonField(
                                          storehouseItem,
                                          r'''$.equipments[0]''',
                                        ).toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'SFProText',
                                              fontSize: 13,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (functions
                                  .jsonToList(getJsonField(
                                    storehouseItem,
                                    r'''$.equipments''',
                                  ))
                                  .length >
                              1)
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondary,
                                  borderRadius: BorderRadius.circular(10),
                                  shape: BoxShape.rectangle,
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(0, 0),
                                      child: Padding(
                                        padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                5, 5, 5, 5),
                                        child: Text(
                                          '+ ${functions.substract(functions.jsonToList(getJsonField(
                                                storehouseItem,
                                                r'''$.equipments''',
                                              )).length.toString(), '1')}',
                                          style:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .override(
                                                    fontFamily: 'SFProText',
                                                    fontSize: 13,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                  ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ].divide(SizedBox(width: 5)),
                      ),
                    ].divide(SizedBox(width: 5)),
                  ),
                Text(
                  'Закупщик: ${getJsonField(
                    storehouseItem,
                    r'''$.buyer.title''',
                  ).toString()}',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'SFProText',
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 12,
                        letterSpacing: 0.0,
                      ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.35,
                            decoration: BoxDecoration(
                              color:
                                  FlutterFlowTheme.of(context).secondary,
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                            ),
                            child: Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(
                                        10, 5, 10, 5),
                                child: Text(
                                  getJsonField(
                                    storehouseItem,
                                    r'''$.inventory_items[0]''',
                                  ).toString(),
                                  maxLines: 1,
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'SFProText',
                                        fontSize: 11,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w300,
                                      ),
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if (functions
                                .jsonToList(getJsonField(
                                  storehouseItem,
                                  r'''$.inventory_items''',
                                ))
                                .length >
                            1)
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              width:
                                  MediaQuery.sizeOf(context).width * 0.35,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondary,
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                              ),
                              child: Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          10, 5, 10, 5),
                                  child: Text(
                                    getJsonField(
                                      storehouseItem,
                                      r'''$.inventory_items[1]''',
                                    ).toString(),
                                    maxLines: 1,
                                    style: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          fontFamily: 'SFProText',
                                          fontSize: 11,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w300,
                                        ),
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        if (functions
                                .jsonToList(getJsonField(
                                  storehouseItem,
                                  r'''$.inventory_items''',
                                ))
                                .length >
                            2)
                          Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondary,
                                borderRadius: BorderRadius.circular(10),
                                shape: BoxShape.rectangle,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment:
                                        AlignmentDirectional(0, 0),
                                    child: Padding(
                                      padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              5, 5, 5, 5),
                                      child: Text(
                                        '+ ${functions.substract(functions.jsonToList(getJsonField(
                                              storehouseItem,
                                              r'''$.inventory_items''',
                                            )).length.toString(), '2')}',
                                        style: FlutterFlowTheme.of(
                                                context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'SFProText',
                                              fontSize: 11,
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FontWeight.w300,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ].divide(SizedBox(width: 5)),
                    ),
                  ].divide(SizedBox(width: 5)),
                ),
                Divider(
                  thickness: 0.5,
                  color: FlutterFlowTheme.of(context).secondaryText,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'До: ${valueOrDefault<String>(
                        dateTimeFormat(
                          "dd.MM.y H:mm",
                          functions
                              .stringToDate(valueOrDefault<String>(
                            getJsonField(
                              storehouseItem,
                              r'''$.available_due''',
                            )?.toString(),
                            '-',
                          )),
                          locale:
                              FFLocalizations.of(context).languageCode,
                        ),
                        '-',
                      )}',
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'SFProText',
                            color: FlutterFlowTheme.of(context)
                                .secondaryText,
                            fontSize: 14,
                            letterSpacing: 0.0,
                          ),
                    ),
                    Text(
                      '${getJsonField(
                        storehouseItem,
                        r'''$.positions''',
                      ).toString()} поз.  |  ${getJsonField(
                        storehouseItem,
                        r'''$.count''',
                      ).toString()} шт.',
                      style: FlutterFlowTheme.of(context)
                          .bodyMedium
                          .override(
                            fontFamily: 'SFProText',
                            color: FlutterFlowTheme.of(context)
                                .secondaryText,
                            fontSize: 14,
                            letterSpacing: 0.0,
                          ),
                    ),
                  ],
                ),
                if (showPublishButton)
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 8, 0, 0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () async {
                          final procId = getJsonField(
                            storehouseItem,
                            r'''$.id''',
                          ).toString();

                          final result = await PublishProcurementCall.call(
                            token: currentAuthenticationToken,
                            id: procId,
                            work: FFAppState().workspace,
                          );

                          if (result.succeeded) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Заявка опубликована'),
                                backgroundColor:
                                    FlutterFlowTheme.of(context).primary,
                              ),
                            );
                            safeSetState(() =>
                                _model.awaitingRequestCompleter = null);
                            await _model
                                .waitForAwaitingRequestCompleted();
                            safeSetState(() =>
                                _model.awaitingCountCompleter = null);
                            safeSetState(() =>
                                _model.apiRequestCompleter2 = null);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Ошибка при публикации заявки'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.publish, size: 18),
                        label: Text('Опубликовать'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16, 10, 16, 10),
                        ),
                      ),
                    ),
                  ),
              ].divide(SizedBox(height: 7)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPagination({
    required int currentPage,
    required int totalCount,
    required VoidCallback onBack,
    required VoidCallback onForward,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FFButtonWidget(
            onPressed: onBack,
            text: 'Назад',
            icon: Icon(
              Icons.chevron_left,
              size: 15,
            ),
            options: FFButtonOptions(
              height: 40,
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              iconColor: FlutterFlowTheme.of(context).primary,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'SFProText',
                    color: FlutterFlowTheme.of(context).primary,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                  ),
              elevation: 0,
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          Text(
            '${currentPage.toString()} из ${totalCount.toString()}',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 16,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          FFButtonWidget(
            onPressed: onForward,
            text: 'Вперед',
            icon: Icon(
              Icons.chevron_right,
              size: 15,
            ),
            options: FFButtonOptions(
              height: 40,
              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              iconAlignment: IconAlignment.end,
              iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
              iconColor: FlutterFlowTheme.of(context).primary,
              color: FlutterFlowTheme.of(context).secondaryBackground,
              textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                    fontFamily: 'SFProText',
                    color: FlutterFlowTheme.of(context).primary,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal,
                  ),
              elevation: 0,
              borderSide: BorderSide(
                color: FlutterFlowTheme.of(context).primary,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
