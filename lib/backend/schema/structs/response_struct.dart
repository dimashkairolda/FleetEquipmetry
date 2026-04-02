// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResponseStruct extends BaseStruct {
  ResponseStruct({
    List<String>? datatitle,
  }) : _datatitle = datatitle;

  // "datatitle" field.
  List<String>? _datatitle;
  List<String> get datatitle => _datatitle ?? const [];
  set datatitle(List<String>? val) => _datatitle = val;

  void updateDatatitle(Function(List<String>) updateFn) {
    updateFn(_datatitle ??= []);
  }

  bool hasDatatitle() => _datatitle != null;

  static ResponseStruct fromMap(Map<String, dynamic> data) => ResponseStruct(
        datatitle: getDataList(data['datatitle']),
      );

  static ResponseStruct? maybeFromMap(dynamic data) =>
      data is Map ? ResponseStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'datatitle': _datatitle,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'datatitle': serializeParam(
          _datatitle,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static ResponseStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResponseStruct(
        datatitle: deserializeParam<String>(
          data['datatitle'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'ResponseStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is ResponseStruct &&
        listEquality.equals(datatitle, other.datatitle);
  }

  @override
  int get hashCode => const ListEquality().hash([datatitle]);
}

ResponseStruct createResponseStruct() => ResponseStruct();
