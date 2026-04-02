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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'short_text_reglament_model.dart';
export 'short_text_reglament_model.dart';

class ShortTextReglamentWidget extends StatefulWidget {
  const ShortTextReglamentWidget({
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
  State<ShortTextReglamentWidget> createState() =>
      _ShortTextReglamentWidgetState();
}

class _ShortTextReglamentWidgetState extends State<ShortTextReglamentWidget> {
  late ShortTextReglamentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ShortTextReglamentModel());

    _model.textController ??= TextEditingController(
        text: !((functions.jsonToString(getJsonField(
                      widget.json,
                      r'''$.answers[0]''',
                    )) ==
                    '\"\"') ||
                (functions.jsonToString(getJsonField(
                      widget.json,
                      r'''$.answers[0]''',
                    )) ==
                    '') ||
                (functions
                        .jsonToList(getJsonField(
                          widget.json,
                          r'''$.answers''',
                        ))
                        .length ==
                    0))
            ? getJsonField(
                widget.json,
                r'''$.answers[0]''',
              ).toString()
            : '');
    _model.textFieldFocusNode ??= FocusNode();

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
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  child: TextFormField(
                    controller: _model.textController,
                    focusNode: _model.textFieldFocusNode,
                    onFieldSubmitted: (_) async {
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
                            _model.textController.text,
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
                              _model.textController.text,
                              'answers')
                          .map((e) => StructureStruct.maybeFromMap(getJsonField(
                                e,
                                r'''$''',
                              )))
                          .withoutNulls
                          .toList()
                          .cast<StructureStruct>();
                      FFAppState().update(() {});

                      safeSetState(() {});
                    },
                    autofocus: false,
                    textInputAction: TextInputAction.done,
                    readOnly: widget.status == 'Пройден',
                    obscureText: false,
                    decoration: InputDecoration(
                      isDense: true,
                      labelStyle:
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
                      hintText: !((functions.jsonToString(getJsonField(
                                    widget.json,
                                    r'''$.answers[0]''',
                                  )) ==
                                  '\"\"') ||
                              (functions.jsonToString(getJsonField(
                                    widget.json,
                                    r'''$.answers[0]''',
                                  )) ==
                                  '') ||
                              (functions
                                      .jsonToList(getJsonField(
                                        widget.json,
                                        r'''$.answers''',
                                      ))
                                      .length ==
                                  0))
                          ? ''
                          : 'Введите текст',
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
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0x00000000),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: FlutterFlowTheme.of(context).error,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).primaryBackground,
                    ),
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    cursorColor: FlutterFlowTheme.of(context).primaryText,
                    enableInteractiveSelection: true,
                    validator:
                        _model.textControllerValidator.asValidator(context),
                  ),
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
                      visible: ((_model.textController.text == '') &&
                              functions.containsString(
                                  (getJsonField(
                                    widget.json,
                                    r'''$.logics[:].value''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  'пустой')) ||
                          ((_model.textController.text != '') &&
                              functions.containsString(
                                  (getJsonField(
                                    widget.json,
                                    r'''$.logics[:].value''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  'заполнен')),
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
                                    actions: functions.containsString(
                                                (getJsonField(
                                                  widget.json,
                                                  r'''$.logics[:].value''',
                                                  true,
                                                ) as List?)!
                                                    .map<String>(
                                                        (e) => e.toString())
                                                    .toList()
                                                    .cast<String>(),
                                                'заполнен') &&
                                            (_model.textController.text !=
                                                    '')
                                        ? functions
                                            .jsonToList(getJsonField(
                                              widget.json,
                                              r'''$.logics''',
                                            ))
                                            .where((e) =>
                                                getJsonField(
                                                  e,
                                                  r'''$.value''',
                                                ) ==
                                                functions.stringToJson(
                                                    '\"заполнен\"'))
                                            .toList()
                                            .map((e) => getJsonField(
                                                  e,
                                                  r'''$.actions[:]''',
                                                ))
                                            .toList()
                                            .map((e) => e.toString())
                                            .toList()
                                        : functions
                                            .jsonToList(getJsonField(
                                              widget.json,
                                              r'''$.logics''',
                                            ))
                                            .where((e) =>
                                                getJsonField(
                                                  e,
                                                  r'''$.value''',
                                                ) ==
                                                functions
                                                    .stringToJson('\"пустой\"'))
                                            .toList()
                                            .map((e) => getJsonField(
                                                  e,
                                                  r'''$.actions[:]''',
                                                ))
                                            .toList()
                                            .map((e) => e.toString())
                                            .toList(),
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
