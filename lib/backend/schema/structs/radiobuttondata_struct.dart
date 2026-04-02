// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RadiobuttondataStruct extends BaseStruct {
  RadiobuttondataStruct({
    String? equiptitle,
    String? datatitle,
    String? response,
  })  : _equiptitle = equiptitle,
        _datatitle = datatitle,
        _response = response;

  // "equiptitle" field.
  String? _equiptitle;
  String get equiptitle => _equiptitle ?? '';
  set equiptitle(String? val) => _equiptitle = val;

  bool hasEquiptitle() => _equiptitle != null;

  // "datatitle" field.
  String? _datatitle;
  String get datatitle => _datatitle ?? '';
  set datatitle(String? val) => _datatitle = val;

  bool hasDatatitle() => _datatitle != null;

  // "response" field.
  String? _response;
  String get response => _response ?? '';
  set response(String? val) => _response = val;

  bool hasResponse() => _response != null;

  static RadiobuttondataStruct fromMap(Map<String, dynamic> data) =>
      RadiobuttondataStruct(
        equiptitle: data['equiptitle'] as String?,
        datatitle: data['datatitle'] as String?,
        response: data['response'] as String?,
      );

  static RadiobuttondataStruct? maybeFromMap(dynamic data) => data is Map
      ? RadiobuttondataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'equiptitle': _equiptitle,
        'datatitle': _datatitle,
        'response': _response,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'equiptitle': serializeParam(
          _equiptitle,
          ParamType.String,
        ),
        'datatitle': serializeParam(
          _datatitle,
          ParamType.String,
        ),
        'response': serializeParam(
          _response,
          ParamType.String,
        ),
      }.withoutNulls;

  static RadiobuttondataStruct fromSerializableMap(Map<String, dynamic> data) =>
      RadiobuttondataStruct(
        equiptitle: deserializeParam(
          data['equiptitle'],
          ParamType.String,
          false,
        ),
        datatitle: deserializeParam(
          data['datatitle'],
          ParamType.String,
          false,
        ),
        response: deserializeParam(
          data['response'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'RadiobuttondataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RadiobuttondataStruct &&
        equiptitle == other.equiptitle &&
        datatitle == other.datatitle &&
        response == other.response;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([equiptitle, datatitle, response]);
}

RadiobuttondataStruct createRadiobuttondataStruct({
  String? equiptitle,
  String? datatitle,
  String? response,
}) =>
    RadiobuttondataStruct(
      equiptitle: equiptitle,
      datatitle: datatitle,
      response: response,
    );
