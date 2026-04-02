// ignore_for_file: unnecessary_getters_setters

import 'package:Equipmetry/backend/schema/structs/approval_procurementss_struct.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApprovalProcurementStruct extends BaseStruct {
  ApprovalProcurementStruct({
    String? title,
    String? approvalMethod,
    String? objectType,
    List<String>? objectIds,
    List<ApprovalProcurementssStruct>? approvalProcurements, // Настроено как List<String> на основе визуальной схожести с object_ids, либо замените на конкретный Struct если нужно
    List<ApproverIdsStruct>? approverIds, // Аналогично, если в FF это список ID
  })  : _title = title,
        _approvalMethod = approvalMethod,
        _objectType = objectType,
        _objectIds = objectIds,
        _approvalProcurements = approvalProcurements,
        _approverIds = approverIds;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "approval_method" field.
  String? _approvalMethod;
  String get approvalMethod => _approvalMethod ?? '';
  set approvalMethod(String? val) => _approvalMethod = val;
  bool hasApprovalMethod() => _approvalMethod != null;

  // "object_type" field.
  String? _objectType;
  String get objectType => _objectType ?? '';
  set objectType(String? val) => _objectType = val;
  bool hasObjectType() => _objectType != null;

  // "object_ids" field.
  List<String>? _objectIds;
  List<String> get objectIds => _objectIds ?? const [];
  set objectIds(List<String>? val) => _objectIds = val;
  void updateObjectIds(Function(List<String>) updateFn) {
    updateFn(_objectIds ??= []);
  }
  bool hasObjectIds() => _objectIds != null;

  // "approval_procurements" field.
  // Примечание: на скриншоте указан тип List<Data (approval_procurements)>. 
  // Если это вложенная структура, замените String на соответствующий тип.
    // "approval_procurements" field.
  List<ApprovalProcurementssStruct>? _approvalProcurements;
  List<ApprovalProcurementssStruct> get approvalProcurements =>
      _approvalProcurements ?? const [];
  set approvalProcurements(List<ApprovalProcurementssStruct>? val) =>
      _approvalProcurements = val;
  void updateApprovalProcurements(Function(List<ApprovalProcurementssStruct>) updateFn) {
    updateFn(_approvalProcurements ??= []);
  }

  bool hasApprovalProcurements() => _approvalProcurements != null;

  // "approver_ids" field.
  List<ApproverIdsStruct>? _approverIds;
  List<ApproverIdsStruct> get approverIds => _approverIds ?? const [];
  set approverIds(List<ApproverIdsStruct>? val) => _approverIds = val;
  void updateApproverIds(Function(List<ApproverIdsStruct>) updateFn) {
    updateFn(_approverIds ??= []);
  }
  bool hasApproverIds() => _approverIds != null;

  static ApprovalProcurementStruct fromMap(Map<String, dynamic> data) =>
      ApprovalProcurementStruct(
        title: data['title'] as String?,
        approvalMethod: data['approval_method'] as String?,
        objectType: data['object_type'] as String?,
        objectIds: getDataList(data['object_ids']),
        approvalProcurements: getStructList(
          data['approval_procurements'],
          ApprovalProcurementssStruct.fromMap,
        ),
        approverIds: getStructList(
          data['approver_ids'],
          ApproverIdsStruct.fromMap,
        )
      );

  static ApprovalProcurementStruct? maybeFromMap(dynamic data) => data is Map
      ? ApprovalProcurementStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'approval_method': _approvalMethod,
        'object_type': _objectType,
        'object_ids': _objectIds,
        'approval_procurements': _approvalProcurements?.map((e) => e.toMap()).toList(),
        'approver_ids': _approverIds?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(_title, ParamType.String),
        'approval_method': serializeParam(_approvalMethod, ParamType.String),
        'object_type': serializeParam(_objectType, ParamType.String),
        'object_ids': serializeParam(_objectIds, ParamType.String, isList: true),
        'approval_procurements': serializeParam(_approvalProcurements, ParamType.DataStruct, isList: true),
        'approver_ids': serializeParam(_approverIds, ParamType.DataStruct, isList: true),
      }.withoutNulls;

  static ApprovalProcurementStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ApprovalProcurementStruct(
        title: deserializeParam(data['title'], ParamType.String, false),
        approvalMethod: deserializeParam(data['approval_method'], ParamType.String, false),
        objectType: deserializeParam(data['object_type'], ParamType.String, false),
        objectIds: deserializeParam<String>(data['object_ids'], ParamType.String, true),
        approvalProcurements: deserializeParam<String>(data['approval_procurements'], ParamType.String, true),
        approverIds: deserializeParam<String>(data['approver_ids'], ParamType.String, true),
      );

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ApprovalProcurementStruct &&
        title == other.title &&
        approvalMethod == other.approvalMethod &&
        objectType == other.objectType &&
        listEquality.equals(objectIds, other.objectIds) &&
        listEquality.equals(approvalProcurements, other.approvalProcurements) &&
        listEquality.equals(approverIds, other.approverIds);
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        approvalMethod,
        objectType,
        objectIds,
        approvalProcurements,
        approverIds
      ]);
}

ApprovalProcurementStruct createApprovalProcurementStruct({
  String? title,
  String? approvalMethod,
  String? objectType,
}) =>
    ApprovalProcurementStruct(
      title: title,
      approvalMethod: approvalMethod,
      objectType: objectType,
    );