import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'edit_naryad_sheet_model.dart';
export 'edit_naryad_sheet_model.dart';

class EditNaryadSheetWidget extends StatefulWidget {
  const EditNaryadSheetWidget({
    super.key,
    this.spareparts,
    this.todo,
    this.equipname,
    this.defectid,
    this.equiplicenseplatenumber,
    this.mesto,
    this.assignee,
    this.acceptor,
    this.date,
    this.name,
    this.equipmentid,
    this.defectname,
    this.defectstatus,
    this.defectdate,
    this.naryadid,
    required this.naryadstatus,
  });

  final List<SparePartsStruct>? spareparts;
  final List<TodoStruct>? todo;
  final String? equipname;
  final String? defectid;
  final String? equiplicenseplatenumber;
  final String? mesto;
  final List<String>? assignee;
  final String? acceptor;
  final String? date;
  final String? name;
  final String? equipmentid;
  final String? defectname;
  final String? defectstatus;
  final String? defectdate;
  final String? naryadid;
  final String? naryadstatus;

  @override
  State<EditNaryadSheetWidget> createState() => _EditNaryadSheetWidgetState();
}

class _EditNaryadSheetWidgetState extends State<EditNaryadSheetWidget> {
  late EditNaryadSheetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditNaryadSheetModel());

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
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if ((widget.naryadstatus == 'В работе') ||
                    (widget.naryadstatus == 'Запланирован'))
                  Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(
                            EditNaryadWidget.routeName,
                            queryParameters: {
                              'spareparts': serializeParam(
                                widget.spareparts,
                                ParamType.DataStruct,
                                isList: true,
                              ),
                              'todo': serializeParam(
                                widget.todo,
                                ParamType.DataStruct,
                                isList: true,
                              ),
                              'defectid': serializeParam(
                                widget.defectid,
                                ParamType.String,
                              ),
                              'name': serializeParam(
                                widget.name,
                                ParamType.String,
                              ),
                              'equipmentid': serializeParam(
                                widget.equipmentid,
                                ParamType.String,
                              ),
                              'equipname': serializeParam(
                                widget.equipname,
                                ParamType.String,
                              ),
                              'equipplatenumber': serializeParam(
                                widget.equiplicenseplatenumber,
                                ParamType.String,
                              ),
                              'defectName': serializeParam(
                                widget.defectname,
                                ParamType.String,
                              ),
                              'defectId': serializeParam(
                                widget.defectid,
                                ParamType.String,
                              ),
                              'mesto': serializeParam(
                                widget.mesto,
                                ParamType.String,
                              ),
                              'assignee': serializeParam(
                                widget.assignee,
                                ParamType.String,
                                isList: true,
                              ),
                              'defectstatus': serializeParam(
                                widget.defectstatus,
                                ParamType.String,
                              ),
                              'defectdate': serializeParam(
                                widget.defectdate,
                                ParamType.String,
                              ),
                              'date': serializeParam(
                                widget.date,
                                ParamType.String,
                              ),
                              'priemwik': serializeParam(
                                widget.acceptor,
                                ParamType.String,
                              ),
                              'naryadid': serializeParam(
                                widget.naryadid,
                                ParamType.String,
                              ),
                            }.withoutNulls,
                          );
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 20.0,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 0.0, 0.0),
                                    child: Text(
                                      'Редактировать',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            fontSize: 16.0,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1.0,
                              color: Color(0xFFE9ECEF),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 50.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        _model.apiResultd03 = await DeleteNaryadsCall.call(
                          access: currentAuthenticationToken,
                          naryadid: widget.naryadid,
                          work: FFAppState().workspace,
                        );

                        if ((_model.apiResultd03?.succeeded ?? true)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Наряд успешно удален!',
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );

                          context.pushNamed(NaryadsWidget.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                (_model.apiResultd03?.jsonBody ?? '')
                                    .toString(),
                                style: TextStyle(
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                              duration: Duration(milliseconds: 4000),
                              backgroundColor:
                                  FlutterFlowTheme.of(context).secondary,
                            ),
                          );
                        }

                        safeSetState(() {});
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.delete_outline,
                                color: FlutterFlowTheme.of(context).error,
                                size: 22.0,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    'Удалить',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: Color(0xFFE9ECEF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ].addToStart(SizedBox(height: 10.0)),
            ),
          ],
        ),
      ),
    );
  }
}
