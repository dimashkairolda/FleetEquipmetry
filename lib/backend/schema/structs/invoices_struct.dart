// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InvoicesStruct extends BaseStruct {
  InvoicesStruct({
    String? objectTitle,
    String? objectShortId,
    String? title,
    String? approvalMethod,
    String? objectType,
    List<String>? objectIds,
    List<ApproverIdsStruct>? approverIds,
    List<ApprovalInvoicesStruct>? approvalInvoices,
  })  : _objectTitle = objectTitle,
        _objectShortId = objectShortId,
        _title = title,
        _approvalMethod = approvalMethod,
        _objectType = objectType,
        _objectIds = objectIds,
        _approverIds = approverIds,
        _approvalInvoices = approvalInvoices;

  // "object_title" field.
  String? _objectTitle;
  String get objectTitle => _objectTitle ?? '';
  set objectTitle(String? val) => _objectTitle = val;

  bool hasObjectTitle() => _objectTitle != null;

  // "object_short_id" field.
  String? _objectShortId;
  String get objectShortId => _objectShortId ?? '';
  set objectShortId(String? val) => _objectShortId = val;

  bool hasObjectShortId() => _objectShortId != null;

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

  // "approver_ids" field.
  List<ApproverIdsStruct>? _approverIds;
  List<ApproverIdsStruct> get approverIds => _approverIds ?? const [];
  set approverIds(List<ApproverIdsStruct>? val) => _approverIds = val;

  void updateApproverIds(Function(List<ApproverIdsStruct>) updateFn) {
    updateFn(_approverIds ??= []);
  }

  bool hasApproverIds() => _approverIds != null;

  // "approval_invoices" field.
  List<ApprovalInvoicesStruct>? _approvalInvoices;
  List<ApprovalInvoicesStruct> get approvalInvoices =>
      _approvalInvoices ?? const [];
  set approvalInvoices(List<ApprovalInvoicesStruct>? val) =>
      _approvalInvoices = val;

  void updateApprovalInvoices(Function(List<ApprovalInvoicesStruct>) updateFn) {
    updateFn(_approvalInvoices ??= []);
  }

  bool hasApprovalInvoices() => _approvalInvoices != null;

  static InvoicesStruct fromMap(Map<String, dynamic> data) => InvoicesStruct(
        objectTitle: data['object_title'] as String?,
        objectShortId: data['object_short_id'] as String?,
        title: data['title'] as String?,
        approvalMethod: data['approval_method'] as String?,
        objectType: data['object_type'] as String?,
        objectIds: getDataList(data['object_ids']),
        approverIds: getStructList(
          data['approver_ids'],
          ApproverIdsStruct.fromMap,
        ),
        approvalInvoices: getStructList(
          data['approval_invoices'],
          ApprovalInvoicesStruct.fromMap,
        ),
      );

  static InvoicesStruct? maybeFromMap(dynamic data) =>
      data is Map ? InvoicesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'object_title': _objectTitle,
        'object_short_id': _objectShortId,
        'title': _title,
        'approval_method': _approvalMethod,
        'object_type': _objectType,
        'object_ids': _objectIds,
        'approver_ids': _approverIds?.map((e) => e.toMap()).toList(),
        'approval_invoices': _approvalInvoices?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'object_title': serializeParam(
          _objectTitle,
          ParamType.String,
        ),
        'object_short_id': serializeParam(
          _objectShortId,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'approval_method': serializeParam(
          _approvalMethod,
          ParamType.String,
        ),
        'object_type': serializeParam(
          _objectType,
          ParamType.String,
        ),
        'object_ids': serializeParam(
          _objectIds,
          ParamType.String,
          isList: true,
        ),
        'approver_ids': serializeParam(
          _approverIds,
          ParamType.DataStruct,
          isList: true,
        ),
        'approval_invoices': serializeParam(
          _approvalInvoices,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static InvoicesStruct fromSerializableMap(Map<String, dynamic> data) =>
      InvoicesStruct(
        objectTitle: deserializeParam(
          data['object_title'],
          ParamType.String,
          false,
        ),
        objectShortId: deserializeParam(
          data['object_short_id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        approvalMethod: deserializeParam(
          data['approval_method'],
          ParamType.String,
          false,
        ),
        objectType: deserializeParam(
          data['object_type'],
          ParamType.String,
          false,
        ),
        objectIds: deserializeParam<String>(
          data['object_ids'],
          ParamType.String,
          true,
        ),
        approverIds: deserializeStructParam<ApproverIdsStruct>(
          data['approver_ids'],
          ParamType.DataStruct,
          true,
          structBuilder: ApproverIdsStruct.fromSerializableMap,
        ),
        approvalInvoices: deserializeStructParam<ApprovalInvoicesStruct>(
          data['approval_invoices'],
          ParamType.DataStruct,
          true,
          structBuilder: ApprovalInvoicesStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InvoicesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InvoicesStruct &&
        objectTitle == other.objectTitle &&
        objectShortId == other.objectShortId &&
        title == other.title &&
        approvalMethod == other.approvalMethod &&
        objectType == other.objectType &&
        listEquality.equals(objectIds, other.objectIds) &&
        listEquality.equals(approverIds, other.approverIds) &&
        listEquality.equals(approvalInvoices, other.approvalInvoices);
  }

  @override
  int get hashCode => const ListEquality().hash([
        objectTitle,
        objectShortId,
        title,
        approvalMethod,
        objectType,
        objectIds,
        approverIds,
        approvalInvoices
      ]);
}

InvoicesStruct createInvoicesStruct({
  String? objectTitle,
  String? objectShortId,
  String? title,
  String? approvalMethod,
  String? objectType,
}) =>
    InvoicesStruct(
      objectTitle: objectTitle,
      objectShortId: objectShortId,
      title: title,
      approvalMethod: approvalMethod,
      objectType: objectType,
    );
