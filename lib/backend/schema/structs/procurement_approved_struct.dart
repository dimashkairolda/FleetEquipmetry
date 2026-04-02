// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProcurementApprovedStruct extends BaseStruct {
  ProcurementApprovedStruct({
    String? procurementId,
    String? approved,
  })  : _procurementId = procurementId,
        _approved = approved;

  // "procurement_id" field.
  String? _procurementId;
  String get procurementId => _procurementId ?? '';
  set procurementId(String? val) => _procurementId = val;

  bool hasProcurementId() => _procurementId != null;

  // "approved" field.
  String? _approved;
  String get approved => _approved ?? '';
  set approved(String? val) => _approved = val;

  bool hasApproved() => _approved != null;

  static ProcurementApprovedStruct fromMap(Map<String, dynamic> data) =>
      ProcurementApprovedStruct(
        procurementId: data['procurement_id'] as String?,
        approved: data['approved'] as String?,
      );

  static ProcurementApprovedStruct? maybeFromMap(dynamic data) => data is Map
      ? ProcurementApprovedStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'procurement_id': _procurementId,
        'approved': _approved,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'procurement_id': serializeParam(
          _procurementId,
          ParamType.String,
        ),
        'approved': serializeParam(
          _approved,
          ParamType.String,
        ),
      }.withoutNulls;

  static ProcurementApprovedStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProcurementApprovedStruct(
        procurementId: deserializeParam(
          data['procurement_id'],
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
    return other is ProcurementApprovedStruct &&
        procurementId == other.procurementId &&
        approved == other.approved;
  }

  @override
  int get hashCode => const ListEquality().hash([procurementId, approved]);
  // Метод для преобразования списка структур в список Map
  static List<Object> toList(List<ProcurementApprovedStruct>? items) =>
      items?.map((e) => e.toMap()).toList() ?? [];
}

ProcurementApprovedStruct createProcurementApprovedStruct({
  String? procurementId,
  String? approved,
}) =>
    ProcurementApprovedStruct(
      procurementId: procurementId,
      approved: approved,
    );
