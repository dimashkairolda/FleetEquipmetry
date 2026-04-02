import '/components/radio_defect_widget.dart';
import '/components/zamery_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'detailed_inspections_model.dart';
export 'detailed_inspections_model.dart';

class DetailedInspectionsWidget extends StatefulWidget {
  const DetailedInspectionsWidget({
    super.key,
    required this.name,
    required this.index,
  });

  final dynamic name;
  final int? index;

  static String routeName = 'detailedInspections';
  static String routePath = '/detailedInspections';

  @override
  State<DetailedInspectionsWidget> createState() =>
      _DetailedInspectionsWidgetState();
}

class _DetailedInspectionsWidgetState extends State<DetailedInspectionsWidget> {
  late DetailedInspectionsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DetailedInspectionsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().inspectionsTemp = 0;
      FFAppState().loopFormResult = 0;
      safeSetState(() {});
      await actions.updateStartedOn(
        FFAppState().checkCache,
        getJsonField(
          widget.name,
          r'''$.id''',
        ),
      );
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
              color: Color(0xFF2A61ED),
              size: 30.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            '${dateTimeFormat(
              "Hm",
              functions.stringToDateTime(getJsonField(
                widget.name,
                r'''$.available_from''',
              ).toString()),
              locale: FFLocalizations.of(context).languageCode,
            )}-${dateTimeFormat(
              "Hm",
              functions.stringToDateTime(getJsonField(
                widget.name,
                r'''$.available_to''',
              ).toString()),
              locale: FFLocalizations.of(context).languageCode,
            )}',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'SFProText',
                  color: Color(0xFF2A61ED),
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 2.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 18.0, 0.0, 18.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.13,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 0.0, 10.0),
                            child: Text(
                              getJsonField(
                                widget.name,
                                r'''$.regulation_info.title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),
                        Divider(
                          thickness: 1.0,
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                        Align(
                          alignment: AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 0.0, 10.0),
                            child: Text(
                              getJsonField(
                                widget.name,
                                r'''$.regulation_info.equipment_info.title''',
                              ).toString(),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    fontSize: 13.0,
                                    letterSpacing: 0.0,
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
                    Builder(
                      builder: (context) {
                        final responses = getJsonField(
                          functions.findJsonElementByID(
                              FFAppState().checkCache,
                              getJsonField(
                                widget.name,
                                r'''$.id''',
                              )),
                          r'''$.responses''',
                        ).toList();

                        return Column(
                          mainAxisSize: MainAxisSize.max,
                          children:
                              List.generate(responses.length, (responsesIndex) {
                            final responsesItem = responses[responsesIndex];
                            return Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Text(
                                        getJsonField(
                                          responsesItem,
                                          r'''$.regulation_work_info.equipment_info.title''',
                                        ).toString(),
                                        textAlign: TextAlign.start,
                                        style: FlutterFlowTheme.of(context)
                                            .bodyLarge
                                            .override(
                                              fontFamily: 'SFProText',
                                              fontSize: 14.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1.0,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                    Builder(
                                      builder: (context) {
                                        final formresult = getJsonField(
                                          responsesItem,
                                          r'''$.form_result''',
                                        ).toList();

                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children:
                                              List.generate(formresult.length,
                                                  (formresultIndex) {
                                            final formresultItem =
                                                formresult[formresultIndex];
                                            return Builder(
                                              builder: (context) {
                                                if (getJsonField(
                                                      formresultItem,
                                                      r'''$.type''',
                                                    ) ==
                                                    'radio_defect') {
                                                  return wrapWithModel(
                                                    model: _model
                                                        .radioDefectModels
                                                        .getModel(
                                                      '',
                                                      formresultIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: RadioDefectWidget(
                                                      key: Key(
                                                        'Key75l_${''}',
                                                      ),
                                                      data: formresultItem,
                                                      searchID: getJsonField(
                                                        widget.name,
                                                        r'''$.id''',
                                                      ),
                                                      equipmentId: getJsonField(
                                                        responsesItem,
                                                        r'''$.regulation_work_info.equipment''',
                                                      ),
                                                      index: widget.index!,
                                                      name: widget.name!,
                                                    ),
                                                  );
                                                } else {
                                                  return wrapWithModel(
                                                    model: _model.zameryModels
                                                        .getModel(
                                                      '',
                                                      formresultIndex,
                                                    ),
                                                    updateCallback: () =>
                                                        safeSetState(() {}),
                                                    child: ZameryWidget(
                                                      key: Key(
                                                        'Keyl3w_${''}',
                                                      ),
                                                      searchID: getJsonField(
                                                        widget.name,
                                                        r'''$.id''',
                                                      ),
                                                      equipmentId: getJsonField(
                                                        responsesItem,
                                                        r'''$.regulation_work_info.equipment''',
                                                      ),
                                                      data: formresultItem,
                                                      index: widget.index!,
                                                      name: widget.name!,
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          }).divide(SizedBox(height: 5.0)),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).divide(SizedBox(height: 5.0)),
                        );
                      },
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        decoration: BoxDecoration(),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              21.0, 0.0, 21.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              FFAppState()
                                  .addToEndedInspections(functions.findJsonByID(
                                      getJsonField(
                                        widget.name,
                                        r'''$.id''',
                                      ),
                                      FFAppState().checkCache));
                              safeSetState(() {});
                              await actions.updateFinishedOn(
                                FFAppState().checkCache,
                                getJsonField(
                                  widget.name,
                                  r'''$.id''',
                                ),
                              );
                              await actions.updateStartedOn(
                                FFAppState().checkCache,
                                getJsonField(
                                  widget.name,
                                  r'''$.id''',
                                ),
                              );
                              context.safePop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Осмотр успешно пройден!',
                                    style: TextStyle(
                                      fontFamily: 'SFProText',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 2000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                              );
                            },
                            text: 'Завершить',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: 40.0,
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: Color(0xFF2A61ED),
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
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .fontStyle,
                                  ),
                              elevation: 3.0,
                              borderSide: BorderSide(
                                color: Colors.transparent,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
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
