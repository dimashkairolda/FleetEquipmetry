import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import '/custom_code/actions/index.dart' as actions;
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'media_reglament_model.dart';
export 'media_reglament_model.dart';

class MediaReglamentWidget extends StatefulWidget {
  const MediaReglamentWidget({
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
  State<MediaReglamentWidget> createState() => _MediaReglamentWidgetState();
}

class _MediaReglamentWidgetState extends State<MediaReglamentWidget> {
  late MediaReglamentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MediaReglamentModel());

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                if (widget.status != 'Пройден')
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      if (widget.status != 'Пройден') {
                        safeSetState(() {
                          _model.isDataUploading_wwwdw21 = false;
                          _model.uploadedLocalFile_wwwdw21 =
                              FFUploadedFile(bytes: Uint8List.fromList([]));
                        });

                        final selectedMedia =
                            await selectMediaWithSourceBottomSheet(
                          context: context,
                          maxWidth: 500.00,
                          maxHeight: 1000.00,
                          imageQuality: 63,
                          allowPhoto: true,
                          allowVideo: true,
                        );
                        if (selectedMedia != null &&
                            selectedMedia.every((m) =>
                                validateFileFormat(m.storagePath, context))) {
                          safeSetState(
                              () => _model.isDataUploading_wwwdw21 = true);
                          var selectedUploadedFiles = <FFUploadedFile>[];

                          try {
                            selectedUploadedFiles = selectedMedia
                                .map((m) => FFUploadedFile(
                                      name: m.storagePath.split('/').last,
                                      bytes: m.bytes,
                                      height: m.dimensions?.height,
                                      width: m.dimensions?.width,
                                      blurHash: m.blurHash,
                                    ))
                                .toList();
                          } finally {
                            _model.isDataUploading_wwwdw21 = false;
                          }
                          if (selectedUploadedFiles.length ==
                              selectedMedia.length) {
                            safeSetState(() {
                              _model.uploadedLocalFile_wwwdw21 =
                                  selectedUploadedFiles.first;
                            });
                          } else {
                            safeSetState(() {});
                            return;
                          }
                        }

                        _model.qqqq =
                            await actions.uploadFileAndConvertToBase64toList(
                          _model.uploadedLocalFile_wwwdw21,
                        );
                        _model.apiResulto11 =
                            await PutDetailedReglamentCall.call(
                          access: currentAuthenticationToken,
                          id: widget.reglamentid,
                          work: FFAppState().workspace,
                          jsonJson: functions.addFilesAtIndex(
                              FFAppState()
                                  .ReglamentDetailed
                                  .map((e) => e.toMap())
                                  .toList(),
                              widget.indexStructure!,
                              widget.indexQuestions!,
                              'files',
                              _model.qqqq!),
                        );

                        FFAppState().ReglamentDetailed = functions
                            .addFilesAtIndex(
                                FFAppState()
                                    .ReglamentDetailed
                                    .map((e) => e.toMap())
                                    .toList(),
                                widget.indexStructure!,
                                widget.indexQuestions!,
                                'files',
                                _model.qqqq!)
                            .map((e) => StructureStruct.maybeFromMap(e))
                            .withoutNulls
                            .toList()
                            .cast<StructureStruct>();
                        FFAppState().update(() {});
                      }

                      safeSetState(() {});
                    },
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(
                          color: FlutterFlowTheme.of(context).primary,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.photo_camera,
                            color: Color(0xFF3466E7),
                            size: 25.0,
                          ),
                          Text(
                            'Добавить вложение',
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context).primary,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ],
                      ),
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
