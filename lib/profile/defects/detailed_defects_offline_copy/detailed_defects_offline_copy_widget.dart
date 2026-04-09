import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/bottom_nav_config.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/procurement/create_procurement/create_procurement_widget.dart';
import '/profile/defects/delete_copy/delete_copy_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'detailed_defects_offline_copy_model.dart';
export 'detailed_defects_offline_copy_model.dart';

class DetailedDefectsOfflineCopyWidget extends StatefulWidget {
  const DetailedDefectsOfflineCopyWidget({
    super.key,
    this.equipID,
    this.type,
    this.title,
    this.reason,
    this.events,
    this.equiptitle,
    this.authorid,
    this.authorfirstname,
    this.responsible,
    this.department,
    this.id,
    this.storehousestatus,
  });

  final int? equipID;
  final String? type;
  final String? title;
  final String? reason;
  final String? events;
  final String? equiptitle;
  final int? authorid;
  final String? authorfirstname;
  final int? responsible;
  final String? department;
  final String? id;
  final String? storehousestatus;

  static String routeName = 'DetailedDefectsOfflineCopy';
  static String routePath = '/detailedDefectsOfflineCopy';

  @override
  State<DetailedDefectsOfflineCopyWidget> createState() =>
      _DetailedDefectsOfflineCopyWidgetState();
}

class _DetailedDefectsOfflineCopyWidgetState
    extends State<DetailedDefectsOfflineCopyWidget>
    with TickerProviderStateMixin {
  late DetailedDefectsOfflineCopyModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedDefectsOfflineCopyModel());

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
      future: GetDetailedDefectsCall.call(
        access: currentAuthenticationToken,
        defect: widget!.id,
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
        final detailedDefectsOfflineCopyGetDetailedDefectsResponse =
            snapshot.data!;

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
              title: Text(
                'Информация о дефекте',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'SFProText',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 18,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(),
                    child: Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          if ((functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/equipment/sectors')
                                      .toString() ==
                                  '2') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '3') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '6') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '7') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '10') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '11') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '14') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '15') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '12'))
                            Align(
                              alignment: AlignmentDirectional(1, 0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  FFAppState().spareparts = (getJsonField(
                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                        .jsonBody,
                                    r'''$.spare_parts''',
                                    true,
                                  )!
                                              .toList()
                                              .map<SparePartsStruct?>(
                                                  SparePartsStruct.maybeFromMap)
                                              .toList()
                                          as Iterable<SparePartsStruct?>)
                                      .withoutNulls
                                      .toList()
                                      .cast<SparePartsStruct>();
                                  FFAppState().todo = (getJsonField(
                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                        .jsonBody,
                                    r'''$.todo''',
                                    true,
                                  )!
                                          .toList()
                                          .map<TodoStruct?>(
                                              TodoStruct.maybeFromMap)
                                          .toList() as Iterable<TodoStruct?>)
                                      .withoutNulls
                                      .toList()
                                      .cast<TodoStruct>();
                                  FFAppState().photosedit = getJsonField(
                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                        .jsonBody,
                                    r'''$.media''',
                                    true,
                                  )!
                                      .toList()
                                      .cast<dynamic>();
                                  FFAppState().defecttime =
                                      functions.stringToDateTime(getJsonField(
                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                        .jsonBody,
                                    r'''$.date''',
                                  ).toString());
                                  safeSetState(() {});

                                  context.pushNamed(
                                    EditDefectWidget.routeName,
                                    queryParameters: {
                                      'spareparts': serializeParam(
                                        (getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.spare_parts''',
                                          true,
                                        )
                                                    ?.toList()
                                                    .map<SparePartsStruct?>(
                                                        SparePartsStruct
                                                            .maybeFromMap)
                                                    .toList()
                                                as Iterable<SparePartsStruct?>)
                                            .withoutNulls,
                                        ParamType.DataStruct,
                                        isList: true,
                                      ),
                                      'todo': serializeParam(
                                        (getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.todo''',
                                          true,
                                        )
                                                    ?.toList()
                                                    .map<TodoStruct?>(
                                                        TodoStruct.maybeFromMap)
                                                    .toList()
                                                as Iterable<TodoStruct?>)
                                            .withoutNulls,
                                        ParamType.DataStruct,
                                        isList: true,
                                      ),
                                      'equipId': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.equipment.id''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'nazvanie': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.title''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'description': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.description''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'date': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.date''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'probeg': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.mileage''',
                                        ),
                                        ParamType.int,
                                      ),
                                      'motohours': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.moto_hours''',
                                        ),
                                        ParamType.int,
                                      ),
                                      'media': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.media''',
                                        ),
                                        ParamType.JSON,
                                      ),
                                      'categoryid': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.category.id''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'defectid': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.id''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'sparepart1': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.spare_parts''',
                                          true,
                                        ),
                                        ParamType.JSON,
                                        isList: true,
                                      ),
                                      'todo1': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.todo''',
                                          true,
                                        ),
                                        ParamType.JSON,
                                        isList: true,
                                      ),
                                      'brandname': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.equipment.brand_id.name''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'modelname': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.equipment.model_id.name''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'number': serializeParam(
                                        getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.equipment.license_plate_number''',
                                        ).toString(),
                                        ParamType.String,
                                      ),
                                      'page': serializeParam(
                                        0,
                                        ParamType.int,
                                      ),
                                      'users': serializeParam(
                                        (getJsonField(
                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                              .jsonBody,
                                          r'''$.assignees[:].id''',
                                          true,
                                        ) as List?)
                                            ?.map<String>((e) => e.toString())
                                            .toList()
                                            .cast<String>(),
                                        ParamType.String,
                                        isList: true,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: FlutterFlowTheme.of(context).primary,
                                  size: 25,
                                ),
                              ),
                            ),
                          if ((functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/equipment/sectors')
                                      .toString() ==
                                  '5') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '3') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '7') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '9') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '11') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '13') ||
                              (functions
                                      .getAclValue(FFAppState().result,
                                          '/api/v1/workspace/defects/{id}')
                                      .toString() ==
                                  '15'))
                            Align(
                              alignment: AlignmentDirectional(0, 0),
                              child: Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(0, 0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.15,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.8,
                                              child: DeleteCopyWidget(
                                                id: getJsonField(
                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                      .jsonBody,
                                                  r'''$.id''',
                                                ).toString(),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );

                                    context.pushNamed(DefectsWidget.routeName);
                                  },
                                  child: Icon(
                                    Icons.delete_forever,
                                    color: FlutterFlowTheme.of(context).primary,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 10, 0, 10),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (functions
                                                  .jsonToList(getJsonField(
                                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                        .jsonBody,
                                                    r'''$.media''',
                                                  ))
                                                  .length
                                                  .toString() ==
                                              '0') {
                                            return Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                            );
                                          } else {
                                            return Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 0, 10, 0),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  fadeInDuration:
                                                      Duration(milliseconds: 0),
                                                  fadeOutDuration:
                                                      Duration(milliseconds: 0),
                                                  imageUrl: getJsonField(
                                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                        .jsonBody,
                                                    r'''$.media[0]''',
                                                  ).toString(),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.16,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.052,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(-1, 0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.5,
                                          decoration: BoxDecoration(),
                                          child: Align(
                                            alignment:
                                                AlignmentDirectional(-1, 0),
                                            child: Text(
                                              getJsonField(
                                                detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                    .jsonBody,
                                                r'''$.title''',
                                              ).toString(),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 17,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
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
                                      20, 0, 0, 10),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    decoration: BoxDecoration(
                                      color: functions
                                          .colorDefectCopy(getJsonField(
                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                            .jsonBody,
                                        r'''$.status''',
                                      ).toString()),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 5, 0, 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    5, 0, 5, 0),
                                            child: Text(
                                              valueOrDefault<String>(
                                                functions
                                                    .statusToRus(getJsonField(
                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                      .jsonBody,
                                                  r'''$.status''',
                                                ).toString()),
                                                '-',
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color: functions
                                                            .colorDefectCopyCopy(
                                                                getJsonField(
                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                              .jsonBody,
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
                                ),
                              ],
                            ),
                          ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.sizeOf(context).width,
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
                                    labelColor: Color(0xFF3466E7),
                                    unselectedLabelColor:
                                        FlutterFlowTheme.of(context)
                                            .secondaryText,
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          fontSize: 13,
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
                                        text: 'Список ТМЦ',
                                      ),
                                      Tab(
                                        text: 'Список работ',
                                      ),
                                      Tab(
                                        text: 'Вложения',
                                      ),
                                      Tab(
                                        text: 'История',
                                      ),
                                    ],
                                    controller: _model.tabBarController,
                                    onTap: (i) async {
                                      [
                                        () async {},
                                        () async {
                                          FFAppState()
                                              .spareparts = (getJsonField(
                                            detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                .jsonBody,
                                            r'''$.spare_parts''',
                                            true,
                                          )!
                                                      .toList()
                                                      .map<SparePartsStruct?>(
                                                          SparePartsStruct
                                                              .maybeFromMap)
                                                      .toList()
                                                  as Iterable<
                                                      SparePartsStruct?>)
                                              .withoutNulls
                                              .toList()
                                              .cast<SparePartsStruct>();
                                          safeSetState(() {});
                                        },
                                        () async {
                                          FFAppState().todo = (getJsonField(
                                            detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                .jsonBody,
                                            r'''$.todo''',
                                            true,
                                          )!
                                                      .toList()
                                                      .map<TodoStruct?>(
                                                          TodoStruct.maybeFromMap)
                                                      .toList()
                                                  as Iterable<TodoStruct?>)
                                              .withoutNulls
                                              .toList()
                                              .cast<TodoStruct>();
                                          safeSetState(() {});
                                        },
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
                                                  .fromSTEB(11.5, 8, 11.5, 0),
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 16, 0, 16),
                                                  child: FutureBuilder<
                                                      ApiCallResponse>(
                                                    future:
                                                        GetDefectStoreHouseOrderCall
                                                            .call(
                                                      token:
                                                          currentAuthenticationToken,
                                                      id: getJsonField(
                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                            .jsonBody,
                                                        r'''$.id''',
                                                      ).toString(),
                                                      work: FFAppState()
                                                          .workspace,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            Center(
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
                                                            ),
                                                            const SizedBox(
                                                                height: 16),
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(12),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: Border.all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .alternate),
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  Icon(
                                                                    (bottomNavMetaFor(
                                                                                'Procurement')
                                                                            ?.icon ??
                                                                        Icons
                                                                            .manage_search),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    size: 22,
                                                                  ),
                                                                  const SizedBox(
                                                                      width: 10),
                                                                  Expanded(
                                                                    child: Text(
                                                                      'Доска объявлений',
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium,
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    onTap:
                                                                        () async {
                                                                      final defectId =
                                                                          getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.id''',
                                                                      ).toString();
                                                                      final sparePartsRaw =
                                                                          getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.spare_parts''',
                                                                        true,
                                                                      );
                                                                      final sparePartsList =
                                                                          (sparePartsRaw
                                                                                  is List)
                                                                              ? sparePartsRaw
                                                                              : <dynamic>[];

                                                                      FFAppState().CTOInventoryItems = sparePartsList
                                                                          .map((e) => SparePartsStruct.maybeFromMap(e))
                                                                          .whereType<
                                                                              SparePartsStruct>()
                                                                          .map(
                                                                            (p) =>
                                                                                InventoryItemsStruct(
                                                                              title: p.title,
                                                                              productArticle: p.productArticle,
                                                                              quantity: p.quantity,
                                                                              unitOfMeasurement: 'шт',
                                                                              defectId: defectId,
                                                                              source: 'DEFECT',
                                                                            ),
                                                                          )
                                                                          .toList();
                                                                      safeSetState(
                                                                          () {});

                                                                      context
                                                                          .pushNamed(
                                                                        CreateProcurementWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'initialTitle':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.title''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          horizontal:
                                                                              12,
                                                                          vertical:
                                                                              6),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'Создать',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodySmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }
                                                      final columnGetDefectStoreHouseOrderResponse =
                                                          snapshot.data!;

                                                      return Column(
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
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-NotePencil_(1).png',
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
                                                                          16,
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
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              3),
                                                                          child:
                                                                              Text(
                                                                            'Описание ',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.75,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              getJsonField(
                                                                                detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                r'''$.description''',
                                                                              )?.toString(),
                                                                              '-',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  fontSize: 17,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
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
                                                                                    columnGetDefectStoreHouseOrderResponse.jsonBody,
                                                                                    r'''$.equipment.avatar''',
                                                                                  ).toString(),
                                                                                  fit: BoxFit.cover,
                                                                                  errorBuilder: (context, error, stackTrace) => Image.asset(
                                                                                    'assets/images/error_image.png',
                                                                                    fit: BoxFit.cover,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            InkWell(
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
                                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                        r'''$.equipment.id''',
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
                                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                          r'''$.equipment.brand_id.name''',
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
                                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                          r'''$.equipment.model_id.name''',
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
                                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                          r'''$.equipment.license_plate_number''',
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
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Icon(
                                                                      (bottomNavMetaFor('Procurement')
                                                                              ?.icon ??
                                                                          Icons
                                                                              .manage_search),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size: 28,
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
                                                                          0.7,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1, -1),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.7,
                                                                              decoration: BoxDecoration(),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                                                                child: Text(
                                                                                  'Доска объявлений',
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
                                                                          ),
                                                                          Builder(
                                                                            builder:
                                                                                (context) {
                                                                              return Align(
                                                                                alignment: AlignmentDirectional(-1, 0),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onTap: () async {
                                                                                    final defectId = getJsonField(
                                                                                      detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                                          .jsonBody,
                                                                                      r'''$.id''',
                                                                                    ).toString();
                                                                                    final sparePartsRaw = getJsonField(
                                                                                      detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                                          .jsonBody,
                                                                                      r'''$.spare_parts''',
                                                                                      true,
                                                                                    );
                                                                                    final sparePartsList =
                                                                                        (sparePartsRaw is List)
                                                                                            ? sparePartsRaw
                                                                                            : <dynamic>[];

                                                                                    FFAppState().CTOInventoryItems =
                                                                                        sparePartsList
                                                                                            .map((e) =>
                                                                                                SparePartsStruct
                                                                                                    .maybeFromMap(e))
                                                                                            .whereType<
                                                                                                SparePartsStruct>()
                                                                                            .map(
                                                                                              (p) =>
                                                                                                  InventoryItemsStruct(
                                                                                                title: p.title,
                                                                                                productArticle:
                                                                                                    p.productArticle,
                                                                                                quantity: p.quantity,
                                                                                                unitOfMeasurement: 'шт',
                                                                                                defectId: defectId,
                                                                                                source: 'DEFECT',
                                                                                              ),
                                                                                            )
                                                                                            .toList();
                                                                                    safeSetState(() {});

                                                                                    context.pushNamed(
                                                                                      CreateProcurementWidget
                                                                                          .routeName,
                                                                                      queryParameters: {
                                                                                        'initialTitle': serializeParam(
                                                                                          getJsonField(
                                                                                            detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                                                .jsonBody,
                                                                                            r'''$.title''',
                                                                                          ).toString(),
                                                                                          ParamType.String,
                                                                                        ),
                                                                                      }.withoutNulls,
                                                                                    );
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: FlutterFlowTheme.of(context)
                                                                                          .primary,
                                                                                      borderRadius:
                                                                                          BorderRadius.circular(10),
                                                                                      shape: BoxShape.rectangle,
                                                                                    ),
                                                                                    child: Align(
                                                                                      alignment:
                                                                                          AlignmentDirectional(0, 0),
                                                                                      child: Padding(
                                                                                        padding:
                                                                                            EdgeInsetsDirectional.fromSTEB(
                                                                                                15, 5, 15, 5),
                                                                                        child: Text(
                                                                                          'Создать',
                                                                                          style: FlutterFlowTheme.of(context)
                                                                                              .bodyLarge
                                                                                              .override(
                                                                                                fontFamily: 'SFProText',
                                                                                                color: FlutterFlowTheme.of(context)
                                                                                                    .secondaryBackground,
                                                                                                fontSize: 15,
                                                                                                letterSpacing: 0.0,
                                                                                                fontWeight: FontWeight.normal,
                                                                                              ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              );
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
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
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/Icon-Wrench.png',
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
                                                                    child: FutureBuilder<
                                                                        ApiCallResponse>(
                                                                      future: GetCTODefectCall
                                                                          .call(
                                                                        access:
                                                                            currentAuthenticationToken,
                                                                        search:
                                                                            getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.id''',
                                                                        ).toString(),
                                                                        work1: FFAppState()
                                                                            .workspace,
                                                                      ),
                                                                      builder:
                                                                          (context,
                                                                              snapshot) {
                                                                        // Customize what your widget looks like when it's loading.
                                                                        if (!snapshot
                                                                            .hasData) {
                                                                          return Center(
                                                                            child:
                                                                                SizedBox(
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
                                                                        final containerGetCTODefectResponse =
                                                                            snapshot.data!;

                                                                        return Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.7,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Align(
                                                                                alignment: AlignmentDirectional(-1, -1),
                                                                                child: Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.7,
                                                                                  decoration: BoxDecoration(),
                                                                                  child: Padding(
                                                                                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                                                                    child: Text(
                                                                                      'Заявка в СТО',
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
                                                                              ),
                                                                              Builder(
                                                                                builder: (context) {
                                                                                  if (functions.jsonToList(containerGetCTODefectResponse.jsonBody).length == 0) {
                                                                                    return Column(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1, 0),
                                                                                          child: InkWell(
                                                                                            splashColor: Colors.transparent,
                                                                                            focusColor: Colors.transparent,
                                                                                            hoverColor: Colors.transparent,
                                                                                            highlightColor: Colors.transparent,
                                                                                            onTap: () async {
                                                                                              FFAppState().addToDefectCTO(detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody);
                                                                                              FFAppState().CTOInventoryItems = functions
                                                                                                  .toOneListCTOINventoryItemsCopy(
                                                                                                      FFAppState().CTOInventoryItems.toList(),
                                                                                                      functions
                                                                                                          .toSht((getJsonField(
                                                                                                            detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                            r'''$.spare_parts''',
                                                                                                            true,
                                                                                                          )!
                                                                                                                  .toList()
                                                                                                                  .map<InventoryItemsStruct?>(InventoryItemsStruct.maybeFromMap)
                                                                                                                  .toList() as Iterable<InventoryItemsStruct?>)
                                                                                                              .withoutNulls
                                                                                                              .toList())
                                                                                                          .toList(),
                                                                                                      getJsonField(
                                                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                        r'''$.id''',
                                                                                                      ).toString())
                                                                                                  .toList()
                                                                                                  .cast<InventoryItemsStruct>();
                                                                                              FFAppState().CTOWorks = functions
                                                                                                  .toOneListCTOWorks(
                                                                                                      FFAppState().CTOWorks.toList(),
                                                                                                      (getJsonField(
                                                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                        r'''$.todo''',
                                                                                                        true,
                                                                                                      )!
                                                                                                              .toList()
                                                                                                              .map<WorksStruct?>(WorksStruct.maybeFromMap)
                                                                                                              .toList() as Iterable<WorksStruct?>)
                                                                                                          .withoutNulls
                                                                                                          .toList(),
                                                                                                      getJsonField(
                                                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                        r'''$.id''',
                                                                                                      ).toString())
                                                                                                  .toList()
                                                                                                  .cast<WorksStruct>();
                                                                                              safeSetState(() {});

                                                                                              context.pushNamed(
                                                                                                CreateCTOWidget.routeName,
                                                                                                queryParameters: {
                                                                                                  'brandname': serializeParam(
                                                                                                    getJsonField(
                                                                                                      detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                      r'''$.equipment.brand_id.name''',
                                                                                                    ).toString(),
                                                                                                    ParamType.String,
                                                                                                  ),
                                                                                                  'modelname': serializeParam(
                                                                                                    getJsonField(
                                                                                                      detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                      r'''$.equipment.model_id.name''',
                                                                                                    ).toString(),
                                                                                                    ParamType.String,
                                                                                                  ),
                                                                                                  'number': serializeParam(
                                                                                                    getJsonField(
                                                                                                      detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                      r'''$.equipment.license_plate_number''',
                                                                                                    ).toString(),
                                                                                                    ParamType.String,
                                                                                                  ),
                                                                                                  'asset': serializeParam(
                                                                                                    getJsonField(
                                                                                                      detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                      r'''$.equipment.id''',
                                                                                                    ).toString(),
                                                                                                    ParamType.String,
                                                                                                  ),
                                                                                                }.withoutNulls,
                                                                                              );
                                                                                            },
                                                                                            child: Container(
                                                                                              decoration: BoxDecoration(
                                                                                                color: FlutterFlowTheme.of(context).primary,
                                                                                                borderRadius: BorderRadius.circular(10),
                                                                                                shape: BoxShape.rectangle,
                                                                                              ),
                                                                                              child: Align(
                                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                                                                                                  child: Text(
                                                                                                    'Создать',
                                                                                                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                          fontSize: 15,
                                                                                                          letterSpacing: 0.0,
                                                                                                          fontWeight: FontWeight.normal,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    );
                                                                                  } else {
                                                                                    return InkWell(
                                                                                      splashColor: Colors.transparent,
                                                                                      focusColor: Colors.transparent,
                                                                                      hoverColor: Colors.transparent,
                                                                                      highlightColor: Colors.transparent,
                                                                                      onTap: () async {
                                                                                        context.pushNamed(
                                                                                          CTOdetailedWidget.routeName,
                                                                                          queryParameters: {
                                                                                            'json': serializeParam(
                                                                                              getJsonField(
                                                                                                containerGetCTODefectResponse.jsonBody,
                                                                                                r'''$[0]''',
                                                                                              ),
                                                                                              ParamType.JSON,
                                                                                            ),
                                                                                          }.withoutNulls,
                                                                                        );
                                                                                      },
                                                                                      child: Container(
                                                                                        decoration: BoxDecoration(
                                                                                          color: functions.colorCTObackground(getJsonField(
                                                                                            containerGetCTODefectResponse.jsonBody,
                                                                                            r'''$[0].status''',
                                                                                          ).toString()),
                                                                                          borderRadius: BorderRadius.circular(4),
                                                                                        ),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5),
                                                                                          child: Row(
                                                                                            mainAxisSize: MainAxisSize.max,
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            children: [
                                                                                              Align(
                                                                                                alignment: AlignmentDirectional(0, 0),
                                                                                                child: Padding(
                                                                                                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                                                                  child: Text(
                                                                                                    getJsonField(
                                                                                                      containerGetCTODefectResponse.jsonBody,
                                                                                                      r'''$[0].status''',
                                                                                                    ).toString(),
                                                                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                          fontFamily: 'SFProText',
                                                                                                          color: functions.colorCTOtext(getJsonField(
                                                                                                            containerGetCTODefectResponse.jsonBody,
                                                                                                            r'''$[0].status''',
                                                                                                          ).toString()),
                                                                                                          fontSize: 15,
                                                                                                          letterSpacing: 0.0,
                                                                                                        ),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ],
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
                                                                ],
                                                              ),
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
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/Icon-Toolbox.png',
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
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.7,
                                                                      decoration:
                                                                          BoxDecoration(),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Align(
                                                                            alignment:
                                                                                AlignmentDirectional(-1, -1),
                                                                            child:
                                                                                Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.7,
                                                                              decoration: BoxDecoration(),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 3),
                                                                                child: Text(
                                                                                  'Наряд',
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
                                                                          ),
                                                                          Builder(
                                                                            builder:
                                                                                (context) {
                                                                              if (functions
                                                                                      .jsonToList(getJsonField(
                                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                        r'''$.tickets''',
                                                                                      ))
                                                                                      .length ==
                                                                                  0) {
                                                                                return Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1, 0),
                                                                                      child: InkWell(
                                                                                        splashColor: Colors.transparent,
                                                                                        focusColor: Colors.transparent,
                                                                                        hoverColor: Colors.transparent,
                                                                                        highlightColor: Colors.transparent,
                                                                                        onTap: () async {
                                                                                          context.pushNamed(
                                                                                            CreateNaryadWidget.routeName,
                                                                                            queryParameters: {
                                                                                              'equipmentid': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.equipment.id''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'equipname': serializeParam(
                                                                                                '${getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.equipment.brand_id.name''',
                                                                                                ).toString()} ${getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.equipment.model_id.name''',
                                                                                                ).toString()} ${getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.equipment.license_plate_number''',
                                                                                                ).toString()}',
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'equipplatenumber': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.equipment.license_plate_number''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'spareparts': serializeParam(
                                                                                                (getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.spare_parts''',
                                                                                                  true,
                                                                                                )?.toList().map<SparePartsStruct?>(SparePartsStruct.maybeFromMap).toList() as Iterable<SparePartsStruct?>)
                                                                                                    .withoutNulls,
                                                                                                ParamType.DataStruct,
                                                                                                isList: true,
                                                                                              ),
                                                                                              'todo': serializeParam(
                                                                                                (getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.todo''',
                                                                                                  true,
                                                                                                )?.toList().map<TodoStruct?>(TodoStruct.maybeFromMap).toList() as Iterable<TodoStruct?>)
                                                                                                    .withoutNulls,
                                                                                                ParamType.DataStruct,
                                                                                                isList: true,
                                                                                              ),
                                                                                              'defectid': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.id''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'name': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.title''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'defectName': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.title''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'defectId': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.id''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'defectstatus': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.status''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                              'defectdate': serializeParam(
                                                                                                getJsonField(
                                                                                                  detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                                  r'''$.created_at''',
                                                                                                ).toString(),
                                                                                                ParamType.String,
                                                                                              ),
                                                                                            }.withoutNulls,
                                                                                          );
                                                                                        },
                                                                                        child: Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: FlutterFlowTheme.of(context).primary,
                                                                                            borderRadius: BorderRadius.circular(10),
                                                                                            shape: BoxShape.rectangle,
                                                                                          ),
                                                                                          child: Align(
                                                                                            alignment: AlignmentDirectional(0, 0),
                                                                                            child: Padding(
                                                                                              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
                                                                                              child: Text(
                                                                                                'Создать',
                                                                                                style: FlutterFlowTheme.of(context).bodyLarge.override(
                                                                                                      fontFamily: 'SFProText',
                                                                                                      color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                                      fontSize: 15,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                );
                                                                              } else {
                                                                                return // Generated code for this Container Widget...
Align(
  alignment: AlignmentDirectional(-1, 0),
  child: InkWell(
    splashColor: Colors.transparent,
    focusColor: Colors.transparent,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    onTap: () async {
      context.pushNamed(
        NaryadsOfflineWidget.routeName,
        queryParameters: {
          'json': serializeParam(
            <String, dynamic>{
              'id': functions
                  .jsonToList(getJsonField(
                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                        .jsonBody,
                    r'''$.tickets''',
                  ))
                  .lastOrNull,
            },
            ParamType.JSON,
          ),
        }.withoutNulls,
      );
    },
    child: Container(
      decoration: BoxDecoration(
        color: Color(0xFFADD8E6),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(15, 5, 15, 5),
          child: Text(
            'Перейти к наряду',
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'SFProText',
                  color: Color(0xFF066586),
                  fontSize: 15,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
          ),
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
                                                                    'assets/images/Icon-WarningDiamond.png',
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
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0,
                                                                              0,
                                                                              0,
                                                                              3),
                                                                          child:
                                                                              Text(
                                                                            'Категория дефекта',
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 14,
                                                                                  letterSpacing: 0.0,
                                                                                ),
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
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.category.title''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
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
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.mileage''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
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
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-Motohours.png',
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
                                                                          'Моточасы',
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
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.moto_hours''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
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
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/Icon-Buildings.png',
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
                                                                          'Колонна',
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
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.column.title''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
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
                                                                          'Датa и время создания дефекта',
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
                                                                              "EEEE, dd MMMM H:mm",
                                                                              functions.stringToDateTime(getJsonField(
                                                                                detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                                r'''$.date''',
                                                                              ).toString()),
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
                                                                      Align(
                                                                        alignment: AlignmentDirectional(
                                                                            -1,
                                                                            -1),
                                                                        child:
                                                                            Text(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
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
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5)),
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
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.05,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.35,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Text(
                                                                      'Список ТМЦ',
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
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if ((functions.getAclValue(FFAppState().result, '/api/v1/workspace/equipment/sectors').toString() == '2') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '3') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '6') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '7') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '10') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '11') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '14') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '15') ||
                                                                    (functions
                                                                            .getAclValue(FFAppState().result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '12'))
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
                                                                      FFAppState()
                                                                          .spareparts = (getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.spare_parts''',
                                                                        true,
                                                                      )!
                                                                              .toList()
                                                                              .map<SparePartsStruct?>(SparePartsStruct.maybeFromMap)
                                                                              .toList() as Iterable<SparePartsStruct?>)
                                                                          .withoutNulls
                                                                          .toList()
                                                                          .cast<SparePartsStruct>();
                                                                      FFAppState()
                                                                          .todo = (getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.todo''',
                                                                        true,
                                                                      )!
                                                                              .toList()
                                                                              .map<TodoStruct?>(TodoStruct.maybeFromMap)
                                                                              .toList() as Iterable<TodoStruct?>)
                                                                          .withoutNulls
                                                                          .toList()
                                                                          .cast<TodoStruct>();
                                                                      FFAppState()
                                                                          .photosedit = getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.media''',
                                                                        true,
                                                                      )!
                                                                          .toList()
                                                                          .cast<dynamic>();
                                                                      FFAppState()
                                                                              .defecttime =
                                                                          functions
                                                                              .stringToDateTime(getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.date''',
                                                                      ).toString());
                                                                      safeSetState(
                                                                          () {});

                                                                      context
                                                                          .pushNamed(
                                                                        EditDefectWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'spareparts':
                                                                              serializeParam(
                                                                            (getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.spare_parts''',
                                                                              true,
                                                                            )?.toList().map<SparePartsStruct?>(SparePartsStruct.maybeFromMap).toList() as Iterable<SparePartsStruct?>)
                                                                                .withoutNulls,
                                                                            ParamType.DataStruct,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'todo':
                                                                              serializeParam(
                                                                            (getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.todo''',
                                                                              true,
                                                                            )?.toList().map<TodoStruct?>(TodoStruct.maybeFromMap).toList() as Iterable<TodoStruct?>)
                                                                                .withoutNulls,
                                                                            ParamType.DataStruct,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'equipId':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'nazvanie':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.title''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'description':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.description''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'date':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.date''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'probeg':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.mileage''',
                                                                            ),
                                                                            ParamType.int,
                                                                          ),
                                                                          'motohours':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.moto_hours''',
                                                                            ),
                                                                            ParamType.int,
                                                                          ),
                                                                          'media':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.media''',
                                                                            ),
                                                                            ParamType.JSON,
                                                                          ),
                                                                          'categoryid':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.category.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'defectid':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'sparepart1':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.spare_parts''',
                                                                              true,
                                                                            ),
                                                                            ParamType.JSON,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'todo1':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.todo''',
                                                                              true,
                                                                            ),
                                                                            ParamType.JSON,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'brandname':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.brand_id.name''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'modelname':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.model_id.name''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'number':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.license_plate_number''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'page':
                                                                              serializeParam(
                                                                            1,
                                                                            ParamType.int,
                                                                          ),
                                                                          'users':
                                                                              serializeParam(
                                                                            (getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.assignees[:].id''',
                                                                              true,
                                                                            ) as List?)
                                                                                ?.map<String>((e) => e.toString())
                                                                                .toList()
                                                                                .cast<String>(),
                                                                            ParamType.String,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size: 24,
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
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final todo =
                                                              FFAppState()
                                                                  .spareparts
                                                                  .toList();

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
                                                                    width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.9,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              valueOrDefault<String>(
                                                                                todoItem.title,
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
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
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
                                                                                            todoItem.productArticle,
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
                                                                                          text: '·',
                                                                                          style: TextStyle(
                                                                                            color: Color(0xFF8291B0),
                                                                                          ),
                                                                                        ),
                                                                                        TextSpan(
                                                                                          text: valueOrDefault<String>(
                                                                                            todoItem.quantity.toString(),
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
                                                                                        )
                                                                                      ],
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'SFProText',
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
                                                                      ].divide(SizedBox(height: 3)).addToEnd(
                                                                              SizedBox(height: 2)),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.05,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.5,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Text(
                                                                      'Cписок работ',
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
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if ((functions.getAclValue(FFAppState().result, '/api/v1/workspace/equipment/sectors').toString() == '2') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '3') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '6') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '7') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '10') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '11') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '14') ||
                                                                    (functions
                                                                            .getAclValue(
                                                                                FFAppState()
                                                                                    .result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '15') ||
                                                                    (functions
                                                                            .getAclValue(FFAppState().result,
                                                                                '/api/v1/workspace/defects/{id}')
                                                                            .toString() ==
                                                                        '12'))
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
                                                                      FFAppState()
                                                                          .spareparts = (getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.spare_parts''',
                                                                        true,
                                                                      )!
                                                                              .toList()
                                                                              .map<SparePartsStruct?>(SparePartsStruct.maybeFromMap)
                                                                              .toList() as Iterable<SparePartsStruct?>)
                                                                          .withoutNulls
                                                                          .toList()
                                                                          .cast<SparePartsStruct>();
                                                                      FFAppState()
                                                                          .todo = (getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.todo''',
                                                                        true,
                                                                      )!
                                                                              .toList()
                                                                              .map<TodoStruct?>(TodoStruct.maybeFromMap)
                                                                              .toList() as Iterable<TodoStruct?>)
                                                                          .withoutNulls
                                                                          .toList()
                                                                          .cast<TodoStruct>();
                                                                      FFAppState()
                                                                          .photosedit = getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.media''',
                                                                        true,
                                                                      )!
                                                                          .toList()
                                                                          .cast<dynamic>();
                                                                      FFAppState()
                                                                              .defecttime =
                                                                          functions
                                                                              .stringToDateTime(getJsonField(
                                                                        detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                            .jsonBody,
                                                                        r'''$.date''',
                                                                      ).toString());
                                                                      safeSetState(
                                                                          () {});

                                                                      context
                                                                          .pushNamed(
                                                                        EditDefectWidget
                                                                            .routeName,
                                                                        queryParameters:
                                                                            {
                                                                          'spareparts':
                                                                              serializeParam(
                                                                            (getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.spare_parts''',
                                                                              true,
                                                                            )?.toList().map<SparePartsStruct?>(SparePartsStruct.maybeFromMap).toList() as Iterable<SparePartsStruct?>)
                                                                                .withoutNulls,
                                                                            ParamType.DataStruct,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'todo':
                                                                              serializeParam(
                                                                            (getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.todo''',
                                                                              true,
                                                                            )?.toList().map<TodoStruct?>(TodoStruct.maybeFromMap).toList() as Iterable<TodoStruct?>)
                                                                                .withoutNulls,
                                                                            ParamType.DataStruct,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'equipId':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'nazvanie':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.title''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'description':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.description''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'date':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.date''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'probeg':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.mileage''',
                                                                            ),
                                                                            ParamType.int,
                                                                          ),
                                                                          'motohours':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.moto_hours''',
                                                                            ),
                                                                            ParamType.int,
                                                                          ),
                                                                          'media':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.media''',
                                                                            ),
                                                                            ParamType.JSON,
                                                                          ),
                                                                          'categoryid':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.category.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'defectid':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.id''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'sparepart1':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.spare_parts''',
                                                                              true,
                                                                            ),
                                                                            ParamType.JSON,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'todo1':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.todo''',
                                                                              true,
                                                                            ),
                                                                            ParamType.JSON,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                          'brandname':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.brand_id.name''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'modelname':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.model_id.name''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'number':
                                                                              serializeParam(
                                                                            getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.equipment.license_plate_number''',
                                                                            ).toString(),
                                                                            ParamType.String,
                                                                          ),
                                                                          'page':
                                                                              serializeParam(
                                                                            2,
                                                                            ParamType.int,
                                                                          ),
                                                                          'users':
                                                                              serializeParam(
                                                                            (getJsonField(
                                                                              detailedDefectsOfflineCopyGetDetailedDefectsResponse.jsonBody,
                                                                              r'''$.assignees[:].id''',
                                                                              true,
                                                                            ) as List?)
                                                                                ?.map<String>((e) => e.toString())
                                                                                .toList()
                                                                                .cast<String>(),
                                                                            ParamType.String,
                                                                            isList:
                                                                                true,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    },
                                                                    child: Icon(
                                                                      Icons
                                                                          .edit,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                      size: 24,
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
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final todo =
                                                              FFAppState()
                                                                  .todo
                                                                  .toList();

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
                                                                    width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children:
                                                                          [
                                                                        Align(
                                                                          alignment: AlignmentDirectional(
                                                                              -1,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.9,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Text(
                                                                              todoItem.title,
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
                                                                          alignment: AlignmentDirectional(
                                                                              -1,
                                                                              0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.9,
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                                              child: Text(
                                                                                todoItem.quantity.toString(),
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
                                                                      ].divide(SizedBox(height: 3)).addToEnd(
                                                                              SizedBox(height: 2)),
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
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.05,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment:
                                                                  AlignmentDirectional(
                                                                      -1, 0),
                                                              child: Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.5,
                                                                decoration:
                                                                    BoxDecoration(),
                                                                child: Text(
                                                                  'Вложения',
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
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                ),
                                                              ),
                                                            ),
                                                            if ((functions.getAclValue(FFAppState().result, '/api/v1/workspace/equipment/sectors').toString() == '2') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '3') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '6') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '7') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '10') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '11') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '14') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState()
                                                                                .result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '15') ||
                                                                (functions
                                                                        .getAclValue(
                                                                            FFAppState().result,
                                                                            '/api/v1/workspace/defects/{id}')
                                                                        .toString() ==
                                                                    '12'))
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
                                                                onTap:
                                                                    () async {
                                                                  FFAppState()
                                                                      .spareparts = (getJsonField(
                                                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                        .jsonBody,
                                                                    r'''$.spare_parts''',
                                                                    true,
                                                                  )!
                                                                          .toList()
                                                                          .map<SparePartsStruct?>(SparePartsStruct.maybeFromMap)
                                                                          .toList() as Iterable<SparePartsStruct?>)
                                                                      .withoutNulls
                                                                      .toList()
                                                                      .cast<SparePartsStruct>();
                                                                  FFAppState()
                                                                      .todo = (getJsonField(
                                                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                        .jsonBody,
                                                                    r'''$.todo''',
                                                                    true,
                                                                  )!
                                                                          .toList()
                                                                          .map<TodoStruct?>(TodoStruct.maybeFromMap)
                                                                          .toList() as Iterable<TodoStruct?>)
                                                                      .withoutNulls
                                                                      .toList()
                                                                      .cast<TodoStruct>();
                                                                  FFAppState()
                                                                          .photosedit =
                                                                      getJsonField(
                                                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                        .jsonBody,
                                                                    r'''$.media''',
                                                                    true,
                                                                  )!
                                                                          .toList()
                                                                          .cast<
                                                                              dynamic>();
                                                                  FFAppState()
                                                                          .defecttime =
                                                                      functions
                                                                          .stringToDateTime(
                                                                              getJsonField(
                                                                    detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                        .jsonBody,
                                                                    r'''$.date''',
                                                                  ).toString());
                                                                  safeSetState(
                                                                      () {});

                                                                  context
                                                                      .pushNamed(
                                                                    EditDefectWidget
                                                                        .routeName,
                                                                    queryParameters:
                                                                        {
                                                                      'spareparts':
                                                                          serializeParam(
                                                                        (getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.spare_parts''',
                                                                          true,
                                                                        )?.toList().map<SparePartsStruct?>(SparePartsStruct.maybeFromMap).toList()
                                                                                as Iterable<SparePartsStruct?>)
                                                                            .withoutNulls,
                                                                        ParamType
                                                                            .DataStruct,
                                                                        isList:
                                                                            true,
                                                                      ),
                                                                      'todo':
                                                                          serializeParam(
                                                                        (getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.todo''',
                                                                          true,
                                                                        )?.toList().map<TodoStruct?>(TodoStruct.maybeFromMap).toList()
                                                                                as Iterable<TodoStruct?>)
                                                                            .withoutNulls,
                                                                        ParamType
                                                                            .DataStruct,
                                                                        isList:
                                                                            true,
                                                                      ),
                                                                      'equipId':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.equipment.id''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'nazvanie':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.title''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'description':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.description''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'date':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.date''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'probeg':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.mileage''',
                                                                        ),
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                      'motohours':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.moto_hours''',
                                                                        ),
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                      'media':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.media''',
                                                                        ),
                                                                        ParamType
                                                                            .JSON,
                                                                      ),
                                                                      'categoryid':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.category.id''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'defectid':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.id''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'sparepart1':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.spare_parts''',
                                                                          true,
                                                                        ),
                                                                        ParamType
                                                                            .JSON,
                                                                        isList:
                                                                            true,
                                                                      ),
                                                                      'todo1':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.todo''',
                                                                          true,
                                                                        ),
                                                                        ParamType
                                                                            .JSON,
                                                                        isList:
                                                                            true,
                                                                      ),
                                                                      'brandname':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.equipment.brand_id.name''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'modelname':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.equipment.model_id.name''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'number':
                                                                          serializeParam(
                                                                        getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.equipment.license_plate_number''',
                                                                        ).toString(),
                                                                        ParamType
                                                                            .String,
                                                                      ),
                                                                      'page':
                                                                          serializeParam(
                                                                        3,
                                                                        ParamType
                                                                            .int,
                                                                      ),
                                                                      'users':
                                                                          serializeParam(
                                                                        (getJsonField(
                                                                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                              .jsonBody,
                                                                          r'''$.assignees[:].id''',
                                                                          true,
                                                                        ) as List?)
                                                                            ?.map<String>((e) => e.toString())
                                                                            .toList()
                                                                            .cast<String>(),
                                                                        ParamType
                                                                            .String,
                                                                        isList:
                                                                            true,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                },
                                                                child: Icon(
                                                                  Icons.edit,
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  size: 24,
                                                                ),
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5,
                                                                  15, 11.5, 0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final todo =
                                                              getJsonField(
                                                            detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                                .jsonBody,
                                                            r'''$.media''',
                                                          ).toList();

                                                          return GridView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            gridDelegate:
                                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                              crossAxisCount: 2,
                                                              crossAxisSpacing:
                                                                  10,
                                                              mainAxisSpacing:
                                                                  10,
                                                              childAspectRatio:
                                                                  1,
                                                            ),
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                todo.length,
                                                            itemBuilder:
                                                                (context,
                                                                    todoIndex) {
                                                              final todoItem =
                                                                  todo[
                                                                      todoIndex];
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
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ].addToEnd(
                                                      SizedBox(height: 10)),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0, 8, 0, 8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.05,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      AlignmentDirectional(
                                                                          -1,
                                                                          0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.5,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Text(
                                                                      'История',
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
                                                                            fontWeight:
                                                                                FontWeight.bold,
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
                                                    FutureBuilder<
                                                        ApiCallResponse>(
                                                      future:
                                                          GetDefectsHistoryCall
                                                              .call(
                                                        access:
                                                            currentAuthenticationToken,
                                                        id: widget!.id,
                                                        work: FFAppState()
                                                            .workspace,
                                                      ),
                                                      builder:
                                                          (context, snapshot) {
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
                                                        final conditionalBuilderGetDefectsHistoryResponse =
                                                            snapshot.data!;

                                                        return Builder(
                                                          builder: (context) {
                                                            if (conditionalBuilderGetDefectsHistoryResponse
                                                                .succeeded) {
                                                              return Padding(
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
                                                                      conditionalBuilderGetDefectsHistoryResponse
                                                                          .jsonBody,
                                                                      r'''$''',
                                                                    ).toList();

                                                                    return Column(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: List.generate(
                                                                          todo.length,
                                                                          (todoIndex) {
                                                                        final todoItem =
                                                                            todo[todoIndex];
                                                                        return Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width,
                                                                              decoration: BoxDecoration(
                                                                                color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              ),
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                children: [
                                                                                  Container(
                                                                                    width: MediaQuery.sizeOf(context).width * 0.1,
                                                                                    height: MediaQuery.sizeOf(context).width * 0.1,
                                                                                    clipBehavior: Clip.antiAlias,
                                                                                    decoration: BoxDecoration(
                                                                                      shape: BoxShape.circle,
                                                                                    ),
                                                                                    child: Image.asset(
                                                                                      'assets/images/Icon-User.png',
                                                                                      fit: BoxFit.cover,
                                                                                    ),
                                                                                  ),
                                                                                  Column(
                                                                                    mainAxisSize: MainAxisSize.max,
                                                                                    children: [
                                                                                      Row(
                                                                                        mainAxisSize: MainAxisSize.max,
                                                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                        children: [
                                                                                          Align(
                                                                                            alignment: AlignmentDirectional(-1, 0),
                                                                                            child: Container(
                                                                                              width: MediaQuery.sizeOf(context).width * 0.5,
                                                                                              decoration: BoxDecoration(),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  getJsonField(
                                                                                                    todoItem,
                                                                                                    r'''$.user.title''',
                                                                                                  )?.toString(),
                                                                                                  '-',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'SFProText',
                                                                                                      fontSize: 15,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.w600,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.3,
                                                                                            decoration: BoxDecoration(
                                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                            ),
                                                                                            child: Align(
                                                                                              alignment: AlignmentDirectional(1, 0),
                                                                                              child: Text(
                                                                                                valueOrDefault<String>(
                                                                                                  dateTimeFormat(
                                                                                                    "dd.MM.y H:mm",
                                                                                                    functions.stringToDate(getJsonField(
                                                                                                      todoItem,
                                                                                                      r'''$.created_at''',
                                                                                                    ).toString()),
                                                                                                    locale: FFLocalizations.of(context).languageCode,
                                                                                                  ),
                                                                                                  '-',
                                                                                                ),
                                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                      fontFamily: 'SFProText',
                                                                                                      color: Color(0xFF8291B0),
                                                                                                      fontSize: 13,
                                                                                                      letterSpacing: 0.0,
                                                                                                      fontWeight: FontWeight.normal,
                                                                                                    ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                      Align(
                                                                                        alignment: AlignmentDirectional(-1, 0),
                                                                                        child: Container(
                                                                                          width: MediaQuery.sizeOf(context).width * 0.8,
                                                                                          decoration: BoxDecoration(),
                                                                                          child: Padding(
                                                                                            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                getJsonField(
                                                                                                  todoItem,
                                                                                                  r'''$.operation''',
                                                                                                )?.toString(),
                                                                                                '-',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    color: Color(0xFF8291B0),
                                                                                                    fontSize: 13,
                                                                                                    letterSpacing: 0.0,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ].divide(SizedBox(height: 3)).addToEnd(SizedBox(height: 2)),
                                                                                  ),
                                                                                ].divide(SizedBox(width: 5)),
                                                                              ),
                                                                            ),
                                                                            Divider(
                                                                              thickness: 1,
                                                                              color: Color(0xFFE9ECEF),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      }).addToStart(SizedBox(
                                                                          height:
                                                                              10)),
                                                                    );
                                                                  },
                                                                ),
                                                              );
                                                            } else {
                                                              return Container(
                                                                decoration:
                                                                    BoxDecoration(
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
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (valueOrDefault<String>(
                        functions.statusToRus(getJsonField(
                          detailedDefectsOfflineCopyGetDetailedDefectsResponse
                              .jsonBody,
                          r'''$.status''',
                        ).toString()),
                        '-',
                      ) ==
                      'Неисправен')
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Container(
                        decoration: BoxDecoration(),
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      11.5, 0, 11.5, 0),
                                  child: FFButtonWidget(
                                    onPressed: () async {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: Text(
                                                        'Хотите исправить дефект?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                false),
                                                        child: Text('Отмена'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                alertDialogContext,
                                                                true),
                                                        child:
                                                            Text('Исправить'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ) ??
                                              false;
                                      if (confirmDialogResponse) {
                                        await StatusfixedCall.call(
                                          access: currentAuthenticationToken,
                                          id: getJsonField(
                                            detailedDefectsOfflineCopyGetDetailedDefectsResponse
                                                .jsonBody,
                                            r'''$.id''',
                                          ).toString(),
                                          work: FFAppState().workspace,
                                        );

                                        FFAppState().alldefects = null;
                                        safeSetState(() {});

                                        context
                                            .pushNamed(DefectsWidget.routeName);
                                      } else {
                                        Navigator.pop(context);
                                      }
                                    },
                                    text: 'Исправить',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width,
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 0, 24, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                          ),
                                      elevation: 3,
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                        width: 1,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            ].divide(SizedBox(height: 5)),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
