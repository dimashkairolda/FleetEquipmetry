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
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'project_model.dart';
export 'project_model.dart';

class ProjectWidget extends StatefulWidget {
  const ProjectWidget({super.key});

  static String routeName = 'Project';
  static String routePath = '/project';

  @override
  State<ProjectWidget> createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  late ProjectModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProjectModel());

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
            ..complete(GetProjectZayavkaCall.call(
              access: currentAuthenticationToken,
              search: _model.textField12TextController.text != ''
                  ? '&page=1&limit=${_model.page.toString()}&number_sr=${_model.textField12TextController.text}'
                  : '&page=1&limit=${_model.page.toString()}',
              customer:
                  _model.customerValue != null && _model.customerValue != ''
                      ? '&customer_id=${_model.customerValue}'
                      : '',
              region: _model.regionValue != null && _model.regionValue != ''
                  ? '&sector_id=${_model.regionValue}'
                  : '',
              project:
                  _model.projectsValue != null && _model.projectsValue != ''
                      ? '&project_id=${_model.projectsValue}'
                      : '',
              payment: _model.paymentValue != null && _model.paymentValue != ''
                  ? '&payment_method_id=${_model.paymentValue}'
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
        final projectGetProjectZayavkaResponse = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
              automaticallyImplyLeading: false,
              leading: BottomNavPrimaryTabScope.isPrimaryTabOf(context)
                  ? null
                  : FlutterFlowIconButton(
                      borderRadius: 30.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.arrow_back_rounded,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                      onPressed: () async {
                        context.pushNamed(ProfilePageWidget.routeName);
                      },
                    ),
              title: Text(
                'Проектные заявки',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 18.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 5.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                11.0, 0.0, 11.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          8.0, 0.0, 8.0, 0.0),
                                      child: TextFormField(
                                        controller:
                                            _model.textField12TextController,
                                        focusNode: _model.textField12FocusNode,
                                        onChanged: (_) => EasyDebounce.debounce(
                                          '_model.textField12TextController',
                                          Duration(milliseconds: 0),
                                          () async {
                                            safeSetState(() => _model
                                                .apiRequestCompleter = null);
                                            await _model
                                                .waitForApiRequestCompleted();
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
                                                    fontSize: 15.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                          hintText: 'Поиск',
                                          hintStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'SFProText',
                                                    color: Color(0xFF99A2AD),
                                                    fontSize: 15.0,
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
                                                            .apiRequestCompleter =
                                                        null);
                                                    await _model
                                                        .waitForApiRequestCompleted();
                                                    safeSetState(() {});
                                                  },
                                                  child: Icon(
                                                    Icons.clear,
                                                    color: Color(0xFF99A2AD),
                                                    size: 15.0,
                                                  ),
                                                )
                                              : null,
                                        ),
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
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
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                11.0, 0.0, 11.0, 0.0),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  if (() {
                                    if (_model.regionValue != null &&
                                        _model.regionValue != '') {
                                      return true;
                                    } else if (_model.customerValue != null &&
                                        _model.customerValue != '') {
                                      return true;
                                    } else if (_model.projectsValue != null &&
                                        _model.projectsValue != '') {
                                      return true;
                                    } else if (_model.paymentValue != null &&
                                        _model.paymentValue != '') {
                                      return true;
                                    } else {
                                      return false;
                                    }
                                  }())
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          safeSetState(() {
                                            _model.regionValueController
                                                ?.reset();
                                            _model.customerValueController
                                                ?.reset();
                                            _model.projectsValueController
                                                ?.reset();
                                            _model.paymentValueController
                                                ?.reset();
                                          });
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        child: Icon(
                                          Icons.close_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          size: 24.0,
                                        ),
                                      ),
                                    ),
                                  FutureBuilder<ApiCallResponse>(
                                    future: GetRaportSectorsCall.call(
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final regionGetRaportSectorsResponse =
                                          snapshot.data!;

                                      return FlutterFlowDropDown<String>(
                                        controller:
                                            _model.regionValueController ??=
                                                FormFieldController<String>(
                                          _model.regionValue ??= '',
                                        ),
                                        options: List<String>.from(
                                            (getJsonField(
                                          regionGetRaportSectorsResponse
                                              .jsonBody,
                                          r'''$[:].id''',
                                          true,
                                        ) as List?)!
                                                .map<String>(
                                                    (e) => e.toString())
                                                .toList()
                                                .cast<String>()),
                                        optionLabels: (getJsonField(
                                          regionGetRaportSectorsResponse
                                              .jsonBody,
                                          r'''$[:].title''',
                                          true,
                                        ) as List?)!
                                            .map<String>((e) => e.toString())
                                            .toList()
                                            .cast<String>(),
                                        onChanged: (val) async {
                                          safeSetState(
                                              () => _model.regionValue = val);
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Регион',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      );
                                    },
                                  ),
                                  FutureBuilder<ApiCallResponse>(
                                    future: GetCustomerCall.call(
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final customerGetCustomerResponse =
                                          snapshot.data!;

                                      return FlutterFlowDropDown<String>(
                                        controller:
                                            _model.customerValueController ??=
                                                FormFieldController<String>(
                                          _model.customerValue ??= '',
                                        ),
                                        options: List<String>.from(
                                            (getJsonField(
                                          customerGetCustomerResponse.jsonBody,
                                          r'''$[:].id''',
                                          true,
                                        ) as List?)!
                                                .map<String>(
                                                    (e) => e.toString())
                                                .toList()
                                                .cast<String>()),
                                        optionLabels: (getJsonField(
                                          customerGetCustomerResponse.jsonBody,
                                          r'''$[:].title''',
                                          true,
                                        ) as List?)!
                                            .map<String>((e) => e.toString())
                                            .toList()
                                            .cast<String>(),
                                        onChanged: (val) async {
                                          safeSetState(
                                              () => _model.customerValue = val);
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.4,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Заказчик',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      );
                                    },
                                  ),
                                  FutureBuilder<ApiCallResponse>(
                                    future: GetProjectsCall.call(
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final projectsGetProjectsResponse =
                                          snapshot.data!;

                                      return FlutterFlowDropDown<String>(
                                        controller:
                                            _model.projectsValueController ??=
                                                FormFieldController<String>(
                                          _model.projectsValue ??= '',
                                        ),
                                        options: List<String>.from(
                                            (getJsonField(
                                          projectsGetProjectsResponse.jsonBody,
                                          r'''$[:].id''',
                                          true,
                                        ) as List?)!
                                                .map<String>(
                                                    (e) => e.toString())
                                                .toList()
                                                .cast<String>()),
                                        optionLabels: (getJsonField(
                                          projectsGetProjectsResponse.jsonBody,
                                          r'''$[:].title''',
                                          true,
                                        ) as List?)!
                                            .map<String>((e) => e.toString())
                                            .toList()
                                            .cast<String>(),
                                        onChanged: (val) async {
                                          safeSetState(
                                              () => _model.projectsValue = val);
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.481,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Проект',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      );
                                    },
                                  ),
                                  FutureBuilder<ApiCallResponse>(
                                    future: GetPaymentMethodCall.call(
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
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      final paymentGetPaymentMethodResponse =
                                          snapshot.data!;

                                      return FlutterFlowDropDown<String>(
                                        controller:
                                            _model.paymentValueController ??=
                                                FormFieldController<String>(
                                          _model.paymentValue ??= '',
                                        ),
                                        options: List<String>.from(
                                            (getJsonField(
                                          paymentGetPaymentMethodResponse
                                              .jsonBody,
                                          r'''$[:].id''',
                                          true,
                                        ) as List?)!
                                                .map<String>(
                                                    (e) => e.toString())
                                                .toList()
                                                .cast<String>()),
                                        optionLabels: (getJsonField(
                                          paymentGetPaymentMethodResponse
                                              .jsonBody,
                                          r'''$[:].title''',
                                          true,
                                        ) as List?)!
                                            .map<String>((e) => e.toString())
                                            .toList()
                                            .cast<String>(),
                                        onChanged: (val) async {
                                          safeSetState(
                                              () => _model.paymentValue = val);
                                          safeSetState(() => _model
                                              .apiRequestCompleter = null);
                                          await _model
                                              .waitForApiRequestCompleted();
                                        },
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.491,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.readexPro(
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              letterSpacing: 0.0,
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                        hintText: 'Форма оплаты',
                                        icon: Icon(
                                          Icons.keyboard_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                        fillColor: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        elevation: 2.0,
                                        borderColor: Colors.transparent,
                                        borderWidth: 0.0,
                                        borderRadius: 8.0,
                                        margin: EdgeInsetsDirectional.fromSTEB(
                                            12.0, 0.0, 12.0, 0.0),
                                        hidesUnderline: true,
                                        isOverButton: false,
                                        isSearchable: false,
                                        isMultiSelect: false,
                                      );
                                    },
                                  ),
                                ].divide(SizedBox(width: 5.0)),
                              ),
                            ),
                          ),
                        ].divide(SizedBox(height: 5.0)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  11.0, 10.0, 11.0, 0.0),
                              child: Builder(
                                builder: (context) {
                                  final equipTRee =
                                      projectGetProjectZayavkaResponse.jsonBody
                                          .toList();

                                  return SingleChildScrollView(
                                    primary: false,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(equipTRee.length,
                                          (equipTReeIndex) {
                                        final equipTReeItem =
                                            equipTRee[equipTReeIndex];
                                        return Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                context.pushNamed(
                                                  ProjectdetailedWidget
                                                      .routeName,
                                                  queryParameters: {
                                                    'json': serializeParam(
                                                      equipTReeItem,
                                                      ParamType.JSON,
                                                    ),
                                                  }.withoutNulls,
                                                );
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  11.0,
                                                                  11.0,
                                                                  11.0,
                                                                  11.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.8,
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
                                                                            equipTReeItem,
                                                                            r'''$.project_info.title''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' • ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            equipTReeItem,
                                                                            r'''$.number_sr''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                16.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.8,
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
                                                                              valueOrDefault<String>(
                                                                            getJsonField(
                                                                              functions
                                                                                  .jsonToList(getJsonField(
                                                                                    equipTReeItem,
                                                                                    r'''$.managers_info''',
                                                                                  ))
                                                                                  .firstOrNull,
                                                                              r'''$.title''',
                                                                            )?.toString(),
                                                                            '-',
                                                                          ),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 13.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' • ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                Color(0xFF696D6E),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            equipTReeItem,
                                                                            r'''$.sector_info.title''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' • ',
                                                                          style:
                                                                              TextStyle(),
                                                                        ),
                                                                        TextSpan(
                                                                          text: getJsonField(
                                                                                    equipTReeItem,
                                                                                    r'''$.equipments_info''',
                                                                                  ) ==
                                                                                  null
                                                                              ? '0'
                                                                              : functions
                                                                                  .jsonToList(getJsonField(
                                                                                    equipTReeItem,
                                                                                    r'''$.equipments_info''',
                                                                                  ))
                                                                                  .length
                                                                                  .toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' техник',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.8,
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
                                                                            equipTReeItem,
                                                                            r'''$.customer_info.title''',
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 13.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' • ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                Color(0xFF696D6E),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            equipTReeItem,
                                                                            r'''$.payment_method_info.title''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            10.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.8,
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
                                                                            equipTReeItem,
                                                                            r'''$.period_from''',
                                                                          ).toString(),
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .titleMedium
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).primaryText,
                                                                                fontSize: 13.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              ' - ',
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                Color(0xFF696D6E),
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                          text:
                                                                              getJsonField(
                                                                            equipTReeItem,
                                                                            r'''$.period_to''',
                                                                          ).toString(),
                                                                          style:
                                                                              TextStyle(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            fontSize:
                                                                                13.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .titleMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'SFProText',
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                13.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ].divide(SizedBox(
                                                                height: 4.0)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                11.0, 0.0, 11.0, 15.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.04,
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.page = _model.page + 10;
                                      safeSetState(() {});
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 5.0, 0.0),
                                          child: Text(
                                            'Смотреть еще',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.readexPro(
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
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryText,
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
                                          ),
                                        ),
                                        Icon(
                                          Icons
                                              .keyboard_double_arrow_down_rounded,
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          size: 24.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
