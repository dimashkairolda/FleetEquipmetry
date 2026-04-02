import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_drop_down.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'send_invoice_model.dart';
export 'send_invoice_model.dart';

class SendInvoiceWidget extends StatefulWidget {
  const SendInvoiceWidget({
    super.key,
    required this.id,
    required this.rojson,
    required this.invoicejson,
  });

  final String? id;
  final dynamic rojson;
  final dynamic invoicejson;

  @override
  State<SendInvoiceWidget> createState() => _SendInvoiceWidgetState();
}

class _SendInvoiceWidgetState extends State<SendInvoiceWidget> {
  late SendInvoiceModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SendInvoiceModel());

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
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 16.0, 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Создать согласование',
                    style: FlutterFlowTheme.of(context).headlineSmall.override(
                          fontFamily: 'SFProText',
                          fontSize: 18.0,
                          letterSpacing: 0.0,
                        ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () async {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close_outlined,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FlutterFlowDropDown<String>(
                    controller: _model.dropDownValueController1 ??=
                        FormFieldController<String>(
                      _model.dropDownValue1 ??= '',
                    ),
                    options: List<String>.from(['SEQUENTIAL', 'PARALLEL']),
                    optionLabels: ['Последовательный', 'Параллельный'],
                    onChanged: (val) =>
                        safeSetState(() => _model.dropDownValue1 = val),
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: MediaQuery.sizeOf(context).height * 0.06,
                    textStyle: FlutterFlowTheme.of(context).bodyMedium.override(
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                    hintText: 'Метод согласования',
                    icon: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                    elevation: 2.0,
                    borderColor: FlutterFlowTheme.of(context).primaryBackground,
                    borderWidth: 2.0,
                    borderRadius: 8.0,
                    margin:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0.0),
                    hidesUnderline: true,
                    isOverButton: false,
                    isSearchable: false,
                    isMultiSelect: false,
                  ),
                  FutureBuilder<ApiCallResponse>(
                    future: UsersListCall.call(
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
                      final dropDownUsersListResponse = snapshot.data!;

                      return FlutterFlowDropDown<String>(
                        multiSelectController:
                            _model.dropDownValueController2 ??=
                                FormListFieldController<String>(null),
                        options: List<String>.from((getJsonField(
                          dropDownUsersListResponse.jsonBody,
                          r'''$[:].id''',
                          true,
                        ) as List?)!
                            .map<String>((e) => e.toString())
                            .toList()
                            .cast<String>()),
                        optionLabels: functions.combineNamesAndSurnames(
                            (getJsonField(
                              dropDownUsersListResponse.jsonBody,
                              r'''$[:].name.first''',
                              true,
                            ) as List?)!
                                .map<String>((e) => e.toString())
                                .toList()
                                .cast<String>(),
                            (getJsonField(
                              dropDownUsersListResponse.jsonBody,
                              r'''$[:].name.last''',
                              true,
                            ) as List?)!
                                .map<String>((e) => e.toString())
                                .toList()
                                .cast<String>()),
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.06,
                        maxHeight: MediaQuery.sizeOf(context).height * 0.3,
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
                        hintText: 'Согласующие',
                        icon: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: FlutterFlowTheme.of(context).secondaryText,
                          size: 24.0,
                        ),
                        fillColor:
                            FlutterFlowTheme.of(context).secondaryBackground,
                        elevation: 2.0,
                        borderColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                        borderWidth: 2.0,
                        borderRadius: 8.0,
                        margin: EdgeInsetsDirectional.fromSTEB(
                            12.0, 0.0, 12.0, 0.0),
                        hidesUnderline: true,
                        isOverButton: false,
                        isSearchable: false,
                        isMultiSelect: true,
                        onMultiSelectChanged: (val) =>
                            safeSetState(() => _model.dropDownValue2 = val),
                      );
                    },
                  ),
                  FFButtonWidget(
                    onPressed: () async {
                      _model.asd = InvoicesStruct(
                        objectTitle: getJsonField(
                          widget.rojson,
                          r'''$.title''',
                        ).toString(),
                        objectShortId: getJsonField(
                          widget.rojson,
                          r'''$.short_id''',
                        ).toString(),
                        title: 'Согласование счетов для заявки SP${getJsonField(
                          widget.rojson,
                          r'''$.short_id''',
                        ).toString()}',
                        approvalMethod: _model.dropDownValue1,
                        objectType: 'STOREHOUSE_ORDER',
                        objectIds: (getJsonField(
                          widget.rojson,
                          r'''$.id''',
                          true,
                        ) as List?)
                            ?.map<String>((e) => e.toString())
                            .toList()
                            .cast<String>(),
                        approverIds: functions
                            .createApproversList(
                                _model.dropDownValue2!.toList(),
                                getJsonField(
                                  widget.invoicejson,
                                  r'''$.id''',
                                ).toString())
                            .map((e) => ApproverIdsStruct.maybeFromMap(e))
                            .withoutNulls
                            .toList(),
                        approvalInvoices: functions
                            .createSingleInvoiceList(
                                getJsonField(
                                  widget.invoicejson,
                                  r'''$.id''',
                                ).toString(),
                                getJsonField(
                                  widget.invoicejson,
                                  r'''$.short_id''',
                                ).toString())
                            .map((e) => ApprovalInvoicesStruct.maybeFromMap(e))
                            .withoutNulls
                            .toList(),
                      );
                      safeSetState(() {});
                      _model.apiResultot1 = await SendInvoiceCall.call(
                        token: currentAuthenticationToken,
                        work: FFAppState().workspace,
                        bodyJson: InvoicesStruct(
                          objectTitle: getJsonField(
                            widget.rojson,
                            r'''$.title''',
                          ).toString(),
                          objectShortId: getJsonField(
                            widget.rojson,
                            r'''$.short_id''',
                          ).toString(),
                          title:
                              'Согласование счетов для заявки SP${getJsonField(
                            widget.rojson,
                            r'''$.short_id''',
                          ).toString()}',
                          approvalMethod: _model.dropDownValue1,
                          objectType: 'STOREHOUSE_ORDER',
                          objectIds: (getJsonField(
                            widget.rojson,
                            r'''$.id''',
                            true,
                          ) as List?)
                              ?.map<String>((e) => e.toString())
                              .toList()
                              .cast<String>(),
                          approverIds: functions
                              .createApproversList(
                                  _model.dropDownValue2!.toList(),
                                  getJsonField(
                                    widget.invoicejson,
                                    r'''$.id''',
                                  ).toString())
                              .map((e) => ApproverIdsStruct.maybeFromMap(e))
                              .withoutNulls
                              .toList(),
                          approvalInvoices: functions
                              .createSingleInvoiceList(
                                  getJsonField(
                                    widget.invoicejson,
                                    r'''$.id''',
                                  ).toString(),
                                  getJsonField(
                                    widget.invoicejson,
                                    r'''$.short_id''',
                                  ).toString())
                              .map(
                                  (e) => ApprovalInvoicesStruct.maybeFromMap(e))
                              .withoutNulls
                              .toList(),
                        ).toMap(),
                      );

                      if ((_model.apiResultot1?.succeeded ?? true)) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Успешно!',
                              style: TextStyle(
                                fontFamily: 'SFProText',
                                color: Colors.white,
                              ),
                            ),
                            duration: Duration(milliseconds: 1000),
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                          ),
                        );
                      }

                      safeSetState(() {});
                    },
                    text: 'Создать',
                    options: FFButtonOptions(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      height: MediaQuery.sizeOf(context).height * 0.05,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      color: FlutterFlowTheme.of(context).primary,
                      textStyle:
                          FlutterFlowTheme.of(context).titleSmall.override(
                                fontFamily: 'SFProText',
                                color: Colors.white,
                                letterSpacing: 0.0,
                              ),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ].divide(SizedBox(height: 10.0)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
