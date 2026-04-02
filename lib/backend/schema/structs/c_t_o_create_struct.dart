// ignore_for_file: unnecessary_getters_setters

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CTOCreateStruct extends BaseStruct {
  CTOCreateStruct({
    String? workspaceId,
    String? title,
    String? equipmentId,
    String? type,
    String? acceptorId,
    String? serviceStationId,
    List<WorksStruct>? works,
    List<InventoryItemsStruct>? inventoryItems,
    bool? needTowTruck,
    String? desiredRepairAt,
    List<String>? defectIds,
    // Новые поля
    List<String>? maintenanceIds,
    bool? diagnosticsOnSite,
    String? diagnosticsAddress,
    String? desiredDiagnosticsAt,
    int? mileage,
    int? engineHours,
    String? typeOfRepairProcess,
  })  : _workspaceId = workspaceId,
        _title = title,
        _equipmentId = equipmentId,
        _type = type,
        _acceptorId = acceptorId,
        _serviceStationId = serviceStationId,
        _works = works,
        _inventoryItems = inventoryItems,
        _needTowTruck = needTowTruck,
        _desiredRepairAt = desiredRepairAt,
        _defectIds = defectIds,
        _maintenanceIds = maintenanceIds,
        _diagnosticsOnSite = diagnosticsOnSite,
        _diagnosticsAddress = diagnosticsAddress,
        _desiredDiagnosticsAt = desiredDiagnosticsAt,
        _mileage = mileage,
        _engineHours = engineHours,
        _typeOfRepairProcess = typeOfRepairProcess;

  // "workspace_id" field.
  String? _workspaceId;
  String get workspaceId => _workspaceId ?? '';
  set workspaceId(String? val) => _workspaceId = val;
  bool hasWorkspaceId() => _workspaceId != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "equipment_id" field.
  String? _equipmentId;
  String get equipmentId => _equipmentId ?? '';
  set equipmentId(String? val) => _equipmentId = val;
  bool hasEquipmentId() => _equipmentId != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;
  bool hasType() => _type != null;

  // "acceptor_id" field.
  String? _acceptorId;
  String get acceptorId => _acceptorId ?? '';
  set acceptorId(String? val) => _acceptorId = val;
  bool hasAcceptorId() => _acceptorId != null;

  // "service_station_id" field.
  String? _serviceStationId;
  String get serviceStationId => _serviceStationId ?? '';
  set serviceStationId(String? val) => _serviceStationId = val;
  bool hasServiceStationId() => _serviceStationId != null;

  // "works" field.
  List<WorksStruct>? _works;
  List<WorksStruct> get works => _works ?? const [];
  set works(List<WorksStruct>? val) => _works = val;
  void updateWorks(Function(List<WorksStruct>) updateFn) {
    updateFn(_works ??= []);
  }
  bool hasWorks() => _works != null;

  // "inventory_items" field.
  List<InventoryItemsStruct>? _inventoryItems;
  List<InventoryItemsStruct> get inventoryItems => _inventoryItems ?? const [];
  set inventoryItems(List<InventoryItemsStruct>? val) => _inventoryItems = val;
  void updateInventoryItems(Function(List<InventoryItemsStruct>) updateFn) {
    updateFn(_inventoryItems ??= []);
  }
  bool hasInventoryItems() => _inventoryItems != null;

  // "need_tow_truck" field.
  bool? _needTowTruck;
  bool get needTowTruck => _needTowTruck ?? false;
  set needTowTruck(bool? val) => _needTowTruck = val;
  bool hasNeedTowTruck() => _needTowTruck != null;

  // "desired_repair_at" field.
  String? _desiredRepairAt;
  String get desiredRepairAt => _desiredRepairAt ?? '';
  set desiredRepairAt(String? val) => _desiredRepairAt = val;
  bool hasDesiredRepairAt() => _desiredRepairAt != null;

  // "defect_ids" field.
  List<String>? _defectIds;
  List<String> get defectIds => _defectIds ?? const [];
  set defectIds(List<String>? val) => _defectIds = val;
  void updateDefectIds(Function(List<String>) updateFn) {
    updateFn(_defectIds ??= []);
  }
  bool hasDefectIds() => _defectIds != null;

  // "maintenance_ids" field.
  List<String>? _maintenanceIds;
  List<String> get maintenanceIds => _maintenanceIds ?? const [];
  set maintenanceIds(List<String>? val) => _maintenanceIds = val;
  void updateMaintenanceIds(Function(List<String>) updateFn) {
    updateFn(_maintenanceIds ??= []);
  }
  bool hasMaintenanceIds() => _maintenanceIds != null;

  // "diagnostics_on_site" field.
  bool? _diagnosticsOnSite;
  bool get diagnosticsOnSite => _diagnosticsOnSite ?? false;
  set diagnosticsOnSite(bool? val) => _diagnosticsOnSite = val;
  bool hasDiagnosticsOnSite() => _diagnosticsOnSite != null;

  // "diagnostics_address" field.
  String? _diagnosticsAddress;
  String get diagnosticsAddress => _diagnosticsAddress ?? '';
  set diagnosticsAddress(String? val) => _diagnosticsAddress = val;
  bool hasDiagnosticsAddress() => _diagnosticsAddress != null;

  // "desired_diagnostics_at" field.
  String? _desiredDiagnosticsAt;
  String get desiredDiagnosticsAt => _desiredDiagnosticsAt ?? '';
  set desiredDiagnosticsAt(String? val) => _desiredDiagnosticsAt = val;
  bool hasDesiredDiagnosticsAt() => _desiredDiagnosticsAt != null;

  // "mileage" field.
  int? _mileage;
  int get mileage => _mileage ?? 0;
  set mileage(int? val) => _mileage = val;
  void incrementMileage(int amount) => _mileage = mileage + amount;
  bool hasMileage() => _mileage != null;

  // "engine_hours" field.
  int? _engineHours;
  int get engineHours => _engineHours ?? 0;
  set engineHours(int? val) => _engineHours = val;
  void incrementEngineHours(int amount) => _engineHours = engineHours + amount;
  bool hasEngineHours() => _engineHours != null;

  String? _typeOfRepairProcess;
  String get typeOfRepairProcess => _typeOfRepairProcess ?? '';
  set typeOfRepairProcess(String? val) => _typeOfRepairProcess = val;
  bool hasTypeOfRepairProcess() => _typeOfRepairProcess != null;

  static CTOCreateStruct fromMap(Map<String, dynamic> data) => CTOCreateStruct(
        workspaceId: data['workspace_id'] as String?,
        title: data['title'] as String?,
        equipmentId: data['equipment_id'] as String?,
        type: data['type'] as String?,
        acceptorId: data['acceptor_id'] as String?,
        serviceStationId: data['service_station_id'] as String?,
        works: getStructList(
          data['works'],
          WorksStruct.fromMap,
        ),
        inventoryItems: getStructList(
          data['inventory_items'],
          InventoryItemsStruct.fromMap,
        ),
        needTowTruck: data['need_tow_truck'] as bool?,
        desiredRepairAt: data['desired_repair_at'] as String?,
        defectIds: getDataList(data['defect_ids']),
        // Маппинг новых полей
        maintenanceIds: getDataList(data['maintenance_ids']),
        diagnosticsOnSite: data['diagnostics_on_site'] as bool?,
        diagnosticsAddress: data['diagnostics_address'] as String?,
        desiredDiagnosticsAt: data['desired_diagnostics_at'] as String?,
        mileage: castToType<int>(data['mileage']),
        engineHours: castToType<int>(data['engine_hours']),
        typeOfRepairProcess: data['type_of_repair_process'] as String?,
      );

  static CTOCreateStruct? maybeFromMap(dynamic data) => data is Map
      ? CTOCreateStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'workspace_id': _workspaceId,
        'title': _title,
        'equipment_id': _equipmentId,
        'type': _type,
        'acceptor_id': _acceptorId,
        'service_station_id': _serviceStationId,
        'works': _works?.map((e) => e.toMap()).toList(),
        'inventory_items': _inventoryItems?.map((e) => e.toMap()).toList(),
        'need_tow_truck': _needTowTruck,
        'desired_repair_at': _desiredRepairAt,
        'defect_ids': _defectIds,
        // Сериализация новых полей
        'maintenance_ids': _maintenanceIds,
        'diagnostics_on_site': _diagnosticsOnSite,
        'diagnostics_address': _diagnosticsAddress,
        'desired_diagnostics_at': _desiredDiagnosticsAt,
        'mileage': _mileage,
        'engine_hours': _engineHours,
        'type_of_repair_process': _typeOfRepairProcess,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'workspace_id': serializeParam(
          _workspaceId,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'equipment_id': serializeParam(
          _equipmentId,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'acceptor_id': serializeParam(
          _acceptorId,
          ParamType.String,
        ),
        'service_station_id': serializeParam(
          _serviceStationId,
          ParamType.String,
        ),
        'works': serializeParam(
          _works,
          ParamType.DataStruct,
          isList: true,
        ),
        'inventory_items': serializeParam(
          _inventoryItems,
          ParamType.DataStruct,
          isList: true,
        ),
        'need_tow_truck': serializeParam(
          _needTowTruck,
          ParamType.bool,
        ),
        'desired_repair_at': serializeParam(
          _desiredRepairAt,
          ParamType.String,
        ),
        'defect_ids': serializeParam(
          _defectIds,
          ParamType.String,
          isList: true,
        ),
        // Сериализация для FlutterFlow новых полей
        'maintenance_ids': serializeParam(
          _maintenanceIds,
          ParamType.String,
          isList: true,
        ),
        'diagnostics_on_site': serializeParam(
          _diagnosticsOnSite,
          ParamType.bool,
        ),
        'diagnostics_address': serializeParam(
          _diagnosticsAddress,
          ParamType.String,
        ),
        'desired_diagnostics_at': serializeParam(
          _desiredDiagnosticsAt,
          ParamType.String,
        ),
        'mileage': serializeParam(
          _mileage,
          ParamType.int,
        ),
        'engine_hours': serializeParam(
          _engineHours,
          ParamType.int,
        ),
        'type_of_repair_process': serializeParam(
          _typeOfRepairProcess,
          ParamType.String,
        ),
      }.withoutNulls;

  static CTOCreateStruct fromSerializableMap(Map<String, dynamic> data) =>
      CTOCreateStruct(
        workspaceId: deserializeParam(
          data['workspace_id'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        equipmentId: deserializeParam(
          data['equipment_id'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        acceptorId: deserializeParam(
          data['acceptor_id'],
          ParamType.String,
          false,
        ),
        serviceStationId: deserializeParam(
          data['service_station_id'],
          ParamType.String,
          false,
        ),
        works: deserializeStructParam<WorksStruct>(
          data['works'],
          ParamType.DataStruct,
          true,
          structBuilder: WorksStruct.fromSerializableMap,
        ),
        inventoryItems: deserializeStructParam<InventoryItemsStruct>(
          data['inventory_items'],
          ParamType.DataStruct,
          true,
          structBuilder: InventoryItemsStruct.fromSerializableMap,
        ),
        needTowTruck: deserializeParam(
          data['need_tow_truck'],
          ParamType.bool,
          false,
        ),
        desiredRepairAt: deserializeParam(
          data['desired_repair_at'],
          ParamType.String,
          false,
        ),
        defectIds: deserializeParam<String>(
          data['defect_ids'],
          ParamType.String,
          true,
        ),
        // Десериализация новых полей
        maintenanceIds: deserializeParam<String>(
          data['maintenance_ids'],
          ParamType.String,
          true,
        ),
        diagnosticsOnSite: deserializeParam(
          data['diagnostics_on_site'],
          ParamType.bool,
          false,
        ),
        diagnosticsAddress: deserializeParam(
          data['diagnostics_address'],
          ParamType.String,
          false,
        ),
        desiredDiagnosticsAt: deserializeParam(
          data['desired_diagnostics_at'],
          ParamType.String,
          false,
        ),
        mileage: deserializeParam(
          data['mileage'],
          ParamType.int,
          false,
        ),
        engineHours: deserializeParam(
          data['engine_hours'],
          ParamType.int,
          false,
        ),
        typeOfRepairProcess: deserializeParam(
          data['type_of_repair_process'],
          ParamType.String,
          false,)
      );

  @override
  String toString() => 'CTOCreateStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CTOCreateStruct &&
        workspaceId == other.workspaceId &&
        title == other.title &&
        equipmentId == other.equipmentId &&
        type == other.type &&
        acceptorId == other.acceptorId &&
        serviceStationId == other.serviceStationId &&
        listEquality.equals(works, other.works) &&
        listEquality.equals(inventoryItems, other.inventoryItems) &&
        needTowTruck == other.needTowTruck &&
        desiredRepairAt == other.desiredRepairAt &&
        listEquality.equals(defectIds, other.defectIds) &&
        // Сравнение новых полей
        listEquality.equals(maintenanceIds, other.maintenanceIds) &&
        diagnosticsOnSite == other.diagnosticsOnSite &&
        diagnosticsAddress == other.diagnosticsAddress &&
        desiredDiagnosticsAt == other.desiredDiagnosticsAt &&
        mileage == other.mileage &&
        engineHours == other.engineHours &&
        typeOfRepairProcess == other.typeOfRepairProcess;
  }

  @override
  int get hashCode => const ListEquality().hash([
        workspaceId,
        title,
        equipmentId,
        type,
        acceptorId,
        serviceStationId,
        works,
        inventoryItems,
        needTowTruck,
        desiredRepairAt,
        defectIds,
        // Хэширование новых полей
        maintenanceIds,
        diagnosticsOnSite,
        diagnosticsAddress,
        desiredDiagnosticsAt,
        mileage,
        engineHours,
        typeOfRepairProcess
      ]);
}

CTOCreateStruct createCTOCreateStruct({
  String? workspaceId,
  String? title,
  String? equipmentId,
  String? type,
  String? acceptorId,
  String? serviceStationId,
  bool? needTowTruck,
  String? desiredRepairAt,
  // Аргументы для новых полей
  bool? diagnosticsOnSite,
  String? diagnosticsAddress,
  String? desiredDiagnosticsAt,
  int? mileage,
  int? engineHours,
  String? typeOfRepairProcess,
}) =>
    CTOCreateStruct(
      workspaceId: workspaceId,
      title: title,
      equipmentId: equipmentId,
      type: type,
      acceptorId: acceptorId,
      serviceStationId: serviceStationId,
      needTowTruck: needTowTruck,
      desiredRepairAt: desiredRepairAt,
      // Инициализация новых полей
      diagnosticsOnSite: diagnosticsOnSite,
      diagnosticsAddress: diagnosticsAddress,
      desiredDiagnosticsAt: desiredDiagnosticsAt,
      mileage: mileage,
      engineHours: engineHours,
      typeOfRepairProcess: typeOfRepairProcess,
    );