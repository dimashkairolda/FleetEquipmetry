// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class GetAreaStruct extends BaseStruct {
  GetAreaStruct({
    int? id,
    String? title,
  })  : _id = id,
        _title = title;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  static GetAreaStruct fromMap(Map<String, dynamic> data) => GetAreaStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
      );

  static GetAreaStruct? maybeFromMap(dynamic data) =>
      data is Map ? GetAreaStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
      }.withoutNulls;

  static GetAreaStruct fromSerializableMap(Map<String, dynamic> data) =>
      GetAreaStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'GetAreaStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is GetAreaStruct && id == other.id && title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([id, title]);
}

GetAreaStruct createGetAreaStruct({
  int? id,
  String? title,
}) =>
    GetAreaStruct(
      id: id,
      title: title,
    );
