import 'package:Equipmetry/procurement/choose_T_M_C/choose_t_m_c_widget.dart';
import 'package:Equipmetry/procurement/procurement/procurement_widget.dart';
import 'package:Equipmetry/procurement/procurement_flow_config.dart';

import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/backend/schema/structs/approval_procurement_struct.dart';
import '/backend/schema/structs/approver_ids_struct.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'dart:ui';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'create_procurement_model.dart';
export 'create_procurement_model.dart';

class CreateProcurementWidget extends StatefulWidget {
  const CreateProcurementWidget({
    super.key,
    this.initialTitle,
  });

  /// Предзаполнение названия заявки (например, из названия дефекта).
  final String? initialTitle;

  static String routeName = 'CreateProcurement';
  static String routePath = '/createProcurement';

  @override
  State<CreateProcurementWidget> createState() =>
      _CreateProcurementWidgetState();
}

class _CreateProcurementWidgetState extends State<CreateProcurementWidget>
    with TickerProviderStateMixin {
  late CreateProcurementModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  ProcurementFlowConfig get _flowConfig =>
      ProcurementFlowConfig.fromFlowType(_model.selectedFlowType);

  Future<void> _loadProcurementParameters() async {
    _model.procurementParameterResponse = await GetProcurementParameterCall.call(
      token: currentAuthenticationToken,
      work: FFAppState().workspace,
    );
    if (!(_model.procurementParameterResponse?.succeeded ?? false)) {
      return;
    }

    final dynamic body = _model.procurementParameterResponse?.jsonBody;
    dynamic param;
    if (body is List && body.isNotEmpty) {
      param = body.first;
    } else {
      param = body;
    }

    final String apiFlowType = getJsonField(param, r'''$.flow_type''').toString();
    if (ProcurementFlowConfig.allFlowTypes.contains(apiFlowType)) {
      _model.selectedFlowType = apiFlowType;
    }
    _model.flowWarehouseModeType =
        getJsonField(param, r'''$.warehouse_mode_type''').toString().isNotEmpty
            ? getJsonField(param, r'''$.warehouse_mode_type''').toString()
            : 'FULL';
    _model.flowManualKp = getJsonField(param, r'''$.manual_kp''') == true;
    _model.flowIntegrationWithEds =
        getJsonField(param, r'''$.integration_with_eds''') == true;
    if (mounted) safeSetState(() {});
  }

  Future<void> _sendPublicationApproval(String procurementId) async {
    final List<String> chosenApprovers = _model.approverIds
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet()
        .toList();
    if (chosenApprovers.isEmpty) {
      return;
    }

    final List<ApproverIdsStruct> approverStructs =
        chosenApprovers.asMap().entries.map((e) {
      return ApproverIdsStruct(
        approverId: e.value,
        approved: null,
        order: e.key + 1,
      );
    }).toList();

    _model.apiResult5a23 = await CreateProcurementApprovalCall.call(
      access: currentAuthenticationToken,
      work: FFAppState().workspace,
      bodyJson: ApprovalProcurementStruct(
        title: 'Закуп запчастей',
        approvalMethod: 'SEQUENTIAL',
        objectType: 'PROCUREMENT',
        objectIds: [procurementId],
        approverIds: approverStructs,
      ).toMap(),
    );

    if (!(_model.apiResult5a23?.succeeded ?? false)) {
      return;
    }

    _model.apiResult5a234 = await SendToApprovementCall.call(
      access: currentAuthenticationToken,
      work: FFAppState().workspace,
      id: procurementId,
      approverIds: chosenApprovers,
      publication_approval_id:
          getJsonField(_model.apiResult5a23?.jsonBody, r'''$.id''').toString(),
    );
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProcurementModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().defecttime = getCurrentTimestamp;
      safeSetState(() {});
      _model.qqq = await actions.checkInternetConnectivity();
      await _loadProcurementParameters();
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));

    _model.nazvanieTextController ??= TextEditingController();
    _model.nazvanieFocusNode ??= FocusNode();
    final presetTitle = widget.initialTitle?.trim();
    if (presetTitle != null &&
        presetTitle.isNotEmpty &&
        _model.nazvanieTextController.text.trim().isEmpty) {
      _model.nazvanieTextController.text = presetTitle;
    }

    _model.addressTextController ??= TextEditingController();
    _model.addressFocusNode ??= FocusNode();

    _model.commentTextController ??= TextEditingController();
    _model.commentFocusNode ??= FocusNode();

    _model.nameTextController ??= TextEditingController();
    _model.nameFocusNode ??= FocusNode();

    _model.attributeTextController ??= TextEditingController();
    _model.attributeFocusNode ??= FocusNode();

    _model.amountTextController ??= TextEditingController();
    _model.amountFocusNode ??= FocusNode();

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
        floatingActionButton: Visibility(
          visible: false,
          child: FloatingActionButton(
            onPressed: () {
              print('FloatingActionButton pressed ...');
            },
            backgroundColor: FlutterFlowTheme.of(context).primary,
            elevation: 8,
            child: Icon(
              Icons.auto_awesome,
              color: FlutterFlowTheme.of(context).info,
              size: 24,
            ),
          ),
        ),
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
              if (Navigator.of(context).canPop()) {
                context.pop();
              } else {
                context.goNamed(ProcurementWidget.routeName);
              }
              FFAppState().CTOInventoryItems = [];
              safeSetState(() {});
            },
          ),
          title: Text(
            'Новая заявка',
            style: FlutterFlowTheme.of(context).titleLarge.override(
                  fontFamily: 'SFProText',
                  color: Color(0xFF3466E7),
                  fontSize: 18,
                  letterSpacing: 0.0,
                ),
          ),
          actions: [
            // Generated code for this Button Widget...
FFButtonWidget(
  onPressed: () async {
    if (_flowConfig.requiresBuyer &&
        (_model.zakupValue == null || _model.zakupValue!.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Выберите закупщика для выбранного типа процесса',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 3000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }
    if (_flowConfig.requiresPublicationApproval &&
        _model.approverIds
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Выберите хотя бы одного согласованта',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 3000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
      return;
    }

    _model.apiResult5a2 = await CreateProcurementCall.call(
      access: currentAuthenticationToken,
      work: FFAppState().workspace,
      bodyJson: ProcurementStruct(
        workspaceId: FFAppState().workspace,
        parentId: null,
        title: _model.nazvanieTextController.text,
        deliveryAddress: _model.addressTextController.text,
        buyerId: (_model.zakupValue?.isEmpty ?? true) ? null : _model.zakupValue,
        availableDue: '${dateTimeFormat(
          "y-MM-ddTH:mm:ss",
          _model.datePicked,
          locale: FFLocalizations.of(context).languageCode,
        )}+05:00',
        defectIds: const [],
        inventoryItems: FFAppState().CTOInventoryItems,
        flowType: _model.selectedFlowType,
        warehouseModeType: _model.flowWarehouseModeType,
        manualKp: _model.flowManualKp,
        integrationWithEds: _model.flowIntegrationWithEds,
        comment: _model.commentTextController.text,
        status: null,
      ).toMap(),
    );

    if (_model.apiResult5a2?.succeeded ?? true) {
      final String createdProcurementId = getJsonField(
        _model.apiResult5a2?.jsonBody,
        r'''$.id''',
      ).toString();
      if (_model.selectedFlowType == 'STRAIGHT' &&
          createdProcurementId.isNotEmpty) {
        await PublishProcurementCall.call(
          token: currentAuthenticationToken,
          id: createdProcurementId,
          work: FFAppState().workspace,
        );
      } else if (_flowConfig.requiresPublicationApproval &&
          createdProcurementId.isNotEmpty) {
        await _sendPublicationApproval(createdProcurementId);
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Заявка успешно создана!',
            style: TextStyle(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
          ),
          duration: Duration(milliseconds: 2000),
          backgroundColor: FlutterFlowTheme.of(context).primary,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            (_model.apiResult5a2?.jsonBody ?? '').toString(),
            style: TextStyle(
              color: FlutterFlowTheme.of(context).primaryText,
            ),
          ),
          duration: Duration(milliseconds: 4000),
          backgroundColor: FlutterFlowTheme.of(context).secondary,
        ),
      );
    }
    FFAppState().CTOInventoryItems = [];
    safeSetState(() {});
    context.goNamed(ProcurementWidget.routeName);
    safeSetState(() {});
  },
  text: 'Сохранить',
  options: FFButtonOptions(
    height: 40,
    padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
    iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
    color: FlutterFlowTheme.of(context).secondaryBackground,
    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
          fontFamily: 'SFProText',
          color: FlutterFlowTheme.of(context).primaryText,
          letterSpacing: 0.0,
        ),
    elevation: 0,
    borderRadius: BorderRadius.circular(8),
  ),
)

          ],
          centerTitle: false,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: FlutterFlowButtonTabBar(
                    useToggleButtonStyle: false,
                    isScrollable: true,
                    labelStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'SFProText',
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                    unselectedLabelStyle:
                        FlutterFlowTheme.of(context).titleMedium.override(
                              fontFamily: 'SFProText',
                              fontSize: 14,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.w500,
                            ),
                    labelColor: Color(0xFF3466E7),
                    unselectedLabelColor:
                        FlutterFlowTheme.of(context).secondaryText,
                    backgroundColor: Color(0xFFA6D0FF),
                    borderWidth: 0,
                    borderRadius: 8,
                    elevation: 2,
                    buttonMargin: EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                    tabs: [
                      Tab(
                        text: 'Основные',
                      ),
                      Tab(
                        text: 'Список ТМЦ',
                      ),
                    ],
                    controller: _model.tabBarController,
                    onTap: (i) async {
                      [() async {}, () async {}][i]();
                    },
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _model.tabBarController,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Form(
                                key: _model.formKey,
                                autovalidateMode: AutovalidateMode.disabled,
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 16, 0, 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(13.5, 15, 13.5, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Название заявки',
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
                                                  TextFormField(
                                                    controller: _model
                                                        .nazvanieTextController,
                                                    focusNode: _model
                                                        .nazvanieFocusNode,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Введите',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF3466E7),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16, 12,
                                                                  16, 12),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    validator: _model
                                                        .nazvanieTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ]
                                                    .divide(SizedBox(height: 5))
                                                    .addToStart(
                                                        SizedBox(height: 5)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(13.5, 15, 7, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Адрес доставки',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  TextFormField(
                                                    controller: _model
                                                        .addressTextController,
                                                    focusNode:
                                                        _model.addressFocusNode,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Введите',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF3466E7),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16, 12,
                                                                  16, 12),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    validator: _model
                                                        .addressTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ]
                                                    .divide(SizedBox(height: 5))
                                                    .addToStart(
                                                        SizedBox(height: 5)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(13.5, 15, 13.5, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Закупщик',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  FutureBuilder<
                                                      ApiCallResponse>(
                                                    future: GetUsersZakupchikCall.call(
                                                      access:
                                                          currentAuthenticationToken,
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
                                                      final zakupGetSTOResponse =
                                                          snapshot.data!;

                                                      return FlutterFlowDropDown<
                                                          String>(
                                                        controller: _model
                                                                .zakupValueController ??=
                                                            FormFieldController<
                                                                String>(
                                                          _model.zakupValue ??=
                                                              '',
                                                        ),
                                                        options: List<
                                                                String>.from(
                                                            (getJsonField(
                                                          zakupGetSTOResponse
                                                              .jsonBody,
                                                          r'''$[:].id''',
                                                          true,
                                                        ) as List?)!
                                                                .map<String>(
                                                                    (e) => e
                                                                        .toString())
                                                                .toList()
                                                                .cast<
                                                                    String>()),
                                                        optionLabels: functions
                                                            .combineNamesAndSurnames(
                                                                (getJsonField(
                                                                  zakupGetSTOResponse
                                                                      .jsonBody,
                                                                  r'''$[:].name.first''',
                                                                  true,
                                                                ) as List?)!
                                                                    .map<String>(
                                                                        (e) => e
                                                                            .toString())
                                                                    .toList()
                                                                    .cast<
                                                                        String>(),
                                                                (getJsonField(
                                                                  zakupGetSTOResponse
                                                                      .jsonBody,
                                                                  r'''$[:].name.last''',
                                                                  true,
                                                                ) as List?)!
                                                                    .map<String>(
                                                                        (e) => e
                                                                            .toString())
                                                                    .toList()
                                                                    .cast<
                                                                        String>()),
                                                        onChanged: (val) =>
                                                            safeSetState(() =>
                                                                _model.zakupValue =
                                                                    val),
                                                        width: 476,
                                                        height: 50,
                                                        searchHintTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'SFProText',
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        searchTextStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
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
                                                                          .normal,
                                                                ),
                                                        hintText:
                                                            'Выберите из списка',
                                                        searchHintText:
                                                            'Поиск по названию',
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down_rounded,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
                                                          size: 24,
                                                        ),
                                                        elevation: 2,
                                                        borderColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        borderWidth: 1,
                                                        borderRadius: 8,
                                                        margin:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 4,
                                                                    16, 4),
                                                        hidesUnderline: true,
                                                        isOverButton: true,
                                                        isSearchable: true,
                                                        isMultiSelect: false,
                                                      );
                                                    },
                                                  ),
                                                ]
                                                    .divide(SizedBox(height: 5))
                                                    .addToStart(
                                                        SizedBox(height: 5)),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(13.5, 15, 13.5, 0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Срок ответа поставщиков',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          fontSize: 14,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                  Container(
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.05,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      border: Border.all(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                      ),
                                                    ),
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
                                                        final _datePickedDate =
                                                            await showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              getCurrentTimestamp,
                                                          firstDate:
                                                              DateTime(1900),
                                                          lastDate:
                                                              DateTime(2050),
                                                          builder:
                                                              (context, child) {
                                                            return wrapInMaterialDatePickerTheme(
                                                              context,
                                                              child!,
                                                              headerBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              headerForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                              headerTextStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .headlineLarge
                                                                      .override(
                                                                        font: GoogleFonts
                                                                            .outfit(
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineLarge
                                                                              .fontStyle,
                                                                        ),
                                                                        fontSize:
                                                                            32,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .headlineLarge
                                                                            .fontStyle,
                                                                      ),
                                                              pickerBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              pickerForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              selectedDateTimeBackgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary,
                                                              selectedDateTimeForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .info,
                                                              actionButtonForegroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .primaryText,
                                                              iconSize: 24,
                                                            );
                                                          },
                                                        );

                                                        TimeOfDay?
                                                            _datePickedTime;
                                                        if (_datePickedDate !=
                                                            null) {
                                                          _datePickedTime =
                                                              await showTimePicker(
                                                            context: context,
                                                            initialTime: TimeOfDay
                                                                .fromDateTime(
                                                                    getCurrentTimestamp),
                                                            builder: (context,
                                                                child) {
                                                              return wrapInMaterialTimePickerTheme(
                                                                context,
                                                                child!,
                                                                headerBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                headerForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                headerTextStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineLarge
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.outfit(
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).headlineLarge.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              32,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .headlineLarge
                                                                              .fontStyle,
                                                                        ),
                                                                pickerBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                pickerForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                selectedDateTimeBackgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                selectedDateTimeForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .info,
                                                                actionButtonForegroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                iconSize: 24,
                                                              );
                                                            },
                                                          );
                                                        }

                                                        if (_datePickedDate !=
                                                                null &&
                                                            _datePickedTime !=
                                                                null) {
                                                          safeSetState(() {
                                                            _model.datePicked =
                                                                DateTime(
                                                              _datePickedDate
                                                                  .year,
                                                              _datePickedDate
                                                                  .month,
                                                              _datePickedDate
                                                                  .day,
                                                              _datePickedTime!
                                                                  .hour,
                                                              _datePickedTime
                                                                  .minute,
                                                            );
                                                          });
                                                        } else if (_model
                                                                .datePicked !=
                                                            null) {
                                                          safeSetState(() {
                                                            _model.datePicked =
                                                                getCurrentTimestamp;
                                                          });
                                                        }
                                                        FFAppState()
                                                                .defecttime =
                                                            _model.datePicked;
                                                        safeSetState(() {});
                                                      },
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Expanded(
  child: Align(
    alignment: AlignmentDirectional(-1, 0),
    child: Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
      child: Text(
        _model.datePicked != null
            ? dateTimeFormat(
                "dd.MM.y H:mm",
                _model.datePicked,
                locale: FFLocalizations.of(context).languageCode,
              )
            : 'Выберите время',
        style: FlutterFlowTheme.of(context).bodyMedium.override(
              fontFamily: 'SFProText',
              color: FlutterFlowTheme.of(context).secondaryText,
              fontSize: 16,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w500,
            ),
      ),
    ),
  ),
)
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                                    .divide(SizedBox(height: 5))
                                                    .addToStart(
                                                        SizedBox(height: 5)),
                                              ),
                                            ),
                                            // Согласованты — только для flow с publication approval
                                            if (_flowConfig.requiresPublicationApproval)
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(13.5, 15, 13.5, 0),
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Согласованты',
                                                      style: FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'SFProText',
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                    FutureBuilder<ApiCallResponse>(
                                                      future: GetUsersCall.call(
                                                        access: currentAuthenticationToken,
                                                        work: FFAppState().workspace,
                                                      ),
                                                      builder: (context, snapshot) {
                                                        if (!snapshot.hasData) {
                                                          return const SizedBox(
                                                            height: 48,
                                                            child: Center(
                                                              child: CircularProgressIndicator(),
                                                            ),
                                                          );
                                                        }
                                                        final usersBody =
                                                            snapshot.data!.jsonBody;
                                                        final List<dynamic> usersList =
                                                            usersBody is List
                                                                ? usersBody
                                                                : [];
                                                        _model.approverIdsController ??=
                                                            FormListFieldController<String>(
                                                          _model.approverIds.isEmpty
                                                              ? null
                                                              : _model.approverIds,
                                                        );
                                                        return FlutterFlowDropDown<String>(
                                                          multiSelectController:
                                                              _model.approverIdsController,
                                                          options: usersList
                                                              .map((u) =>
                                                                  u['id']
                                                                      .toString())
                                                              .toList(),
                                                          optionLabels:
                                                              usersList.map((u) {
                                                            final first =
                                                                u['name']?['first'] ??
                                                                    '';
                                                            final last =
                                                                u['name']?['last'] ??
                                                                    '';
                                                            return '$first $last'
                                                                .trim();
                                                          }).toList(),
                                                          width: double.infinity,
                                                          height: 46,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
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
                                                                            .normal,
                                                                  ),
                                                          hintText:
                                                              'Выберите согласовантов',
                                                          searchHintText:
                                                              'Поиск',
                                                          icon: Icon(
                                                            Icons
                                                                .keyboard_arrow_down_rounded,
                                                            color:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                            size: 24,
                                                          ),
                                                          elevation: 2,
                                                          borderColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .alternate,
                                                          borderWidth: 1,
                                                          borderRadius: 8,
                                                          margin:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(16, 4,
                                                                      16, 4),
                                                          hidesUnderline: true,
                                                          isOverButton: true,
                                                          isSearchable: true,
                                                          isMultiSelect: true,
                                                          onMultiSelectChanged:
                                                              (val) =>
                                                                  safeSetState(
                                                                    () {
                                                                      _model.approverIds =
                                                                          val ?? [];
                                                                      _model
                                                                              .approverIdsController
                                                                              ?.value =
                                                                          _model
                                                                              .approverIds;
                                                                    },
                                                                  ),
                                                        );
                                                      },
                                                    ),
                                                  ]
                                                      .divide(const SizedBox(height: 5))
                                                      .addToStart(
                                                          const SizedBox(height: 5)),
                                                ),
                                              ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(13.5, 15, 13.5, 15),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Комментарий к заявке',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          letterSpacing: 0.0,
                                                        ),
                                                  ),
                                                  TextFormField(
                                                    controller: _model
                                                        .commentTextController,
                                                    focusNode:
                                                        _model.commentFocusNode,
                                                    autofocus: true,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      labelText: 'Введите',
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryText,
                                                                fontSize: 14,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'SFProText',
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      enabledBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color:
                                                              Color(0xFF3466E7),
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(16, 12,
                                                                  16, 12),
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily:
                                                              'SFProText',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    cursorColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primary,
                                                    validator: _model
                                                        .commentTextControllerValidator
                                                        .asValidator(context),
                                                  ),
                                                ]
                                                    .divide(SizedBox(height: 5))
                                                    .addToStart(
                                                        SizedBox(height: 5)),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ].divide(SizedBox(height: 12)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 16, 0, 16),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            13.5, 15, 13.5, 0),
                                        child: Text(
                                          'Список ТМЦ',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'SFProText',
                                                fontSize: 16,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            13.5, 15, 13.5, 15),
                                        child: Builder(
                                          builder: (context) {
                                            final spareparts = FFAppState()
                                                .CTOInventoryItems
                                                .toList();

                                            return Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: List.generate(
                                                  spareparts.length,
                                                  (sparepartsIndex) {
                                                final sparepartsItem =
                                                    spareparts[sparepartsIndex];
                                                return Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'ТМЦ ${functions.plusOne(sparepartsIndex.toString())}',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.05,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  sparepartsItem
                                                                      .title,
                                                                  '-',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.35,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Text(
                                                                valueOrDefault<
                                                                    String>(
                                                                  sparepartsItem
                                                                      .productArticle,
                                                                  '-',
                                                                ),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    -1, 0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.15,
                                                              decoration:
                                                                  BoxDecoration(),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0,
                                                                            0,
                                                                            10,
                                                                            0),
                                                                child: RichText(
                                                                  textScaler: MediaQuery.of(
                                                                          context)
                                                                      .textScaler,
                                                                  text:
                                                                      TextSpan(
                                                                    children: [
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          sparepartsItem
                                                                              .quantity
                                                                              .toString(),
                                                                          '-',
                                                                        ),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'SFProText',
                                                                              letterSpacing: 0.0,
                                                                            ),
                                                                      ),
                                                                      TextSpan(
                                                                        text:
                                                                            ' ',
                                                                        style:
                                                                            TextStyle(
                                                                          fontFamily:
                                                                              'SFProText',
                                                                        ),
                                                                      ),
                                                                      TextSpan(
                                                                        text: valueOrDefault<
                                                                            String>(
                                                                          sparepartsItem
                                                                              .unitOfMeasurement,
                                                                          '-',
                                                                        ),
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
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              FFAppState()
                                                                  .removeAtIndexFromCTOInventoryItems(
                                                                      sparepartsIndex);
                                                              safeSetState(
                                                                  () {});
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .delete_outline,
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              size: 24,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 1,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ],
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ),
                                      if (_model.isEdit)
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  12, 0, 12, 0),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Название ТМЦ',
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                      width: MediaQuery.sizeOf(
                                                              context)
                                                          .width,
                                                      child: TextFormField(
                                                        controller: _model
                                                            .nameTextController,
                                                        focusNode: _model
                                                            .nameFocusNode,
                                                        autofocus: true,
                                                        obscureText: false,
                                                        decoration:
                                                            InputDecoration(
                                                          isDense: true,
                                                          labelStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          hintText:
                                                              'Введите название',
                                                          hintStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryText,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          errorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                          focusedErrorBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .error,
                                                              width: 1,
                                                            ),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                        validator: _model
                                                            .nameTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.45,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Парт номер',
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
                                                                0.5,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .attributeTextController,
                                                              focusNode: _model
                                                                  .attributeFocusNode,
                                                              autofocus: true,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                hintText:
                                                                    'Введите парт номер',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              validator: _model
                                                                  .attributeTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.45,
                                                      decoration:
                                                          BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            'Количество',
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
                                                                0.5,
                                                            child:
                                                                TextFormField(
                                                              controller: _model
                                                                  .amountTextController,
                                                              focusNode: _model
                                                                  .amountFocusNode,
                                                              autofocus: true,
                                                              obscureText:
                                                                  false,
                                                              decoration:
                                                                  InputDecoration(
                                                                isDense: true,
                                                                labelStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                hintText:
                                                                    'Введите количество',
                                                                hintStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .labelMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'SFProText',
                                                                      letterSpacing:
                                                                          0.0,
                                                                    ),
                                                                enabledBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryText,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                focusedBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                errorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                focusedErrorBorder:
                                                                    OutlineInputBorder(
                                                                  borderSide:
                                                                      BorderSide(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .error,
                                                                    width: 1,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                              validator: _model
                                                                  .amountTextControllerValidator
                                                                  .asValidator(
                                                                      context),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]
                                                  .divide(SizedBox(height: 10))
                                                  .addToStart(
                                                      SizedBox(height: 10))
                                                  .addToEnd(
                                                      SizedBox(height: 10)),
                                            ),
                                          ),
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 15),
                                        child: Builder(
                                          builder: (context) {
                                            if (!_model.isEdit) {
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11.5, 0,
                                                                11.5, 0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        _model.isEdit = true;
                                                        safeSetState(() {});
                                                      },
                                                      text: '+ Добавить ТМЦ',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.05,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
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
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 1),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          context.pushNamed(
                                                              ChooseTMCWidget
                                                                  .routeName);
                                                        },
                                                        text:
                                                            'Выбрать из склада',
                                                        icon: Icon(
                                                          Icons.warehouse,
                                                          size: 15,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                      context)
                                                                  .width,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.05,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(24,
                                                                      0, 24, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          iconColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 3,
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 5)),
                                              );
                                            } else {
                                              return Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1, 1),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(11.5, 0,
                                                                  11.5, 0),
                                                      child: FFButtonWidget(
                                                        onPressed: () async {
                                                          FFAppState()
                                                              .addToCTOInventoryItems(
                                                                  InventoryItemsStruct(
                                                            title:
                                                                valueOrDefault<
                                                                    String>(
                                                              _model
                                                                  .nameTextController
                                                                  .text,
                                                              '-',
                                                            ),
                                                            productArticle:
                                                                valueOrDefault<
                                                                    String>(
                                                              _model
                                                                  .attributeTextController
                                                                  .text,
                                                              '-',
                                                            ),
                                                            quantity:
                                                                valueOrDefault<
                                                                    int>(
                                                              int.tryParse(_model
                                                                  .amountTextController
                                                                  .text),
                                                              1,
                                                            ),
                                                            unitOfMeasurement:
                                                                'шт',
                                                          ));
                                                          safeSetState(() {});
                                                          _model.isEdit = false;
                                                          safeSetState(() {});
                                                          safeSetState(() {
                                                            _model
                                                                .nameTextController
                                                                ?.clear();
                                                            _model
                                                                .attributeTextController
                                                                ?.clear();
                                                            _model
                                                                .amountTextController
                                                                ?.clear();
                                                          });
                                                        },
                                                        text: 'Добавить',
                                                        icon: Icon(
                                                          Icons.add,
                                                          size: 15,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                      context)
                                                                  .width,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.05,
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(24,
                                                                      0, 24, 0),
                                                          iconPadding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(0,
                                                                      0, 0, 0),
                                                          iconColor: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .titleSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'SFProText',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 3,
                                                          borderSide:
                                                              BorderSide(
                                                            width: 1,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(11.5, 0,
                                                                11.5, 0),
                                                    child: FFButtonWidget(
                                                      onPressed: () async {
                                                        _model.isEdit = false;
                                                        safeSetState(() {});
                                                        safeSetState(() {
                                                          _model
                                                              .nameTextController
                                                              ?.clear();
                                                          _model
                                                              .attributeTextController
                                                              ?.clear();
                                                          _model
                                                              .amountTextController
                                                              ?.clear();
                                                        });
                                                      },
                                                      text: 'Отменить',
                                                      options: FFButtonOptions(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                    context)
                                                                .width,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .height *
                                                                0.05,
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(16, 0,
                                                                    16, 0),
                                                        iconPadding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0, 0, 0, 0),
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
                                                                ),
                                                        elevation: 0,
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          width: 1,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(SizedBox(height: 5)),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        ),
      ),
    );
  }
}
