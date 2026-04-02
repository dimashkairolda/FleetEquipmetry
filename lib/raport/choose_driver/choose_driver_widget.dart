import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'choose_driver_model.dart';
export 'choose_driver_model.dart';

class ChooseDriverWidget extends StatefulWidget {
  const ChooseDriverWidget({
    super.key,
    required this.iscurrent,
  });

  final bool? iscurrent;

  static String routeName = 'chooseDriver';
  static String routePath = '/chooseDriver';

  @override
  State<ChooseDriverWidget> createState() => _ChooseDriverWidgetState();
}

class _ChooseDriverWidgetState extends State<ChooseDriverWidget> {
  late ChooseDriverModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChooseDriverModel());

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
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            borderWidth: 1.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.chevron_left_rounded,
              color: FlutterFlowTheme.of(context).primaryText,
              size: 24.0,
            ),
            onPressed: () async {
              context.safePop();
            },
          ),
          title: Text(
            'Выбрать водителя',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [],
          centerTitle: false,
          elevation: 0.0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          decoration: BoxDecoration(),
                          child: Text(
                            'ФИО',
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
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.35,
                          decoration: BoxDecoration(),
                          child: Text(
                            'Смена',
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
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.07,
                          decoration: BoxDecoration(),
                        ),
                      ],
                    ),
                  ].divide(SizedBox(height: 15.0)),
                ),
                Builder(
                  builder: (context) {
                    final drivers = (widget.iscurrent!
                            ? FFAppState().currentdriver
                            : FFAppState().nextdriver)
                        .toList();

                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(drivers.length, (driversIndex) {
                        final driversItem = drivers[driversIndex];
                        return Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.45,
                              decoration: BoxDecoration(),
                              child: Text(
                                driversItem.title,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.35,
                              decoration: BoxDecoration(),
                              child: Text(
                                driversItem.shift,
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                    ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.07,
                              decoration: BoxDecoration(),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  if (widget.iscurrent!) {
                                    FFAppState().removeAtIndexFromCurrentdriver(
                                        driversIndex);
                                    safeSetState(() {});
                                  } else {
                                    FFAppState().removeAtIndexFromNextdriver(
                                        driversIndex);
                                    safeSetState(() {});
                                  }
                                },
                                child: Icon(
                                  Icons.delete_sharp,
                                  color: Color(0xFFFF2330),
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).divide(SizedBox(height: 15.0)),
                    );
                  },
                ),
                if (_model.isedited)
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(11.0, 0.0, 11.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        FutureBuilder<ApiCallResponse>(
                          future: GetEmployeesCall.call(
                            access: currentAuthenticationToken,
                            work: FFAppState().workspace,
                          ),
                          builder: (context, snapshot) {
                            // Customize what your widget looks like when it's loading.
                            if (!snapshot.hasData) {
                              return Center(
                                child: SizedBox(
                                  width: 50.0,
                                  height: 50.0,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      FlutterFlowTheme.of(context).primaryText,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final dropDownGetEmployeesResponse = snapshot.data!;

                            return FlutterFlowDropDown<String>(
                              controller: _model.dropDownValueController1 ??=
                                  FormFieldController<String>(
                                _model.dropDownValue1 ??= '',
                              ),
                              options: List<String>.from((getJsonField(
                                dropDownGetEmployeesResponse.jsonBody,
                                r'''$[:].id''',
                                true,
                              ) as List?)!
                                  .map<String>((e) => e.toString())
                                  .toList()
                                  .cast<String>()),
                              optionLabels: functions.combineNamesAndSurnames(
                                  (getJsonField(
                                    dropDownGetEmployeesResponse.jsonBody,
                                    r'''$[:].name.first''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>(),
                                  (getJsonField(
                                    dropDownGetEmployeesResponse.jsonBody,
                                    r'''$[:].name.last''',
                                    true,
                                  ) as List?)!
                                      .map<String>((e) => e.toString())
                                      .toList()
                                      .cast<String>()),
                              onChanged: (val) => safeSetState(
                                  () => _model.dropDownValue1 = val),
                              width: 411.0,
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              maxHeight:
                                  MediaQuery.sizeOf(context).height * 0.6,
                              searchHintTextStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  ),
                              searchTextStyle: FlutterFlowTheme.of(context)
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
                              textStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'SFProText',
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'Выберите водителя',
                              searchHintText: 'Поиск ',
                              icon: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                size: 24.0,
                              ),
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              elevation: 2.0,
                              borderColor:
                                  FlutterFlowTheme.of(context).alternate,
                              borderWidth: 0.0,
                              borderRadius: 8.0,
                              margin: EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 0.0),
                              hidesUnderline: true,
                              isOverButton: true,
                              isSearchable: true,
                              isMultiSelect: false,
                            );
                          },
                        ),
                        FlutterFlowDropDown<String>(
                          controller: _model.dropDownValueController2 ??=
                              FormFieldController<String>(null),
                          options: ['День', 'Ночь'],
                          onChanged: (val) =>
                              safeSetState(() => _model.dropDownValue2 = val),
                          width: 411.0,
                          height: MediaQuery.sizeOf(context).height * 0.05,
                          maxHeight: MediaQuery.sizeOf(context).height * 0.4,
                          textStyle:
                              FlutterFlowTheme.of(context).bodyMedium.override(
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
                          hintText: 'Выберите смену',
                          icon: Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            size: 24.0,
                          ),
                          fillColor:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          elevation: 2.0,
                          borderColor: FlutterFlowTheme.of(context).alternate,
                          borderWidth: 0.0,
                          borderRadius: 8.0,
                          margin: EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 12.0, 0.0),
                          hidesUnderline: true,
                          isOverButton: true,
                          isSearchable: false,
                          isMultiSelect: false,
                        ),
                      ].divide(SizedBox(height: 15.0)),
                    ),
                  ),
                if (!_model.isedited)
                  FFButtonWidget(
                    onPressed: () async {
                      _model.isedited = true;
                      safeSetState(() {});
                    },
                    text: '+ добавить',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 0.95,
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      textStyle:
                          FlutterFlowTheme.of(context).bodyMedium.override(
                                fontFamily: 'SFProText',
                                color: FlutterFlowTheme.of(context).primary,
                                letterSpacing: 0.0,
                              ),
                      elevation: 0.0,
                      borderSide: BorderSide(
                        color: FlutterFlowTheme.of(context).primary,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                Align(
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Builder(
                    builder: (context) {
                      if (_model.isedited) {
                        return FFButtonWidget(
                          onPressed: () async {
                            if (widget.iscurrent!) {
                              FFAppState().addToCurrentdriver(DriverStruct(
                                id: _model.dropDownValue1,
                                shift: _model.dropDownValue2,
                                title: functions.getTitleById(
                                    FFAppState().employees.toList(),
                                    _model.dropDownValue1!),
                              ));
                              safeSetState(() {});
                            } else {
                              FFAppState().addToNextdriver(DriverStruct(
                                id: _model.dropDownValue1,
                                shift: _model.dropDownValue2,
                                title: functions.getTitleById(
                                    FFAppState().employees.toList(),
                                    _model.dropDownValue1!),
                              ));
                              safeSetState(() {});
                            }

                            if (Navigator.of(context).canPop()) {
                              context.pop();
                            }
                            context.pushNamed(
                              ChooseDriverWidget.routeName,
                              queryParameters: {
                                'iscurrent': serializeParam(
                                  widget.iscurrent,
                                  ParamType.bool,
                                ),
                              }.withoutNulls,
                            );
                          },
                          text: 'Применить',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        );
                      } else {
                        return FFButtonWidget(
                          onPressed: () async {
                            context.safePop();
                          },
                          text: 'Сохранить',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.95,
                            height: 40.0,
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).primary,
                            textStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'SFProText',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                ),
                            elevation: 0.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ].divide(SizedBox(height: 10.0)),
            ),
          ],
        ),
      ),
    );
  }
}
