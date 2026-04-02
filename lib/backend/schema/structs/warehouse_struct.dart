// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WarehouseStruct extends BaseStruct {
  WarehouseStruct({
    String? id,
    String? workspaceId,
    String? name,
  })  : _id = id,
        _workspaceId = workspaceId,
        _name = name;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "workspace_id" field.
  String? _workspaceId;
  String get workspaceId => _workspaceId ?? '';
  set workspaceId(String? val) => _workspaceId = val;

  bool hasWorkspaceId() => _workspaceId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  static WarehouseStruct fromMap(Map<String, dynamic> data) => WarehouseStruct(
        id: data['id'] as String?,
        workspaceId: data['workspace_id'] as String?,
        name: data['name'] as String?,
      );

  static WarehouseStruct? maybeFromMap(dynamic data) => data is Map
      ? WarehouseStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'workspace_id': _workspaceId,
        'name': _name,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'workspace_id': serializeParam(
          _workspaceId,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
      }.withoutNulls;

  static WarehouseStruct fromSerializableMap(Map<String, dynamic> data) =>
      WarehouseStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        workspaceId: deserializeParam(
          data['workspace_id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WarehouseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WarehouseStruct &&
        id == other.id &&
        workspaceId == other.workspaceId &&
        name == other.name;
  }

  @override
  int get hashCode => const ListEquality().hash([id, workspaceId, name]);
}

WarehouseStruct createWarehouseStruct({
  String? id,
  String? workspaceId,
  String? name,
}) =>
    WarehouseStruct(
      id: id,
      workspaceId: workspaceId,
      name: name,
    );
