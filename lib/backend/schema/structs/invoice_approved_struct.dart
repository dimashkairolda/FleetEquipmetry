// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvoiceApprovedStruct extends BaseStruct {
  InvoiceApprovedStruct({
    String? invoiceId,
    String? approved,
  })  : _invoiceId = invoiceId,
        _approved = approved;

  // "invoice_id" field.
  String? _invoiceId;
  String get invoiceId => _invoiceId ?? '';
  set invoiceId(String? val) => _invoiceId = val;

  bool hasInvoiceId() => _invoiceId != null;

  // "approved" field.
  String? _approved;
  String get approved => _approved ?? '';
  set approved(String? val) => _approved = val;

  bool hasApproved() => _approved != null;

  static InvoiceApprovedStruct fromMap(Map<String, dynamic> data) =>
      InvoiceApprovedStruct(
        invoiceId: data['invoice_id'] as String?,
        approved: data['approved'] as String?,
      );

  static InvoiceApprovedStruct? maybeFromMap(dynamic data) => data is Map
      ? InvoiceApprovedStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'invoice_id': _invoiceId,
        'approved': _approved,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'invoice_id': serializeParam(
          _invoiceId,
          ParamType.String,
        ),
        'approved': serializeParam(
          _approved,
          ParamType.String,
        ),
      }.withoutNulls;

  static InvoiceApprovedStruct fromSerializableMap(Map<String, dynamic> data) =>
      InvoiceApprovedStruct(
        invoiceId: deserializeParam(
          data['invoice_id'],
          ParamType.String,
          false,
        ),
        approved: deserializeParam(
          data['approved'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'InvoiceApprovedStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InvoiceApprovedStruct &&
        invoiceId == other.invoiceId &&
        approved == other.approved;
  }

  @override
  int get hashCode => const ListEquality().hash([invoiceId, approved]);
}

InvoiceApprovedStruct createInvoiceApprovedStruct({
  String? invoiceId,
  String? approved,
}) =>
    InvoiceApprovedStruct(
      invoiceId: invoiceId,
      approved: approved,
    );
