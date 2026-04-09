import 'package:Equipmetry/main.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/bottom_nav_primary_tab_scope.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'defects_model.dart';
export 'defects_model.dart';

class DefectsWidget extends StatefulWidget {
  const DefectsWidget({super.key});

  static String routeName = 'Defects';
  static String routePath = '/defects';

  @override
  State<DefectsWidget> createState() => _DefectsWidgetState();
}

class _DefectsWidgetState extends State<DefectsWidget> {
  late DefectsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DefectsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.authResponse2 = await AuthCall.call(
        username: FFAppState().rememberEmail,
        password: FFAppState().rememberPassword,
      );

      GoRouter.of(context).prepareAuthEvent();
      await authManager.signIn(
        authenticationToken: AuthCall.accesstoken(
          (_model.authResponse2?.jsonBody ?? ''),
        ),
      );
    });

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

    return FutureBuilder<ApiCallResponse>(
      future: (_model.apiRequestCompleter ??= Completer<ApiCallResponse>()
            ..complete(GetDefectsAPICall.call(
              access: currentAuthenticationToken,
              search: _model.textField12TextController.text != ''
                  ? '&title=${functions.encodeToUrlComponent(_model.textField12TextController.text)}'
                  : '',
              column: _model.dropDownColumnValue != null &&
                      _model.dropDownColumnValue != ''
                  ? '&column_id=${_model.dropDownColumnValue}'
                  : '',
              page: _model.page.toString(),
              classifications: _model.dropDownClassficationValue != null &&
                      _model.dropDownClassficationValue != ''
                  ? '&classification_id=${_model.dropDownClassficationValue}'
                  : '',
              status: _model.dropDownStatusValue != null &&
                      _model.dropDownStatusValue != ''
                  ? '&status=${_model.dropDownStatusValue}'
                  : '',
              work: FFAppState().workspace,
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ),
          );
        }
        final defectsGetDefectsAPIResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                context.pushNamed(ChooseassetWidget.routeName);

                FFAppState().spareparts = [];
                FFAppState().todo = [];
                safeSetState(() {});
              },
              backgroundColor: FlutterFlowTheme.of(context).primary,
              elevation: 8.0,
              child: Icon(
                Icons.add,
                color: FlutterFlowTheme.of(context).info,
                size: 24.0,
              ),
            ),
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading:
                  !BottomNavPrimaryTabScope.isPrimaryTabOf(context),
              title: Text(
                'Журнал дефектов',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 5.0, 0.0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 20.0,
                    borderWidth: 1.0,
                    buttonSize: 40.0,
                    icon: Icon(
                      Icons.replay,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      safeSetState(() => _model.apiRequestCompleter = null);
                      await _model.waitForApiRequestCompleted();
                    },
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  if (functions
                          .getAclValue(FFAppState().result,
                              '/api/v1/workspace/defects/preview')
                          .toString() !=
                      '111') {
                    return Stack(
                      children: [
                        ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.12,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0),
                                    topLeft: Radius.circular(0.0),
                                    topRight: Radius.circular(0.0),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          11.0, 5.0, 11.0, 5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10.0),
                                              ),
                                              child: // Generated code for this TextField12 Widget...
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
  child: TextFormField(
    controller: _model.textField12TextController,
    focusNode: _model.textField12FocusNode,
    onChanged: (_) => EasyDebounce.debounce(
      '_model.textField12TextController',
      Duration(milliseconds: 0),
      () async {
        safeSetState(() => _model.apiRequestCompleter = null);
        await _model.waitForApiRequestCompleted();
      },
    ),
    autofocus: false,
    textInputAction: TextInputAction.search,
    obscureText: false,
    decoration: InputDecoration(
      labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
            fontFamily: 'SFProText',
            color: Color(0xFF99A2AD),
            fontSize: 15,
            letterSpacing: 0.0,
          ),
      hintText: 'Поиск',
      hintStyle: FlutterFlowTheme.of(context).labelMedium.override(
            fontFamily: 'SFProText',
            color: Color(0xFF99A2AD),
            fontSize: 15,
            letterSpacing: 0.0,
          ),
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
      errorBorder: InputBorder.none,
      focusedErrorBorder: InputBorder.none,
      contentPadding: EdgeInsets.all(12),
      prefixIcon: Icon(
        Icons.search_rounded,
        color: Color(0xFF99A2AD),
      ),
      suffixIcon: _model.textField12TextController!.text.isNotEmpty
          ? InkWell(
              onTap: () async {
                _model.textField12TextController?.clear();
                safeSetState(() => _model.apiRequestCompleter = null);
                await _model.waitForApiRequestCompleted();
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
    style: FlutterFlowTheme.of(context).bodyMedium.override(
          fontFamily: 'SFProText',
          letterSpacing: 0.0,
        ),
    maxLines: null,
    validator: _model.textField12TextControllerValidator.asValidator(context),
  ),
)
,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: _model.rowController,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Builder(
                                              builder: (context) {
                                                if ((_model.dropDownColumnValue != null && _model.dropDownColumnValue != '') ||
                                                    (_model.dropDownClassficationValue !=
                                                            null &&
                                                        _model.dropDownClassficationValue !=
                                                            '') ||
                                                    (_model.dropDownStatusValue !=
                                                            null &&
                                                        _model.dropDownStatusValue !=
                                                            '')) {
                                                  return FlutterFlowIconButton(
                                                    borderColor:
                                                        Colors.transparent,
                                                    borderRadius: 20.0,
                                                    borderWidth: 1.0,
                                                    buttonSize:
                                                        MediaQuery.sizeOf(
                                                                    context)
                                                                .width *
                                                            0.1,
                                                    icon: Icon(
                                                      Icons.close,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      size: 24.0,
                                                    ),
                                                    onPressed: () async {
                                                      safeSetState(() {
                                                        _model
                                                            .dropDownColumnValueController
                                                            ?.reset();
                                                        _model
                                                            .dropDownClassficationValueController
                                                            ?.reset();
                                                        _model
                                                            .dropDownStatusValueController
                                                            ?.reset();
                                                      });
                                                      _model.page = 10;
                                                      safeSetState(() {});
                                                    },
                                                  );
                                                } else {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            FutureBuilder<ApiCallResponse>(
                                              future: FFAppState().column(
                                                requestFn: () =>
                                                    GetColumnsCall.call(
                                                  access:
                                                      currentAuthenticationToken,
                                                  work: FFAppState().workspace,
                                                ),
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final conditionalBuilderGetColumnsResponse =
                                                    snapshot.data!;

                                                return Builder(
                                                  builder: (context) {
                                                    if (functions
                                                            .jsonToList(
                                                                getJsonField(
                                                              conditionalBuilderGetColumnsResponse
                                                                  .jsonBody,
                                                              r'''$''',
                                                            ))
                                                            .length !=
                                                        0) {
                                                      return // Generated code for this DropDownColumn Widget...
FlutterFlowDropDown<String>(
  controller: _model.dropDownColumnValueController ??=
      FormFieldController<String>(
    _model.dropDownColumnValue ??= '',
  ),
  options: List<String>.from((getJsonField(
    conditionalBuilderGetColumnsResponse.jsonBody,
    r'''$[:].id''',
    true,
  ) as List?)!
      .map<String>((e) => e.toString())
      .toList()
      .cast<String>()),
  optionLabels: (getJsonField(
    conditionalBuilderGetColumnsResponse.jsonBody,
    r'''$[:].title''',
    true,
  ) as List?)!
      .map<String>((e) => e.toString())
      .toList()
      .cast<String>(),
  onChanged: (val) async {
    safeSetState(() => _model.dropDownColumnValue = val);
    safeSetState(() => _model.apiRequestCompleter = null);
    await _model.waitForApiRequestCompleted();
  },
  width: MediaQuery.sizeOf(context).width * 0.4,
  height: MediaQuery.sizeOf(context).height * 0.04,
  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
        font: GoogleFonts.readexPro(
          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
        ),
        letterSpacing: 0.0,
        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
      ),
  hintText: 'Колонна',
  icon: Icon(
    Icons.keyboard_arrow_down_rounded,
    color: FlutterFlowTheme.of(context).secondaryText,
    size: 24,
  ),
  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
  elevation: 2,
  borderColor: FlutterFlowTheme.of(context).warning,
  borderWidth: 1,
  borderRadius: 8,
  margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
  hidesUnderline: true,
  isOverButton: false,
  isSearchable: false,
  isMultiSelect: false,
)
;
                                                    } else {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            FutureBuilder<ApiCallResponse>(
                                              future:
                                                  GetClassificationsCall.call(
                                                access:
                                                    currentAuthenticationToken,
                                                work: FFAppState().workspace,
                                              ),
                                              builder: (context, snapshot) {
                                                // Customize what your widget looks like when it's loading.
                                                if (!snapshot.hasData) {
                                                  return Center(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                Color>(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                }
                                                final conditionalBuilderGetClassificationsResponse =
                                                    snapshot.data!;

                                                return Builder(
                                                  builder: (context) {
                                                    if (functions
                                                            .jsonToList(
                                                                getJsonField(
                                                              conditionalBuilderGetClassificationsResponse
                                                                  .jsonBody,
                                                              r'''$''',
                                                            ))
                                                            .length !=
                                                        0) {
                                                      return // Generated code for this DropDownClassfication Widget...
FlutterFlowDropDown<String>(
  controller: _model.dropDownClassficationValueController ??=
      FormFieldController<String>(
    _model.dropDownClassficationValue ??= '',
  ),
  options: List<String>.from((getJsonField(
    conditionalBuilderGetClassificationsResponse.jsonBody,
    r'''$[:].id''',
    true,
  ) as List?)!
      .map<String>((e) => e.toString())
      .toList()
      .cast<String>()),
  optionLabels: (getJsonField(
    conditionalBuilderGetClassificationsResponse.jsonBody,
    r'''$[:].name''',
    true,
  ) as List?)!
      .map<String>((e) => e.toString())
      .toList()
      .cast<String>(),
  onChanged: (val) async {
    safeSetState(() => _model.dropDownClassficationValue = val);
    safeSetState(() => _model.apiRequestCompleter = null);
    await _model.waitForApiRequestCompleted();
  },
  width: MediaQuery.sizeOf(context).width * 0.4,
  height: MediaQuery.sizeOf(context).height * 0.04,
  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
        font: GoogleFonts.readexPro(
          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
        ),
        letterSpacing: 0.0,
        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
      ),
  hintText: 'Категория',
  icon: Icon(
    Icons.keyboard_arrow_down_rounded,
    color: FlutterFlowTheme.of(context).secondaryText,
    size: 24,
  ),
  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
  elevation: 2,
  borderColor: FlutterFlowTheme.of(context).warning,
  borderWidth: 1,
  borderRadius: 8,
  margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
  hidesUnderline: true,
  isOverButton: false,
  isSearchable: false,
  isMultiSelect: false,
);
                                                    } else {
                                                      return Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              },
                                            ),
                                            // Generated code for this DropDownStatus Widget...
FlutterFlowDropDown<String>(
  controller: _model.dropDownStatusValueController ??=
      FormFieldController<String>(
    _model.dropDownStatusValue ??= '',
  ),
  options: List<String>.from(['NEW', 'ON_REPAIR', 'APPROVED']),
  optionLabels: ['Не исправен', 'Акт сформирован', 'Исправен'],
  onChanged: (val) async {
    safeSetState(() => _model.dropDownStatusValue = val);
    safeSetState(() => _model.apiRequestCompleter = null);
    await _model.waitForApiRequestCompleted();
  },
  width: MediaQuery.sizeOf(context).width * 0.4,
  height: MediaQuery.sizeOf(context).height * 0.04,
  textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
        font: GoogleFonts.readexPro(
          fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
          fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
        ),
        letterSpacing: 0.0,
        fontWeight: FlutterFlowTheme.of(context).bodyMedium.fontWeight,
        fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
      ),
  hintText: 'Статус',
  icon: Icon(
    Icons.keyboard_arrow_down_rounded,
    color: FlutterFlowTheme.of(context).secondaryText,
    size: 24,
  ),
  fillColor: FlutterFlowTheme.of(context).secondaryBackground,
  elevation: 2,
  borderColor: FlutterFlowTheme.of(context).warning,
  borderWidth: 1,
  borderRadius: 8,
  margin: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
  hidesUnderline: true,
  isOverButton: false,
  isSearchable: false,
  isMultiSelect: false,
)
,
                                          ]
                                              .divide(SizedBox(width: 10.0))
                                              .addToStart(SizedBox(width: 5.0))
                                              .addToEnd(SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Builder(
                              builder: (context) {
                                if (!defectsGetDefectsAPIResponse.succeeded) {
                                  return Container(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.9,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Align(
                                      alignment: AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 5.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.915,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              Color(0xFFC6C9CF),
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.7,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.5,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.02,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFFC6C9CF),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                          ),
                                                        ].divide(SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                      Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            Color(0xFF8291B0),
                                                        size: 24.0,
                                                      ),
                                                    ].divide(
                                                        SizedBox(width: 5.0)),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 5.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.838,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.02,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xFFC6C9CF),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                          ),
                                                        ),
                                                      ]
                                                          .divide(SizedBox(
                                                              height: 5.0))
                                                          .addToStart(SizedBox(
                                                              height: 5.0)),
                                                    ),
                                                  ),
                                                  Divider(
                                                    thickness: 2.0,
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent4,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Builder(
                                          builder: (context) {
                                            final defects =
                                                defectsGetDefectsAPIResponse
                                                    .jsonBody
                                                    .toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                      defects.length,
                                                      (defectsIndex) {
                                                final defectsItem =
                                                    defects[defectsIndex];
                                                return Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          0.0, 0.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        DetailedDefectsOfflineCopyWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'id': serializeParam(
                                                            getJsonField(
                                                              defectsItem,
                                                              r'''$.id''',
                                                            ).toString(),
                                                            ParamType.String,
                                                          ),
                                                          'storehousestatus':
                                                              serializeParam(
                                                            functions
                                                                        .listlength(
                                                                            getJsonField(
                                                                          defectsItem,
                                                                          r'''$.storehouse_order_statuses''',
                                                                          true,
                                                                        ))
                                                                        .toString() ==
                                                                    '0'
                                                                ? 'nul'
                                                                : valueOrDefault<
                                                                    String>(
                                                                    functions
                                                                        .jsonToList(
                                                                            getJsonField(
                                                                          defectsItem,
                                                                          r'''$.storehouse_order_statuses''',
                                                                        ))
                                                                        .lastOrNull
                                                                        ?.toString(),
                                                                    'n',
                                                                  ),
                                                            ParamType.String,
                                                          ),
                                                        }.withoutNulls,
                                                      );

                                                      MyApp.analytics.logEvent(
    name: 'tab_navigation',
    parameters: {'tab_name': DetailedDefectsOfflineCopyWidget.routeName},
  );
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.915,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Container(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.12,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.12,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child:
                                                                    Image.asset(
                                                                  'assets/images/Defect.png',
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                              Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.7,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child: Text(
                                                                      getJsonField(
                                                                        defectsItem,
                                                                        r'''$.title''',
                                                                      )
                                                                          .toString()
                                                                          .maybeHandleOverflow(
                                                                            maxChars:
                                                                                35,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .headlineSmall
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                17.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.7,
                                                                    decoration:
                                                                        BoxDecoration(),
                                                                    child:
                                                                        RichText(
                                                                      textScaler:
                                                                          MediaQuery.of(context)
                                                                              .textScaler,
                                                                      text:
                                                                          TextSpan(
                                                                        children: [
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              defectsItem,
                                                                              r'''$.equipment''',
                                                                            ).toString(),
                                                                            style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                  fontFamily: 'SFProText',
                                                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                                                  fontSize: 15.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                ' · ',
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                            ),
                                                                          ),
                                                                          TextSpan(
                                                                            text:
                                                                                getJsonField(
                                                                              defectsItem,
                                                                              r'''$.license_plate_number''',
                                                                            ).toString(),
                                                                            style:
                                                                                TextStyle(
                                                                              fontFamily: 'SFProText',
                                                                            ),
                                                                          )
                                                                        ],
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 15.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ].divide(SizedBox(
                                                                    height:
                                                                        5.0)),
                                                              ),
                                                             
                                                             
                                                            ].divide(SizedBox(
                                                                width: 5.0)),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.3,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: functions
                                                                        .colorDefectCopy(
                                                                            getJsonField(
                                                                      defectsItem,
                                                                      r'''$.status''',
                                                                    ).toString()),
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            4.0),
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        Container(
                                                                          width:
                                                                              MediaQuery.sizeOf(context).width * 0.25,
                                                                          decoration:
                                                                              BoxDecoration(),
                                                                          child:
                                                                              Align(
                                                                            alignment:
                                                                                AlignmentDirectional(0.0, 0.0),
                                                                            child:
                                                                                Padding(
                                                                              padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                              child: Text(
                                                                                valueOrDefault<String>(
                                                                                  functions.statusToRus(getJsonField(
                                                                                    defectsItem,
                                                                                    r'''$.status''',
                                                                                  ).toString()),
                                                                                  '-',
                                                                                ),
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'SFProText',
                                                                                      color: functions.colorDefectCopyCopy(getJsonField(
                                                                                        defectsItem,
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
                                                                Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .calendar_today_outlined,
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryText,
                                                                      size:
                                                                          20.0,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        dateTimeFormat(
                                                                          "MMMMEEEEd",
                                                                          functions
                                                                              .stringToDate(getJsonField(
                                                                            defectsItem,
                                                                            r'''$.created_at''',
                                                                          ).toString()),
                                                                          locale:
                                                                              FFLocalizations.of(context).languageCode,
                                                                        ).maybeHandleOverflow(
                                                                          maxChars:
                                                                              50,
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.start,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: FlutterFlowTheme.of(context).secondaryText,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                            ),
                                                                      ),
                                                                    ),
                                                                  ].divide(SizedBox(
                                                                      width:
                                                                          5.0)),
                                                                ),
                                                              ]
                                                                  .divide(SizedBox(
                                                                      height:
                                                                          5.0))
                                                                  .addToStart(
                                                                      SizedBox(
                                                                          height:
                                                                              5.0)),
                                                            ),
                                                          ),
                                                          if (defectsItem !=
                                                              functions
                                                                  .jsonToList(
                                                                      defectsGetDefectsAPIResponse
                                                                          .jsonBody)
                                                                  .lastOrNull)
                                                            Divider(
                                                              thickness: 2.0,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .accent4,
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              })
                                                  .addToStart(
                                                      SizedBox(height: 15.0))
                                                  .addToEnd(
                                                      SizedBox(height: 10.0)),
                                            );
                                          },
                                        ),
                                      ),
                                      Builder(
                                        builder: (context) {
                                          final saveddefects = FFAppState()
                                              .saveddefects
                                              .toList();

                                          return Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                saveddefects.length,
                                                (saveddefectsIndex) {
                                              final saveddefectsItem =
                                                  saveddefects[
                                                      saveddefectsIndex];
                                              return Align(
                                                alignment: AlignmentDirectional(
                                                    0.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 5.0),
                                                  child: InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      context.pushNamed(
                                                        SaveddefectsWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'equipID':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .equipmentId,
                                                            ParamType.String,
                                                          ),
                                                          'title':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .title,
                                                            ParamType.String,
                                                          ),
                                                          'description':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .description,
                                                            ParamType.String,
                                                          ),
                                                          'equiptitle':
                                                              serializeParam(
                                                            '${getJsonField(
                                                              functions.findJsonByIDCopy(
                                                                  saveddefectsItem
                                                                      .equipmentId,
                                                                  FFAppState()
                                                                      .Equiptree
                                                                      .toList()),
                                                              r'''$.brand_id.name''',
                                                            ).toString()} ${getJsonField(
                                                              functions.findJsonByIDCopy(
                                                                  saveddefectsItem
                                                                      .equipmentId,
                                                                  FFAppState()
                                                                      .Equiptree
                                                                      .toList()),
                                                              r'''$.model_id.name''',
                                                            ).toString()}',
                                                            ParamType.String,
                                                          ),
                                                          'mileage':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .mileage
                                                                .toString(),
                                                            ParamType.String,
                                                          ),
                                                          'category':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .categoryId,
                                                            ParamType.String,
                                                          ),
                                                          'author':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .userId,
                                                            ParamType.String,
                                                          ),
                                                          'motohours':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .motoHours
                                                                .toString(),
                                                            ParamType.String,
                                                          ),
                                                          'date':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .date,
                                                            ParamType.String,
                                                          ),
                                                          'todo':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .todo,
                                                            ParamType
                                                                .DataStruct,
                                                            isList: true,
                                                          ),
                                                          'tmc': serializeParam(
                                                            saveddefectsItem
                                                                .spareParts,
                                                            ParamType
                                                                .DataStruct,
                                                            isList: true,
                                                          ),
                                                          'photos':
                                                              serializeParam(
                                                            saveddefectsItem
                                                                .media,
                                                            ParamType.String,
                                                            isList: true,
                                                          ),
                                                          'status':
                                                              serializeParam(
                                                            'waiting',
                                                            ParamType.String,
                                                          ),
                                                          'index':
                                                              serializeParam(
                                                            saveddefectsIndex,
                                                            ParamType.int,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.941,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        15.0,
                                                                        17.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Expanded(
                                                                  child:
                                                                      Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            4.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                    child: Text(
                                                                      dateTimeFormat(
                                                                        "MMMMEEEEd",
                                                                        functions
                                                                            .stringToDate(saveddefectsItem.date),
                                                                        locale:
                                                                            FFLocalizations.of(context).languageCode,
                                                                      ).maybeHandleOverflow(
                                                                        maxChars:
                                                                            50,
                                                                      ),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .end,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).secondaryText,
                                                                            fontSize:
                                                                                12.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        11.0,
                                                                        0.0,
                                                                        11.0,
                                                                        0.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.12,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.12,
                                                                  clipBehavior:
                                                                      Clip.antiAlias,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child: Image
                                                                      .asset(
                                                                    'assets/images/logo.png',
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                                Column(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.75,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Text(
                                                                          saveddefectsItem
                                                                              .title
                                                                              .maybeHandleOverflow(
                                                                            maxChars:
                                                                                35,
                                                                            replacement:
                                                                                '…',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                fontSize: 17.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          2.0,
                                                                          0.0,
                                                                          3.0),
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.75,
                                                                        decoration:
                                                                            BoxDecoration(),
                                                                        child:
                                                                            Text(
                                                                          '${getJsonField(
                                                                            functions.findJsonByIDCopy(saveddefectsItem.equipmentId,
                                                                                FFAppState().Equiptree.toList()),
                                                                            r'''$.brand_id.name''',
                                                                          ).toString()} ${getJsonField(
                                                                            functions.findJsonByIDCopy(saveddefectsItem.equipmentId,
                                                                                FFAppState().Equiptree.toList()),
                                                                            r'''$.model_id.name''',
                                                                          ).toString()}',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: Color(0xFF696D6E),
                                                                                fontSize: 15.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          10.0),
                                                                      child:
                                                                          Container(
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          color:
                                                                              Color(0xFFEFF1F3),
                                                                          borderRadius:
                                                                              BorderRadius.circular(16.0),
                                                                        ),
                                                                        child:
                                                                            Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              5.0,
                                                                              0.0,
                                                                              5.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.max,
                                                                            children: [
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 0.0, 0.0),
                                                                                child: Container(
                                                                                  width: MediaQuery.sizeOf(context).width * 0.022,
                                                                                  height: MediaQuery.sizeOf(context).width * 0.022,
                                                                                  decoration: BoxDecoration(
                                                                                    color: functions.colorDefectCopy('waiting'),
                                                                                    shape: BoxShape.circle,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                                                                                child: Text(
                                                                                  valueOrDefault<String>(
                                                                                    functions.statusToRus('waiting'),
                                                                                    '-',
                                                                                  ),
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        fontSize: 12.0,
                                                                                        letterSpacing: 0.0,
                                                                                      ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 5.0)),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }),
                                          );
                                        },
                                      ),
                                      if (functions
                                              .jsonToList(
                                                  defectsGetDefectsAPIResponse
                                                      .jsonBody)
                                              .length >=
                                          10)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  11.0, 0.0, 11.0, 15.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.page = _model.page + 10;
                                              safeSetState(() {});
                                              HapticFeedback.lightImpact();
                                              safeSetState(() => _model
                                                  .apiRequestCompleter = null);
                                              await _model
                                                  .waitForApiRequestCompleted();
                                            },
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 5.0, 0.0, 5.0),
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.4,
                                                    decoration: BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  5.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        5.0,
                                                                        0.0),
                                                            child: Text(
                                                              'Смотреть еще',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .readexPro(
                                                                      fontWeight: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontWeight,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontWeight,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .keyboard_double_arrow_down_rounded,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryText,
                                                            size: 24.0,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ],
                          controller: _model.listViewController,
                        ),
                        if (_model.page > 10)
                          Align(
                            alignment: AlignmentDirectional(-1.0, 1.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 15.0),
                              child: FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).primary,
                                borderRadius: 15.0,
                                borderWidth: 1.0,
                                buttonSize:
                                    MediaQuery.sizeOf(context).width * 0.14,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                icon: Icon(
                                  Icons.keyboard_double_arrow_up_outlined,
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                                onPressed: () async {
                                  await _model.listViewController?.animateTo(
                                    0,
                                    duration: Duration(milliseconds: 100),
                                    curve: Curves.ease,
                                  );
                                  _model.page = 10;
                                  safeSetState(() {});
                                  HapticFeedback.lightImpact();
                                },
                              ),
                            ),
                          ),
                      ],
                    );
                  } else {
                    return Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                      ),
                      child: Align(
                        alignment: AlignmentDirectional(0.0, 0.0),
                        child: Text(
                          'Модуль \"Дефекты\" недоступен',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SFProText',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
