import 'package:Equipmetry/cto/create_c_t_o_maintenance/create_c_t_o_maintenance_widget.dart';

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

import 'maintenance_c_t_o_model.dart';
export 'maintenance_c_t_o_model.dart';

class MaintenanceCTOWidget extends StatefulWidget {
  const MaintenanceCTOWidget({
    super.key,
    required this.json,
    required this.id,
    required this.itemsData,
  });

  final dynamic json;
  final String? id;
  final dynamic itemsData;

  static String routeName = 'MaintenanceCTO';
  static String routePath = '/maintenanceCTO';

  @override
  State<MaintenanceCTOWidget> createState() => _MaintenanceCTOWidgetState();
}

class _MaintenanceCTOWidgetState extends State<MaintenanceCTOWidget> {
  late MaintenanceCTOModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => MaintenanceCTOModel());

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
                  child: custom_widgets.CTOWizard(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.98,
                    maintenanceId: widget!.id!,
                    workspaceId: FFAppState().workspace,
                    token: currentAuthenticationToken!,
                    onFinish: () async {
                      context.pushNamed(
                        CreateCTOMaintenanceWidget.routeName,
                        queryParameters: {
                          'brandname': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.equipment_info.brand_id.name''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'modelname': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.equipment_info.model_id.name''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'number': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.equipment_info.license_plate_number''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'asset': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.equipment_info.id''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'nazvanie': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.schedule_info.title''',
                            ).toString(),
                            ParamType.String,
                          ),
                          'maintenanceId': serializeParam(
                            getJsonField(
                              widget!.json,
                              r'''$.id''',
                            ).toString(),
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
