// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InspectionsStruct extends BaseStruct {
  InspectionsStruct({
    int? regulation,
    int? regulationWork,
    RegulationWorkInfoStruct? regulationWorkInfo,
    int? form,
    List<FormResultStruct>? formResult,
  })  : _regulation = regulation,
        _regulationWork = regulationWork,
        _regulationWorkInfo = regulationWorkInfo,
        _form = form,
        _formResult = formResult;

  // "regulation" field.
  int? _regulation;
  int get regulation => _regulation ?? 0;
  set regulation(int? val) => _regulation = val;

  void incrementRegulation(int amount) => regulation = regulation + amount;

  bool hasRegulation() => _regulation != null;

  // "regulation_work" field.
  int? _regulationWork;
  int get regulationWork => _regulationWork ?? 0;
  set regulationWork(int? val) => _regulationWork = val;

  void incrementRegulationWork(int amount) =>
      regulationWork = regulationWork + amount;

  bool hasRegulationWork() => _regulationWork != null;

  // "regulation_work_info" field.
  RegulationWorkInfoStruct? _regulationWorkInfo;
  RegulationWorkInfoStruct get regulationWorkInfo =>
      _regulationWorkInfo ?? RegulationWorkInfoStruct();
  set regulationWorkInfo(RegulationWorkInfoStruct? val) =>
      _regulationWorkInfo = val;

  void updateRegulationWorkInfo(Function(RegulationWorkInfoStruct) updateFn) {
    updateFn(_regulationWorkInfo ??= RegulationWorkInfoStruct());
  }

  bool hasRegulationWorkInfo() => _regulationWorkInfo != null;

  // "form" field.
  int? _form;
  int get form => _form ?? 0;
  set form(int? val) => _form = val;

  void incrementForm(int amount) => form = form + amount;

  bool hasForm() => _form != null;

  // "form_result" field.
  List<FormResultStruct>? _formResult;
  List<FormResultStruct> get formResult => _formResult ?? const [];
  set formResult(List<FormResultStruct>? val) => _formResult = val;

  void updateFormResult(Function(List<FormResultStruct>) updateFn) {
    updateFn(_formResult ??= []);
  }

  bool hasFormResult() => _formResult != null;

  static InspectionsStruct fromMap(Map<String, dynamic> data) =>
      InspectionsStruct(
        regulation: castToType<int>(data['regulation']),
        regulationWork: castToType<int>(data['regulation_work']),
        regulationWorkInfo:
            data['regulation_work_info'] is RegulationWorkInfoStruct
                ? data['regulation_work_info']
                : RegulationWorkInfoStruct.maybeFromMap(
                    data['regulation_work_info']),
        form: castToType<int>(data['form']),
        formResult: getStructList(
          data['form_result'],
          FormResultStruct.fromMap,
        ),
      );

  static InspectionsStruct? maybeFromMap(dynamic data) => data is Map
      ? InspectionsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'regulation': _regulation,
        'regulation_work': _regulationWork,
        'regulation_work_info': _regulationWorkInfo?.toMap(),
        'form': _form,
        'form_result': _formResult?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'regulation': serializeParam(
          _regulation,
          ParamType.int,
        ),
        'regulation_work': serializeParam(
          _regulationWork,
          ParamType.int,
        ),
        'regulation_work_info': serializeParam(
          _regulationWorkInfo,
          ParamType.DataStruct,
        ),
        'form': serializeParam(
          _form,
          ParamType.int,
        ),
        'form_result': serializeParam(
          _formResult,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static InspectionsStruct fromSerializableMap(Map<String, dynamic> data) =>
      InspectionsStruct(
        regulation: deserializeParam(
          data['regulation'],
          ParamType.int,
          false,
        ),
        regulationWork: deserializeParam(
          data['regulation_work'],
          ParamType.int,
          false,
        ),
        regulationWorkInfo: deserializeStructParam(
          data['regulation_work_info'],
          ParamType.DataStruct,
          false,
          structBuilder: RegulationWorkInfoStruct.fromSerializableMap,
        ),
        form: deserializeParam(
          data['form'],
          ParamType.int,
          false,
        ),
        formResult: deserializeStructParam<FormResultStruct>(
          data['form_result'],
          ParamType.DataStruct,
          true,
          structBuilder: FormResultStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InspectionsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InspectionsStruct &&
        regulation == other.regulation &&
        regulationWork == other.regulationWork &&
        regulationWorkInfo == other.regulationWorkInfo &&
        form == other.form &&
        listEquality.equals(formResult, other.formResult);
  }

  @override
  int get hashCode => const ListEquality()
      .hash([regulation, regulationWork, regulationWorkInfo, form, formResult]);
}

InspectionsStruct createInspectionsStruct({
  int? regulation,
  int? regulationWork,
  RegulationWorkInfoStruct? regulationWorkInfo,
  int? form,
}) =>
    InspectionsStruct(
      regulation: regulation,
      regulationWork: regulationWork,
      regulationWorkInfo: regulationWorkInfo ?? RegulationWorkInfoStruct(),
      form: form,
    );
