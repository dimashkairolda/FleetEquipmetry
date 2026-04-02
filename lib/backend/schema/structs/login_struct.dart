// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LoginStruct extends BaseStruct {
  LoginStruct({
    String? accesstoken,
    String? refreshtoken,
  })  : _accesstoken = accesstoken,
        _refreshtoken = refreshtoken;

  // "accesstoken" field.
  String? _accesstoken;
  String get accesstoken => _accesstoken ?? '';
  set accesstoken(String? val) => _accesstoken = val;

  bool hasAccesstoken() => _accesstoken != null;

  // "refreshtoken" field.
  String? _refreshtoken;
  String get refreshtoken => _refreshtoken ?? '';
  set refreshtoken(String? val) => _refreshtoken = val;

  bool hasRefreshtoken() => _refreshtoken != null;

  static LoginStruct fromMap(Map<String, dynamic> data) => LoginStruct(
        accesstoken: data['accesstoken'] as String?,
        refreshtoken: data['refreshtoken'] as String?,
      );

  static LoginStruct? maybeFromMap(dynamic data) =>
      data is Map ? LoginStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'accesstoken': _accesstoken,
        'refreshtoken': _refreshtoken,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'accesstoken': serializeParam(
          _accesstoken,
          ParamType.String,
        ),
        'refreshtoken': serializeParam(
          _refreshtoken,
          ParamType.String,
        ),
      }.withoutNulls;

  static LoginStruct fromSerializableMap(Map<String, dynamic> data) =>
      LoginStruct(
        accesstoken: deserializeParam(
          data['accesstoken'],
          ParamType.String,
          false,
        ),
        refreshtoken: deserializeParam(
          data['refreshtoken'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LoginStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is LoginStruct &&
        accesstoken == other.accesstoken &&
        refreshtoken == other.refreshtoken;
  }

  @override
  int get hashCode => const ListEquality().hash([accesstoken, refreshtoken]);
}

LoginStruct createLoginStruct({
  String? accesstoken,
  String? refreshtoken,
}) =>
    LoginStruct(
      accesstoken: accesstoken,
      refreshtoken: refreshtoken,
    );
