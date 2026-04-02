// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateDefectStruct extends BaseStruct {
  CreateDefectStruct({
    String? title,
    String? userId,
    String? workspaceId,
    int? motoHours,
    int? mileage,
    String? equipmentId,
    String? description,
    String? date,
    String? categoryId,
    List<String>? assigneeIds,
    List<SparePartsStruct>? spareParts,
    List<TodoStruct>? todo,
    String? source,
    List<String>? media,
    String? ticketId,
  })  : _title = title,
        _userId = userId,
        _workspaceId = workspaceId,
        _motoHours = motoHours,
        _mileage = mileage,
        _equipmentId = equipmentId,
        _description = description,
        _date = date,
        _categoryId = categoryId,
        _assigneeIds = assigneeIds,
        _spareParts = spareParts,
        _todo = todo,
        _source = source,
        _media = media,
        _ticketId = ticketId;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "user_id" field.
  String? _userId;
  String get userId => _userId ?? '';
  set userId(String? val) => _userId = val;

  bool hasUserId() => _userId != null;

  // "workspace_id" field.
  String? _workspaceId;
  String get workspaceId => _workspaceId ?? '';
  set workspaceId(String? val) => _workspaceId = val;

  bool hasWorkspaceId() => _workspaceId != null;

  // "moto_hours" field.
  int? _motoHours;
  int get motoHours => _motoHours ?? 0;
  set motoHours(int? val) => _motoHours = val;

  void incrementMotoHours(int amount) => motoHours = motoHours + amount;

  bool hasMotoHours() => _motoHours != null;

  // "mileage" field.
  int? _mileage;
  int get mileage => _mileage ?? 0;
  set mileage(int? val) => _mileage = val;

  void incrementMileage(int amount) => mileage = mileage + amount;

  bool hasMileage() => _mileage != null;

  // "equipment_id" field.
  String? _equipmentId;
  String get equipmentId => _equipmentId ?? '';
  set equipmentId(String? val) => _equipmentId = val;

  bool hasEquipmentId() => _equipmentId != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  set description(String? val) => _description = val;

  bool hasDescription() => _description != null;

  // "date" field.
  String? _date;
  String get date => _date ?? '';
  set date(String? val) => _date = val;

  bool hasDate() => _date != null;

  // "category_id" field.
  String? _categoryId;
  String get categoryId => _categoryId ?? '';
  set categoryId(String? val) => _categoryId = val;

  bool hasCategoryId() => _categoryId != null;

  // "assignee_ids" field.
  List<String>? _assigneeIds;
  List<String> get assigneeIds => _assigneeIds ?? const [];
  set assigneeIds(List<String>? val) => _assigneeIds = val;

  void updateAssigneeIds(Function(List<String>) updateFn) {
    updateFn(_assigneeIds ??= []);
  }

  bool hasAssigneeIds() => _assigneeIds != null;

  // "spare_parts" field.
  List<SparePartsStruct>? _spareParts;
  List<SparePartsStruct> get spareParts => _spareParts ?? const [];
  set spareParts(List<SparePartsStruct>? val) => _spareParts = val;

  void updateSpareParts(Function(List<SparePartsStruct>) updateFn) {
    updateFn(_spareParts ??= []);
  }

  bool hasSpareParts() => _spareParts != null;

  // "todo" field.
  List<TodoStruct>? _todo;
  List<TodoStruct> get todo => _todo ?? const [];
  set todo(List<TodoStruct>? val) => _todo = val;

  void updateTodo(Function(List<TodoStruct>) updateFn) {
    updateFn(_todo ??= []);
  }

  bool hasTodo() => _todo != null;

  // "source" field.
  String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;

  // "media" field.
  List<String>? _media;
  List<String> get media => _media ?? const [];
  set media(List<String>? val) => _media = val;

  void updateMedia(Function(List<String>) updateFn) {
    updateFn(_media ??= []);
  }

  bool hasMedia() => _media != null;

  // "ticket_id" field.
  String? _ticketId;
  String get ticketId => _ticketId ?? '';
  set ticketId(String? val) => _ticketId = val;

  bool hasTicketId() => _ticketId != null;

  static CreateDefectStruct fromMap(Map<String, dynamic> data) =>
      CreateDefectStruct(
        title: data['title'] as String?,
        userId: data['user_id'] as String?,
        workspaceId: data['workspace_id'] as String?,
        motoHours: castToType<int>(data['moto_hours']),
        mileage: castToType<int>(data['mileage']),
        equipmentId: data['equipment_id'] as String?,
        description: data['description'] as String?,
        date: data['date'] as String?,
        categoryId: data['category_id'] as String?,
        assigneeIds: getDataList(data['assignee_ids']),
        spareParts: getStructList(
          data['spare_parts'],
          SparePartsStruct.fromMap,
        ),
        todo: getStructList(
          data['todo'],
          TodoStruct.fromMap,
        ),
        source: data['source'] as String?,
        media: getDataList(data['media']),
        ticketId: data['ticket_id'] as String?,
      );

  static CreateDefectStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateDefectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'user_id': _userId,
        'workspace_id': _workspaceId,
        'moto_hours': _motoHours,
        'mileage': _mileage,
        'equipment_id': _equipmentId,
        'description': _description,
        'date': _date,
        'category_id': _categoryId,
        'assignee_ids': _assigneeIds,
        'spare_parts': _spareParts?.map((e) => e.toMap()).toList(),
        'todo': _todo?.map((e) => e.toMap()).toList(),
        'source': _source,
        'media': _media,
        'ticket_id': _ticketId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'user_id': serializeParam(
          _userId,
          ParamType.String,
        ),
        'workspace_id': serializeParam(
          _workspaceId,
          ParamType.String,
        ),
        'moto_hours': serializeParam(
          _motoHours,
          ParamType.int,
        ),
        'mileage': serializeParam(
          _mileage,
          ParamType.int,
        ),
        'equipment_id': serializeParam(
          _equipmentId,
          ParamType.String,
        ),
        'description': serializeParam(
          _description,
          ParamType.String,
        ),
        'date': serializeParam(
          _date,
          ParamType.String,
        ),
        'category_id': serializeParam(
          _categoryId,
          ParamType.String,
        ),
        'assignee_ids': serializeParam(
          _assigneeIds,
          ParamType.String,
          isList: true,
        ),
        'spare_parts': serializeParam(
          _spareParts,
          ParamType.DataStruct,
          isList: true,
        ),
        'todo': serializeParam(
          _todo,
          ParamType.DataStruct,
          isList: true,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'media': serializeParam(
          _media,
          ParamType.String,
          isList: true,
        ),
        'ticket_id': serializeParam(
          _ticketId,
          ParamType.String,
        ),
      }.withoutNulls;

  static CreateDefectStruct fromSerializableMap(Map<String, dynamic> data) =>
      CreateDefectStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        userId: deserializeParam(
          data['user_id'],
          ParamType.String,
          false,
        ),
        workspaceId: deserializeParam(
          data['workspace_id'],
          ParamType.String,
          false,
        ),
        motoHours: deserializeParam(
          data['moto_hours'],
          ParamType.int,
          false,
        ),
        mileage: deserializeParam(
          data['mileage'],
          ParamType.int,
          false,
        ),
        equipmentId: deserializeParam(
          data['equipment_id'],
          ParamType.String,
          false,
        ),
        description: deserializeParam(
          data['description'],
          ParamType.String,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.String,
          false,
        ),
        categoryId: deserializeParam(
          data['category_id'],
          ParamType.String,
          false,
        ),
        assigneeIds: deserializeParam<String>(
          data['assignee_ids'],
          ParamType.String,
          true,
        ),
        spareParts: deserializeStructParam<SparePartsStruct>(
          data['spare_parts'],
          ParamType.DataStruct,
          true,
          structBuilder: SparePartsStruct.fromSerializableMap,
        ),
        todo: deserializeStructParam<TodoStruct>(
          data['todo'],
          ParamType.DataStruct,
          true,
          structBuilder: TodoStruct.fromSerializableMap,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        media: deserializeParam<String>(
          data['media'],
          ParamType.String,
          true,
        ),
        ticketId: deserializeParam(
          data['ticket_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'CreateDefectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CreateDefectStruct &&
        title == other.title &&
        userId == other.userId &&
        workspaceId == other.workspaceId &&
        motoHours == other.motoHours &&
        mileage == other.mileage &&
        equipmentId == other.equipmentId &&
        description == other.description &&
        date == other.date &&
        categoryId == other.categoryId &&
        listEquality.equals(assigneeIds, other.assigneeIds) &&
        listEquality.equals(spareParts, other.spareParts) &&
        listEquality.equals(todo, other.todo) &&
        source == other.source &&
        listEquality.equals(media, other.media) &&
        ticketId == other.ticketId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        userId,
        workspaceId,
        motoHours,
        mileage,
        equipmentId,
        description,
        date,
        categoryId,
        assigneeIds,
        spareParts,
        todo,
        source,
        media,
        ticketId
      ]);
}

CreateDefectStruct createCreateDefectStruct({
  String? title,
  String? userId,
  String? workspaceId,
  int? motoHours,
  int? mileage,
  String? equipmentId,
  String? description,
  String? date,
  String? categoryId,
  String? source,
  String? ticketId,
}) =>
    CreateDefectStruct(
      title: title,
      userId: userId,
      workspaceId: workspaceId,
      motoHours: motoHours,
      mileage: mileage,
      equipmentId: equipmentId,
      description: description,
      date: date,
      categoryId: categoryId,
      source: source,
      ticketId: ticketId,
    );
