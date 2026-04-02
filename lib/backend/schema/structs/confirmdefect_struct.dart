// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ConfirmdefectStruct extends BaseStruct {
  ConfirmdefectStruct({
    String? type,
    String? event,
    String? title,
    String? reason,
    int? id,
    String? equipTitle,
    int? equipID,
    int? isFixedOnPlace,
    int? isEmergencySituation,
    int? authorid,
    String? authorfirstname,
    String? authorlastname,
    String? department,
    int? responsible,
    ResponseStruct? paramVals,
  })  : _type = type,
        _event = event,
        _title = title,
        _reason = reason,
        _id = id,
        _equipTitle = equipTitle,
        _equipID = equipID,
        _isFixedOnPlace = isFixedOnPlace,
        _isEmergencySituation = isEmergencySituation,
        _authorid = authorid,
        _authorfirstname = authorfirstname,
        _authorlastname = authorlastname,
        _department = department,
        _responsible = responsible,
        _paramVals = paramVals;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "event" field.
  String? _event;
  String get event => _event ?? '';
  set event(String? val) => _event = val;

  bool hasEvent() => _event != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "reason" field.
  String? _reason;
  String get reason => _reason ?? '';
  set reason(String? val) => _reason = val;

  bool hasReason() => _reason != null;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "equipTitle" field.
  String? _equipTitle;
  String get equipTitle => _equipTitle ?? '';
  set equipTitle(String? val) => _equipTitle = val;

  bool hasEquipTitle() => _equipTitle != null;

  // "equipID" field.
  int? _equipID;
  int get equipID => _equipID ?? 0;
  set equipID(int? val) => _equipID = val;

  void incrementEquipID(int amount) => equipID = equipID + amount;

  bool hasEquipID() => _equipID != null;

  // "isFixedOnPlace" field.
  int? _isFixedOnPlace;
  int get isFixedOnPlace => _isFixedOnPlace ?? 0;
  set isFixedOnPlace(int? val) => _isFixedOnPlace = val;

  void incrementIsFixedOnPlace(int amount) =>
      isFixedOnPlace = isFixedOnPlace + amount;

  bool hasIsFixedOnPlace() => _isFixedOnPlace != null;

  // "isEmergencySituation" field.
  int? _isEmergencySituation;
  int get isEmergencySituation => _isEmergencySituation ?? 0;
  set isEmergencySituation(int? val) => _isEmergencySituation = val;

  void incrementIsEmergencySituation(int amount) =>
      isEmergencySituation = isEmergencySituation + amount;

  bool hasIsEmergencySituation() => _isEmergencySituation != null;

  // "authorid" field.
  int? _authorid;
  int get authorid => _authorid ?? 0;
  set authorid(int? val) => _authorid = val;

  void incrementAuthorid(int amount) => authorid = authorid + amount;

  bool hasAuthorid() => _authorid != null;

  // "authorfirstname" field.
  String? _authorfirstname;
  String get authorfirstname => _authorfirstname ?? '';
  set authorfirstname(String? val) => _authorfirstname = val;

  bool hasAuthorfirstname() => _authorfirstname != null;

  // "authorlastname" field.
  String? _authorlastname;
  String get authorlastname => _authorlastname ?? '';
  set authorlastname(String? val) => _authorlastname = val;

  bool hasAuthorlastname() => _authorlastname != null;

  // "department" field.
  String? _department;
  String get department => _department ?? '';
  set department(String? val) => _department = val;

  bool hasDepartment() => _department != null;

  // "responsible" field.
  int? _responsible;
  int get responsible => _responsible ?? 0;
  set responsible(int? val) => _responsible = val;

  void incrementResponsible(int amount) => responsible = responsible + amount;

  bool hasResponsible() => _responsible != null;

  // "param_vals" field.
  ResponseStruct? _paramVals;
  ResponseStruct get paramVals => _paramVals ?? ResponseStruct();
  set paramVals(ResponseStruct? val) => _paramVals = val;

  void updateParamVals(Function(ResponseStruct) updateFn) {
    updateFn(_paramVals ??= ResponseStruct());
  }

  bool hasParamVals() => _paramVals != null;

  static ConfirmdefectStruct fromMap(Map<String, dynamic> data) =>
      ConfirmdefectStruct(
        type: data['type'] as String?,
        event: data['event'] as String?,
        title: data['title'] as String?,
        reason: data['reason'] as String?,
        id: castToType<int>(data['id']),
        equipTitle: data['equipTitle'] as String?,
        equipID: castToType<int>(data['equipID']),
        isFixedOnPlace: castToType<int>(data['isFixedOnPlace']),
        isEmergencySituation: castToType<int>(data['isEmergencySituation']),
        authorid: castToType<int>(data['authorid']),
        authorfirstname: data['authorfirstname'] as String?,
        authorlastname: data['authorlastname'] as String?,
        department: data['department'] as String?,
        responsible: castToType<int>(data['responsible']),
        paramVals: data['param_vals'] is ResponseStruct
            ? data['param_vals']
            : ResponseStruct.maybeFromMap(data['param_vals']),
      );

  static ConfirmdefectStruct? maybeFromMap(dynamic data) => data is Map
      ? ConfirmdefectStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'type': _type,
        'event': _event,
        'title': _title,
        'reason': _reason,
        'id': _id,
        'equipTitle': _equipTitle,
        'equipID': _equipID,
        'isFixedOnPlace': _isFixedOnPlace,
        'isEmergencySituation': _isEmergencySituation,
        'authorid': _authorid,
        'authorfirstname': _authorfirstname,
        'authorlastname': _authorlastname,
        'department': _department,
        'responsible': _responsible,
        'param_vals': _paramVals?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'event': serializeParam(
          _event,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'reason': serializeParam(
          _reason,
          ParamType.String,
        ),
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'equipTitle': serializeParam(
          _equipTitle,
          ParamType.String,
        ),
        'equipID': serializeParam(
          _equipID,
          ParamType.int,
        ),
        'isFixedOnPlace': serializeParam(
          _isFixedOnPlace,
          ParamType.int,
        ),
        'isEmergencySituation': serializeParam(
          _isEmergencySituation,
          ParamType.int,
        ),
        'authorid': serializeParam(
          _authorid,
          ParamType.int,
        ),
        'authorfirstname': serializeParam(
          _authorfirstname,
          ParamType.String,
        ),
        'authorlastname': serializeParam(
          _authorlastname,
          ParamType.String,
        ),
        'department': serializeParam(
          _department,
          ParamType.String,
        ),
        'responsible': serializeParam(
          _responsible,
          ParamType.int,
        ),
        'param_vals': serializeParam(
          _paramVals,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static ConfirmdefectStruct fromSerializableMap(Map<String, dynamic> data) =>
      ConfirmdefectStruct(
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        event: deserializeParam(
          data['event'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        reason: deserializeParam(
          data['reason'],
          ParamType.String,
          false,
        ),
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        equipTitle: deserializeParam(
          data['equipTitle'],
          ParamType.String,
          false,
        ),
        equipID: deserializeParam(
          data['equipID'],
          ParamType.int,
          false,
        ),
        isFixedOnPlace: deserializeParam(
          data['isFixedOnPlace'],
          ParamType.int,
          false,
        ),
        isEmergencySituation: deserializeParam(
          data['isEmergencySituation'],
          ParamType.int,
          false,
        ),
        authorid: deserializeParam(
          data['authorid'],
          ParamType.int,
          false,
        ),
        authorfirstname: deserializeParam(
          data['authorfirstname'],
          ParamType.String,
          false,
        ),
        authorlastname: deserializeParam(
          data['authorlastname'],
          ParamType.String,
          false,
        ),
        department: deserializeParam(
          data['department'],
          ParamType.String,
          false,
        ),
        responsible: deserializeParam(
          data['responsible'],
          ParamType.int,
          false,
        ),
        paramVals: deserializeStructParam(
          data['param_vals'],
          ParamType.DataStruct,
          false,
          structBuilder: ResponseStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'ConfirmdefectStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ConfirmdefectStruct &&
        type == other.type &&
        event == other.event &&
        title == other.title &&
        reason == other.reason &&
        id == other.id &&
        equipTitle == other.equipTitle &&
        equipID == other.equipID &&
        isFixedOnPlace == other.isFixedOnPlace &&
        isEmergencySituation == other.isEmergencySituation &&
        authorid == other.authorid &&
        authorfirstname == other.authorfirstname &&
        authorlastname == other.authorlastname &&
        department == other.department &&
        responsible == other.responsible &&
        paramVals == other.paramVals;
  }

  @override
  int get hashCode => const ListEquality().hash([
        type,
        event,
        title,
        reason,
        id,
        equipTitle,
        equipID,
        isFixedOnPlace,
        isEmergencySituation,
        authorid,
        authorfirstname,
        authorlastname,
        department,
        responsible,
        paramVals
      ]);
}

ConfirmdefectStruct createConfirmdefectStruct({
  String? type,
  String? event,
  String? title,
  String? reason,
  int? id,
  String? equipTitle,
  int? equipID,
  int? isFixedOnPlace,
  int? isEmergencySituation,
  int? authorid,
  String? authorfirstname,
  String? authorlastname,
  String? department,
  int? responsible,
  ResponseStruct? paramVals,
}) =>
    ConfirmdefectStruct(
      type: type,
      event: event,
      title: title,
      reason: reason,
      id: id,
      equipTitle: equipTitle,
      equipID: equipID,
      isFixedOnPlace: isFixedOnPlace,
      isEmergencySituation: isEmergencySituation,
      authorid: authorid,
      authorfirstname: authorfirstname,
      authorlastname: authorlastname,
      department: department,
      responsible: responsible,
      paramVals: paramVals ?? ResponseStruct(),
    );
