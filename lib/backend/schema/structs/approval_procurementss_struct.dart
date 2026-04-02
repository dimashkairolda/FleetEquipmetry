// ignore_for_file: unnecessary_getters_setters

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApprovalProcurementssStruct extends BaseStruct {
  ApprovalProcurementssStruct({
    String? procurementId,
  }) : _procurementId = procurementId;

  // "procurement_id" field.
  String? _procurementId;
  String get procurementId => _procurementId ?? '';
  set procurementId(String? val) => _procurementId = val;
  bool hasProcurementId() => _procurementId != null;

  static ApprovalProcurementssStruct fromMap(Map<String, dynamic> data) =>
      ApprovalProcurementssStruct(
        procurementId: data['procurement_id'] as String?,
      );

  static ApprovalProcurementssStruct? maybeFromMap(dynamic data) => data is Map
      ? ApprovalProcurementssStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'procurement_id': _procurementId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'procurement_id': serializeParam(_procurementId, ParamType.String),
      }.withoutNulls;

  static ApprovalProcurementssStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ApprovalProcurementssStruct(
        procurementId:
            deserializeParam(data['procurement_id'], ParamType.String, false),
      );

  // Метод для преобразования списка структур в список Map (удобно для API)
  static List<Map<String, dynamic>> toList(
          List<ApprovalProcurementssStruct>? items) =>
      items?.map((e) => e.toMap()).toList() ?? [];

  @override
  bool operator ==(Object other) {
    return other is ApprovalProcurementssStruct &&
        procurementId == other.procurementId;
  }

  @override
  int get hashCode => const ListEquality().hash([procurementId]);
}

ApprovalProcurementssStruct createApprovalProcurementssStruct({
  String? procurementId,
}) =>
    ApprovalProcurementssStruct(
      procurementId: procurementId,
    );