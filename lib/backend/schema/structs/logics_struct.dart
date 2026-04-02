// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LogicsStruct extends BaseStruct {
  LogicsStruct({
    List<String>? actions,
    String? optionKey,
    String? type,
    String? value,
    String? valueCmp1,
    String? valueCmp2,
  })  : _actions = actions,
        _optionKey = optionKey,
        _type = type,
        _value = value,
        _valueCmp1 = valueCmp1,
        _valueCmp2 = valueCmp2;

  // "actions" field.
  List<String>? _actions;
  List<String> get actions => _actions ?? const [];
  set actions(List<String>? val) => _actions = val;

  void updateActions(Function(List<String>) updateFn) {
    updateFn(_actions ??= []);
  }

  bool hasActions() => _actions != null;

  // "option_key" field.
  String? _optionKey;
  String get optionKey => _optionKey ?? '';
  set optionKey(String? val) => _optionKey = val;

  bool hasOptionKey() => _optionKey != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "value" field.
  String? _value;
  String get value => _value ?? '';
  set value(String? val) => _value = val;

  bool hasValue() => _value != null;

  // "value_cmp_1" field.
  String? _valueCmp1;
  String get valueCmp1 => _valueCmp1 ?? '';
  set valueCmp1(String? val) => _valueCmp1 = val;

  bool hasValueCmp1() => _valueCmp1 != null;

  // "value_cmp_2" field.
  String? _valueCmp2;
  String get valueCmp2 => _valueCmp2 ?? '';
  set valueCmp2(String? val) => _valueCmp2 = val;

  bool hasValueCmp2() => _valueCmp2 != null;

  static LogicsStruct fromMap(Map<String, dynamic> data) => LogicsStruct(
        actions: getDataList(data['actions']),
        optionKey: data['option_key'] as String?,
        type: data['type'] as String?,
        value: data['value'] as String?,
        valueCmp1: data['value_cmp_1'] as String?,
        valueCmp2: data['value_cmp_2'] as String?,
      );

  static LogicsStruct? maybeFromMap(dynamic data) =>
      data is Map ? LogicsStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'actions': _actions,
        'option_key': _optionKey,
        'type': _type,
        'value': _value,
        'value_cmp_1': _valueCmp1,
        'value_cmp_2': _valueCmp2,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'actions': serializeParam(
          _actions,
          ParamType.String,
          isList: true,
        ),
        'option_key': serializeParam(
          _optionKey,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'value': serializeParam(
          _value,
          ParamType.String,
        ),
        'value_cmp_1': serializeParam(
          _valueCmp1,
          ParamType.String,
        ),
        'value_cmp_2': serializeParam(
          _valueCmp2,
          ParamType.String,
        ),
      }.withoutNulls;

  static LogicsStruct fromSerializableMap(Map<String, dynamic> data) =>
      LogicsStruct(
        actions: deserializeParam<String>(
          data['actions'],
          ParamType.String,
          true,
        ),
        optionKey: deserializeParam(
          data['option_key'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        value: deserializeParam(
          data['value'],
          ParamType.String,
          false,
        ),
        valueCmp1: deserializeParam(
          data['value_cmp_1'],
          ParamType.String,
          false,
        ),
        valueCmp2: deserializeParam(
          data['value_cmp_2'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'LogicsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is LogicsStruct &&
        listEquality.equals(actions, other.actions) &&
        optionKey == other.optionKey &&
        type == other.type &&
        value == other.value &&
        valueCmp1 == other.valueCmp1 &&
        valueCmp2 == other.valueCmp2;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([actions, optionKey, type, value, valueCmp1, valueCmp2]);
}

LogicsStruct createLogicsStruct({
  String? optionKey,
  String? type,
  String? value,
  String? valueCmp1,
  String? valueCmp2,
}) =>
    LogicsStruct(
      optionKey: optionKey,
      type: type,
      value: value,
      valueCmp1: valueCmp1,
      valueCmp2: valueCmp2,
    );
