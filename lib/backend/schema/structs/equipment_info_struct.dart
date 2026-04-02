// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EquipmentInfoStruct extends BaseStruct {
  EquipmentInfoStruct({
    int? id,
    String? title,
    String? factoryNumber,
    String? inventoryNumber,
    String? dispatchNumber,
    int? area,
  })  : _id = id,
        _title = title,
        _factoryNumber = factoryNumber,
        _inventoryNumber = inventoryNumber,
        _dispatchNumber = dispatchNumber,
        _area = area;

  // "id" field.
  int? _id;
  int get id => _id ?? 0;
  set id(int? val) => _id = val;

  void incrementId(int amount) => id = id + amount;

  bool hasId() => _id != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "factory_number" field.
  String? _factoryNumber;
  String get factoryNumber => _factoryNumber ?? '';
  set factoryNumber(String? val) => _factoryNumber = val;

  bool hasFactoryNumber() => _factoryNumber != null;

  // "inventory_number" field.
  String? _inventoryNumber;
  String get inventoryNumber => _inventoryNumber ?? '';
  set inventoryNumber(String? val) => _inventoryNumber = val;

  bool hasInventoryNumber() => _inventoryNumber != null;

  // "dispatch_number" field.
  String? _dispatchNumber;
  String get dispatchNumber => _dispatchNumber ?? '';
  set dispatchNumber(String? val) => _dispatchNumber = val;

  bool hasDispatchNumber() => _dispatchNumber != null;

  // "area" field.
  int? _area;
  int get area => _area ?? 0;
  set area(int? val) => _area = val;

  void incrementArea(int amount) => area = area + amount;

  bool hasArea() => _area != null;

  static EquipmentInfoStruct fromMap(Map<String, dynamic> data) =>
      EquipmentInfoStruct(
        id: castToType<int>(data['id']),
        title: data['title'] as String?,
        factoryNumber: data['factory_number'] as String?,
        inventoryNumber: data['inventory_number'] as String?,
        dispatchNumber: data['dispatch_number'] as String?,
        area: castToType<int>(data['area']),
      );

  static EquipmentInfoStruct? maybeFromMap(dynamic data) => data is Map
      ? EquipmentInfoStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'title': _title,
        'factory_number': _factoryNumber,
        'inventory_number': _inventoryNumber,
        'dispatch_number': _dispatchNumber,
        'area': _area,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.int,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'factory_number': serializeParam(
          _factoryNumber,
          ParamType.String,
        ),
        'inventory_number': serializeParam(
          _inventoryNumber,
          ParamType.String,
        ),
        'dispatch_number': serializeParam(
          _dispatchNumber,
          ParamType.String,
        ),
        'area': serializeParam(
          _area,
          ParamType.int,
        ),
      }.withoutNulls;

  static EquipmentInfoStruct fromSerializableMap(Map<String, dynamic> data) =>
      EquipmentInfoStruct(
        id: deserializeParam(
          data['id'],
          ParamType.int,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        factoryNumber: deserializeParam(
          data['factory_number'],
          ParamType.String,
          false,
        ),
        inventoryNumber: deserializeParam(
          data['inventory_number'],
          ParamType.String,
          false,
        ),
        dispatchNumber: deserializeParam(
          data['dispatch_number'],
          ParamType.String,
          false,
        ),
        area: deserializeParam(
          data['area'],
          ParamType.int,
          false,
        ),
      );

  @override
  String toString() => 'EquipmentInfoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EquipmentInfoStruct &&
        id == other.id &&
        title == other.title &&
        factoryNumber == other.factoryNumber &&
        inventoryNumber == other.inventoryNumber &&
        dispatchNumber == other.dispatchNumber &&
        area == other.area;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, title, factoryNumber, inventoryNumber, dispatchNumber, area]);
}

EquipmentInfoStruct createEquipmentInfoStruct({
  int? id,
  String? title,
  String? factoryNumber,
  String? inventoryNumber,
  String? dispatchNumber,
  int? area,
}) =>
    EquipmentInfoStruct(
      id: id,
      title: title,
      factoryNumber: factoryNumber,
      inventoryNumber: inventoryNumber,
      dispatchNumber: dispatchNumber,
      area: area,
    );
