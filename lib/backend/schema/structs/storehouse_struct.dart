// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StorehouseStruct extends BaseStruct {
  StorehouseStruct({
    WarehouseStruct? warehouse,
    List<String>? approverIds,
  })  : _warehouse = warehouse,
        _approverIds = approverIds;

  // "warehouse" field.
  WarehouseStruct? _warehouse;
  WarehouseStruct get warehouse => _warehouse ?? WarehouseStruct();
  set warehouse(WarehouseStruct? val) => _warehouse = val;

  void updateWarehouse(Function(WarehouseStruct) updateFn) {
    updateFn(_warehouse ??= WarehouseStruct());
  }

  bool hasWarehouse() => _warehouse != null;

  // "approver_ids" field.
  List<String>? _approverIds;
  List<String> get approverIds => _approverIds ?? const [];
  set approverIds(List<String>? val) => _approverIds = val;

  void updateApproverIds(Function(List<String>) updateFn) {
    updateFn(_approverIds ??= []);
  }

  bool hasApproverIds() => _approverIds != null;

  static StorehouseStruct fromMap(Map<String, dynamic> data) =>
      StorehouseStruct(
        warehouse: data['warehouse'] is WarehouseStruct
            ? data['warehouse']
            : WarehouseStruct.maybeFromMap(data['warehouse']),
        approverIds: getDataList(data['approver_ids']),
      );

  static StorehouseStruct? maybeFromMap(dynamic data) => data is Map
      ? StorehouseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'warehouse': _warehouse?.toMap(),
        'approver_ids': _approverIds,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'warehouse': serializeParam(
          _warehouse,
          ParamType.DataStruct,
        ),
        'approver_ids': serializeParam(
          _approverIds,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static StorehouseStruct fromSerializableMap(Map<String, dynamic> data) =>
      StorehouseStruct(
        warehouse: deserializeStructParam(
          data['warehouse'],
          ParamType.DataStruct,
          false,
          structBuilder: WarehouseStruct.fromSerializableMap,
        ),
        approverIds: deserializeParam<String>(
          data['approver_ids'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'StorehouseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is StorehouseStruct &&
        warehouse == other.warehouse &&
        listEquality.equals(approverIds, other.approverIds);
  }

  @override
  int get hashCode => const ListEquality().hash([warehouse, approverIds]);
}

StorehouseStruct createStorehouseStruct({
  WarehouseStruct? warehouse,
}) =>
    StorehouseStruct(
      warehouse: warehouse ?? WarehouseStruct(),
    );
