// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class QuestionsStruct extends BaseStruct {
  QuestionsStruct({
    String? id,
    bool? isRequired,
    String? type,
    List<OptionsStruct>? options,
    List<String>? answers,
    List<String>? comments,
    List<DefectsStruct>? defects,
    List<FilesStruct>? files,
    String? from,
    bool? isDate,
    bool? itsTime,
    List<LogicsStruct>? logics,
    List<String>? tickets,
    String? title,
    String? to,
    String? unitOfMeasurement,
  })  : _id = id,
        _isRequired = isRequired,
        _type = type,
        _options = options,
        _answers = answers,
        _comments = comments,
        _defects = defects,
        _files = files,
        _from = from,
        _isDate = isDate,
        _itsTime = itsTime,
        _logics = logics,
        _tickets = tickets,
        _title = title,
        _to = to,
        _unitOfMeasurement = unitOfMeasurement;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "is_required" field.
  bool? _isRequired;
  bool get isRequired => _isRequired ?? false;
  set isRequired(bool? val) => _isRequired = val;

  bool hasIsRequired() => _isRequired != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "options" field.
  List<OptionsStruct>? _options;
  List<OptionsStruct> get options => _options ?? const [];
  set options(List<OptionsStruct>? val) => _options = val;

  void updateOptions(Function(List<OptionsStruct>) updateFn) {
    updateFn(_options ??= []);
  }

  bool hasOptions() => _options != null;

  // "answers" field.
  List<String>? _answers;
  List<String> get answers => _answers ?? const [];
  set answers(List<String>? val) => _answers = val;

  void updateAnswers(Function(List<String>) updateFn) {
    updateFn(_answers ??= []);
  }

  bool hasAnswers() => _answers != null;

  // "comments" field.
  List<String>? _comments;
  List<String> get comments => _comments ?? const [];
  set comments(List<String>? val) => _comments = val;

  void updateComments(Function(List<String>) updateFn) {
    updateFn(_comments ??= []);
  }

  bool hasComments() => _comments != null;

  // "defects" field.
  List<DefectsStruct>? _defects;
  List<DefectsStruct> get defects => _defects ?? const [];
  set defects(List<DefectsStruct>? val) => _defects = val;

  void updateDefects(Function(List<DefectsStruct>) updateFn) {
    updateFn(_defects ??= []);
  }

  bool hasDefects() => _defects != null;

  // "files" field.
  List<FilesStruct>? _files;
  List<FilesStruct> get files => _files ?? const [];
  set files(List<FilesStruct>? val) => _files = val;

  void updateFiles(Function(List<FilesStruct>) updateFn) {
    updateFn(_files ??= []);
  }

  bool hasFiles() => _files != null;

  // "from" field.
  String? _from;
  String get from => _from ?? '';
  set from(String? val) => _from = val;

  bool hasFrom() => _from != null;

  // "is_date" field.
  bool? _isDate;
  bool get isDate => _isDate ?? false;
  set isDate(bool? val) => _isDate = val;

  bool hasIsDate() => _isDate != null;

  // "its_time" field.
  bool? _itsTime;
  bool get itsTime => _itsTime ?? false;
  set itsTime(bool? val) => _itsTime = val;

  bool hasItsTime() => _itsTime != null;

  // "logics" field.
  List<LogicsStruct>? _logics;
  List<LogicsStruct> get logics => _logics ?? const [];
  set logics(List<LogicsStruct>? val) => _logics = val;

  void updateLogics(Function(List<LogicsStruct>) updateFn) {
    updateFn(_logics ??= []);
  }

  bool hasLogics() => _logics != null;

  // "tickets" field.
  List<String>? _tickets;
  List<String> get tickets => _tickets ?? const [];
  set tickets(List<String>? val) => _tickets = val;

  void updateTickets(Function(List<String>) updateFn) {
    updateFn(_tickets ??= []);
  }

  bool hasTickets() => _tickets != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "to" field.
  String? _to;
  String get to => _to ?? '';
  set to(String? val) => _to = val;

  bool hasTo() => _to != null;

  // "unit_of_measurement" field.
  String? _unitOfMeasurement;
  String get unitOfMeasurement => _unitOfMeasurement ?? '';
  set unitOfMeasurement(String? val) => _unitOfMeasurement = val;

  bool hasUnitOfMeasurement() => _unitOfMeasurement != null;

  static QuestionsStruct fromMap(Map<String, dynamic> data) => QuestionsStruct(
        id: data['id'] as String?,
        isRequired: data['is_required'] as bool?,
        type: data['type'] as String?,
        options: getStructList(
          data['options'],
          OptionsStruct.fromMap,
        ),
        answers: getDataList(data['answers']),
        comments: getDataList(data['comments']),
        defects: getStructList(
          data['defects'],
          DefectsStruct.fromMap,
        ),
        files: getStructList(
          data['files'],
          FilesStruct.fromMap,
        ),
        from: data['from'] as String?,
        isDate: data['is_date'] as bool?,
        itsTime: data['its_time'] as bool?,
        logics: getStructList(
          data['logics'],
          LogicsStruct.fromMap,
        ),
        tickets: getDataList(data['tickets']),
        title: data['title'] as String?,
        to: data['to'] as String?,
        unitOfMeasurement: data['unit_of_measurement'] as String?,
      );

  static QuestionsStruct? maybeFromMap(dynamic data) => data is Map
      ? QuestionsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'is_required': _isRequired,
        'type': _type,
        'options': _options?.map((e) => e.toMap()).toList(),
        'answers': _answers,
        'comments': _comments,
        'defects': _defects?.map((e) => e.toMap()).toList(),
        'files': _files?.map((e) => e.toMap()).toList(),
        'from': _from,
        'is_date': _isDate,
        'its_time': _itsTime,
        'logics': _logics?.map((e) => e.toMap()).toList(),
        'tickets': _tickets,
        'title': _title,
        'to': _to,
        'unit_of_measurement': _unitOfMeasurement,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'is_required': serializeParam(
          _isRequired,
          ParamType.bool,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'options': serializeParam(
          _options,
          ParamType.DataStruct,
          isList: true,
        ),
        'answers': serializeParam(
          _answers,
          ParamType.String,
          isList: true,
        ),
        'comments': serializeParam(
          _comments,
          ParamType.String,
          isList: true,
        ),
        'defects': serializeParam(
          _defects,
          ParamType.DataStruct,
          isList: true,
        ),
        'files': serializeParam(
          _files,
          ParamType.DataStruct,
          isList: true,
        ),
        'from': serializeParam(
          _from,
          ParamType.String,
        ),
        'is_date': serializeParam(
          _isDate,
          ParamType.bool,
        ),
        'its_time': serializeParam(
          _itsTime,
          ParamType.bool,
        ),
        'logics': serializeParam(
          _logics,
          ParamType.DataStruct,
          isList: true,
        ),
        'tickets': serializeParam(
          _tickets,
          ParamType.String,
          isList: true,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'to': serializeParam(
          _to,
          ParamType.String,
        ),
        'unit_of_measurement': serializeParam(
          _unitOfMeasurement,
          ParamType.String,
        ),
      }.withoutNulls;

  static QuestionsStruct fromSerializableMap(Map<String, dynamic> data) =>
      QuestionsStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        isRequired: deserializeParam(
          data['is_required'],
          ParamType.bool,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        options: deserializeStructParam<OptionsStruct>(
          data['options'],
          ParamType.DataStruct,
          true,
          structBuilder: OptionsStruct.fromSerializableMap,
        ),
        answers: deserializeParam<String>(
          data['answers'],
          ParamType.String,
          true,
        ),
        comments: deserializeParam<String>(
          data['comments'],
          ParamType.String,
          true,
        ),
        defects: deserializeStructParam<DefectsStruct>(
          data['defects'],
          ParamType.DataStruct,
          true,
          structBuilder: DefectsStruct.fromSerializableMap,
        ),
        files: deserializeStructParam<FilesStruct>(
          data['files'],
          ParamType.DataStruct,
          true,
          structBuilder: FilesStruct.fromSerializableMap,
        ),
        from: deserializeParam(
          data['from'],
          ParamType.String,
          false,
        ),
        isDate: deserializeParam(
          data['is_date'],
          ParamType.bool,
          false,
        ),
        itsTime: deserializeParam(
          data['its_time'],
          ParamType.bool,
          false,
        ),
        logics: deserializeStructParam<LogicsStruct>(
          data['logics'],
          ParamType.DataStruct,
          true,
          structBuilder: LogicsStruct.fromSerializableMap,
        ),
        tickets: deserializeParam<String>(
          data['tickets'],
          ParamType.String,
          true,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        to: deserializeParam(
          data['to'],
          ParamType.String,
          false,
        ),
        unitOfMeasurement: deserializeParam(
          data['unit_of_measurement'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'QuestionsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is QuestionsStruct &&
        id == other.id &&
        isRequired == other.isRequired &&
        type == other.type &&
        listEquality.equals(options, other.options) &&
        listEquality.equals(answers, other.answers) &&
        listEquality.equals(comments, other.comments) &&
        listEquality.equals(defects, other.defects) &&
        listEquality.equals(files, other.files) &&
        from == other.from &&
        isDate == other.isDate &&
        itsTime == other.itsTime &&
        listEquality.equals(logics, other.logics) &&
        listEquality.equals(tickets, other.tickets) &&
        title == other.title &&
        to == other.to &&
        unitOfMeasurement == other.unitOfMeasurement;
  }

  @override
  int get hashCode => const ListEquality().hash([
        id,
        isRequired,
        type,
        options,
        answers,
        comments,
        defects,
        files,
        from,
        isDate,
        itsTime,
        logics,
        tickets,
        title,
        to,
        unitOfMeasurement
      ]);
}

QuestionsStruct createQuestionsStruct({
  String? id,
  bool? isRequired,
  String? type,
  String? from,
  bool? isDate,
  bool? itsTime,
  String? title,
  String? to,
  String? unitOfMeasurement,
}) =>
    QuestionsStruct(
      id: id,
      isRequired: isRequired,
      type: type,
      from: from,
      isDate: isDate,
      itsTime: itsTime,
      title: title,
      to: to,
      unitOfMeasurement: unitOfMeasurement,
    );
