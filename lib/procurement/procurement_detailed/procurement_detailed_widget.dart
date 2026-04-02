import 'package:Equipmetry/procurement/add_price/add_price_widget.dart';
import 'package:Equipmetry/procurement/compare_offers/compare_offers_widget.dart';
import 'package:Equipmetry/procurement/manual_K_P/manual_K_P_widget.dart';
import 'package:Equipmetry/procurement/procurement/procurement_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'procurement_detailed_model.dart';
export 'procurement_detailed_model.dart';

class ProcurementDetailedWidget extends StatefulWidget {
  const ProcurementDetailedWidget({
    super.key,
    required this.id,
  });

  final String? id;

  static String routeName = 'ProcurementDetailed';
  static String routePath = '/procurementDetailed';

  @override
  State<ProcurementDetailedWidget> createState() =>
      _ProcurementDetailedWidgetState();
}

class _ProcurementDetailedWidgetState extends State<ProcurementDetailedWidget>
    with TickerProviderStateMixin {
  late ProcurementDetailedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProcurementDetailedModel());

    _model.tabBarController = TabController(
      vsync: this,
      length: 4,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

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
      future: GetProcurementDetailedCall.call(
        token: currentAuthenticationToken,
        id: widget!.id,
        work: FFAppState().workspace,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
        final procurementDetailedGetStoreHouseDetailedResponse = snapshot.data!;

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
                borderColor: Colors.transparent,
                borderRadius: 30,
                borderWidth: 1,
                buttonSize: 60,
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Color(0xFF3466E7),
                  size: 30,
                ),
                onPressed: () async {
                  context.goNamed(ProcurementWidget.routeName);
                },
              ),
              title: Text(
                'Заявка RFQ${getJsonField(
                  procurementDetailedGetStoreHouseDetailedResponse.jsonBody,
                  r'''$.short_id''',
                ).toString()}',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'SFProText',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 17,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              actions: [],
              centerTitle: false,
            ),
            body: SafeArea(
              top: true,
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.95,
                        decoration: BoxDecoration(),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment(0, 0),
                              child: FlutterFlowButtonTabBar(
                                useToggleButtonStyle: false,
                                isScrollable: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'SFProText',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                unselectedLabelStyle:
                                    FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'SFProText',
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                labelColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).primary,
                                backgroundColor: Color(0xFF2A61ED),
                                borderWidth: 2,
                                borderRadius: 8,
                                elevation: 0,
                                labelPadding: EdgeInsetsDirectional.fromSTEB(
                                    10, 0, 10, 0),
                                buttonMargin:
                                    EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                                tabs: [
                                  Tab(
                                    text: 'Сведения',
                                  ),
                                  Tab(
                                    text: 'Поставка',
                                  ),
                                  Tab(
                                    text: 'Список запчастей',
                                  ),
                                  Tab(
                                    text: 'История',
                                  ),
                                ],
                                controller: _model.tabBarController,
                                onTap: (i) async {
                                  [
                                    () async {},
                                    () async {},
                                    () async {},
                                    () async {}
                                  ][i]();
                                },
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _model.tabBarController,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          // Generated code for this Container Widget...
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    20, 10, 20, 0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(10, 0, 10, 0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 20, 0, 0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            'Заявка RFQ${getJsonField(
                                                              procurementDetailedGetStoreHouseDetailedResponse
                                                                  .jsonBody,
                                                              r'''$.short_id''',
                                                            ).toString()}',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .headlineMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                                  fontSize: 14,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    0, 0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: functions
                                                                    .coloProcumentBG(
                                                                        getJsonField(
                                                                  procurementDetailedGetStoreHouseDetailedResponse
                                                                      .jsonBody,
                                                                  r'''$.status''',
                                                                ).toString()),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                shape: BoxShape
                                                                    .rectangle,
                                                              ),
                                                              child: Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        0, 0),
                                                                child: Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          10,
                                                                          5,
                                                                          10,
                                                                          5),
                                                                  child: Text(
                                                                    valueOrDefault<
                                                                        String>(
                                                                      functions
                                                                          .procurementStatus(
                                                                              getJsonField(
                                                                        procurementDetailedGetStoreHouseDetailedResponse
                                                                            .jsonBody,
                                                                        r'''$.status''',
                                                                      ).toString()),
                                                                      '-',
                                                                    ),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyLarge
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: FlutterFlowTheme.of(context)
                                                        .alternate,
                                                    ),
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
                                                        Text(
                                                          'Название',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.5,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                procurementDetailedGetStoreHouseDetailedResponse
                                                                    .jsonBody,
                                                                r'''$.title''',
                                                              )?.toString(),
                                                              '-',
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: FlutterFlowTheme.of(context)
                                                        .alternate,
                                                    ),
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
                                                        Text(
                                                          'Адрес доставки',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.5,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                procurementDetailedGetStoreHouseDetailedResponse
                                                                    .jsonBody,
                                                                r'''$.delivery_address''',
                                                              )?.toString(),
                                                              '-',
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: FlutterFlowTheme.of(context)
                                                        .alternate,
                                                    ),
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
                                                        Text(
                                                          'Закупщик',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                procurementDetailedGetStoreHouseDetailedResponse
                                                                    .jsonBody,
                                                                r'''$.buyer.title''',
                                                              )?.toString(),
                                                              '-',
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: FlutterFlowTheme.of(context)
                                                        .alternate,
                                                    ),
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
                                                        Text(
                                                          'Заказчик',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              getJsonField(
                                                                procurementDetailedGetStoreHouseDetailedResponse
                                                                    .jsonBody,
                                                                r'''$.author.title''',
                                                              )?.toString(),
                                                              '-',
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: FlutterFlowTheme.of(context)
                                                        .alternate,
                                                    ),
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
                                                        Text(
                                                          'Дата создания',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.4,
                                                          decoration:
                                                              BoxDecoration(),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              dateTimeFormat(
                                                                "dd.MM.y H:mm",
                                                                functions
                                                                    .stringToDate(
                                                                        getJsonField(
                                                                  procurementDetailedGetStoreHouseDetailedResponse
                                                                      .jsonBody,
                                                                  r'''$.created_at''',
                                                                ).toString()),
                                                                locale: FFLocalizations.of(
                                                                        context)
                                                                    .languageCode,
                                                              ),
                                                              '-',
                                                            ),
                                                            textAlign:
                                                                TextAlign.end,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  fontSize: 15,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color: FlutterFlowTheme.of(context)
                                                        .alternate,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 0, 20),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Дополнительные требования',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryText,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                          Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.9,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                getJsonField(
                                                                  procurementDetailedGetStoreHouseDetailedResponse
                                                                      .jsonBody,
                                                                  r'''$.comment''',
                                                                )?.toString(),
                                                                '-',
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    fontSize:
                                                                        15,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ].divide(
                                                      SizedBox(height: 10)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (FFAppState().STO != "Поставщик")
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.58,
                                                child:
                                                    custom_widgets.OrderStepper(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.9,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.4,
                                                  currentStatus: getJsonField(
                                                    procurementDetailedGetStoreHouseDetailedResponse
                                                        .jsonBody,
                                                    r'''$.status''',
                                                  ).toString(),
                                                ),
                                              ),
                                            ),
                                          SizedBox(
                                            height: 100,
                                          )
                                        ]
                                            .divide(SizedBox(height: 10))
                                            .addToEnd(SizedBox(height: 60)),
                                      ),
                                    ),
                                  ),
                                  Visibility(
                                    visible: getJsonField(
                                          procurementDetailedGetStoreHouseDetailedResponse
                                              .jsonBody,
                                          r'''$.offers''',
                                        ) !=
                                        null,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                1,
                                            child: custom_widgets
                                                .ProcurementOffersList(
                                              width: MediaQuery.sizeOf(context)
                                                  .width,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  1,
                                              sentCounterpartyOffers:
                                                  getJsonField(
                                                procurementDetailedGetStoreHouseDetailedResponse
                                                    .jsonBody,
                                                r'''$.offers''',
                                                true,
                                              )!,
                                              sentInventoryItems: getJsonField(
                                                procurementDetailedGetStoreHouseDetailedResponse
                                                    .jsonBody,
                                                r'''$.inventory_items''',
                                                true,
                                              )!,
                                              currentUserId: getJsonField(
                                                FFAppState().result,
                                                r'''$.user.id''',
                                              ).toString(),
                                              confirmOrderAction:
                                                  (itemId, offerId) async {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      '123',
                                                      style: TextStyle(
                                                        fontFamily: 'SFProText',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 1200),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                  ),
                                                );
                                              },
                                              procurementId: widget.id!,
                                              procurementStatus: getJsonField(
                                                    procurementDetailedGetStoreHouseDetailedResponse
                                                        .jsonBody,
                                                    r'''$.status''',
                                                  ).toString(),
                                              authToken: currentAuthenticationToken!,
                                              onRefresh: () async {
  // Просто вызываем перерисовку, FutureBuilder сам сделает новый запрос
  safeSetState(() {}); 
},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.933,
                                            decoration: BoxDecoration(),
                                            child: Builder(
                                              builder: (context) {
                                                final responsible =
                                                    getJsonField(
                                                  procurementDetailedGetStoreHouseDetailedResponse
                                                      .jsonBody,
                                                  r'''$.inventory_items''',
                                                ).toList();

                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                          responsible.length,
                                                          (responsibleIndex) {
                                                    final responsibleItem =
                                                        responsible[
                                                            responsibleIndex];
                                                    return Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.933,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.074,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(6),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        20,
                                                                        0,
                                                                        0,
                                                                        0),
                                                            child: Column(
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
                                                                Text(
                                                                  getJsonField(
                                                                    responsibleItem,
                                                                    r'''$.title''',
                                                                  ).toString(),
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'SFProText',
                                                                        fontSize:
                                                                            15,
                                                                        letterSpacing:
                                                                            0.0,
                                                                      ),
                                                                ),
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            'Парт номер: ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: Color(0xFF3466E7),
                                                                              fontSize: 13,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            getJsonField(
                                                                          responsibleItem,
                                                                          r'''$.product_article''',
                                                                        ).toString(),
                                                                        style:
                                                                            TextStyle(),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          color:
                                                                              Color(0xFF3466E7),
                                                                          fontSize:
                                                                              13,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                                RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text:
                                                                            'Количество: ',
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              color: Color(0xFF3466E7),
                                                                              fontSize: 13,
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            getJsonField(
                                                                          responsibleItem,
                                                                          r'''$.quantity''',
                                                                        ).toString(),
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            ' ',
                                                                        style:
                                                                            TextStyle(),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            getJsonField(
                                                                          responsibleItem,
                                                                          r'''$.unit_of_measurement''',
                                                                        ).toString(),
                                                                        style:
                                                                            TextStyle(),
                                                                      )
                                                                    ],
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          color:
                                                                              Color(0xFF3466E7),
                                                                          fontSize:
                                                                              13,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  })
                                                      .divide(
                                                          SizedBox(height: 10))
                                                      .addToStart(
                                                          SizedBox(height: 10)),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 8, 0, 8),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11.5, 0,
                                                                11.5, 0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                      context)
                                                                  .width,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Row(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1, 0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.5,
                                                                  decoration:
                                                                      BoxDecoration(),
                                                                  child: Text(
                                                                    'История',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                          fontSize:
                                                                              15,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  FutureBuilder<
                                                      ApiCallResponse>(
                                                    future:
                                                        GetProcurementHistoryCall
                                                            .call(
                                                      access:
                                                          currentAuthenticationToken,
                                                      id: widget!.id,
                                                      work: FFAppState()
                                                          .workspace,
                                                    ),
                                                    builder:
                                                        (context, snapshot) {
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
                                                      final conditionalBuilderGetDefectsHistoryResponse =
                                                          snapshot.data!;

                                                      return Builder(
                                                        builder: (context) {
                                                          if (conditionalBuilderGetDefectsHistoryResponse
                                                              .succeeded) {
                                                            return Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          11.5,
                                                                          0,
                                                                          11.5,
                                                                          0),
                                                              child: Builder(
                                                                builder:
                                                                    (context) {
                                                                  final todo =
                                                                      getJsonField(
                                                                    conditionalBuilderGetDefectsHistoryResponse
                                                                        .jsonBody,
                                                                    r'''$''',
                                                                  ).toList();

                                                                  return Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: List.generate(
                                                                        todo.length,
                                                                        (todoIndex) {
                                                                      final todoItem =
                                                                          todo[
                                                                              todoIndex];
                                                                      return Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                            ),
                                                                            child:
                                                                                Row(
                                                                              mainAxisSize: MainAxisSize.max,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Column(
                                                                                  mainAxisSize: MainAxisSize.max,
                                                                                  children: [
                                                                                    Row(
                                                                                      mainAxisSize: MainAxisSize.max,
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Align(
                                                                                          alignment: AlignmentDirectional(-1, 0),
                                                                                          child: Container(
                                                                                            width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                            decoration: BoxDecoration(),
                                                                                            child: Text(
                                                                                              valueOrDefault<String>(
                                                                                                getJsonField(
                                                                                                  todoItem,
                                                                                                  r'''$.description''',
                                                                                                )?.toString(),
                                                                                                '-',
                                                                                              ),
                                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                    fontFamily: 'SFProText',
                                                                                                    fontSize: 15,
                                                                                                    letterSpacing: 0.0,
                                                                                                    fontWeight: FontWeight.w600,
                                                                                                  ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    Align(
                                                                                      alignment: AlignmentDirectional(-1, 0),
                                                                                      child: Container(
                                                                                        width: MediaQuery.sizeOf(context).width * 0.9,
                                                                                        decoration: BoxDecoration(),
                                                                                        child: Padding(
                                                                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 10, 0),
                                                                                          child: Text(
                                                                                            valueOrDefault<String>(
                                                                                              dateTimeFormat(
                                                                                                "dd.MM.y H:mm",
                                                                                                functions.stringToDate(getJsonField(
                                                                                                  todoItem,
                                                                                                  r'''$.datetime''',
                                                                                                ).toString()),
                                                                                                locale: FFLocalizations.of(context).languageCode,
                                                                                              ),
                                                                                              '-',
                                                                                            ),
                                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                                  fontFamily: 'SFProText',
                                                                                                  color: Color(0xFF8291B0),
                                                                                                  fontSize: 13,
                                                                                                  letterSpacing: 0.0,
                                                                                                ),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ].divide(SizedBox(height: 3)).addToEnd(SizedBox(height: 2)),
                                                                                ),
                                                                              ].divide(SizedBox(width: 5)),
                                                                            ),
                                                                          ),
                                                                          Divider(
                                                                            thickness:
                                                                                1,
                                                                            color:
                                                                                FlutterFlowTheme.of(context)
                                                        .alternate,
                                                                          ),
                                                                        ],
                                                                      );
                                                                    }).addToStart(
                                                                        SizedBox(
                                                                            height:
                                                                                10)),
                                                                  );
                                                                },
                                                              ),
                                                            );
                                                          } else {
                                                            return Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
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
                    ],
                  ),
                  // Generated code for this Button Widget...
                  Align(
                    alignment: AlignmentDirectional(0, 1),
                    child: Builder(
                      builder: (context) {
                        if (valueOrDefault<String>(
                              functions.procurementStatus(getJsonField(
                                procurementDetailedGetStoreHouseDetailedResponse
                                    .jsonBody,
                                r'''$.status''',
                              ).toString()),
                              '-',
                            ) ==
                            'Новая - сбор предложений') {
                          return FFButtonWidget(
                            onPressed: () async {
                              context.pushNamed(
                                AddPriceWidget.routeName,
                                queryParameters: {
                                  'json': serializeParam(
                                    procurementDetailedGetStoreHouseDetailedResponse
                                        .jsonBody,
                                    ParamType.JSON,
                                  ),
                                }.withoutNulls,
                              );
                            },
                            text: 'Отправить предложение',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        } else if (valueOrDefault<String>(
                              functions.procurementStatus(getJsonField(
                                procurementDetailedGetStoreHouseDetailedResponse
                                    .jsonBody,
                                r'''$.status''',
                              ).toString()),
                              '-',
                            ) ==
                            'Сравнение предложений' || valueOrDefault<String>(
                              functions.procurementStatus(getJsonField(
                                procurementDetailedGetStoreHouseDetailedResponse
                                    .jsonBody,
                                r'''$.status''',
                              ).toString()),
                              '-',
                            ) ==
                            'Опубликовано')  {
                          return Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  context.pushNamed(
                                    ManualKPWidget.routeName,
                                    queryParameters: {
                                      'json': serializeParam(
                                        procurementDetailedGetStoreHouseDetailedResponse
                                            .jsonBody,
                                        ParamType.JSON,
                                      ),
                                    }.withoutNulls,
                                  );
                                },
                                text: 'Добавить КП вручную',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 0, 16, 0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'SFProText',
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        letterSpacing: 0.0,
                                      ),
                                  elevation: 0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              if (getJsonField(
                                    procurementDetailedGetStoreHouseDetailedResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString() !=
                                  'PUBLISHED')
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed(
                                      CompareOffersWidget.routeName,
                                      queryParameters: {
                                        'json': serializeParam(
                                          procurementDetailedGetStoreHouseDetailedResponse
                                              .jsonBody,
                                          ParamType.JSON,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  text: 'Cравнить предложения',
                                  options: FFButtonOptions(
                                    width: MediaQuery.sizeOf(context).width * 0.9,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.05,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: FlutterFlowTheme.of(context).primary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'SFProText',
                                          color: Colors.white,
                                          letterSpacing: 0.0,
                                        ),
                                    elevation: 0,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                            ].divide(SizedBox(height: 5)),
                          );
                        } else if (valueOrDefault<String>(
                                  functions.procurementStatus(getJsonField(
                                    procurementDetailedGetStoreHouseDetailedResponse
                                        .jsonBody,
                                    r'''$.status''',
                                  ).toString()),
                                  '-',
                                ) ==
                                'Ожидание подтверждения оплаты') {
                          return FFButtonWidget(
                            onPressed: () async {
                              _model.apiResult35r = await ConfirmPaymentProcurementCall.call(
                                access: currentAuthenticationToken,
                                id: widget!.id,
                                counterpartId: getJsonField(
                                  FFAppState().result,
                                  r'''$.user.id''',
                                ).toString(),
                                work: FFAppState().workspace,
                              );

                              if ((_model.apiResult35r?.succeeded ?? true)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Подтвержден получение оплаты!',
                                      style: TextStyle(
                                        fontFamily: 'SFProText',
                                        color: Colors.white,
                                      ),
                                    ),
                                    duration: Duration(milliseconds: 2000),
                                    backgroundColor: Color(0xFF32C680),
                                  ),
                                );
                              }

                              safeSetState(() {});
                            },
                            text: 'Подтвердить оплату',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: Color(0xFF3BC825),
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        }else if (valueOrDefault<String>(
                              functions.procurementStatus(getJsonField(
                                procurementDetailedGetStoreHouseDetailedResponse
                                    .jsonBody,
                                r'''$.status''',
                              ).toString()),
                              '-',
                            ) ==
                            'Готово к отгрузке') {
                          return FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Подтверждение'),
                                            content: Text(
                                                'Вы хотите подтвердить отправку товаров?'),
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
                                _model.apiResult35r2 = await SendGoodsProcurementCall.call(
                                  access: currentAuthenticationToken,
                                  work: FFAppState().workspace,
                                  id: procurementDetailedGetStoreHouseDetailedResponse?.jsonBody['id'] ?? '',
                                );

                                if ((_model.apiResult35r2?.succeeded ?? true)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Товар успешно отправлен!',
                                        style: TextStyle(
                                          fontFamily: 'SFProText',
                                          color: Colors.white,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Color(0xFF32C680),
                                    ),
                                  );
                                }
                              }

                              safeSetState(() {});
                            },
                            text: 'Отправить',
                            icon: FaIcon(
                              FontAwesomeIcons.truck,
                              size: 18,
                            ),
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconAlignment: IconAlignment.start,
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderSide: BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        } else if (getJsonField(
                                procurementDetailedGetStoreHouseDetailedResponse
                                    .jsonBody,
                                r'''$.status''',
                              ).toString() ==
                              'AWAITING_PUBLICATION' &&
                            getJsonField(
                                  procurementDetailedGetStoreHouseDetailedResponse
                                      .jsonBody,
                                  r'''$.flow_type''',
                                ).toString().contains('WITH_BUYER') &&
                            getJsonField(
                                  procurementDetailedGetStoreHouseDetailedResponse
                                      .jsonBody,
                                  r'''$.buyer.id''',
                                ).toString() ==
                                getJsonField(
                                  FFAppState().result,
                                  r'''$.user.id''',
                                ).toString()) {
                          return FFButtonWidget(
                            onPressed: () async {
                              var confirmDialogResponse =
                                  await showDialog<bool>(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            title: Text('Подтверждение'),
                                            content: Text(
                                                'Вы хотите опубликовать заявку?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, false),
                                                child: Text('Отмена'),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext, true),
                                                child: Text('Опубликовать'),
                                              ),
                                            ],
                                          );
                                        },
                                      ) ??
                                      false;
                              if (confirmDialogResponse) {
                                final result =
                                    await PublishProcurementCall.call(
                                  token: currentAuthenticationToken,
                                  id: widget!.id,
                                  work: FFAppState().workspace,
                                );

                                if (result.succeeded) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Заявка успешно опубликована!',
                                        style: TextStyle(
                                          fontFamily: 'SFProText',
                                          color: Colors.white,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Color(0xFF32C680),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Ошибка при публикации заявки',
                                        style: TextStyle(
                                          fontFamily: 'SFProText',
                                          color: Colors.white,
                                        ),
                                      ),
                                      duration: Duration(milliseconds: 2000),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }

                              safeSetState(() {});
                            },
                            text: 'Опубликовать',
                            icon: Icon(
                              Icons.publish,
                              size: 18,
                            ),
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                              iconPadding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'SFProText',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
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
