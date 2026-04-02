import '/auth/custom_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_radio_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'one_from_list_reglament_model.dart';
export 'one_from_list_reglament_model.dart';

class OneFromListReglamentWidget extends StatefulWidget {
  const OneFromListReglamentWidget({
    super.key,
    required this.json,
    required this.indexStructure,
    required this.indexQuestions,
    required this.reglamentid,
    this.probeg,
    this.motohours,
    required this.equipid,
    required this.equipmentname,
    this.status,
  });

  final dynamic json;
  final int? indexStructure;
  final int? indexQuestions;
  final String? reglamentid;
  final int? probeg;
  final int? motohours;
  final String? equipid;
  final String? equipmentname;
  final String? status;

  @override
  State<OneFromListReglamentWidget> createState() =>
      _OneFromListReglamentWidgetState();
}

class _OneFromListReglamentWidgetState
    extends State<OneFromListReglamentWidget> {
  late OneFromListReglamentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OneFromListReglamentModel());

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

    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 10.0, 5.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      getJsonField(
                        widget.json,
                        r'''$.title''',
                      ).toString(),
                      textAlign: TextAlign.start,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    if (getJsonField(
                      widget.json,
                      r'''$.is_required''',
                    ))
                      Text(
                        ' *',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'SFProText',
                              color: FlutterFlowTheme.of(context).error,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                            ),
                      ),
                  ],
                ),
                FlutterFlowRadioButton(
                  options: (getJsonField(
                    widget.json,
                    r'''$.options[:].title''',
                    true,
                  ) as List?)!
                      .map<String>((e) => e.toString())
                      .toList()
                      .cast<String>()
                      .toList(),
                  onChanged: (widget.status == 'Пройден')
                      ? null
                      : (val) async {
                          safeSetState(() {});
                          _model.apiResultph6Copy3 =
                              await PutDetailedReglamentCall.call(
                            access: currentAuthenticationToken,
                            id: widget.reglamentid,
                            work: FFAppState().workspace,
                            jsonJson: functions.updateAtIndex(
                                FFAppState()
                                    .ReglamentDetailed
                                    .map((e) => e.toMap())
                                    .toList(),
                                widget.indexStructure!,
                                widget.indexQuestions!,
                                _model.radioButtonValue!,
                                'answers'),
                          );

                          FFAppState().ReglamentDetailed = functions
                              .updateAtIndex(
                                  FFAppState()
                                      .ReglamentDetailed
                                      .map((e) => e.toMap())
                                      .toList(),
                                  widget.indexStructure!,
                                  widget.indexQuestions!,
                                  _model.radioButtonValue!,
                                  'answers')
                              .map((e) =>
                                  StructureStruct.maybeFromMap(getJsonField(
                                    e,
                                    r'''$''',
                                  )))
                              .withoutNulls
                              .toList()
                              .cast<StructureStruct>();
                          FFAppState().update(() {});

                          safeSetState(() {});
                        },
                  controller: _model.radioButtonValueController ??=
                      FormFieldController<String>(getJsonField(
                    widget.json,
                    r'''$.answers[0]''',
                  ).toString()),
                  optionHeight: 32.0,
                  textStyle: FlutterFlowTheme.of(context).labelMedium.override(
                        font: GoogleFonts.readexPro(
                          fontWeight: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .labelMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).labelMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).labelMedium.fontStyle,
                      ),
                  selectedTextStyle:
                      FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'SFProText',
                            letterSpacing: 0.0,
                          ),
                  buttonPosition: RadioButtonPosition.left,
                  direction: Axis.vertical,
                  radioButtonColor: FlutterFlowTheme.of(context).primary,
                  inactiveRadioButtonColor:
                      FlutterFlowTheme.of(context).secondaryText,
                  toggleable: false,
                  horizontalAlignment: WrapAlignment.start,
                  verticalAlignment: WrapCrossAlignment.start,
                ),
              ]
                  .divide(SizedBox(height: 7.0))
                  .addToStart(SizedBox(height: 5.0))
                  .addToEnd(SizedBox(height: 5.0)),
            ),
          ),
        ],
      ),
    );
  }
}
