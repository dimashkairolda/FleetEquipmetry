import 'package:Equipmetry/auth/custom_auth/auth_util.dart';
import 'package:Equipmetry/backend/api_requests/api_calls.dart';
import 'package:Equipmetry/backend/schema/structs/approval_procurement_struct.dart';
import 'package:Equipmetry/backend/schema/structs/approval_procurementss_struct.dart';
import 'package:Equipmetry/backend/schema/structs/approver_ids_struct.dart';
import 'package:Equipmetry/backend/schema/structs/procurement_approved_struct.dart';
import 'package:Equipmetry/procurement/procurement_flow_config.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import 'package:flutter/material.dart';

import 'compare_offers_model.dart';
export 'compare_offers_model.dart';

class CompareOffersWidget extends StatefulWidget {
  const CompareOffersWidget({
    super.key,
    required this.json,
  });

  final dynamic json;

  static String routeName = 'compareOffers';
  static String routePath = '/compareOffers';

  @override
  State<CompareOffersWidget> createState() => _CompareOffersWidgetState();
}

class _CompareOffersWidgetState extends State<CompareOffersWidget> {
  late CompareOffersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompareOffersModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  // Показывает bottom sheet выбора согласовантов и возвращает выбранные id,
  // либо null если пользователь отменил.
  Future<List<String>?> _showApproverSheet({
    required bool requiresApproval,
  }) async {
    List<dynamic> usersList = [];
    List<String> selectedApprovers = [];

    // Загружаем пользователей заранее.
    final usersResp = await GetUsersCall.call(
      access: currentAuthenticationToken,
      work: FFAppState().workspace,
    );
    if (usersResp.succeeded) {
      final body = usersResp.jsonBody;
      usersList = body is List ? body : [];
    }

    final List<String>? result = await showModalBottomSheet<List<String>>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateSheet) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text(
                    'Отправить на согласование?',
                    style: FlutterFlowTheme.of(context)
                        .headlineSmall
                        .copyWith(fontFamily: 'SFProText'),
                  ),
                  const SizedBox(height: 20),
                  if (requiresApproval) ...[
                    Text(
                      'Согласованты',
                      style:
                          FlutterFlowTheme.of(context).bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                fontFamily: 'SFProText',
                              ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      constraints: const BoxConstraints(maxHeight: 220),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: usersList.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              itemCount: usersList.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, idx) {
                                final user = usersList[idx];
                                final String uid =
                                    user['id']?.toString() ?? '';
                                final String name =
                                    '${user['name']?['first'] ?? ''} ${user['name']?['last'] ?? ''}'
                                        .trim();
                                final bool isSelected =
                                    selectedApprovers.contains(uid);
                                return CheckboxListTile(
                                  dense: true,
                                  title: Text(name,
                                      style:
                                          FlutterFlowTheme.of(context).bodyMedium),
                                  value: isSelected,
                                  activeColor:
                                      FlutterFlowTheme.of(context).primary,
                                  onChanged: (val) {
                                    setStateSheet(() {
                                      if (val == true) {
                                        selectedApprovers.add(uid);
                                      } else {
                                        selectedApprovers.remove(uid);
                                      }
                                    });
                                  },
                                );
                              },
                            ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context, null),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48)),
                          child: const Text('Отмена'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context, selectedApprovers),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                FlutterFlowTheme.of(context).primary,
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text('Отправить',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: SingleChildScrollView(
          primary: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: custom_widgets.MobileCompareOffers(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  procurementData: widget.json!,
                  onAddToCart: (selectedOffers) async {
                    final String flowType = getJsonField(
                      widget.json,
                      r'''$.flow_type''',
                    ).toString();
                    final bool requiresApproval = ProcurementFlowConfig
                        .fromFlowType(flowType)
                        .requiresPublicationApproval;

                    // Показываем диалог выбора согласовантов
                    final List<String>? chosenApprovers =
                        await _showApproverSheet(
                      requiresApproval: requiresApproval,
                    );

                    // Если пользователь нажал "Отмена" — прерываем
                    if (chosenApprovers == null) return;

                    String? publicationApprovalId;

                    if (requiresApproval && chosenApprovers.isNotEmpty) {
                      final List<ApproverIdsStruct> approverStructs =
                          chosenApprovers.asMap().entries.map((e) {
                        return ApproverIdsStruct(
                          approverId: e.value,
                          approved: null,
                          procurementApproved: [
                            ProcurementApprovedStruct(
                              procurementId: getJsonField(
                                      widget.json, r'''$.id''')
                                  .toString(),
                              approved: null,
                            ),
                          ],
                          order: e.key + 1,
                        );
                      }).toList();

                      _model.apiResult5a23 =
                          await CreateProcurementApprovalCall.call(
                        access: currentAuthenticationToken,
                        work: FFAppState().workspace,
                        bodyJson: ApprovalProcurementStruct(
                          title:
                              'Закуп запчастей RFQ${getJsonField(widget.json, r'''$.short_id''').toString()}',
                          approvalMethod: 'SEQUENTIAL',
                          objectType: 'PROCUREMENT_KP',
                          objectIds: [
                            getJsonField(widget.json, r'''$.id''').toString()
                          ],
                          approverIds: approverStructs,
                          approvalProcurements: [
                            ApprovalProcurementssStruct(
                              procurementId:
                                  getJsonField(widget.json, r'''$.id''')
                                      .toString(),
                            )
                          ],
                        ).toMap(),
                      );
                      publicationApprovalId =
                          _model.apiResult5a23?.jsonBody['id']?.toString();
                    }

                    _model.apiResult5a234 = await ChooseKPCall.call(
                      access: currentAuthenticationToken,
                      work: FFAppState().workspace,
                      offers_selected: selectedOffers,
                      id: getJsonField(widget.json, r'''$.id''').toString(),
                      approverIds: (requiresApproval && chosenApprovers.isNotEmpty) ? chosenApprovers : [],
                      publication_approval_id: publicationApprovalId ?? '',
                    );
                    context.safePop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
