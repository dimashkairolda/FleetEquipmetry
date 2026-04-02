import 'package:Equipmetry/naryads/create_naryad_maintenance/create_naryad_maintenance_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'maintenance_naryad_model.dart';
export 'maintenance_naryad_model.dart';

class MaintenanceNaryadWidget extends StatefulWidget {
  const MaintenanceNaryadWidget({
    super.key,
    required this.json,
    required this.id,
    required this.itemsData,
  });

  final dynamic json;
  final String? id;
  final dynamic itemsData;

  static String routeName = 'MaintenanceNaryad';
  static String routePath = '/maintenanceNaryad';

  @override
  State<MaintenanceNaryadWidget> createState() =>
      _MaintenanceNaryadWidgetState();
}

class _MaintenanceNaryadWidgetState extends State<MaintenanceNaryadWidget> {
  late MaintenanceNaryadModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MaintenanceNaryadModel());

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
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            primary: false,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.98,
                  child: custom_widgets.MaintenanceWizard(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.98,
                    maintenanceId: widget!.id!,
                    workspaceId: FFAppState().workspace,
                    token: currentAuthenticationToken!,
                    onFinish: () async {
                      context.pushNamed(
                        CreateNaryadMaintenanceWidget.routeName,
                        queryParameters: {
                          'name': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.schedule_info.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'equipmentid': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.equipment_info.id''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'equipname': serializeParam(
                            '${getJsonField(
                              widget!.json,
                              r'''$.equipment_info.brand_id.name''',
                            ).toString()} ${getJsonField(
                              widget!.json,
                              r'''$.equipment_info.model_id.name''',
                            ).toString()} ${getJsonField(
                              widget!.json,
                              r'''$.equipment_info.license_plate_number''',
                            ).toString()}',
                            ParamType.String,
                          ),
                          'equipplatenumber': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.equipment_info.license_plate_number''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'maintenanceId': serializeParam(
                            widget!.id,
                            ParamType.String,
                          ),
                        }.withoutNulls,
                      );
                    },
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
