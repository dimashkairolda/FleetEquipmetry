// ignore_for_file: unnecessary_getters_setters

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ProcurementStruct extends BaseStruct {
  ProcurementStruct({
    String? workspaceId,
    String? parentId,
    String? title,
    String? deliveryAddress,
    String? buyerId,
    String? availableDue,
    List<String>? defectIds,
    String? flowType,
    String? warehouseModeType,
    bool? manualKp,
    bool? integrationWithEds,
    String? comment,
    String? status,
    List<InventoryItemsStruct>? inventoryItems,
  })  : _workspaceId = workspaceId,
        _parentId = parentId,
        _title = title,
        _deliveryAddress = deliveryAddress,
        _buyerId = buyerId,
        _availableDue = availableDue,
        _defectIds = defectIds,
        _flowType = flowType,
        _warehouseModeType = warehouseModeType,
        _manualKp = manualKp,
        _integrationWithEds = integrationWithEds,
        _comment = comment,
        _status = status,
        _inventoryItems = inventoryItems;

  // "workspace_id" field.
  String? _workspaceId;
  String get workspaceId => _workspaceId ?? '';
  set workspaceId(String? val) => _workspaceId = val;
  bool hasWorkspaceId() => _workspaceId != null;

  // "parent_id" field.
  String? _parentId;
  String get parentId => _parentId ?? '';
  set parentId(String? val) => _parentId = val;
  bool hasParentId() => _parentId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "delivery_address" field.
  String? _deliveryAddress;
  String get deliveryAddress => _deliveryAddress ?? '';
  set deliveryAddress(String? val) => _deliveryAddress = val;
  bool hasDeliveryAddress() => _deliveryAddress != null;

  // "buyer_id" field.
  String? _buyerId;
  String get buyerId => _buyerId ?? '';
  set buyerId(String? val) => _buyerId = val;
  bool hasBuyerId() => _buyerId != null;

  // "available_due" field.
  String? _availableDue;
  String get availableDue => _availableDue ?? '';
  set availableDue(String? val) => _availableDue = val;
  bool hasAvailableDue() => _availableDue != null;

  // "defect_ids" field.
  List<String>? _defectIds;
  List<String> get defectIds => _defectIds ?? const [];
  set defectIds(List<String>? val) => _defectIds = val;
  void updateDefectIds(Function(List<String>) updateFn) {
    updateFn(_defectIds ??= []);
  }
  bool hasDefectIds() => _defectIds != null;

  // "flow_type" field.
  String? _flowType;
  String get flowType => _flowType ?? '';
  set flowType(String? val) => _flowType = val;
  bool hasFlowType() => _flowType != null;

  // "warehouse_mode_type" field.
  String? _warehouseModeType;
  String get warehouseModeType => _warehouseModeType ?? '';
  set warehouseModeType(String? val) => _warehouseModeType = val;
  bool hasWarehouseModeType() => _warehouseModeType != null;

  // "manual_kp" field.
  bool? _manualKp;
  bool get manualKp => _manualKp ?? false;
  set manualKp(bool? val) => _manualKp = val;
  bool hasManualKp() => _manualKp != null;

  // "integration_with_eds" field.
  bool? _integrationWithEds;
  bool get integrationWithEds => _integrationWithEds ?? false;
  set integrationWithEds(bool? val) => _integrationWithEds = val;
  bool hasIntegrationWithEds() => _integrationWithEds != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;
  bool hasComment() => _comment != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;
  bool hasStatus() => _status != null;

  // "inventory_items" field.
  List<InventoryItemsStruct>? _inventoryItems;
  List<InventoryItemsStruct> get inventoryItems => _inventoryItems ?? const [];
  set inventoryItems(List<InventoryItemsStruct>? val) => _inventoryItems = val;
  void updateInventoryItems(Function(List<InventoryItemsStruct>) updateFn) {
    updateFn(_inventoryItems ??= []);
  }
  bool hasInventoryItems() => _inventoryItems != null;

  static ProcurementStruct fromMap(Map<String, dynamic> data) =>
      ProcurementStruct(
        workspaceId: data['workspace_id'] as String?,
        parentId: data['parent_id'] as String?,
        title: data['title'] as String?,
        deliveryAddress: data['delivery_address'] as String?,
        buyerId: data['buyer_id'] as String?,
        availableDue: data['available_due'] as String?,
        defectIds: getDataList(data['defect_ids']),
        flowType: data['flow_type'] as String?,
        warehouseModeType: data['warehouse_mode_type'] as String?,
        manualKp: data['manual_kp'] as bool?,
        integrationWithEds: data['integration_with_eds'] as bool?,
        comment: data['comment'] as String?,
        status: data['status'] as String?,
        inventoryItems: getStructList(
          data['inventory_items'],
          InventoryItemsStruct.fromMap,
        ),
      );

  static ProcurementStruct? maybeFromMap(dynamic data) => data is Map
      ? ProcurementStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'workspace_id': _workspaceId,
        'parent_id': _parentId,
        'title': _title,
        'delivery_address': _deliveryAddress,
        'buyer_id': _buyerId,
        'available_due': _availableDue,
        'defect_ids': _defectIds,
        'flow_type': _flowType,
        'warehouse_mode_type': _warehouseModeType,
        'manual_kp': _manualKp,
        'integration_with_eds': _integrationWithEds,
        'comment': _comment,
        'status': _status,
        'inventory_items': _inventoryItems?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'workspace_id': serializeParam(_workspaceId, ParamType.String),
        'parent_id': serializeParam(_parentId, ParamType.String),
        'title': serializeParam(_title, ParamType.String),
        'delivery_address': serializeParam(_deliveryAddress, ParamType.String),
        'buyer_id': serializeParam(_buyerId, ParamType.String),
        'available_due': serializeParam(_availableDue, ParamType.String),
        'defect_ids': serializeParam(_defectIds, ParamType.String, isList: true),
        'flow_type': serializeParam(_flowType, ParamType.String),
        'warehouse_mode_type': serializeParam(_warehouseModeType, ParamType.String),
        'manual_kp': serializeParam(_manualKp, ParamType.bool),
        'integration_with_eds': serializeParam(_integrationWithEds, ParamType.bool),
        'comment': serializeParam(_comment, ParamType.String),
        'status': serializeParam(_status, ParamType.String),
        'inventory_items': serializeParam(_inventoryItems, ParamType.DataStruct, isList: true),
      }.withoutNulls;

  static ProcurementStruct fromSerializableMap(Map<String, dynamic> data) =>
      ProcurementStruct(
        workspaceId: deserializeParam(data['workspace_id'], ParamType.String, false),
        parentId: deserializeParam(data['parent_id'], ParamType.String, false),
        title: deserializeParam(data['title'], ParamType.String, false),
        deliveryAddress: deserializeParam(data['delivery_address'], ParamType.String, false),
        buyerId: deserializeParam(data['buyer_id'], ParamType.String, false),
        availableDue: deserializeParam(data['available_due'], ParamType.String, false),
        defectIds: deserializeParam<String>(data['defect_ids'], ParamType.String, true),
        flowType: deserializeParam(data['flow_type'], ParamType.String, false),
        warehouseModeType: deserializeParam(data['warehouse_mode_type'], ParamType.String, false),
        manualKp: deserializeParam(data['manual_kp'], ParamType.bool, false),
        integrationWithEds: deserializeParam(data['integration_with_eds'], ParamType.bool, false),
        comment: deserializeParam(data['comment'], ParamType.String, false),
        status: deserializeParam(data['status'], ParamType.String, false),
        inventoryItems: deserializeStructParam<InventoryItemsStruct>(
          data['inventory_items'],
          ParamType.DataStruct,
          true,
          structBuilder: InventoryItemsStruct.fromSerializableMap,
        ),
      );

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ProcurementStruct &&
        workspaceId == other.workspaceId &&
        parentId == other.parentId &&
        title == other.title &&
        deliveryAddress == other.deliveryAddress &&
        buyerId == other.buyerId &&
        availableDue == other.availableDue &&
        listEquality.equals(defectIds, other.defectIds) &&
        flowType == other.flowType &&
        warehouseModeType == other.warehouseModeType &&
        manualKp == other.manualKp &&
        integrationWithEds == other.integrationWithEds &&
        comment == other.comment &&
        status == other.status &&
        listEquality.equals(inventoryItems, other.inventoryItems);
  }

  @override
  int get hashCode => const ListEquality().hash([
        workspaceId,
        parentId,
        title,
        deliveryAddress,
        buyerId,
        availableDue,
        defectIds,
        flowType,
        warehouseModeType,
        manualKp,
        integrationWithEds,
        comment,
        status,
        inventoryItems
      ]);
}

ProcurementStruct createProcurementStruct({
  String? workspaceId,
  String? parentId,
  String? title,
  String? deliveryAddress,
  String? buyerId,
  String? availableDue,
  String? flowType,
  String? warehouseModeType,
  bool? manualKp,
  bool? integrationWithEds,
  String? comment,
  String? status,
}) =>
    ProcurementStruct(
      workspaceId: workspaceId,
      parentId: parentId,
      title: title,
      deliveryAddress: deliveryAddress,
      buyerId: buyerId,
      availableDue: availableDue,
      flowType: flowType,
      warehouseModeType: warehouseModeType,
      manualKp: manualKp,
      integrationWithEds: integrationWithEds,
      comment: comment,
      status: status,
    );