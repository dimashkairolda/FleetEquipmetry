// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ReferencesStruct extends BaseStruct {
  ReferencesStruct({
    String? type,
    String? id,
  })  : _type = type,
        _id = id;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  static ReferencesStruct fromMap(Map<String, dynamic> data) =>
      ReferencesStruct(
        type: data['type'] as String?,
        id: data['id'] as String?,
      );

  static ReferencesStruct? maybeFromMap(dynamic data) => data is Map
      ? ReferencesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'id': _id,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
      }.withoutNulls;

  static ReferencesStruct fromSerializableMap(Map<String, dynamic> data) =>
      ReferencesStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ReferencesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ReferencesStruct && type == other.type && id == other.id;
  }

  @override
  int get hashCode => const ListEquality().hash([type, id]);
}

ReferencesStruct createReferencesStruct({
  String? type,
  String? id,
}) =>
    ReferencesStruct(
      type: type,
      id: id,
    );
