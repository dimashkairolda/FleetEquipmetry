import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'inspections_time_list_model.dart';
export 'inspections_time_list_model.dart';

class InspectionsTimeListWidget extends StatefulWidget {
  const InspectionsTimeListWidget({
    super.key,
    required this.title,
  });

  final String? title;

  static String routeName = 'InspectionsTimeList';
  static String routePath = '/inspectionsTimeList';

  @override
  State<InspectionsTimeListWidget> createState() =>
      _InspectionsTimeListWidgetState();
}

class _InspectionsTimeListWidgetState extends State<InspectionsTimeListWidget> {
  late InspectionsTimeListModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InspectionsTimeListModel());

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
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.chevron_left_sharp,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget.title,
              'q',
            ),
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'SFProText',
                  fontSize: 14.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 12.0, 0.0),
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  var _shouldSetState = false;
                  Function() _navigate = () {};
                  _model.authResponse = await AuthCall.call(
                    username: FFAppState().rememberEmail,
                    password: FFAppState().rememberPassword,
                  );

                  _shouldSetState = true;
                  GoRouter.of(context).prepareAuthEvent();
                  await authManager.signIn(
                    authenticationToken: AuthCall.accesstoken(
                      (_model.authResponse?.jsonBody ?? ''),
                    ),
                  );
                  _navigate = () => context.goNamedAuth(
                      RaportWidget.routeName, context.mounted);
                  FFAppState().sendDefectCounter = 0;
                  FFAppState().loopConfirm = 0;
                  FFAppState().loopReject = 0;
                  FFAppState().loopFixed = 0;
                  FFAppState().loadingInspections = 1;
                  safeSetState(() {});
                  FFAppState().loopInspections = 0;
                  safeSetState(() {});
                  _model.apiResultcb9 = await GetSparePartsCatalogCall.call(
                    access: currentAuthenticationToken,
                  );

                  _shouldSetState = true;
                  if ((_model.apiResultcb9?.succeeded ?? true)) {
                    FFAppState().checkCache = getJsonField(
                      (_model.apiResultcb9?.jsonBody ?? ''),
                      r'''$.data''',
                    );
                    safeSetState(() {});
                  } else {
                    _navigate();
                    if (_shouldSetState) safeSetState(() {});
                    return;
                  }

                  FFAppState().loadingInspections = 0;
                  FFAppState().endedInspections = [];
                  safeSetState(() {});

                  _navigate();
                  if (_shouldSetState) safeSetState(() {});
                },
                child: Icon(
                  Icons.sync,
                  color: FlutterFlowTheme.of(context).primary,
                  size: 30.0,
                ),
              ),
            ),
          ],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Builder(
                  builder: (context) {
                    final inspections = functions
                        .filterInspectionsByTitle(
                            FFAppState().checkCache, widget.title!)
                        .toList();

                    return ListView.builder(
                      padding: EdgeInsets.zero,
                      primary: false,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: inspections.length,
                      itemBuilder: (context, inspectionsIndex) {
                        final inspectionsItem = inspections[inspectionsIndex];
                        return Align(
                          alignment: AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 1.0),
                            child: InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                context.pushNamed(
                                  DetailedInspectionsWidget.routeName,
                                  queryParameters: {
                                    'name': serializeParam(
                                      getJsonField(
                                        inspectionsItem,
                                        r'''$''',
                                      ),
                                      ParamType.JSON,
                                    ),
                                    'index': serializeParam(
                                      inspectionsIndex,
                                      ParamType.int,
                                    ),
                                  }.withoutNulls,
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 0.0,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      offset: Offset(
                                        0.0,
                                        1.0,
                                      ),
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(0.0),
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 12.0, 16.0, 12.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12.0, 0.0, 12.0, 0.0),
                                          child: Text(
                                            '${dateTimeFormat(
                                              "Hm",
                                              functions.stringToDateTime(
                                                  getJsonField(
                                                inspectionsItem,
                                                r'''$.available_from''',
                                              ).toString()),
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )}-${dateTimeFormat(
                                              "Hm",
                                              functions.stringToDateTime(
                                                  getJsonField(
                                                inspectionsItem,
                                                r'''$.available_to''',
                                              ).toString()),
                                              locale:
                                                  FFLocalizations.of(context)
                                                      .languageCode,
                                            )}',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily: 'SFProText',
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          if ((FFAppState()
                                                      .loadingInspections ==
                                                  1) &&
                                              functions.isJsonInList(
                                                  getJsonField(
                                                    inspectionsItem,
                                                    r'''$.id''',
                                                  ),
                                                  FFAppState()
                                                      .endedInspections
                                                      .toList())) {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 7.0, 0.0),
                                              child: Lottie.asset(
                                                'assets/jsons/clock-loading.json',
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.02,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.02,
                                                fit: BoxFit.cover,
                                                animate: true,
                                              ),
                                            );
                                          } else if (functions.isJsonInList(
                                              getJsonField(
                                                inspectionsItem,
                                                r'''$.id''',
                                              ),
                                              FFAppState()
                                                  .endedInspections
                                                  .toList())) {
                                            return Icon(
                                              Icons.cloud_off_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24.0,
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
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.35,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.025,
                                          decoration: BoxDecoration(
                                            color: () {
                                              if ((functions
                                                          .checkInspectionStatus(
                                                              getJsonField(
                                                                inspectionsItem,
                                                                r'''$.available_from''',
                                                              ).toString(),
                                                              getJsonField(
                                                                inspectionsItem,
                                                                r'''$.available_to''',
                                                              ).toString()) ==
                                                      'Просрочено') &&
                                                  (getJsonField(
                                                        inspectionsItem,
                                                        r'''$.finished_on''',
                                                      ) ==
                                                      null)) {
                                                return Color(0xFFF73742);
                                              } else if ((functions
                                                          .checkInspectionStatus(
                                                              getJsonField(
                                                                inspectionsItem,
                                                                r'''$.available_from''',
                                                              ).toString(),
                                                              getJsonField(
                                                                inspectionsItem,
                                                                r'''$.available_to''',
                                                              ).toString()) ==
                                                      'Текущее') &&
                                                  (getJsonField(
                                                        inspectionsItem,
                                                        r'''$.finished_on''',
                                                      ) ==
                                                      null)) {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .warning;
                                              } else if ((functions
                                                          .checkInspectionStatus(
                                                              getJsonField(
                                                                inspectionsItem,
                                                                r'''$.available_from''',
                                                              ).toString(),
                                                              getJsonField(
                                                                inspectionsItem,
                                                                r'''$.available_to''',
                                                              ).toString()) ==
                                                      'Запланировано') &&
                                                  (getJsonField(
                                                        inspectionsItem,
                                                        r'''$.finished_on''',
                                                      ) ==
                                                      null)) {
                                                return Color(0xFF2A61ED);
                                              } else {
                                                return Color(0xFF39D283);
                                              }
                                            }(),
                                            borderRadius:
                                                BorderRadius.circular(4.0),
                                          ),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(0.0, 0.0),
                                            child: Text(
                                              getJsonField(
                                                        inspectionsItem,
                                                        r'''$.finished_on''',
                                                      ) !=
                                                      null
                                                  ? 'Выполнено'
                                                  : functions
                                                      .checkInspectionStatus(
                                                          getJsonField(
                                                            inspectionsItem,
                                                            r'''$.available_from''',
                                                          ).toString(),
                                                          getJsonField(
                                                            inspectionsItem,
                                                            r'''$.available_to''',
                                                          ).toString()),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.chevron_right_rounded,
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryText,
                                        size: 24.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
