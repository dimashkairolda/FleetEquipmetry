// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InspectionsShablonStruct extends BaseStruct {
  InspectionsShablonStruct({
    String? title,
    String? description,
    List<ReferencesStruct>? references,
    List<QuestionsStruct>? questions,
  })  : _title = title,
        _description = description,
        _references = references,
        _questions = questions;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "references" field.
  List<ReferencesStruct>? _references;
  List<ReferencesStruct> get references => _references ?? const [];
  set references(List<ReferencesStruct>? val) => _references = val;

  void updateReferences(Function(List<ReferencesStruct>) updateFn) {
    updateFn(_references ??= []);
  }

  bool hasReferences() => _references != null;

  // "questions" field.
  List<QuestionsStruct>? _questions;
  List<QuestionsStruct> get questions => _questions ?? const [];
  set questions(List<QuestionsStruct>? val) => _questions = val;

  void updateQuestions(Function(List<QuestionsStruct>) updateFn) {
    updateFn(_questions ??= []);
  }

  bool hasQuestions() => _questions != null;

  static InspectionsShablonStruct fromMap(Map<String, dynamic> data) =>
      InspectionsShablonStruct(
        title: data['title'] as String?,
        description: data['description'] as String?,
        references: getStructList(
          data['references'],
          ReferencesStruct.fromMap,
        ),
        questions: getStructList(
          data['questions'],
          QuestionsStruct.fromMap,
        ),
      );

  static InspectionsShablonStruct? maybeFromMap(dynamic data) => data is Map
      ? InspectionsShablonStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'description': _description,
        'references': _references?.map((e) => e.toMap()).toList(),
        'questions': _questions?.map((e) => e.toMap()).toList(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'references': serializeParam(
          _references,
          ParamType.DataStruct,
          isList: true,
        ),
        'questions': serializeParam(
          _questions,
          ParamType.DataStruct,
          isList: true,
        ),
      }.withoutNulls;

  static InspectionsShablonStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      InspectionsShablonStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        references: deserializeStructParam<ReferencesStruct>(
          data['references'],
          ParamType.DataStruct,
          true,
          structBuilder: ReferencesStruct.fromSerializableMap,
        ),
        questions: deserializeStructParam<QuestionsStruct>(
          data['questions'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InspectionsShablonStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is InspectionsShablonStruct &&
        title == other.title &&
        description == other.description &&
        listEquality.equals(references, other.references) &&
        listEquality.equals(questions, other.questions);
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, description, references, questions]);
}

InspectionsShablonStruct createInspectionsShablonStruct({
  String? title,
  String? description,
}) =>
    InspectionsShablonStruct(
      title: title,
      description: description,
    );
