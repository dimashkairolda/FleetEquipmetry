// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OptionsStruct extends BaseStruct {
  OptionsStruct({
    String? title,
    String? color,
    String? key,
  })  : _title = title,
        _color = color,
        _key = key;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "color" field.
  String? _color;
  String get color => _color ?? '';
  set color(String? val) => _color = val;

  bool hasColor() => _color != null;

  // "key" field.
  String? _key;
  String get key => _key ?? '';
  set key(String? val) => _key = val;

  bool hasKey() => _key != null;

  static OptionsStruct fromMap(Map<String, dynamic> data) => OptionsStruct(
        title: data['title'] as String?,
        color: data['color'] as String?,
        key: data['key'] as String?,
      );

  static OptionsStruct? maybeFromMap(dynamic data) =>
      data is Map ? OptionsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'color': _color,
        'key': _key,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'color': serializeParam(
          _color,
          ParamType.String,
        ),
        'key': serializeParam(
          _key,
          ParamType.String,
        ),
      }.withoutNulls;

  static OptionsStruct fromSerializableMap(Map<String, dynamic> data) =>
      OptionsStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        color: deserializeParam(
          data['color'],
          ParamType.String,
          false,
        ),
        key: deserializeParam(
          data['key'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'OptionsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is OptionsStruct &&
        title == other.title &&
        color == other.color &&
        key == other.key;
  }

  @override
  int get hashCode => const ListEquality().hash([title, color, key]);
}

OptionsStruct createOptionsStruct({
  String? title,
  String? color,
  String? key,
}) =>
    OptionsStruct(
      title: title,
      color: color,
      key: key,
    );
