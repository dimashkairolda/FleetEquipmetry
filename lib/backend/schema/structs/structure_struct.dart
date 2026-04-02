// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class StructureStruct extends BaseStruct {
  StructureStruct({
    List<QuestionsStruct>? questions,
    String? title,
  })  : _questions = questions,
        _title = title;

  // "questions" field.
  List<QuestionsStruct>? _questions;
  List<QuestionsStruct> get questions => _questions ?? const [];
  set questions(List<QuestionsStruct>? val) => _questions = val;

  void updateQuestions(Function(List<QuestionsStruct>) updateFn) {
    updateFn(_questions ??= []);
  }

  bool hasQuestions() => _questions != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  static StructureStruct fromMap(Map<String, dynamic> data) => StructureStruct(
        questions: getStructList(
          data['questions'],
          QuestionsStruct.fromMap,
        ),
        title: data['title'] as String?,
      );

  static StructureStruct? maybeFromMap(dynamic data) => data is Map
      ? StructureStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'questions': _questions?.map((e) => e.toMap()).toList(),
        'title': _title,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'questions': serializeParam(
          _questions,
          ParamType.DataStruct,
          isList: true,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
      }.withoutNulls;

  static StructureStruct fromSerializableMap(Map<String, dynamic> data) =>
      StructureStruct(
        questions: deserializeStructParam<QuestionsStruct>(
          data['questions'],
          ParamType.DataStruct,
          true,
          structBuilder: QuestionsStruct.fromSerializableMap,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'StructureStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is StructureStruct &&
        listEquality.equals(questions, other.questions) &&
        title == other.title;
  }

  @override
  int get hashCode => const ListEquality().hash([questions, title]);
}

StructureStruct createStructureStruct({
  String? title,
}) =>
    StructureStruct(
      title: title,
    );
