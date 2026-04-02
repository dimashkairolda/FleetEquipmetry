import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'store_house_model.dart';
export 'store_house_model.dart';

class StoreHouseWidget extends StatefulWidget {
  const StoreHouseWidget({super.key});

  static String routeName = 'StoreHouse';
  static String routePath = '/storeHouse';

  @override
  State<StoreHouseWidget> createState() => _StoreHouseWidgetState();
}

class _StoreHouseWidgetState extends State<StoreHouseWidget> {
  late StoreHouseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => StoreHouseModel());

    _model.textField12TextController ??= TextEditingController();
    _model.textField12FocusNode ??= FocusNode();

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
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
          automaticallyImplyLeading: false,
          leading: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.goNamed(ProfilePageWidget.routeName);
              FFAppState().searchOutput = [];
              FFAppState().isShowFullList1 = true;
              safeSetState(() {});
            },
            child: Icon(
              Icons.chevron_left,
              color: FlutterFlowTheme.of(context).secondaryText,
              size: 24,
            ),
          ),
          title: Text(
            'Ремонтное обеспечение',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'SFProText',
                  fontSize: 18,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [
            FlutterFlowIconButton(
              borderColor: Colors.transparent,
              borderRadius: 20,
              borderWidth: 1,
              buttonSize: 40,
              icon: Icon(
                Icons.replay,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 24,
              ),
              onPressed: () async {
                safeSetState(() => _model.apiRequestCompleter1 = null);
                await _model.waitForApiRequestCompleted1();
                safeSetState(() => _model.apiRequestCompleter2 = null);
                await _model.waitForApiRequestCompleted2();
              },
            ),
          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: FutureBuilder<ApiCallResponse>(
            future:
                (_model.apiRequestCompleter1 ??= Completer<ApiCallResponse>()
                      ..complete(GetStoreHouseCall.call(
                        token: currentAuthenticationToken,
                        work: FFAppState().workspace,
                        search: _model.textField12TextController.text != null &&
                                _model.textField12TextController.text != ''
                            ? '&title=${_model.textField12TextController.text}'
                            : '',
                        equipment: _model.dropDownColumnValue != null &&
                                _model.dropDownColumnValue != ''
                            ? '&equipment_id=${_model.dropDownColumnValue}'
                            : '',
                        page: _model.page,
                      )))
                    .future,
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primaryText,
                      ),
                    ),
                  ),
                );
              }
              final columnGetStoreHouseResponse1 = snapshot.data!;

              return SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(11, 0, 11, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Flexible(
                                  child: Container(
                                    height: MediaQuery.sizeOf(context).height *
                                        0.042,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 8, 0),
                                      child: TextFormField(
                                        controller:
                                            _model.textField12TextController,
                                        focusNode: _model.textField12FocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.textField12TextController',
                                          Duration(milliseconds: 0),
                                          () async {
                                            safeSetState(() => _model
                                                .apiRequestCompleter1 = null);
                                            await _model
                                                .waitForApiRequestCompleted1();
                                            safeSetState(() => _model
                                                .apiRequestCompleter2 = null);
                                            await _model
                                                .waitForApiRequestCompleted2();
                                          },
                                        ),
                                        autofocus: false,
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          labelStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'SFProText',
                                                    color: Color(0xFF99A2AD),
                                                    fontSize: 15,
                                                    letterSpacing: 0.0,
                                                  ),
                                          hintText: 'Поиск',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'SFProText',
                                                    color: Color(0xFF99A2AD),
                                                    fontSize: 15,
                                                    letterSpacing: 0.0,
                                                  ),
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search_rounded,
                                            color: Color(0xFF99A2AD),
                                          ),
                                          suffixIcon: _model
                                                  .textField12TextController!
                                                  .text
                                                  .isNotEmpty
                                              ? InkWell(
                                                  onTap: () async {
                                                    _model
                                                        .textField12TextController
                                                        ?.clear();
                                                    safeSetState(() => _model
                                                            .apiRequestCompleter1 =
                                                        null);
                                                    await _model
                                                        .waitForApiRequestCompleted1();
                                                    safeSetState(() => _model
                                                            .apiRequestCompleter2 =
                                                        null);
                                                    await _model
                                                        .waitForApiRequestCompleted2();
                                                    safeSetState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF99A2AD),
                                                    size: 15,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'SFProText',
                                              letterSpacing: 0.0,
                                            ),
                                        validator: _model
                                            .textField12TextControllerValidator
                                            .asValidator(context),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // --- ИСПРАВЛЕНИЕ ЗДЕСЬ: Заменили Expanded на SingleChildScrollView ---
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (_model.dropDownColumnValue != null &&
                                        _model.dropDownColumnValue != '') {
                                      return FlutterFlowIconButton(
                                        borderColor: Colors.transparent,
                                        borderRadius: 20,
                                        borderWidth: 1,
                                        buttonSize:
                                            MediaQuery.sizeOf(context).width *
                                                0.1,
                                        icon: Icon(
                                          Icons.close,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24,
                                        ),
                                        onPressed: () async {
                                          safeSetState(() {
                                            _model.dropDownColumnValueController
                                                ?.reset();
                                            _model.dropDownColumnValue = null;
                                          });
                                          safeSetState(() => _model
                                              .apiRequestCompleter1 = null);
                                          await _model
                                              .waitForApiRequestCompleted1();
                                          safeSetState(() => _model
                                              .apiRequestCompleter2 = null);
                                          await _model
                                              .waitForApiRequestCompleted2();
                                        },
                                      );
                                    } else {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      );
                                    }
                                  },
                                ),
                                FutureBuilder<ApiCallResponse>(
                                  future: GetEquipmentsTreeCall.call(
                                    access: currentAuthenticationToken,
                                    work: FFAppState().workspace,
                                    page: 50,
                                  ),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return Center(
                                        child: SizedBox(
                                          width: 50,
                                          height: 50,
                                          child: CircularProgressIndicator(
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    final conditionalBuilderGetEquipmentsTreeResponse =
                                        snapshot.data!;

                                    return Builder(
                                      builder: (context) {
                                        if (functions
                                                .jsonToList(getJsonField(
                                                  conditionalBuilderGetEquipmentsTreeResponse
                                                      .jsonBody,
                                                  r'''$''',
                                                ))
                                                .length !=
                                            0) {
                                          return FlutterFlowDropDown<String>(
                                            controller: _model
                                                    .dropDownColumnValueController ??=
                                                FormFieldController<String>(
                                              _model.dropDownColumnValue ??= '',
                                            ),
                                            options: List<String>.from(
                                                (getJsonField(
                                              conditionalBuilderGetEquipmentsTreeResponse
                                                  .jsonBody,
                                              r'''$[:].id''',
                                              true,
                                            ) as List?)!
                                                    .map<String>(
                                                        (e) => e.toString())
                                                    .toList()
                                                    .cast<String>()),
                                            optionLabels:
                                                functions.combineTechnics(
                                                    (getJsonField(
                                                      conditionalBuilderGetEquipmentsTreeResponse
                                                          .jsonBody,
                                                      r'''$[:].brand_id.name''',
                                                      true,
                                                    ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>(),
                                                    (getJsonField(
                                                      conditionalBuilderGetEquipmentsTreeResponse
                                                          .jsonBody,
                                                      r'''$[:].model_id.name''',
                                                      true,
                                                    ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>(),
                                                    (getJsonField(
                                                      conditionalBuilderGetEquipmentsTreeResponse
                                                          .jsonBody,
                                                      r'''$[:].license_plate_number''',
                                                      true,
                                                    ) as List?)!
                                                        .map<String>(
                                                            (e) => e.toString())
                                                        .toList()
                                                        .cast<String>()),
                                            onChanged: (val) async {
                                              safeSetState(() => _model
                                                  .dropDownColumnValue = val);
                                              safeSetState(() => _model
                                                  .apiRequestCompleter1 = null);
                                              await _model
                                                  .waitForApiRequestCompleted1();
                                              safeSetState(() => _model
                                                  .apiRequestCompleter2 = null);
                                              await _model
                                                  .waitForApiRequestCompleted2();
                                            },
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.4,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.04,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      font:
                                                          GoogleFonts.readexPro(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                            hintText: 'Техника',
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_rounded,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                              size: 24,
                                            ),
                                            fillColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            elevation: 2,
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                            borderWidth: 1,
                                            borderRadius: 8,
                                            margin:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 12, 0),
                                            hidesUnderline: true,
                                            isOverButton: false,
                                            isSearchable: false,
                                            isMultiSelect: false,
                                          );
                                        } else {
                                          return Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ]
                                  .divide(SizedBox(width: 10))
                                  .addToStart(SizedBox(width: 5))
                                  .addToEnd(SizedBox(width: 10)),
                            ),
                          ),
                          // -----------------------------------------------------------------------
                        ]
                            .divide(SizedBox(height: 5))
                            .addToStart(SizedBox(height: 5))
                            .addToEnd(SizedBox(height: 5)),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Builder(
                          builder: (context) {
                            // ИСПРАВЛЕНИЕ: Добавлен кастинг (as List), чтобы избежать ошибки типов
                            final storehouse = (columnGetStoreHouseResponse1
                                    .jsonBody as List)
                                .toList();

                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: List.generate(storehouse.length,
                                  (storehouseIndex) {
                                final storehouseItem =
                                    storehouse[storehouseIndex];
                                return InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      StoreHouseDetailedWidget.routeName,
                                      queryParameters: {
                                        'id': serializeParam(
                                          getJsonField(
                                            storehouseItem,
                                            r'''$.id''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                        'srokdostavki': serializeParam(
                                          valueOrDefault<String>(
                                            getJsonField(
                                              storehouseItem,
                                              r'''$.approximate_delivery_date''',
                                            )?.toString(),
                                            '-',
                                          ),
                                          ParamType.String,
                                        ),
                                        'status': serializeParam(
                                          getJsonField(
                                            storehouseItem,
                                            r'''$.status''',
                                          ).toString(),
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 15, 16, 0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Источник: ',
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 15,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.67,
                                                decoration: BoxDecoration(),
                                                child: Visibility(
                                                  visible: getJsonField(
                                                        storehouseItem,
                                                        r'''$.references[0].title''',
                                                      ) !=
                                                      null,
                                                  child: Text(
                                                    getJsonField(
                                                      storehouseItem,
                                                      r'''$.references[0].title''',
                                                    ).toString(),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          fontSize: 15,
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 5)),
                                          ),
                                          Builder(
                                            builder: (context) {
                                              final equips = getJsonField(
                                                storehouseItem,
                                                r'''$.equipments''',
                                              ).toList();

                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children:
                                                    List.generate(equips.length,
                                                        (equipsIndex) {
                                                  final equipsItem =
                                                      equips[equipsIndex];
                                                  return Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.08,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.08,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          getJsonField(
                                                            equipsItem,
                                                            r'''$.avatar''',
                                                          ).toString(),
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                            'assets/images/error_image.png',
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.8,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          '${getJsonField(
                                                            equipsItem,
                                                            r'''$.title''',
                                                          ).toString()} ${getJsonField(
                                                            equipsItem,
                                                            r'''$.license_plate_number''',
                                                          ).toString()}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                                fontSize: 15,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 10)),
                                                  );
                                                }).divide(SizedBox(height: 5)),
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        functions.colorRemontBG(
                                                            getJsonField(
                                                      storehouseItem,
                                                      r'''$.status''',
                                                    ).toString()),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 5, 10, 5),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          functions
                                                              .statusToRemont(
                                                                  getJsonField(
                                                            storehouseItem,
                                                            r'''$.status''',
                                                          ).toString()),
                                                          'nul',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    functions
                                                                        .colorRemontText(
                                                                            getJsonField(
                                                                      storehouseItem,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                  ),
                                                                  fontSize: 13,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Align(
                                                alignment:
                                                    AlignmentDirectional(0, 0),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            0, 0),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  10, 5, 10, 5),
                                                      child: Text(
                                                        'ТМЦ: ${valueOrDefault<String>(
                                                          getJsonField(
                                                            storehouseItem,
                                                            r'''$.quantity_items_requested''',
                                                          )?.toString(),
                                                          '-',
                                                        )}',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 13,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(SizedBox(width: 10)),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Дата заявки: ${valueOrDefault<String>(
                                                  dateTimeFormat(
                                                    "d.M.y",
                                                    functions.stringToDate(
                                                        valueOrDefault<String>(
                                                      getJsonField(
                                                        storehouseItem,
                                                        r'''$.created_at''',
                                                      )?.toString(),
                                                      '-',
                                                    )),
                                                    locale: FFLocalizations.of(
                                                            context)
                                                        .languageCode,
                                                  ),
                                                  '-',
                                                )}',
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'SFProText',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      fontSize: 14,
                                                      letterSpacing: 0.0,
                                                    ),
                                              ),
                                              if (getJsonField(
                                                    storehouseItem,
                                                    r'''$.approximate_delivery_date''',
                                                  ) !=
                                                  null)
                                                Text(
                                                  'Время доставки: ${valueOrDefault<String>(
                                                    dateTimeFormat(
                                                      "d.M.y",
                                                      functions.stringToDate(
                                                          valueOrDefault<
                                                              String>(
                                                        getJsonField(
                                                          storehouseItem,
                                                          r'''$.approximate_delivery_date''',
                                                        )?.toString(),
                                                        '-',
                                                      )),
                                                      locale:
                                                          FFLocalizations.of(
                                                                  context)
                                                              .languageCode,
                                                    ),
                                                    '-',
                                                  )}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondaryText,
                                                        fontSize: 14,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                            ],
                                          ),
                                          Divider(
                                            thickness: 0.5,
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                          ),
                                        ].divide(SizedBox(height: 10)),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                    FutureBuilder<ApiCallResponse>(
                      // Запрос КОЛИЧЕСТВА (Count)
                      future: (_model.apiRequestCompleter2 ??= Completer<
                              ApiCallResponse>()
                            ..complete(GetStoreHouseCountCall.call(
                              token: currentAuthenticationToken,
                              work: FFAppState().workspace,
                              search: _model.textField12TextController.text !=
                                          null &&
                                      _model.textField12TextController.text !=
                                          ''
                                  ? '&title=${_model.textField12TextController.text}'
                                  : '',
                              equipment: _model.dropDownColumnValue != null &&
                                      _model.dropDownColumnValue != ''
                                  ? '&equipment_id=${_model.dropDownColumnValue}'
                                  : '',
                              page: _model.page,
                            )))
                          .future,
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primaryText,
                                ),
                              ),
                            ),
                          );
                        }
                        final conditionalBuilderGetStoreHouseResponse =
                            snapshot.data!;

                        return Builder(
                          builder: (context) {
                            // ИСПРАВЛЕНИЕ: Безопасное получение Count без краша
                            int totalCount = functions.stringtoint(
                                getJsonField(
                                        conditionalBuilderGetStoreHouseResponse
                                            .jsonBody,
                                        r'''$.count''')
                                    .toString());

                            return Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  10, 10, 10, 15),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () async {
                                      if (_model.page <= 1) {
                                        return;
                                      }

                                      _model.page = _model.page + -1;
                                      safeSetState(() {});
                                      safeSetState(() =>
                                          _model.apiRequestCompleter1 = null);
                                      await _model.waitForApiRequestCompleted1(
                                          minWait: 500);
                                    },
                                    text: 'Назад',
                                    icon: Icon(
                                      Icons.chevron_left,
                                      size: 15,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      iconColor: FlutterFlowTheme.of(context)
                                          .primary,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Text(
                                    '${_model.page.toString()} из ${functions.divideUntilLessThanThousand(totalCount).toString()}',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          fontSize: 16,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  FFButtonWidget(
                                    onPressed: () async {
                                      _model.page = _model.page + 1;
                                      safeSetState(() {});
                                      safeSetState(() =>
                                          _model.apiRequestCompleter1 = null);
                                      await _model.waitForApiRequestCompleted1(
                                          minWait: 500);
                                    },
                                    text: 'Вперед',
                                    icon: Icon(
                                      Icons.chevron_right,
                                      size: 15,
                                    ),
                                    options: FFButtonOptions(
                                      height: 40,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 0, 16, 0),
                                      iconAlignment: IconAlignment.end,
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0, 0, 0, 0),
                                      iconColor: FlutterFlowTheme.of(context)
                                          .primary,
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'SFProText',
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.normal,
                                          ),
                                      elevation: 0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}