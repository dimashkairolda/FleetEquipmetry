import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'zamery_model.dart';
export 'zamery_model.dart';

class ZameryWidget extends StatefulWidget {
  const ZameryWidget({
    super.key,
    required this.data,
    required this.searchID,
    required this.equipmentId,
    required this.name,
    required this.index,
  });

  final dynamic data;
  final int? searchID;
  final int? equipmentId;
  final dynamic name;
  final int? index;

  @override
  State<ZameryWidget> createState() => _ZameryWidgetState();
}

class _ZameryWidgetState extends State<ZameryWidget> {
  late ZameryModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ZameryModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (getJsonField(
            widget.data,
            r'''$.result.response''',
          ) ==
          null) {
        _model.isTrue = 0;
        safeSetState(() {});
      } else {
        if (getJsonField(
              widget.data,
              r'''$.result.response''',
            ) ==
            functions.stringToJson('\"normal\"')) {
          _model.isTrue = 1;
          safeSetState(() {});
        } else {
          _model.isTrue = 2;
          safeSetState(() {});
        }
      }
    });

    _model.textController ??= TextEditingController(
        text: getJsonField(
                  widget.data,
                  r'''$.result.response''',
                ) ==
                null
            ? ' '
            : getJsonField(
                widget.data,
                r'''$.result.response''',
              ).toString());
    _model.textFieldFocusNode ??= FocusNode();
    _model.textFieldFocusNode!.addListener(
      () async {
        await actions.updateResponseByIdZamery(
          FFAppState().checkCache,
          widget.searchID!,
          widget.equipmentId!,
          getJsonField(
            widget.data,
            r'''$.data.title''',
          ).toString(),
          _model.textController.text,
        );
      },
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Align(
      alignment: AlignmentDirectional(0.0, 0.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.99,
        height: valueOrDefault<double>(
          getJsonField(
                    widget.data,
                    r'''$.result.defect''',
                  ) ==
                  null
              ? 180.0
              : 240.0,
          180.0,
        ),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(11.0, 11.0, 10.0, 0.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                getJsonField(
                  widget.data,
                  r'''$.data.title''',
                ).toString(),
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 14.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _model.textController,
                      focusNode: _model.textFieldFocusNode,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: valueOrDefault<String>(
                          getJsonField(
                            widget.data,
                            r'''$.data.unit''',
                          )?.toString(),
                          'Введите',
                        ),
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'SFProText',
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  font: GoogleFonts.readexPro(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .fontStyle,
                                  ),
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .fontStyle,
                                ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFD6D6D6),
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).primary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: FlutterFlowTheme.of(context).error,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                          ),
                      keyboardType: TextInputType.multiline,
                      validator:
                          _model.textControllerValidator.asValidator(context),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    context.pushNamed(
                      CreateDefectFromInspectionWidget.routeName,
                      queryParameters: {
                        'searchid': serializeParam(
                          widget.searchID,
                          ParamType.int,
                        ),
                        'equipid': serializeParam(
                          widget.equipmentId,
                          ParamType.int,
                        ),
                        'formTitle': serializeParam(
                          getJsonField(
                            widget.data,
                            r'''$.data.title''',
                          ).toString(),
                          ParamType.String,
                        ),
                        'text': serializeParam(
                          getJsonField(
                            widget.data,
                            r'''$.data.title''',
                          ).toString(),
                          ParamType.String,
                        ),
                        'title': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'reason': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'event': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'type': serializeParam(
                          '',
                          ParamType.String,
                        ),
                        'isfixedonplace': serializeParam(
                          0,
                          ParamType.int,
                        ),
                        'isemergencysituation': serializeParam(
                          0,
                          ParamType.int,
                        ),
                        'name': serializeParam(
                          widget.name,
                          ParamType.JSON,
                        ),
                        'index': serializeParam(
                          widget.index,
                          ParamType.int,
                        ),
                      }.withoutNulls,
                    );
                  },
                  text: '+ Добавить дефект',
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 40.0,
                    padding:
                        EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: Color(0xFF2A61ED),
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'SFProText',
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          fontSize: 12.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
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
              Builder(
                builder: (context) {
                  if (getJsonField(
                        widget.data,
                        r'''$.result.defect''',
                      ) ==
                      null) {
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: 0.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                    );
                  } else {
                    return InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.pushNamed(
                          CreateDefectFromInspectionWidget.routeName,
                          queryParameters: {
                            'searchid': serializeParam(
                              widget.searchID,
                              ParamType.int,
                            ),
                            'equipid': serializeParam(
                              widget.equipmentId,
                              ParamType.int,
                            ),
                            'formTitle': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.data.title''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'text': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.data.title''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'title': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.result.defect.title''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'reason': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.result.defect.reason''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'event': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.result.defect.event''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'type': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.result.defect.type''',
                              ).toString(),
                              ParamType.String,
                            ),
                            'isfixedonplace': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.result.defect.isFixedOnPlace''',
                              ),
                              ParamType.int,
                            ),
                            'isemergencysituation': serializeParam(
                              getJsonField(
                                widget.data,
                                r'''$.result.defect.isEmergencySituation''',
                              ),
                              ParamType.int,
                            ),
                            'name': serializeParam(
                              widget.name,
                              ParamType.JSON,
                            ),
                            'index': serializeParam(
                              widget.index,
                              ParamType.int,
                            ),
                          }.withoutNulls,
                        );
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: 40.0,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: FlutterFlowTheme.of(context).error,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              15.0, 0.0, 15.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                getJsonField(
                                  widget.data,
                                  r'''$.result.defect.title''',
                                ).toString(),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.readexPro(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                              Icon(
                                Icons.remove_red_eye,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
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
        ),
      ),
    );
  }
}
