// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RegulationWorkInfoStruct extends BaseStruct {
  RegulationWorkInfoStruct({
    int? equipment,
    EquipmentInfoStruct? equipmentInfo,
  })  : _equipment = equipment,
        _equipmentInfo = equipmentInfo;

  // "equipment" field.
  int? _equipment;
  int get equipment => _equipment ?? 0;
  set equipment(int? val) => _equipment = val;

  void incrementEquipment(int amount) => equipment = equipment + amount;

  bool hasEquipment() => _equipment != null;

  // "equipment_info" field.
  EquipmentInfoStruct? _equipmentInfo;
  EquipmentInfoStruct get equipmentInfo =>
      _equipmentInfo ?? EquipmentInfoStruct();
  set equipmentInfo(EquipmentInfoStruct? val) => _equipmentInfo = val;

  void updateEquipmentInfo(Function(EquipmentInfoStruct) updateFn) {
    updateFn(_equipmentInfo ??= EquipmentInfoStruct());
  }

  bool hasEquipmentInfo() => _equipmentInfo != null;

  static RegulationWorkInfoStruct fromMap(Map<String, dynamic> data) =>
      RegulationWorkInfoStruct(
        equipment: castToType<int>(data['equipment']),
        equipmentInfo: data['equipment_info'] is EquipmentInfoStruct
            ? data['equipment_info']
            : EquipmentInfoStruct.maybeFromMap(data['equipment_info']),
      );

  static RegulationWorkInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? RegulationWorkInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'equipment': _equipment,
        'equipment_info': _equipmentInfo?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'equipment': serializeParam(
          _equipment,
          ParamType.int,
        ),
        'equipment_info': serializeParam(
          _equipmentInfo,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static RegulationWorkInfoStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      RegulationWorkInfoStruct(
        equipment: deserializeParam(
          data['equipment'],
          ParamType.int,
          false,
        ),
        equipmentInfo: deserializeStructParam(
          data['equipment_info'],
          ParamType.DataStruct,
          false,
          structBuilder: EquipmentInfoStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'RegulationWorkInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is RegulationWorkInfoStruct &&
        equipment == other.equipment &&
        equipmentInfo == other.equipmentInfo;
  }

  @override
  int get hashCode => const ListEquality().hash([equipment, equipmentInfo]);
}

RegulationWorkInfoStruct createRegulationWorkInfoStruct({
  int? equipment,
  EquipmentInfoStruct? equipmentInfo,
}) =>
    RegulationWorkInfoStruct(
      equipment: equipment,
      equipmentInfo: equipmentInfo ?? EquipmentInfoStruct(),
    );
