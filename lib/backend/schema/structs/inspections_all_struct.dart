// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InspectionsAllStruct extends BaseStruct {
  InspectionsAllStruct({
    String? title,
    String? equiptitle,
    int? id,
    String? schedule,
    List<InspectionsStruct>? responses,
  })  : _title = title,
        _equiptitle = equiptitle,
        _id = id,
        _schedule = schedule,
        _responses = responses;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "equiptitle" field.
  String? _equiptitle;
  String get equiptitle => _equiptitle ?? '';
  set equiptitle(String? val) => _equiptitle = val;

  bool hasEquiptitle() => _equiptitle != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "schedule" field.
  String? _schedule;
  String get schedule => _schedule ?? '';
  set schedule(String? val) => _schedule = val;

  bool hasSchedule() => _schedule != null;

  // "responses" field.
  List<InspectionsStruct>? _responses;
  List<InspectionsStruct> get responses => _responses ?? const [];
  set responses(List<InspectionsStruct>? val) => _responses = val;

  void updateResponses(Function(List<InspectionsStruct>) updateFn) {
    updateFn(_responses ??= []);
  }

  bool hasResponses() => _responses != null;

  static InspectionsAllStruct fromMap(Map<String, dynamic> data) =>
      InspectionsAllStruct(
        title: data['title'] as String?,
        equiptitle: data['equiptitle'] as String?,
        id: castToType<int>(data['id']),
        schedule: data['schedule'] as String?,
        responses: getStructList(
          data['responses'],
          InspectionsStruct.fromMap,
        ),
      );

  static InspectionsAllStruct? maybeFromMap(dynamic data) => data is Map
      ? InspectionsAllStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'equiptitle': _equiptitle,
        'id': _id,
        'schedule': _schedule,
        'responses': _responses?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'equiptitle': serializeParam(
          _equiptitle,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'schedule': serializeParam(
          _schedule,
          ParamType.String,
        ),
        'responses': serializeParam(
          _responses,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static InspectionsAllStruct fromSerializableMap(Map<String, dynamic> data) =>
      InspectionsAllStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        equiptitle: deserializeParam(
          data['equiptitle'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        schedule: deserializeParam(
          data['schedule'],
          ParamType.String,
          false,
        ),
        responses: deserializeStructParam<InspectionsStruct>(
          data['responses'],
          ParamType.DataStruct,
          true,
          structBuilder: InspectionsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InspectionsAllStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InspectionsAllStruct &&
        title == other.title &&
        equiptitle == other.equiptitle &&
        id == other.id &&
        schedule == other.schedule &&
        listEquality.equals(responses, other.responses);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, equiptitle, id, schedule, responses]);
}

InspectionsAllStruct createInspectionsAllStruct({
  String? title,
  String? equiptitle,
  int? id,
  String? schedule,
}) =>
    InspectionsAllStruct(
      title: title,
      equiptitle: equiptitle,
      id: id,
      schedule: schedule,
    );
