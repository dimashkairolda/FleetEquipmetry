// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class OfflineDefectsStruct extends BaseStruct {
  OfflineDefectsStruct({
    int? areaID,
    int? equipID,
    String? type,
    String? title,
    String? reason,
    String? event,
    bool? isFixedOnPlace,
    bool? isEmergencySituation,
    List<String>? spareParts,
  })  : _areaID = areaID,
        _equipID = equipID,
        _type = type,
        _title = title,
        _reason = reason,
        _event = event,
        _isFixedOnPlace = isFixedOnPlace,
        _isEmergencySituation = isEmergencySituation,
        _spareParts = spareParts;

  // "areaID" field.
  int? _areaID;
  int get areaID => _areaID ?? 0;
  set areaID(int? val) => _areaID = val;

  void incrementAreaID(int amount) => areaID = areaID + amount;

  bool hasAreaID() => _areaID != null;

  // "equipID" field.
  int? _equipID;
  int get equipID => _equipID ?? 0;
  set equipID(int? val) => _equipID = val;

  void incrementEquipID(int amount) => equipID = equipID + amount;

  bool hasEquipID() => _equipID != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

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

  // "event" field.
  String? _event;
  String get event => _event ?? '';
  set event(String? val) => _event = val;

  bool hasEvent() => _event != null;

  // "is_fixed_on_place" field.
  bool? _isFixedOnPlace;
  bool get isFixedOnPlace => _isFixedOnPlace ?? false;
  set isFixedOnPlace(bool? val) => _isFixedOnPlace = val;

  bool hasIsFixedOnPlace() => _isFixedOnPlace != null;

  // "is_emergency_situation" field.
  bool? _isEmergencySituation;
  bool get isEmergencySituation => _isEmergencySituation ?? false;
  set isEmergencySituation(bool? val) => _isEmergencySituation = val;

  bool hasIsEmergencySituation() => _isEmergencySituation != null;

  // "spare_parts" field.
  List<String>? _spareParts;
  List<String> get spareParts => _spareParts ?? const [];
  set spareParts(List<String>? val) => _spareParts = val;

  void updateSpareParts(Function(List<String>) updateFn) {
    updateFn(_spareParts ??= []);
  }

  bool hasSpareParts() => _spareParts != null;

  static OfflineDefectsStruct fromMap(Map<String, dynamic> data) =>
      OfflineDefectsStruct(
        areaID: castToType<int>(data['areaID']),
        equipID: castToType<int>(data['equipID']),
        type: data['type'] as String?,
        title: data['title'] as String?,
        reason: data['reason'] as String?,
        event: data['event'] as String?,
        isFixedOnPlace: data['is_fixed_on_place'] as bool?,
        isEmergencySituation: data['is_emergency_situation'] as bool?,
        spareParts: getDataList(data['spare_parts']),
      );

  static OfflineDefectsStruct? maybeFromMap(dynamic data) => data is Map
      ? OfflineDefectsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'areaID': _areaID,
        'equipID': _equipID,
        'type': _type,
        'title': _title,
        'reason': _reason,
        'event': _event,
        'is_fixed_on_place': _isFixedOnPlace,
        'is_emergency_situation': _isEmergencySituation,
        'spare_parts': _spareParts,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'areaID': serializeParam(
          _areaID,
          ParamType.int,
        ),
        'equipID': serializeParam(
          _equipID,
          ParamType.int,
        ),
        'type': serializeParam(
          _type,
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
        'event': serializeParam(
          _event,
          ParamType.String,
        ),
        'is_fixed_on_place': serializeParam(
          _isFixedOnPlace,
          ParamType.bool,
        ),
        'is_emergency_situation': serializeParam(
          _isEmergencySituation,
          ParamType.bool,
        ),
        'spare_parts': serializeParam(
          _spareParts,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static OfflineDefectsStruct fromSerializableMap(Map<String, dynamic> data) =>
      OfflineDefectsStruct(
        areaID: deserializeParam(
          data['areaID'],
          ParamType.int,
          false,
        ),
        equipID: deserializeParam(
          data['equipID'],
          ParamType.int,
          false,
        ),
        type: deserializeParam(
          data['type'],
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
        event: deserializeParam(
          data['event'],
          ParamType.String,
          false,
        ),
        isFixedOnPlace: deserializeParam(
          data['is_fixed_on_place'],
          ParamType.bool,
          false,
        ),
        isEmergencySituation: deserializeParam(
          data['is_emergency_situation'],
          ParamType.bool,
          false,
        ),
        spareParts: deserializeParam<String>(
          data['spare_parts'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'OfflineDefectsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is OfflineDefectsStruct &&
        areaID == other.areaID &&
        equipID == other.equipID &&
        type == other.type &&
        title == other.title &&
        reason == other.reason &&
        event == other.event &&
        isFixedOnPlace == other.isFixedOnPlace &&
        isEmergencySituation == other.isEmergencySituation &&
        listEquality.equals(spareParts, other.spareParts);
  }

  @override
  int get hashCode => const ListEquality().hash([
        areaID,
        equipID,
        type,
        title,
        reason,
        event,
        isFixedOnPlace,
        isEmergencySituation,
        spareParts
      ]);
}

OfflineDefectsStruct createOfflineDefectsStruct({
  int? areaID,
  int? equipID,
  String? type,
  String? title,
  String? reason,
  String? event,
  bool? isFixedOnPlace,
  bool? isEmergencySituation,
}) =>
    OfflineDefectsStruct(
      areaID: areaID,
      equipID: equipID,
      type: type,
      title: title,
      reason: reason,
      event: event,
      isFixedOnPlace: isFixedOnPlace,
      isEmergencySituation: isEmergencySituation,
    );
