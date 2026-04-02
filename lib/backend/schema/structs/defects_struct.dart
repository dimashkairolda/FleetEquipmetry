// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DefectsStruct extends BaseStruct {
  DefectsStruct({
    String? id,
    String? title,
    String? status,
  })  : _id = id,
        _title = title,
        _status = status;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "status" field.
  String? _status;
  String get status => _status ?? '';
  set status(String? val) => _status = val;

  bool hasStatus() => _status != null;

  static DefectsStruct fromMap(Map<String, dynamic> data) => DefectsStruct(
        id: data['id'] as String?,
        title: data['title'] as String?,
        status: data['status'] as String?,
      );

  static DefectsStruct? maybeFromMap(dynamic data) =>
      data is Map ? DefectsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'status': _status,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'status': serializeParam(
          _status,
          ParamType.String,
        ),
      }.withoutNulls;

  static DefectsStruct fromSerializableMap(Map<String, dynamic> data) =>
      DefectsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        status: deserializeParam(
          data['status'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DefectsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DefectsStruct &&
        id == other.id &&
        title == other.title &&
        status == other.status;
  }

  @override
  int get hashCode => const ListEquality().hash([id, title, status]);
}

DefectsStruct createDefectsStruct({
  String? id,
  String? title,
  String? status,
}) =>
    DefectsStruct(
      id: id,
      title: title,
      status: status,
    );
