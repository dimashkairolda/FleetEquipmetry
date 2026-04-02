import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/reglaments/adds/adds_widget.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'multiple_model.dart';
export 'multiple_model.dart';

class MultipleWidget extends StatefulWidget {
  const MultipleWidget({
    super.key,
    required this.json,
    required this.indexStructure,
    required this.indexQuestions,
    required this.reglamentid,
    this.probeg,
    this.motohours,
    required this.equipid,
    required this.equipmentname,
    required this.status,
  });

  final dynamic json;
  final int? indexStructure;
  final int? indexQuestions;
  final String? reglamentid;
  final int? probeg;
  final int? motohours;
  final String? equipid;
  final String? equipmentname;
  final String? status;

  @override
  State<MultipleWidget> createState() => _MultipleWidgetState();
}

class _MultipleWidgetState extends State<MultipleWidget> {
  late MultipleModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MultipleModel());

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

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      getJsonField(
                        widget.json,
                        r'''$.title''',
                      ).toString(),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (getJsonField(
                      widget.json,
                      r'''$.is_required''',
                    ))
                      Text(
                        ' *',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SFProText',
                              color: FlutterFlowTheme.of(context).error,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                  ],
                ),
                Builder(
                  builder: (context) {
                    final options = getJsonField(
                      widget.json,
                      r'''$.options''',
                    ).toList();

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(options.length, (optionsIndex) {
                        final optionsItem = options[optionsIndex];
                        return Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          decoration: BoxDecoration(),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (widget.status != 'Пройден') {
                                _model.apiResultph6Copy3 =
                                    await PutDetailedReglamentCall.call(
                                  access: currentAuthenticationToken,
                                  id: widget.reglamentid,
                                  work: FFAppState().workspace,
                                  jsonJson: functions.updateAtIndex(
                                      FFAppState()
                                          .ReglamentDetailed
                                          .map((e) => e.toMap())
                                          .toList(),
                                      widget.indexStructure!,
                                      widget.indexQuestions!,
                                      getJsonField(
                                        optionsItem,
                                        r'''$.title''',
                                      ).toString(),
                                      'answers'),
                                );

                                FFAppState().ReglamentDetailed = functions
                                    .updateAtIndex(
                                        FFAppState()
                                            .ReglamentDetailed
                                            .map((e) => e.toMap())
                                            .toList(),
                                        widget.indexStructure!,
                                        widget.indexQuestions!,
                                        getJsonField(
                                          optionsItem,
                                          r'''$.title''',
                                        ).toString(),
                                        'answers')
                                    .map((e) => StructureStruct.maybeFromMap(
                                            getJsonField(
                                          e,
                                          r'''$''',
                                        )))
                                    .withoutNulls
                                    .toList()
                                    .cast<StructureStruct>();
                                FFAppState().update(() {});
                              }

                              safeSetState(() {});
                            },
                            text: getJsonField(
                              optionsItem,
                              r'''$.title''',
                            ).toString(),
                            options: FFButtonOptions(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  24.0, 0.0, 24.0, 0.0),
                              iconPadding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: getJsonField(
                                        widget.json,
                                        r'''$.answers[0]''',
                                      ) ==
                                      getJsonField(
                                        optionsItem,
                                        r'''$.title''',
                                      )
                                  ? functions.brightenColor(
                                      functions.hexToColor(getJsonField(
                                      optionsItem,
                                      r'''$.color''',
                                    ).toString()))
                                  : FlutterFlowTheme.of(context).secondary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: getJsonField(
                                              widget.json,
                                              r'''$.answers[0]''',
                                            ) ==
                                            getJsonField(
                                              optionsItem,
                                              r'''$.title''',
                                            )
                                        ? functions.hexToColor(getJsonField(
                                            optionsItem,
                                            r'''$.color''',
                                          ).toString())
                                        : FlutterFlowTheme.of(context).primary,
                                    fontSize: 14.0,
                                    letterSpacing: 0.0,
                                  ),
                              borderSide: BorderSide(
                                color: getJsonField(
                                          widget.json,
                                          r'''$.answers[0]''',
                                        ) ==
                                        getJsonField(
                                          optionsItem,
                                          r'''$.title''',
                                        )
                                    ? functions.hexToColor(getJsonField(
                                        optionsItem,
                                        r'''$.color''',
                                      ).toString())
                                    : FlutterFlowTheme.of(context).primary,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        );
                      }).divide(SizedBox(height: 5.0)),
                    );
                  },
                ),
                if (functions
                        .jsonToList(getJsonField(
                          widget.json,
                          r'''$.comments''',
                        ))
                        .length !=
                    0)
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Text(
                            'Заметки',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final comments = getJsonField(
                              widget.json,
                              r'''$.comments''',
                            ).toList();

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(comments.length,
                                  (commentsIndex) {
                                final commentsItem = comments[commentsIndex];
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.8,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        commentsItem.toString(),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SFProText',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    if (widget.status != 'Пройден')
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.apiResultph6 =
                                              await PutDetailedReglamentCall
                                                  .call(
                                            access: currentAuthenticationToken,
                                            id: widget.reglamentid,
                                            work: FFAppState().workspace,
                                            jsonJson: functions.removeAtIndex(
                                                FFAppState()
                                                    .ReglamentDetailed
                                                    .map((e) => e.toMap())
                                                    .toList(),
                                                widget.indexStructure!,
                                                widget.indexQuestions!,
                                                commentsIndex,
                                                'comments'),
                                          );

                                          FFAppState().ReglamentDetailed =
                                              functions
                                                  .removeAtIndex(
                                                      FFAppState()
                                                          .ReglamentDetailed
                                                          .map((e) => e.toMap())
                                                          .toList(),
                                                      widget.indexStructure!,
                                                      widget.indexQuestions!,
                                                      commentsIndex,
                                                      'comments')
                                                  .map((e) => StructureStruct
                                                      .maybeFromMap(e))
                                                  .withoutNulls
                                                  .toList()
                                                  .cast<StructureStruct>();
                                          FFAppState().update(() {});

                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          size: 24.0,
                                        ),
                                      ),
                                  ],
                                );
                              }).divide(SizedBox(height: 5.0)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (functions
                        .jsonToList(getJsonField(
                          widget.json,
                          r'''$.defects''',
                        ))
                        .length !=
                    0)
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Text(
                            'Дефекты',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final comments = getJsonField(
                              widget.json,
                              r'''$.defects''',
                            ).toList();

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(comments.length,
                                  (commentsIndex) {
                                final commentsItem = comments[commentsIndex];
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.5,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        valueOrDefault<String>(
                                          getJsonField(
                                            commentsItem,
                                            r'''$.title''',
                                          )?.toString(),
                                          '-',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SFProText',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: functions
                                            .colorDefectCopy(getJsonField(
                                          commentsItem,
                                          r'''$.status''',
                                        ).toString()),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.25,
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      functions.statusToRus(
                                                          getJsonField(
                                                        commentsItem,
                                                        r'''$.status''',
                                                      ).toString()),
                                                      '-',
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: functions
                                                              .colorDefectCopyCopy(
                                                                  getJsonField(
                                                            commentsItem,
                                                            r'''$.status''',
                                                          ).toString()),
                                                          fontSize: 12.0,
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
                                    if (widget.status != 'Пройден')
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.apiResultph6Copy =
                                              await PutDetailedReglamentCall
                                                  .call(
                                            access: currentAuthenticationToken,
                                            id: widget.reglamentid,
                                            work: FFAppState().workspace,
                                            jsonJson: functions.removeAtIndex(
                                                FFAppState()
                                                    .ReglamentDetailed
                                                    .map((e) => e.toMap())
                                                    .toList(),
                                                widget.indexStructure!,
                                                widget.indexQuestions!,
                                                commentsIndex,
                                                'defects'),
                                          );

                                          FFAppState().ReglamentDetailed =
                                              functions
                                                  .removeAtIndex(
                                                      FFAppState()
                                                          .ReglamentDetailed
                                                          .map((e) => e.toMap())
                                                          .toList(),
                                                      widget.indexStructure!,
                                                      widget.indexQuestions!,
                                                      commentsIndex,
                                                      'defects')
                                                  .map((e) => StructureStruct
                                                      .maybeFromMap(e))
                                                  .withoutNulls
                                                  .toList()
                                                  .cast<StructureStruct>();
                                          FFAppState().update(() {});

                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          size: 24.0,
                                        ),
                                      ),
                                  ],
                                );
                              }).divide(SizedBox(height: 5.0)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (functions
                        .jsonToList(getJsonField(
                          widget.json,
                          r'''$.tickets''',
                        ))
                        .length !=
                    0)
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Text(
                            'Наряды',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final comments = getJsonField(
                              widget.json,
                              r'''$.tickets''',
                            ).toList();

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: List.generate(comments.length,
                                  (commentsIndex) {
                                final commentsItem = comments[commentsIndex];
                                return Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.5,
                                      decoration: BoxDecoration(),
                                      child: Text(
                                        valueOrDefault<String>(
                                          getJsonField(
                                            commentsItem,
                                            r'''$.title''',
                                          )?.toString(),
                                          '-',
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SFProText',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      decoration: BoxDecoration(
                                        color: functions
                                            .colorNaryadsCopy(getJsonField(
                                          commentsItem,
                                          r'''$.status''',
                                        ).toString()),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(),
                                              child: Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      functions.statusNaryads(
                                                          getJsonField(
                                                        commentsItem,
                                                        r'''$.status''',
                                                      ).toString()),
                                                      '-',
                                                    ),
                                                    textAlign: TextAlign.center,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: functions
                                                              .colorNaryads(
                                                                  getJsonField(
                                                            commentsItem,
                                                            r'''$.status''',
                                                          ).toString()),
                                                          fontSize: 12.0,
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
                                    if (widget.status != 'Пройден')
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          _model.apiResultph6CopyCopy =
                                              await PutDetailedReglamentCall
                                                  .call(
                                            access: currentAuthenticationToken,
                                            id: widget.reglamentid,
                                            work: FFAppState().workspace,
                                            jsonJson: functions.removeAtIndex(
                                                FFAppState()
                                                    .ReglamentDetailed
                                                    .map((e) => e.toMap())
                                                    .toList(),
                                                widget.indexStructure!,
                                                widget.indexQuestions!,
                                                commentsIndex,
                                                'tickets'),
                                          );

                                          FFAppState().ReglamentDetailed =
                                              functions
                                                  .removeAtIndex(
                                                      FFAppState()
                                                          .ReglamentDetailed
                                                          .map((e) => e.toMap())
                                                          .toList(),
                                                      widget.indexStructure!,
                                                      widget.indexQuestions!,
                                                      commentsIndex,
                                                      'tickets')
                                                  .map((e) => StructureStruct
                                                      .maybeFromMap(e))
                                                  .withoutNulls
                                                  .toList()
                                                  .cast<StructureStruct>();
                                          FFAppState().update(() {});

                                          safeSetState(() {});
                                        },
                                        child: Icon(
                                          Icons.delete_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          size: 24.0,
                                        ),
                                      ),
                                  ],
                                );
                              }).divide(SizedBox(height: 5.0)),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (functions
                        .jsonToList(getJsonField(
                          widget.json,
                          r'''$.files''',
                        ))
                        .length !=
                    0)
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: BoxDecoration(),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 5.0),
                          child: Text(
                            'Фото/видео',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  fontSize: 15.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ),
                        Builder(
                          builder: (context) {
                            final files = getJsonField(
                              widget.json,
                              r'''$.files''',
                            ).toList();

                            return SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children:
                                    List.generate(files.length, (filesIndex) {
                                  final filesItem = files[filesIndex];
                                  return Stack(
                                    alignment: AlignmentDirectional(1.0, -1.0),
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 7.0, 0.0),
                                        child: InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            context.pushNamed(
                                              MediaViewerWidget.routeName,
                                              queryParameters: {
                                                'data': serializeParam(
                                                  getJsonField(
                                                    filesItem,
                                                    r'''$.data''',
                                                  ).toString(),
                                                  ParamType.String,
                                                ),
                                              }.withoutNulls,
                                            );
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.237,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.098,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12.0),
                                              border: Border.all(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                width: 2.0,
                                              ),
                                            ),
                                            child: Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.2,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.09,
                                              child: custom_widgets.Base64Media(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.2,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.09,
                                                base64Data: getJsonField(
                                                  filesItem,
                                                  r'''$.data''',
                                                ).toString(),
                                                controllable: false,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Color(0xFF3466E7),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Visibility(
                                          visible: widget.status != 'Пройден',
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.apiResultph6Copy2 =
                                                  await PutDetailedReglamentCall
                                                      .call(
                                                access:
                                                    currentAuthenticationToken,
                                                id: widget.reglamentid,
                                                work: FFAppState().workspace,
                                                jsonJson:
                                                    functions.removeAtIndex(
                                                        FFAppState()
                                                            .ReglamentDetailed
                                                            .map((e) =>
                                                                e.toMap())
                                                            .toList(),
                                                        widget.indexStructure!,
                                                        widget.indexQuestions!,
                                                        filesIndex,
                                                        'files'),
                                              );

                                              FFAppState().ReglamentDetailed =
                                                  functions
                                                      .removeAtIndex(
                                                          FFAppState()
                                                              .ReglamentDetailed
                                                              .map(
                                                                  (e) =>
                                                                      e.toMap())
                                                              .toList(),
                                                          widget
                                                              .indexStructure!,
                                                          widget
                                                              .indexQuestions!,
                                                          filesIndex,
                                                          'files')
                                                      .map((e) =>
                                                          StructureStruct
                                                              .maybeFromMap(e))
                                                      .withoutNulls
                                                      .toList()
                                                      .cast<StructureStruct>();
                                              FFAppState().update(() {});

                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.clear_sharp,
                                              color: Colors.white,
                                              size: 24.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).divide(SizedBox(width: 5.0)),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                if (widget.status != 'Пройден')
                  Container(
                    decoration: BoxDecoration(),
                    child: Visibility(
                      visible: functions.checkLogicTrigger(widget.json!),
                      child: FFButtonWidget(
                        onPressed: () async {
                          await showModalBottomSheet(
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            enableDrag: false,
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: MediaQuery.viewInsetsOf(context),
                                child: Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.3,
                                  child: AddsWidget(
                                    json: widget.json!,
                                    indexStructure: widget.indexStructure!,
                                    indexQuestion: widget.indexQuestions!,
                                    reglamentid: widget.reglamentid!,
                                    equipment: widget.equipmentname!,
                                    probeg: widget.probeg,
                                    motohours: widget.motohours,
                                    equipid: widget.equipid!,
                                    actions: (getJsonField(
                                      widget.json,
                                      r'''$.logics[:].actions[:]''',
                                      true,
                                    ) as List?)
                                        ?.map<String>((e) => e.toString())
                                        .toList()
                                        .cast<String>(),
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        text: 'Действия',
                        icon: Icon(
                          Icons.add,
                          size: 15.0,
                        ),
                        options: FFButtonOptions(
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              16.0, 0.0, 16.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconColor: FlutterFlowTheme.of(context).primary,
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SFProText',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                  ),
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
              ]
                  .divide(SizedBox(height: 7.0))
                  .addToStart(SizedBox(height: 5.0))
                  .addToEnd(SizedBox(height: 5.0)),
            ),
          ),
        ],
      ),
    );
  }
}
