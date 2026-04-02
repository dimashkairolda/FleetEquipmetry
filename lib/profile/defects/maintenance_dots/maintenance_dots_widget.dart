import 'package:Equipmetry/profile/defects/maintenance_c_t_o/maintenance_c_t_o_widget.dart';
import 'package:Equipmetry/profile/defects/maintenance_naryad/maintenance_naryad_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'maintenance_dots_model.dart';
export 'maintenance_dots_model.dart';

class MaintenanceDotsWidget extends StatefulWidget {
  const MaintenanceDotsWidget({
    super.key,
    required this.id,
    required this.status,
    required this.equipinfo,
    required this.nazvanie,
    this.json,
  });

  final String? id;
  final String? status;
  final dynamic equipinfo;
  final String? nazvanie;
  final dynamic json;

  @override
  State<MaintenanceDotsWidget> createState() => _MaintenanceDotsWidgetState();
}

class _MaintenanceDotsWidgetState extends State<MaintenanceDotsWidget> {
  late MaintenanceDotsModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MaintenanceDotsModel());

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
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: FlutterFlowTheme.of(context).primaryText,
                              size: 20,
                            ),
                            Align(
                              alignment: AlignmentDirectional(-1, 0),
                              child: Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                                child: Text(
                                  'Показать',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'SFProText',
                                        fontSize: 16,
                                        letterSpacing: 0.0,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xFFE9ECEF),
                        ),
                      ],
                    ),
                  ),
                ),
                
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 50,
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
                          MaintenanceCTOWidget.routeName,
                          queryParameters: {
                            'json': serializeParam(
                              widget!.json,
                              ParamType.JSON,
                            ),
                            'id': serializeParam(
                              widget!.id,
                              ParamType.String,
                            ),
                            'itemsData': serializeParam(
                              widget!.json,
                              ParamType.JSON,
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
                                Icons.card_travel_rounded,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 20,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Создать заявку в СТО',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          fontSize: 16,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFFE9ECEF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 50,
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
                          MaintenanceNaryadWidget.routeName,
                          queryParameters: {
                            'json': serializeParam(
                              widget!.json,
                              ParamType.JSON,
                            ),
                            'id': serializeParam(
                              widget!.id,
                              ParamType.String,
                            ),
                            'itemsData': serializeParam(
                              widget!.json,
                              ParamType.JSON,
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
                                Icons.add_box,
                                color: FlutterFlowTheme.of(context).primaryText,
                                size: 20,
                              ),
                              Align(
                                alignment: AlignmentDirectional(-1, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      10, 0, 0, 0),
                                  child: Text(
                                    'Создать наряд',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          fontSize: 16,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1,
                            color: Color(0xFFE9ECEF),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (!((valueOrDefault<String>(
                          functions.statusMaintenance(widget!.status),
                          '-',
                        ) ==
                        'Выполнен') ||
                    (valueOrDefault<String>(
                          functions.statusMaintenance(widget!.status),
                          '-',
                        ) ==
                        'Пропущенные')))
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          var _shouldSetState = false;
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Подтвердите действие'),
                                    content: Text(
                                        'Отметить график обслуживание как \'Выполнено\'?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Отмена'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Подтвердить'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            _model.apiResult00w =
                                await MaintenancesCompleteCall.call(
                              access: currentAuthenticationToken,
                              work: FFAppState().workspace,
                              id: widget!.id,
                              lastmaintenance: functions.stringToInt(getJsonField(
                                widget!.json,
                                r'''$.last_maintenance''',
                              ).toString())!,

                            );

                            _shouldSetState = true;
                            if ((_model.apiResult00w?.succeeded ?? true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Успешно!',
                                    style: TextStyle(
                                      fontFamily: 'SFProText',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                              );

                              context.pushNamed(MaintenanceWidget.routeName);
                            } else {
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                          } else {
                            Navigator.pop(context);
                          }

                          if (_shouldSetState) safeSetState(() {});
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.check,
                                  color: FlutterFlowTheme.of(context).success,
                                  size: 22,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'Выполнено',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: FlutterFlowTheme.of(context)
                                                .success,
                                            fontSize: 16,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE9ECEF),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                if (!((valueOrDefault<String>(
                          functions.statusMaintenance(widget!.status),
                          '-',
                        ) ==
                        'Выполнен') ||
                    (valueOrDefault<String>(
                          functions.statusMaintenance(widget!.status),
                          '-',
                        ) ==
                        'Пропущенные')))
                  Align(
                    alignment: AlignmentDirectional(0, 0),
                    child: Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      height: 50,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          var _shouldSetState = false;
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: Text('Подтвердите действие'),
                                    content: Text(
                                        'Отметить график обслуживание как \'Пропущенный\'?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Отмена'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Подтвердить'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            _model.apiResult00wCopy =
                                await MaintenancesMissedCall.call(
                              access: currentAuthenticationToken,
                              id: widget!.id,
                              work: FFAppState().workspace,
                            );

                            _shouldSetState = true;
                            if ((_model.apiResult00wCopy?.succeeded ?? true)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Успешно!',
                                    style: TextStyle(
                                      fontFamily: 'SFProText',
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  duration: Duration(milliseconds: 1000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                ),
                              );

                              context.pushNamed(MaintenanceWidget.routeName);
                            } else {
                              if (_shouldSetState) safeSetState(() {});
                              return;
                            }
                          } else {
                            Navigator.pop(context);
                          }

                          if (_shouldSetState) safeSetState(() {});
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Icon(
                                  Icons.close,
                                  color: FlutterFlowTheme.of(context).error,
                                  size: 22,
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 0, 0),
                                    child: Text(
                                      'Пропустить',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 16,
                                            letterSpacing: 0.0,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Color(0xFFE9ECEF),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ].addToStart(SizedBox(height: 10)),
            ),
          ],
        ),
      ),
    );
  }
}
