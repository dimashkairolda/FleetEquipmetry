import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/reglaments/reglament_comments/reglament_comments_widget.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'adds_model.dart';
export 'adds_model.dart';

class AddsWidget extends StatefulWidget {
  const AddsWidget({
    super.key,
    required this.json,
    required this.indexStructure,
    required this.indexQuestion,
    required this.reglamentid,
    required this.equipment,
    this.probeg,
    this.motohours,
    required this.equipid,
    this.actions,
  });

  final dynamic json;
  final int? indexStructure;
  final int? indexQuestion;
  final String? reglamentid;
  final String? equipment;
  final int? probeg;
  final int? motohours;
  final String? equipid;
  final List<String>? actions;

  @override
  State<AddsWidget> createState() => _AddsWidgetState();
}

class _AddsWidgetState extends State<AddsWidget> {
  late AddsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddsModel());

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

    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (functions.containsString(
                  widget!.actions!.toList(), 'attach_media'))
                FFButtonWidget(
                  onPressed: () async {
                    safeSetState(() {
                      _model.isDataUploading_wwwdw23 = false;
                      _model.uploadedLocalFile_wwwdw23 =
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
                      safeSetState(() => _model.isDataUploading_wwwdw23 = true);
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
                        _model.isDataUploading_wwwdw23 = false;
                      }
                      if (selectedUploadedFiles.length ==
                          selectedMedia.length) {
                        safeSetState(() {
                          _model.uploadedLocalFile_wwwdw23 =
                              selectedUploadedFiles.first;
                        });
                      } else {
                        safeSetState(() {});
                        return;
                      }
                    }

                    _model.qqqq =
                        await actions.uploadFileAndConvertToBase64toList(
                      _model.uploadedLocalFile_wwwdw23,
                    );
                    
                    if (!functions.imageNull(_model.qqqq!)) {
                      FFAppState().ReglamentDetailed = functions
                          .addFilesAtIndex(
                              FFAppState()
                                  .ReglamentDetailed
                                  .map((e) => e.toMap())
                                  .toList(),
                              widget!.indexStructure!,
                              widget!.indexQuestion!,
                              'files',
                              _model.qqqq!)
                          .map((e) => StructureStruct.maybeFromMap(e))
                          .withoutNulls
                          .toList()
                          .cast<StructureStruct>();
                      FFAppState().update(() {});
                      _model.apiResulto11 = await PutDetailedReglamentCall.call(
                        access: currentAuthenticationToken,
                        id: widget!.reglamentid,
                        work: FFAppState().workspace,
                        jsonJson: FFAppState()
                            .ReglamentDetailed
                            .map((e) => e.toMap())
                            .toList(),
                      );

                      Navigator.pop(context);
                    }

                    safeSetState(() {});
                  },
                  text: 'Фото или видео',
                  icon: Icon(
                    Icons.perm_media,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'SFProText',
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              if (functions.containsString(
                  widget!.actions!.toList(), 'add_comment'))
                FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                    await showModalBottomSheet(
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      enableDrag: false,
                      context: context,
                      builder: (context) {
                        return Padding(
                          padding: MediaQuery.viewInsetsOf(context),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.3,
                            child: ReglamentCommentsWidget(
                              json: widget!.json!,
                              indexStructure: widget!.indexStructure!,
                              indexQuestion: widget!.indexQuestion!,
                              reglamentid: widget!.reglamentid!,
                            ),
                          ),
                        );
                      },
                    ).then((value) => safeSetState(() {}));
                  },
                  text: 'Заметки',
                  icon: Icon(
                    Icons.insert_comment_outlined,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'SFProText',
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              if (functions.containsString(
                  widget!.actions!.toList(), 'create_defect'))
                FFButtonWidget(
                  onPressed: () async {
                    Navigator.pop(context);
                    if (Navigator.of(context).canPop()) {
                      context.pop();
                    }
                    context.pushNamed(
                      CreateDefectFromReglamentWidget.routeName,
                      queryParameters: {
                        'equipId': serializeParam(
                          widget!.equipid,
                          ParamType.String,
                        ),
                        'brandname': serializeParam(
                          widget!.equipment,
                          ParamType.String,
                        ),
                        'probeg': serializeParam(
                          widget!.probeg,
                          ParamType.int,
                        ),
                        'motohours': serializeParam(
                          widget!.motohours,
                          ParamType.int,
                        ),
                        'reglamentid': serializeParam(
                          widget!.reglamentid,
                          ParamType.String,
                        ),
                        'structureIndex': serializeParam(
                          widget!.indexStructure,
                          ParamType.int,
                        ),
                        'questionIndex': serializeParam(
                          widget!.indexQuestion,
                          ParamType.int,
                        ),
                      }.withoutNulls,
                    );
                  },
                  text: 'Создать дефект',
                  icon: Icon(
                    Icons.report_gmailerrorred_sharp,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'SFProText',
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              if (functions.containsString(
                  widget!.actions!.toList(), 'create_ticket'))
                FFButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Создать наряд',
                  icon: Icon(
                    Icons.build_rounded,
                    size: 15,
                  ),
                  options: FFButtonOptions(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'SFProText',
                          color: FlutterFlowTheme.of(context).primary,
                          letterSpacing: 0.0,
                        ),
                    elevation: 0,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
