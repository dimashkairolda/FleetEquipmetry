// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FilesStruct extends BaseStruct {
  FilesStruct({
    String? title,
    String? data,
    String? extension,
    int? size,
  })  : _title = title,
        _data = data,
        _extension = extension,
        _size = size;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "data" field.
  String? _data;
  String get data => _data ?? '';
  set data(String? val) => _data = val;

  bool hasData() => _data != null;

  // "extension" field.
  String? _extension;
  String get extension => _extension ?? '';
  set extension(String? val) => _extension = val;

  bool hasExtension() => _extension != null;

  // "size" field.
  int? _size;
  int get size => _size ?? 0;
  set size(int? val) => _size = val;

  void incrementSize(int amount) => size = size + amount;

  bool hasSize() => _size != null;

  static FilesStruct fromMap(Map<String, dynamic> data) => FilesStruct(
        title: data['title'] as String?,
        data: data['data'] as String?,
        extension: data['extension'] as String?,
        size: castToType<int>(data['size']),
      );

  static FilesStruct? maybeFromMap(dynamic data) =>
      data is Map ? FilesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'data': _data,
        'extension': _extension,
        'size': _size,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'data': serializeParam(
          _data,
          ParamType.String,
        ),
        'extension': serializeParam(
          _extension,
          ParamType.String,
        ),
        'size': serializeParam(
          _size,
          ParamType.int,
        ),
      }.withoutNulls;

  static FilesStruct fromSerializableMap(Map<String, dynamic> data) =>
      FilesStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        data: deserializeParam(
          data['data'],
          ParamType.String,
          false,
        ),
        extension: deserializeParam(
          data['extension'],
          ParamType.String,
          false,
        ),
        size: deserializeParam(
          data['size'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'FilesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FilesStruct &&
        title == other.title &&
        data == other.data &&
        extension == other.extension &&
        size == other.size;
  }

  @override
  int get hashCode => const ListEquality().hash([title, data, extension, size]);
}

FilesStruct createFilesStruct({
  String? title,
  String? data,
  String? extension,
  int? size,
}) =>
    FilesStruct(
      title: title,
      data: data,
      extension: extension,
      size: size,
    );
