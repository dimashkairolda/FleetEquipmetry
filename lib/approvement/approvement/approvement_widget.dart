import 'package:Equipmetry/approvement/approvement_detailed/approvement_detailed_widget.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/bottom_nav_primary_tab_scope.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'dart:async';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'approvement_model.dart';
export 'approvement_model.dart';

class ApprovementWidget extends StatefulWidget {
  const ApprovementWidget({super.key});

  static String routeName = 'Approvement';
  static String routePath = '/approvement';

  @override
  State<ApprovementWidget> createState() => _ApprovementWidgetState();
}

class _ApprovementWidgetState extends State<ApprovementWidget> {
  late ApprovementModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ApprovementModel());

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
      future: (_model.apiRequestCompleter2 ??= Completer<ApiCallResponse>()
            ..complete(GetAppromentCall.call(
              access: currentAuthenticationToken,
              search: _model.textField12TextController.text != null &&
                      _model.textField12TextController.text != ''
                  ? '&title=${_model.textField12TextController.text}'
                  : '',
              page: _model.page.toString(),
              work: FFAppState().workspace,
              period:
                  (FFAppState().dateot != null) && (FFAppState().datedo != null)
                      ? '&period_from=${dateTimeFormat(
                          "y-MM-dd",
                          FFAppState().dateot,
                          locale: FFLocalizations.of(context).languageCode,
                        )}&period_till=${dateTimeFormat(
                          "y-MM-dd",
                          FFAppState().datedo,
                          locale: FFLocalizations.of(context).languageCode,
                        )}'
                      : '',
            )))
          .future,
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            body: Center(
              child: SizedBox(
                width: 50,
                height: 50,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primaryText,
                  ),
                ),
              ),
            ),
          );
        }
        final approvementGetNaryadsResponse = snapshot.data!;

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
              leading: BottomNavPrimaryTabScope.isPrimaryTabOf(context)
                  ? null
                  : InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(ProfilePageWidget.routeName);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 24,
                      ),
                    ),
              title: Text(
                'Журнал согласований',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'SFProText',
                      fontSize: 18,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 5, 0),
                  child: FlutterFlowIconButton(
                    borderRadius: 20,
                    buttonSize: 40,
                    icon: Icon(
                      Icons.replay,
                      color: FlutterFlowTheme.of(context).info,
                      size: 24,
                    ),
                    onPressed: () async {
                      safeSetState(() => _model.apiRequestCompleter2 = null);
                      await _model.waitForApiRequestCompleted2();
                    },
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0,
            ),
            body: SafeArea(
              top: true,
              child: Builder(
                builder: (context) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height * 0.12,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    11, 5, 11, 5),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondary,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8, 0, 8, 0),
                                          child: TextFormField(
                                            controller: _model
                                                .textField12TextController,
                                            focusNode:
                                                _model.textField12FocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.textField12TextController',
                                              Duration(milliseconds: 2000),
                                              () async {
                                                safeSetState(() => _model
                                                        .apiRequestCompleter2 =
                                                    null);
                                                await _model
                                                    .waitForApiRequestCompleted2();
                                                safeSetState(() => _model
                                                        .apiRequestCompleter1 =
                                                    null);
                                                await _model
                                                    .waitForApiRequestCompleted1();
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
                                                        color:
                                                            Color(0xFF99A2AD),
                                                        fontSize: 15,
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'Поиск',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            Color(0xFF99A2AD),
                                                        fontSize: 15,
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                              contentPadding:
                                                  EdgeInsetsDirectional
                                                      .fromSTEB(0, 12, 0, 0),
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
                                                                .apiRequestCompleter2 =
                                                            null);
                                                        await _model
                                                            .waitForApiRequestCompleted2();
                                                        safeSetState(() => _model
                                                                .apiRequestCompleter1 =
                                                            null);
                                                        await _model
                                                            .waitForApiRequestCompleted1();
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.clear,
                                                        color:
                                                            Color(0xFF99A2AD),
                                                        size: 15,
                                                      ),
                                                    )
                                                  : null,
                                            ),
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
                              Expanded(
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Builder(
                                        builder: (context) {
                                          if (FFAppState().dateot != null) {
                                            return FlutterFlowIconButton(
                                              borderColor: Colors.transparent,
                                              borderRadius: 20,
                                              borderWidth: 1,
                                              buttonSize:
                                                  MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.1,
                                              icon: Icon(
                                                Icons.close,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                                size: 24,
                                              ),
                                              onPressed: () async {
                                                FFAppState().dateot = null;
                                                FFAppState().datedo = null;
                                                safeSetState(() {});
                                                safeSetState(() => _model
                                                        .apiRequestCompleter2 =
                                                    null);
                                                await _model
                                                    .waitForApiRequestCompleted2();
                                                safeSetState(() => _model
                                                        .apiRequestCompleter1 =
                                                    null);
                                                await _model
                                                    .waitForApiRequestCompleted1();
                                              },
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
                                      ),
                                      InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          await actions
                                              .showDateRangePickerDialog(
                                            context,
                                          );
                                          safeSetState(() => _model
                                              .apiRequestCompleter2 = null);
                                          await _model
                                              .waitForApiRequestCompleted2();
                                          safeSetState(() => _model
                                              .apiRequestCompleter1 = null);
                                          await _model
                                              .waitForApiRequestCompleted1();
                                        },
                                        child: Container(
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.04,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .warning,
                                              width: 1,
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    12, 0, 12, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  color: Color(0xFF8291B0),
                                                  size: 20,
                                                ),
                                                Align(
                                                  alignment:
                                                      AlignmentDirectional(
                                                          -1, 0),
                                                  child: Text(
                                                    (FFAppState().dateot !=
                                                                null) &&
                                                            (FFAppState()
                                                                    .datedo !=
                                                                null)
                                                        ? '${dateTimeFormat(
                                                            "dd.MM.y",
                                                            FFAppState().dateot,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )} - ${dateTimeFormat(
                                                            "dd.MM.y",
                                                            FFAppState().datedo,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          )}'
                                                        : dateTimeFormat(
                                                            "dd.MM.y",
                                                            getCurrentTimestamp,
                                                            locale: FFLocalizations
                                                                    .of(context)
                                                                .languageCode,
                                                          ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .readexPro(
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
                                                  ),
                                                ),
                                              ].divide(SizedBox(width: 5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(width: 10))
                                        .addToStart(SizedBox(width: 5))
                                        .addToEnd(SizedBox(width: 10)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          primary: false,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Builder(
                                builder: (context) {
                                  if (approvementGetNaryadsResponse.succeeded) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Builder(
                                            builder: (context) {
                                              final defects =
                                                  approvementGetNaryadsResponse
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
                                                            0, 0),
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
                                                        await context.pushNamed(
                                                          ApprovementDetailedWidget
                                                              .routeName,
                                                          queryParameters: {
                                                            'id':
                                                                serializeParam(
                                                              getJsonField(
                                                                      defectsItem,
                                                                      r'''$.id''')
                                                                  .toString(),
                                                              ParamType.String,
                                                            ),
                                                          }.withoutNulls,
                                                        );

                                                        // 2. Этот код выполнится ТОЛЬКО КОГДА юзер вернется назад
                                                        // Сбрасываем completer, чтобы FutureBuilder сделал новый запрос
                                                        safeSetState(() => _model
                                                                .apiRequestCompleter2 =
                                                            null);
                                                        await _model
                                                            .waitForApiRequestCompleted2();
                                                      },
                                                      child: Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.915,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
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
                                                                      child:
                                                                          Text(
                                                                        valueOrDefault<
                                                                            String>(
                                                                          getJsonField(
                                                                            defectsItem,
                                                                            r'''$.title''',
                                                                          )?.toString(),
                                                                          '-',
                                                                        ).maybeHandleOverflow(
                                                                          maxChars:
                                                                              35,
                                                                          replacement:
                                                                              '…',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .headlineSmall
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              fontSize: 17,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.w600,
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
                                                                            MediaQuery.of(context).textScaler,
                                                                        text:
                                                                            TextSpan(
                                                                          children: [
                                                                            TextSpan(
                                                                              text: valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  defectsItem,
                                                                                  r'''$.author_info.title''',
                                                                                )?.toString(),
                                                                                '-',
                                                                              ),
                                                                              style: FlutterFlowTheme.of(context).headlineSmall.override(
                                                                                    fontFamily: 'SFProText',
                                                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                                                    fontSize: 15,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.normal,
                                                                                  ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: ' · ',
                                                                              style: TextStyle(
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                              ),
                                                                            ),
                                                                            TextSpan(
                                                                              text: valueOrDefault<String>(
                                                                                getJsonField(
                                                                                  defectsItem,
                                                                                  r'''$.budget''',
                                                                                )?.toString(),
                                                                                '-',
                                                                              ),
                                                                              style: TextStyle(),
                                                                            )
                                                                          ],
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .headlineSmall
                                                                              .override(
                                                                                fontFamily: 'SFProText',
                                                                                color: FlutterFlowTheme.of(context).secondaryText,
                                                                                fontSize: 15,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ].divide(
                                                                      SizedBox(
                                                                          height:
                                                                              5)),
                                                                ),
                                                              ].divide(SizedBox(
                                                                  width: 5)),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0,
                                                                          0,
                                                                          0,
                                                                          5),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.3,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: functions
                                                                          .approvalBGcolor(
                                                                              getJsonField(
                                                                        defectsItem,
                                                                        r'''$.status''',
                                                                      ).toString()),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              4),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding: EdgeInsetsDirectional
                                                                          .fromSTEB(
                                                                              0,
                                                                              5,
                                                                              0,
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            decoration:
                                                                                BoxDecoration(),
                                                                            child:
                                                                                Align(
                                                                              alignment: AlignmentDirectional(0, 0),
                                                                              child: Padding(
                                                                                padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                                                                                child: Text(
                                                                                  valueOrDefault<String>(
                                                                                    functions.approvalStatus(getJsonField(
                                                                                      defectsItem,
                                                                                      r'''$.status''',
                                                                                    ).toString()),
                                                                                    '-',
                                                                                  ),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'SFProText',
                                                                                        color: functions.approvalTEXTcolor(getJsonField(
                                                                                          defectsItem,
                                                                                          r'''$.status''',
                                                                                        ).toString()),
                                                                                        fontSize: 12,
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
                                                                ]
                                                                    .divide(SizedBox(
                                                                        height:
                                                                            5))
                                                                    .addToStart(
                                                                        SizedBox(
                                                                            height:
                                                                                5)),
                                                              ),
                                                            ),
                                                            // Generated code for this Row Widget...

                                                            if (defectsItem !=
                                                                functions
                                                                    .jsonToList(
                                                                        approvementGetNaryadsResponse
                                                                            .jsonBody)
                                                                    .lastOrNull)
                                                              Divider(
                                                                thickness: 2,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                })
                                                    .addToStart(
                                                        SizedBox(height: 15))
                                                    .addToEnd(
                                                        SizedBox(height: 10)),
                                              );
                                            },
                                          ),
                                        ),
                                        FutureBuilder<ApiCallResponse>(
                                          future: (_model
                                                      .apiRequestCompleter1 ??=
                                                  Completer<ApiCallResponse>()
                                                    ..complete(
                                                        GetAppromentCountCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      page: _model.page
                                                          .toString(),
                                                      work: FFAppState()
                                                          .workspace,
                                                      search: _model.textField12TextController
                                                                      .text !=
                                                                  null &&
                                                              _model.textField12TextController
                                                                      .text !=
                                                                  ''
                                                          ? '&title=${_model.textField12TextController.text}'
                                                          : '',
                                                      period: (FFAppState()
                                                                      .dateot !=
                                                                  null) &&
                                                              (FFAppState()
                                                                      .datedo !=
                                                                  null)
                                                          ? '&period_from=${dateTimeFormat(
                                                              "y-MM-dd",
                                                              FFAppState()
                                                                  .dateot,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )}&period_till=${dateTimeFormat(
                                                              "y-MM-dd",
                                                              FFAppState()
                                                                  .datedo,
                                                              locale: FFLocalizations
                                                                      .of(context)
                                                                  .languageCode,
                                                            )}'
                                                          : '',
                                                    )))
                                              .future,
                                          builder: (context, snapshot) {
                                            // Customize what your widget looks like when it's loading.
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: SizedBox(
                                                  width: 50,
                                                  height: 50,
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
                                            final conditionalBuilderGetDefectsAPIResponse =
                                                snapshot.data!;

                                            return Builder(
                                              builder: (context) {
                                                if (functions
                                                        .jsonToList(
                                                            approvementGetNaryadsResponse
                                                                .jsonBody)
                                                        .length <
                                                    10) {
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                    ),
                                                  );
                                                } else {
                                                  return Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10, 10, 10, 15),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            if (_model.page <=
                                                                1) {
                                                              return;
                                                            }

                                                            _model.page =
                                                                _model.page +
                                                                    -1;
                                                            safeSetState(() {});
                                                            safeSetState(() =>
                                                                _model.apiRequestCompleter2 =
                                                                    null);
                                                            await _model
                                                                .waitForApiRequestCompleted2();
                                                            safeSetState(() =>
                                                                _model.apiRequestCompleter1 =
                                                                    null);
                                                            await _model
                                                                .waitForApiRequestCompleted1(
                                                                    minWait:
                                                                        500);
                                                          },
                                                          text: 'Назад',
                                                          icon: Icon(
                                                            Icons.chevron_left,
                                                            size: 15,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 40,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            iconColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                            elevation: 0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        Text(
                                                          '${_model.page.toString()} из ${functions.divideUntilLessThanThousand(functions.stringtoint(getJsonField(
                                                                conditionalBuilderGetDefectsAPIResponse
                                                                    .jsonBody,
                                                                r'''$.count''',
                                                              ).toString())).toString()}',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                fontSize: 16,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                        ),
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            _model.page =
                                                                _model.page + 1;
                                                            safeSetState(() {});
                                                            safeSetState(() =>
                                                                _model.apiRequestCompleter2 =
                                                                    null);
                                                            await _model
                                                                .waitForApiRequestCompleted2();
                                                            safeSetState(() =>
                                                                _model.apiRequestCompleter1 =
                                                                    null);
                                                            await _model
                                                                .waitForApiRequestCompleted1(
                                                                    minWait:
                                                                        500);
                                                          },
                                                          text: 'Вперед',
                                                          icon: Icon(
                                                            Icons.chevron_right,
                                                            size: 15,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            height: 40,
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16,
                                                                        0,
                                                                        16,
                                                                        0),
                                                            iconAlignment:
                                                                IconAlignment
                                                                    .end,
                                                            iconPadding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            iconColor:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                            elevation: 0,
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Container(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.9,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Align(
                                        alignment: AlignmentDirectional(0, 0),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 5, 0, 5),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.915,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .accent4,
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
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
                                                            color: Color(
                                                                0xFFC6C9CF),
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
                                                                            10),
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
                                                                            10),
                                                              ),
                                                            ),
                                                          ].divide(SizedBox(
                                                              height: 5)),
                                                        ),
                                                        Icon(
                                                          Icons.more_vert,
                                                          color:
                                                              Color(0xFF8291B0),
                                                          size: 24,
                                                        ),
                                                      ].divide(
                                                          SizedBox(width: 5)),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 5),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.838,
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
                                                                          10),
                                                            ),
                                                          ),
                                                        ]
                                                            .divide(SizedBox(
                                                                height: 5))
                                                            .addToStart(
                                                                SizedBox(
                                                                    height: 5)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 2,
                                                      color:
                                                          FlutterFlowTheme.of(
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
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
