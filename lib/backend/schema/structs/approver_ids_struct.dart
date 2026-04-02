// ignore_for_file: unnecessary_getters_setters


import 'package:Equipmetry/backend/schema/structs/procurement_approved_struct.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApproverIdsStruct extends BaseStruct {
  ApproverIdsStruct({
    String? approverId,
    String? approved,
    int? order,
    List<InvoiceApprovedStruct>? invoiceApproved,
    List<ProcurementApprovedStruct>? procurementApproved,
  })  : _approverId = approverId,
        _approved = approved,
        _order = order,
        _invoiceApproved = invoiceApproved,
        _procurementApproved = procurementApproved;
  // "approver_id" field.
  String? _approverId;
  String get approverId => _approverId ?? '';
  set approverId(String? val) => _approverId = val;

  bool hasApproverId() => _approverId != null;

  // "approved" field.
  String? _approved;
  String get approved => _approved ?? '';
  set approved(String? val) => _approved = val;

  bool hasApproved() => _approved != null;

  // "order" field.
  int? _order;
  int get order => _order ?? 0;
  set order(int? val) => _order = val;

  void incrementOrder(int amount) => order = order + amount;

  bool hasOrder() => _order != null;

  // "invoice_approved" field.
  List<InvoiceApprovedStruct>? _invoiceApproved;
  List<InvoiceApprovedStruct> get invoiceApproved =>
      _invoiceApproved ?? const [];
  set invoiceApproved(List<InvoiceApprovedStruct>? val) =>
      _invoiceApproved = val;

  void updateInvoiceApproved(Function(List<InvoiceApprovedStruct>) updateFn) {
    updateFn(_invoiceApproved ??= []);
  }

  bool hasInvoiceApproved() => _invoiceApproved != null;

    // "procurement_approved" field.
  List<ProcurementApprovedStruct>? _procurementApproved;
  List<ProcurementApprovedStruct> get procurementApproved =>
      _procurementApproved ?? const [];
  set procurementApproved(List<ProcurementApprovedStruct>? val) =>
      _procurementApproved = val;
  void updateProcurementApproved(Function(List<ProcurementApprovedStruct>) updateFn) {
    updateFn(_procurementApproved ??= []);
  }

  bool hasProcurementApproved() => _procurementApproved != null;

  static ApproverIdsStruct fromMap(Map<String, dynamic> data) =>
      ApproverIdsStruct(
        approverId: data['approver_id'] as String?,
        approved: data['approved'] as String?,
        order: castToType<int>(data['order']),
        invoiceApproved: getStructList(
          data['invoice_approved'],
          InvoiceApprovedStruct.fromMap,
        ),
        procurementApproved: getStructList(
          data['procurement_approved'],
          ProcurementApprovedStruct.fromMap,
        ),
      );

  static ApproverIdsStruct? maybeFromMap(dynamic data) => data is Map
      ? ApproverIdsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'approver_id': _approverId,
        'approved': _approved,
        'order': _order,
        'invoice_approved': _invoiceApproved?.map((e) => e.toMap()).toList(),
        'procurement_approved': _procurementApproved?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'approver_id': serializeParam(
          _approverId,
          ParamType.String,
        ),
        'approved': serializeParam(
          _approved,
          ParamType.String,
        ),
        'order': serializeParam(
          _order,
          ParamType.int,
        ),
        'invoice_approved': serializeParam(
          _invoiceApproved,
          ParamType.DataStruct,
          isList: true,
        ),
        'procurement_approved': serializeParam(
          _procurementApproved,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static ApproverIdsStruct fromSerializableMap(Map<String, dynamic> data) =>
      ApproverIdsStruct(
        approverId: deserializeParam(
          data['approver_id'],
          ParamType.String,
          false,
        ),
        approved: deserializeParam(
          data['approved'],
          ParamType.String,
          false,
        ),
        order: deserializeParam(
          data['order'],
          ParamType.int,
          false,
        ),
        invoiceApproved: deserializeStructParam<InvoiceApprovedStruct>(
          data['invoice_approved'],
          ParamType.DataStruct,
          true,
          structBuilder: InvoiceApprovedStruct.fromSerializableMap,
        ),
        procurementApproved: deserializeStructParam<ProcurementApprovedStruct>(
          data['procurement_approved'],
          ParamType.DataStruct,
          true,
          structBuilder: ProcurementApprovedStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ApproverIdsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ApproverIdsStruct &&
        approverId == other.approverId &&
        approved == other.approved &&
        order == other.order &&
        listEquality.equals(invoiceApproved, other.invoiceApproved) &&
        listEquality.equals(procurementApproved, other.procurementApproved);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([approverId, approved, order, invoiceApproved, procurementApproved]);
}

ApproverIdsStruct createApproverIdsStruct({
  String? approverId,
  String? approved,
  int? order,
  List<ProcurementApprovedStruct>? procurementApproved,
}) =>
    ApproverIdsStruct(
      approverId: approverId,
      approved: approved,
      order: order,
      procurementApproved: procurementApproved,
    );
