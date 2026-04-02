// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FormresultdataStruct extends BaseStruct {
  FormresultdataStruct({
    String? title,
    String? defect,
    String? normal,
    List<String>? remark,
    bool? required,
    String? description,
    List<String>? actionDefect,
  })  : _title = title,
        _defect = defect,
        _normal = normal,
        _remark = remark,
        _required = required,
        _description = description,
        _actionDefect = actionDefect;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "defect" field.
  String? _defect;
  String get defect => _defect ?? '';
  set defect(String? val) => _defect = val;

  bool hasDefect() => _defect != null;

  // "normal" field.
  String? _normal;
  String get normal => _normal ?? '';
  set normal(String? val) => _normal = val;

  bool hasNormal() => _normal != null;

  // "remark" field.
  List<String>? _remark;
  List<String> get remark => _remark ?? const [];
  set remark(List<String>? val) => _remark = val;

  void updateRemark(Function(List<String>) updateFn) {
    updateFn(_remark ??= []);
  }

  bool hasRemark() => _remark != null;

  // "required" field.
  bool? _required;
  bool get required => _required ?? false;
  set required(bool? val) => _required = val;

  bool hasRequired() => _required != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "action_defect" field.
  List<String>? _actionDefect;
  List<String> get actionDefect => _actionDefect ?? const [];
  set actionDefect(List<String>? val) => _actionDefect = val;

  void updateActionDefect(Function(List<String>) updateFn) {
    updateFn(_actionDefect ??= []);
  }

  bool hasActionDefect() => _actionDefect != null;

  static FormresultdataStruct fromMap(Map<String, dynamic> data) =>
      FormresultdataStruct(
        title: data['title'] as String?,
        defect: data['defect'] as String?,
        normal: data['normal'] as String?,
        remark: getDataList(data['remark']),
        required: data['required'] as bool?,
        description: data['description'] as String?,
        actionDefect: getDataList(data['action_defect']),
      );

  static FormresultdataStruct? maybeFromMap(dynamic data) => data is Map
      ? FormresultdataStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'defect': _defect,
        'normal': _normal,
        'remark': _remark,
        'required': _required,
        'description': _description,
        'action_defect': _actionDefect,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'defect': serializeParam(
          _defect,
          ParamType.String,
        ),
        'normal': serializeParam(
          _normal,
          ParamType.String,
        ),
        'remark': serializeParam(
          _remark,
          ParamType.String,
          isList: true,
        ),
        'required': serializeParam(
          _required,
          ParamType.bool,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'action_defect': serializeParam(
          _actionDefect,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static FormresultdataStruct fromSerializableMap(Map<String, dynamic> data) =>
      FormresultdataStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        defect: deserializeParam(
          data['defect'],
          ParamType.String,
          false,
        ),
        normal: deserializeParam(
          data['normal'],
          ParamType.String,
          false,
        ),
        remark: deserializeParam<String>(
          data['remark'],
          ParamType.String,
          true,
        ),
        required: deserializeParam(
          data['required'],
          ParamType.bool,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        actionDefect: deserializeParam<String>(
          data['action_defect'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'FormresultdataStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is FormresultdataStruct &&
        title == other.title &&
        defect == other.defect &&
        normal == other.normal &&
        listEquality.equals(remark, other.remark) &&
        required == other.required &&
        description == other.description &&
        listEquality.equals(actionDefect, other.actionDefect);
  }

  @override
  int get hashCode => const ListEquality().hash(
      [title, defect, normal, remark, required, description, actionDefect]);
}

FormresultdataStruct createFormresultdataStruct({
  String? title,
  String? defect,
  String? normal,
  bool? required,
  String? description,
}) =>
    FormresultdataStruct(
      title: title,
      defect: defect,
      normal: normal,
      required: required,
      description: description,
    );
