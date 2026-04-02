// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FormResultStruct extends BaseStruct {
  FormResultStruct({
    FormresultdataStruct? data,
    String? type,
    String? title,
    ResultformStruct? result,
  })  : _data = data,
        _type = type,
        _title = title,
        _result = result;

  // "data" field.
  FormresultdataStruct? _data;
  FormresultdataStruct get data => _data ?? FormresultdataStruct();
  set data(FormresultdataStruct? val) => _data = val;

  void updateData(Function(FormresultdataStruct) updateFn) {
    updateFn(_data ??= FormresultdataStruct());
  }

  bool hasData() => _data != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "result" field.
  ResultformStruct? _result;
  ResultformStruct get result => _result ?? ResultformStruct();
  set result(ResultformStruct? val) => _result = val;

  void updateResult(Function(ResultformStruct) updateFn) {
    updateFn(_result ??= ResultformStruct());
  }

  bool hasResult() => _result != null;

  static FormResultStruct fromMap(Map<String, dynamic> data) =>
      FormResultStruct(
        data: data['data'] is FormresultdataStruct
            ? data['data']
            : FormresultdataStruct.maybeFromMap(data['data']),
        type: data['type'] as String?,
        title: data['title'] as String?,
        result: data['result'] is ResultformStruct
            ? data['result']
            : ResultformStruct.maybeFromMap(data['result']),
      );

  static FormResultStruct? maybeFromMap(dynamic data) => data is Map
      ? FormResultStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'data': _data?.toMap(),
        'type': _type,
        'title': _title,
        'result': _result?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'data': serializeParam(
          _data,
          ParamType.DataStruct,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'result': serializeParam(
          _result,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static FormResultStruct fromSerializableMap(Map<String, dynamic> data) =>
      FormResultStruct(
        data: deserializeStructParam(
          data['data'],
          ParamType.DataStruct,
          false,
          structBuilder: FormresultdataStruct.fromSerializableMap,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        result: deserializeStructParam(
          data['result'],
          ParamType.DataStruct,
          false,
          structBuilder: ResultformStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'FormResultStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FormResultStruct &&
        data == other.data &&
        type == other.type &&
        title == other.title &&
        result == other.result;
  }

  @override
  int get hashCode => const ListEquality().hash([data, type, title, result]);
}

FormResultStruct createFormResultStruct({
  FormresultdataStruct? data,
  String? type,
  String? title,
  ResultformStruct? result,
}) =>
    FormResultStruct(
      data: data ?? FormresultdataStruct(),
      type: type,
      title: title,
      result: result ?? ResultformStruct(),
    );
