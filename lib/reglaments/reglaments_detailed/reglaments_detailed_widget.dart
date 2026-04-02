import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/components/date_reglament_widget.dart';
import '/components/media_reglament_widget.dart';
import '/components/motohours_reglament_widget.dart';
import '/components/multiple_from_list_reglament_widget.dart';
import '/components/multiple_widget.dart';
import '/components/number_reglament_widget.dart';
import '/components/odometer_reglament_widget.dart';
import '/components/one_from_list_reglament_widget.dart';
import '/components/scale_reglament_widget.dart';
import '/components/short_text_reglament_widget.dart';
import '/components/sign_reglament_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'reglaments_detailed_model.dart';
export 'reglaments_detailed_model.dart';

class ReglamentsDetailedWidget extends StatefulWidget {
  const ReglamentsDetailedWidget({
    super.key,
    required this.id,
  });

  final String? id;

  static String routeName = 'ReglamentsDetailed';
  static String routePath = '/reglamentsDetailed';

  @override
  State<ReglamentsDetailedWidget> createState() =>
      _ReglamentsDetailedWidgetState();
}

class _ReglamentsDetailedWidgetState extends State<ReglamentsDetailedWidget> {
  late ReglamentsDetailedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ReglamentsDetailedModel());

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
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(GetDetailedReglamentCall.call(
              access: currentAuthenticationToken,
              id: widget.id,
              work: FFAppState().workspace,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ),
          );
        }
        final reglamentsDetailedGetDetailedReglamentResponse = snapshot.data!;

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
                  Icons.chevron_left,
                  color: Color(0xFF3466E7),
                  size: 30.0,
                ),
                onPressed: () async {
                  context.safePop();
                  FFAppState().ReglamentDetailed = [];
                  safeSetState(() {});
                },
              ),
              title: Text(
                'Регламентные работы',
                style: FlutterFlowTheme.of(context).titleLarge.override(
                      fontFamily: 'SFProText',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: [
                Visibility(
                  visible: valueOrDefault<String>(
                        functions.statusReglament(getJsonField(
                          reglamentsDetailedGetDetailedReglamentResponse
                              .jsonBody,
                          r'''$.status''',
                        ).toString()),
                        '-',
                      ) ==
                      'В процессе',
                  child: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.15,
                      height: 100.0,
                      decoration: BoxDecoration(),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
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
                                      title: Text('Внимание'),
                                      content: Text(
                                          'Вы точно хотите завершить регламент?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, false),
                                          child: Text('Отмена'),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.pop(
                                              alertDialogContext, true),
                                          child: Text('Завершить'),
                                        ),
                                      ],
                                    );
                                  },
                                ) ??
                                false;
                            if (confirmDialogResponse) {
                              _model.apiResultph6Copy3 =
                                  await PutDetailedReglamentPassedCall.call(
                                access: currentAuthenticationToken,
                                id: widget.id,
                                work: FFAppState().workspace,
                                jsonJson: FFAppState()
                                    .ReglamentDetailed
                                    .map((e) => e.toMap())
                                    .toList(),
                              );

                              safeSetState(
                                  () => _model.apiRequestCompleter = null);
                              await _model.waitForApiRequestCompleted();
                            } else {
                              Navigator.pop(context);
                            }

                            safeSetState(() {});
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(0.0, 0.0),
                                child: Icon(
                                  Icons.check,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 25.0,
                                ),
                              ),
                            ],
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
              child: FutureBuilder<ApiCallResponse>(
                future: GetEngineAndOdometerCall.call(
                  access: currentAuthenticationToken,
                  equipid: getJsonField(
                    reglamentsDetailedGetDetailedReglamentResponse.jsonBody,
                    r'''$.schedule.equipment.id''',
                  ).toString(),
                  work: FFAppState().workspace,
                ),
                builder: (context, snapshot) {
                  // Customize what your widget looks like when it's loading.
                  if (!snapshot.hasData) {
                    return Center(
                      child: SizedBox(
                        width: 50.0,
                        height: 50.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            FlutterFlowTheme.of(context).primaryText,
                          ),
                        ),
                      ),
                    );
                  }
                  final columnGetEngineAndOdometerResponse = snapshot.data!;

                  return RefreshIndicator(
                    onRefresh: () async {
                      safeSetState(() => _model.apiRequestCompleter = null);
                      await _model.waitForApiRequestCompleted();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12.0),
                                        bottomRight: Radius.circular(12.0),
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(0.0),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    -1.0, 0.0),
                                                child: Text(
                                                  getJsonField(
                                                    reglamentsDetailedGetDetailedReglamentResponse
                                                        .jsonBody,
                                                    r'''$.schedule.form.title''',
                                                  ).toString(),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyLarge
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        fontSize: 17.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                decoration: BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.08,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.08,
                                                            clipBehavior:
                                                                Clip.antiAlias,
                                                            decoration:
                                                                BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.schedule.equipment.avatar''',
                                                              ).toString(),
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context,
                                                                      error,
                                                                      stackTrace) =>
                                                                  Image.asset(
                                                                'assets/images/error_image.png',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.75,
                                                          decoration:
                                                              BoxDecoration(),
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
                                                              context.pushNamed(
                                                                EquipmentsDetailedCopyWidget
                                                                    .routeName,
                                                                queryParameters:
                                                                    {
                                                                  'tab':
                                                                      serializeParam(
                                                                    0,
                                                                    ParamType
                                                                        .int,
                                                                  ),
                                                                  'json':
                                                                      serializeParam(
                                                                    getJsonField(
                                                                      reglamentsDetailedGetDetailedReglamentResponse
                                                                          .jsonBody,
                                                                      r'''$.schedule.equipment.id''',
                                                                    ),
                                                                    ParamType
                                                                        .JSON,
                                                                  ),
                                                                }.withoutNulls,
                                                              );
                                                            },
                                                            child: RichText(
                                                              textScaler:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                              text: TextSpan(
                                                                children: [
                                                                  TextSpan(
                                                                    text: valueOrDefault<
                                                                        String>(
                                                                      getJsonField(
                                                                        reglamentsDetailedGetDetailedReglamentResponse
                                                                            .jsonBody,
                                                                        r'''$.schedule.equipment.title''',
                                                                      )?.toString(),
                                                                      '-',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          fontSize:
                                                                              15.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  )
                                                                ],
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      fontSize:
                                                                          15.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
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
                                            ],
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            decoration: BoxDecoration(
                                              color: functions
                                                  .statusReglamentBGColor(
                                                      getJsonField(
                                                reglamentsDetailedGetDetailedReglamentResponse
                                                    .jsonBody,
                                                r'''$.status''',
                                              ).toString()),
                                              borderRadius:
                                                  BorderRadius.circular(4.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.25,
                                                    decoration: BoxDecoration(),
                                                    child: Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, 0.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    5.0,
                                                                    0.0,
                                                                    5.0,
                                                                    0.0),
                                                        child: Text(
                                                          valueOrDefault<
                                                              String>(
                                                            functions
                                                                .statusReglament(
                                                                    getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.status''',
                                                            ).toString()),
                                                            '-',
                                                          ),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: functions
                                                                    .statusReglamentTextColor(
                                                                        getJsonField(
                                                                  reglamentsDetailedGetDetailedReglamentResponse
                                                                      .jsonBody,
                                                                  r'''$.status''',
                                                                ).toString()),
                                                                fontSize: 12.0,
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
                                        ]
                                            .divide(SizedBox(height: 8.0))
                                            .addToEnd(SizedBox(height: 8.0)),
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
                            child: Builder(
                              builder: (context) {
                                final structure = FFAppState()
                                    .ReglamentDetailed
                                    .map((e) => e)
                                    .toList();

                                return Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(structure.length,
                                      (structureIndex) {
                                    final structureItem =
                                        structure[structureIndex];
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  11.5, 8.0, 11.5, 0.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                1.0,
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Text(
                                                'Раздел ${functions.addOne(structureIndex)} из ${functions.jsonToList(getJsonField(
                                                      reglamentsDetailedGetDetailedReglamentResponse
                                                          .jsonBody,
                                                      r'''$.structure''',
                                                    )).length.toString()}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) {
                                            final questions = structureItem
                                                .questions
                                                .toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  questions.length,
                                                  (questionsIndex) {
                                                final questionsItem =
                                                    questions[questionsIndex];
                                                return Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          11.5, 8.0, 11.5, 0.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.0),
                                                    ),
                                                    child: Builder(
                                                      builder: (context) {
                                                        if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"multiple\"') {
                                                          return MultipleWidget(
                                                            key: Key(
                                                                'Keyxze_${questionsIndex}_of_${questions.length}'),
                                                            json: questionsItem
                                                                .toMap(),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"multiple_from_list\"') {
                                                          return MultipleFromListReglamentWidget(
                                                            key: Key(
                                                                'Keyllu_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"one_from_list\"') {
                                                          return OneFromListReglamentWidget(
                                                            key: Key(
                                                                'Keyh7x_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.achedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.achedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"odometer\"') {
                                                          return OdometerReglamentWidget(
                                                            key: Key(
                                                                'Keyzfy_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"engine_hours\"') {
                                                          return MotohoursReglamentWidget(
                                                            key: Key(
                                                                'Keytr7_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"number\"') {
                                                          return NumberReglamentWidget(
                                                            key: Key(
                                                                'Keyc6e_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"sign\"') {
                                                          return SignReglamentWidget(
                                                            key: Key(
                                                                'Key0k7_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"short_text\"') {
                                                          return ShortTextReglamentWidget(
                                                            key: Key(
                                                                'Keytkn_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"media\"') {
                                                          return MediaReglamentWidget(
                                                            key: Key(
                                                                'Keyro4_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"scale\"') {
                                                          return ScaleReglamentWidget(
                                                            key: Key(
                                                                'Key1bo_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odomoter''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else if (functions
                                                                .jsonToString(
                                                                    getJsonField(
                                                              questionsItem
                                                                  .toMap(),
                                                              r'''$.type''',
                                                            )) ==
                                                            '\"date_time\"') {
                                                          return DateReglamentWidget(
                                                            key: Key(
                                                                'Key1yh_${questionsIndex}_of_${questions.length}'),
                                                            indexStructure:
                                                                structureIndex,
                                                            indexQuestions:
                                                                questionsIndex,
                                                            reglamentid:
                                                                widget.id!,
                                                            probeg:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.odometer''',
                                                            ),
                                                            motohours:
                                                                getJsonField(
                                                              columnGetEngineAndOdometerResponse
                                                                  .jsonBody,
                                                              r'''$.engine_hours''',
                                                            ),
                                                            equipid:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.id''',
                                                            ).toString(),
                                                            equipmentname:
                                                                getJsonField(
                                                              reglamentsDetailedGetDetailedReglamentResponse
                                                                  .jsonBody,
                                                              r'''$.schedule.equipment.title''',
                                                            ).toString(),
                                                            json: questionsItem
                                                                .toMap(),
                                                            status:
                                                                valueOrDefault<
                                                                    String>(
                                                              functions
                                                                  .statusReglament(
                                                                      getJsonField(
                                                                reglamentsDetailedGetDetailedReglamentResponse
                                                                    .jsonBody,
                                                                r'''$.status''',
                                                              ).toString()),
                                                              '-',
                                                            ),
                                                          );
                                                        } else {
                                                          return Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.657,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              'Ошибка! Пожалуйста обратитесь к администратору!',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
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
                                                            ),
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
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
