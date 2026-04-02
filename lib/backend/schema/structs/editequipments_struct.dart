// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EditequipmentsStruct extends BaseStruct {
  EditequipmentsStruct({
    String? equipmentId,
    String? sectorId,
    String? projectId,
    List<String>? responsibleEmployees,
    String? technicalStatus,
    String? exploitationStatus,
    String? location,
    String? columnAssignees,
    String? workTypeId,
    String? createdAt,
  })  : _equipmentId = equipmentId,
        _sectorId = sectorId,
        _projectId = projectId,
        _responsibleEmployees = responsibleEmployees,
        _technicalStatus = technicalStatus,
        _exploitationStatus = exploitationStatus,
        _location = location,
        _columnAssignees = columnAssignees,
        _workTypeId = workTypeId,
        _createdAt = createdAt;

  // "equipment_id" field.
  String? _equipmentId;
  String get equipmentId => _equipmentId ?? '';
  set equipmentId(String? val) => _equipmentId = val;

  bool hasEquipmentId() => _equipmentId != null;

  // "sector_id" field.
  String? _sectorId;
  String get sectorId => _sectorId ?? '';
  set sectorId(String? val) => _sectorId = val;

  bool hasSectorId() => _sectorId != null;

  // "project_id" field.
  String? _projectId;
  String get projectId => _projectId ?? '';
  set projectId(String? val) => _projectId = val;

  bool hasProjectId() => _projectId != null;

  // "responsible_employees" field.
  List<String>? _responsibleEmployees;
  List<String> get responsibleEmployees => _responsibleEmployees ?? const [];
  set responsibleEmployees(List<String>? val) => _responsibleEmployees = val;

  void updateResponsibleEmployees(Function(List<String>) updateFn) {
    updateFn(_responsibleEmployees ??= []);
  }

  bool hasResponsibleEmployees() => _responsibleEmployees != null;

  // "technical_status" field.
  String? _technicalStatus;
  String get technicalStatus => _technicalStatus ?? '';
  set technicalStatus(String? val) => _technicalStatus = val;

  bool hasTechnicalStatus() => _technicalStatus != null;

  // "exploitation_status" field.
  String? _exploitationStatus;
  String get exploitationStatus => _exploitationStatus ?? '';
  set exploitationStatus(String? val) => _exploitationStatus = val;

  bool hasExploitationStatus() => _exploitationStatus != null;

  // "location" field.
  String? _location;
  String get location => _location ?? '';
  set location(String? val) => _location = val;

  bool hasLocation() => _location != null;

  // "column_assignees" field.
  String? _columnAssignees;
  String get columnAssignees => _columnAssignees ?? '';
  set columnAssignees(String? val) => _columnAssignees = val;

  bool hasColumnAssignees() => _columnAssignees != null;

  // "work_type_id" field.
  String? _workTypeId;
  String get workTypeId => _workTypeId ?? '';
  set workTypeId(String? val) => _workTypeId = val;

  bool hasWorkTypeId() => _workTypeId != null;

  // "created_at" field.
  String? _createdAt;
  String get createdAt => _createdAt ?? '';
  set createdAt(String? val) => _createdAt = val;

  bool hasCreatedAt() => _createdAt != null;

  static EditequipmentsStruct fromMap(Map<String, dynamic> data) =>
      EditequipmentsStruct(
        equipmentId: data['equipment_id'] as String?,
        sectorId: data['sector_id'] as String?,
        projectId: data['project_id'] as String?,
        responsibleEmployees: getDataList(data['responsible_employees']),
        technicalStatus: data['technical_status'] as String?,
        exploitationStatus: data['exploitation_status'] as String?,
        location: data['location'] as String?,
        columnAssignees: data['column_assignees'] as String?,
        workTypeId: data['work_type_id'] as String?,
        createdAt: data['created_at'] as String?,
      );

  static EditequipmentsStruct? maybeFromMap(dynamic data) => data is Map
      ? EditequipmentsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'equipment_id': _equipmentId,
        'sector_id': _sectorId,
        'project_id': _projectId,
        'responsible_employees': _responsibleEmployees,
        'technical_status': _technicalStatus,
        'exploitation_status': _exploitationStatus,
        'location': _location,
        'column_assignees': _columnAssignees,
        'work_type_id': _workTypeId,
        'created_at': _createdAt,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'equipment_id': serializeParam(
          _equipmentId,
          ParamType.String,
        ),
        'sector_id': serializeParam(
          _sectorId,
          ParamType.String,
        ),
        'project_id': serializeParam(
          _projectId,
          ParamType.String,
        ),
        'responsible_employees': serializeParam(
          _responsibleEmployees,
          ParamType.String,
          isList: true,
        ),
        'technical_status': serializeParam(
          _technicalStatus,
          ParamType.String,
        ),
        'exploitation_status': serializeParam(
          _exploitationStatus,
          ParamType.String,
        ),
        'location': serializeParam(
          _location,
          ParamType.String,
        ),
        'column_assignees': serializeParam(
          _columnAssignees,
          ParamType.String,
        ),
        'work_type_id': serializeParam(
          _workTypeId,
          ParamType.String,
        ),
        'created_at': serializeParam(
          _createdAt,
          ParamType.String,
        ),
      }.withoutNulls;

  static EditequipmentsStruct fromSerializableMap(Map<String, dynamic> data) =>
      EditequipmentsStruct(
        equipmentId: deserializeParam(
          data['equipment_id'],
          ParamType.String,
          false,
        ),
        sectorId: deserializeParam(
          data['sector_id'],
          ParamType.String,
          false,
        ),
        projectId: deserializeParam(
          data['project_id'],
          ParamType.String,
          false,
        ),
        responsibleEmployees: deserializeParam<String>(
          data['responsible_employees'],
          ParamType.String,
          true,
        ),
        technicalStatus: deserializeParam(
          data['technical_status'],
          ParamType.String,
          false,
        ),
        exploitationStatus: deserializeParam(
          data['exploitation_status'],
          ParamType.String,
          false,
        ),
        location: deserializeParam(
          data['location'],
          ParamType.String,
          false,
        ),
        columnAssignees: deserializeParam(
          data['column_assignees'],
          ParamType.String,
          false,
        ),
        workTypeId: deserializeParam(
          data['work_type_id'],
          ParamType.String,
          false,
        ),
        createdAt: deserializeParam(
          data['created_at'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'EditequipmentsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is EditequipmentsStruct &&
        equipmentId == other.equipmentId &&
        sectorId == other.sectorId &&
        projectId == other.projectId &&
        listEquality.equals(responsibleEmployees, other.responsibleEmployees) &&
        technicalStatus == other.technicalStatus &&
        exploitationStatus == other.exploitationStatus &&
        location == other.location &&
        columnAssignees == other.columnAssignees &&
        workTypeId == other.workTypeId &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode => const ListEquality().hash([
        equipmentId,
        sectorId,
        projectId,
        responsibleEmployees,
        technicalStatus,
        exploitationStatus,
        location,
        columnAssignees,
        workTypeId,
        createdAt
      ]);
}

EditequipmentsStruct createEditequipmentsStruct({
  String? equipmentId,
  String? sectorId,
  String? projectId,
  String? technicalStatus,
  String? exploitationStatus,
  String? location,
  String? columnAssignees,
  String? workTypeId,
  String? createdAt,
}) =>
    EditequipmentsStruct(
      equipmentId: equipmentId,
      sectorId: sectorId,
      projectId: projectId,
      technicalStatus: technicalStatus,
      exploitationStatus: exploitationStatus,
      location: location,
      columnAssignees: columnAssignees,
      workTypeId: workTypeId,
      createdAt: createdAt,
    );
