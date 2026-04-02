import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/cto/kp/kp_widget.dart';
import '/cto/kp_work/kp_work_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'kp_edit_model.dart';
export 'kp_edit_model.dart';

class KpEditWidget extends StatefulWidget {
  const KpEditWidget({
    super.key,
    required this.json,
  });

  final dynamic json;

  static String routeName = 'kpEdit';
  static String routePath = '/kpEdit';

  @override
  State<KpEditWidget> createState() => _KpEditWidgetState();
}

class _KpEditWidgetState extends State<KpEditWidget>
    with TickerProviderStateMixin {
  late KpEditModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => KpEditModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().kpInventory = (getJsonField(
        widget.json,
        r'''$.inventory_items''',
        true,
      )!
              .toList()
              .map<InventoryItemsStruct?>(InventoryItemsStruct.maybeFromMap)
              .toList() as Iterable<InventoryItemsStruct?>)
          .withoutNulls
          .toList()
          .cast<InventoryItemsStruct>();
      FFAppState().kpWork = (getJsonField(
        widget.json,
        r'''$.works''',
        true,
      )!
              .toList()
              .map<WorksStruct?>(WorksStruct.maybeFromMap)
              .toList() as Iterable<WorksStruct?>)
          .withoutNulls
          .toList()
          .cast<WorksStruct>();
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
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
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF3466E7),
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
              FFAppState().fotki = [];
              FFAppState().todo = [];
              FFAppState().spareparts = [];
              FFAppState().photos = [];
              FFAppState().photosedit = [];
              safeSetState(() {});
            },
          ),
          title: Text(
            'Составить КП',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'SFProText',
                  color: Color(0xFF3466E7),
                  fontSize: 18.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Align(
              alignment: AlignmentDirectional(1.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  _model.apiResultih5 = await CTOCommandCall.call(
                    command: 'kp',
                    access: currentAuthenticationToken,
                    work: FFAppState().workspace,
                    id: getJsonField(
                      widget.json,
                      r'''$.id''',
                    ).toString(),
                    bodyJson: CTOCreateStruct(
                      works: FFAppState().kpWork,
                      inventoryItems: FFAppState().kpInventory,
                    ).toMap(),
                  );

                  if ((_model.apiResultih5?.succeeded ?? true)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Успешно!',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                      ),
                    );
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed(
                      CTOdetailedWidget.routeName,
                      queryParameters: {
                        'json': serializeParam(
                          widget.json,
                          ParamType.JSON,
                        ),
                      }.withoutNulls,
                    );
                  }
                  FFAppState().kpInventory = [];
                  FFAppState().kpWork = [];
                  safeSetState(() {});

                  safeSetState(() {});
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.3,
                  height: 100.0,
                  decoration: BoxDecoration(),
                  child: Align(
                    alignment: AlignmentDirectional(1.0, 0.0),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                      child: Text(
                        'Сохранить',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SFProText',
                              color: Color(0xFF3466E7),
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment(0.0, 0),
                  child: FlutterFlowButtonTabBar(
                    useToggleButtonStyle: false,
                    isScrollable: true,
                    labelStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'SFProText',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                    unselectedLabelStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'SFProText',
                              fontSize: 14.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                    labelColor: Color(0xFF3466E7),
                    unselectedLabelColor:
                        FlutterFlowTheme.of(context).secondaryText,
                    backgroundColor: Color(0xFFA6D0FF),
                    borderWidth: 0.0,
                    borderRadius: 8.0,
                    elevation: 2.0,
                    buttonMargin:
                        EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                    tabs: [
                      Tab(
                        text: 'Список ТМЦ',
                      ),
                      Tab(
                        text: 'Список работ',
                      ),
                    ],
                    controller: _model.tabBarController,
                    onTap: (i) async {
                      [() async {}, () async {}][i]();
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _model.tabBarController,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    13.5, 15.0, 13.5, 0.0),
                                            child: Text(
                                              'Список ТМЦ',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            13.5, 15.0, 13.5, 15.0),
                                        child: Builder(
                                          builder: (context) {
                                            final spareparts = FFAppState()
                                                .kpInventory
                                                .toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  spareparts.length,
                                                  (sparepartsIndex) {
                                                final sparepartsItem =
                                                    spareparts[sparepartsIndex];
                                                return KpWidget(
                                                  key: Key(
                                                      'Key8f2_${sparepartsIndex}_of_${spareparts.length}'),
                                                  parameter1:
                                                      sparepartsItem.title,
                                                  parameter2: sparepartsItem
                                                      .productArticle,
                                                  parameter3: sparepartsItem
                                                      .quantity
                                                      .toDouble(),
                                                  parameter4: sparepartsItem
                                                      .unitOfMeasurement,
                                                  parameter5:
                                                      sparepartsItem.price,
                                                  parameter6: sparepartsItem
                                                      .serviceStationComment,
                                                  index: sparepartsIndex,
                                                );
                                              }),
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
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 16.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            13.5, 15.0, 13.5, 0.0),
                                        child: Text(
                                          'Список работ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            11.5, 15.0, 11.5, 15.0),
                                        child: Builder(
                                          builder: (context) {
                                            final todo =
                                                FFAppState().kpWork.toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  todo.length, (todoIndex) {
                                                final todoItem =
                                                    todo[todoIndex];
                                                return KpWorkWidget(
                                                  key: Key(
                                                      'Key24s_${todoIndex}_of_${todo.length}'),
                                                  parameter1: todoItem.title,
                                                  parameter2: todoItem.quantity
                                                      .toDouble(),
                                                  parameter3:
                                                      todoItem.price.toDouble(),
                                                  parameter4: todoItem
                                                      .serviceStationComment,
                                                  index: todoIndex,
                                                );
                                              }),
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
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
