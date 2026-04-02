// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class WorksStruct extends BaseStruct {
  WorksStruct({
    String? title,
    int? quantity,
    String? defectId,
    int? price,
    String? serviceStationComment,
    // Новые поля
    String? maintenanceId,
    String? workspaceId,
  })  : _title = title,
        _quantity = quantity,
        _defectId = defectId,
        _price = price,
        _serviceStationComment = serviceStationComment,
        _maintenanceId = maintenanceId,
        _workspaceId = workspaceId;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;
  bool hasTitle() => _title != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 1;
  set quantity(int? val) => _quantity = val;
  void incrementQuantity(int amount) => quantity = quantity + amount;
  bool hasQuantity() => _quantity != null;

  // "defect_id" field.
  String? _defectId;
  String get defectId => _defectId ?? '';
  set defectId(String? val) => _defectId = val;
  bool hasDefectId() => _defectId != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;
  void incrementPrice(int amount) => price = price + amount;
  bool hasPrice() => _price != null;

  // "service_station_comment" field.
  String? _serviceStationComment;
  String get serviceStationComment => _serviceStationComment ?? '';
  set serviceStationComment(String? val) => _serviceStationComment = val;
  bool hasServiceStationComment() => _serviceStationComment != null;

  // "maintenance_id" field (Новое поле).
  String? _maintenanceId;
  String get maintenanceId => _maintenanceId ?? '';
  set maintenanceId(String? val) => _maintenanceId = val;
  bool hasMaintenanceId() => _maintenanceId != null;

  // "workspace_id" field (Новое поле).
  String? _workspaceId;
  String get workspaceId => _workspaceId ?? '';
  set workspaceId(String? val) => _workspaceId = val;
  bool hasWorkspaceId() => _workspaceId != null;

  static WorksStruct fromMap(Map<String, dynamic> data) => WorksStruct(
        title: data['title'] as String?,
        quantity: castToType<int>(data['quantity']),
        defectId: data['defect_id'] as String?,
        price: castToType<int>(data['price']),
        serviceStationComment: data['service_station_comment'] as String?,
        maintenanceId: data['maintenance_id'] as String?,
        workspaceId: data['workspace_id'] as String?,
      );

  static WorksStruct? maybeFromMap(dynamic data) =>
      data is Map ? WorksStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'quantity': _quantity,
        'defect_id': _defectId,
        'price': _price,
        'service_station_comment': _serviceStationComment,
        'maintenance_id': _maintenanceId,
        'workspace_id': _workspaceId,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'defect_id': serializeParam(
          _defectId,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'service_station_comment': serializeParam(
          _serviceStationComment,
          ParamType.String,
        ),
        'maintenance_id': serializeParam(
          _maintenanceId,
          ParamType.String,
        ),
        'workspace_id': serializeParam(
          _workspaceId,
          ParamType.String,
        ),
      }.withoutNulls;

  static WorksStruct fromSerializableMap(Map<String, dynamic> data) =>
      WorksStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        defectId: deserializeParam(
          data['defect_id'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        serviceStationComment: deserializeParam(
          data['service_station_comment'],
          ParamType.String,
          false,
        ),
        maintenanceId: deserializeParam(
          data['maintenance_id'],
          ParamType.String,
          false,
        ),
        workspaceId: deserializeParam(
          data['workspace_id'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'WorksStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is WorksStruct &&
        title == other.title &&
        quantity == other.quantity &&
        defectId == other.defectId &&
        price == other.price &&
        serviceStationComment == other.serviceStationComment &&
        maintenanceId == other.maintenanceId &&
        workspaceId == other.workspaceId;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        quantity,
        defectId,
        price,
        serviceStationComment,
        maintenanceId,
        workspaceId
      ]);
}

WorksStruct createWorksStruct({
  String? title,
  int? quantity,
  String? defectId,
  int? price,
  String? serviceStationComment,
  String? maintenanceId,
  String? workspaceId,
}) =>
    WorksStruct(
      title: title,
      quantity: quantity,
      defectId: defectId,
      price: price,
      serviceStationComment: serviceStationComment,
      maintenanceId: maintenanceId,
      workspaceId: workspaceId,
    );