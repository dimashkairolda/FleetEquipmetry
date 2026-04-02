// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InventoryItemsStruct extends BaseStruct {
  InventoryItemsStruct({
    String? title,
    String? productArticle,
    int? quantity,
    String? unitOfMeasurement,
    String? defectId,
    String? source,
    double? price,
    bool? inStock,
    String? serviceStationComment,
  })  : _title = title,
        _productArticle = productArticle,
        _quantity = quantity,
        _unitOfMeasurement = unitOfMeasurement,
        _defectId = defectId,
        _source = source,
        _price = price,
        _inStock = inStock,
        _serviceStationComment = serviceStationComment;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "product_article" field.
  String? _productArticle;
  String get productArticle => _productArticle ?? '';
  set productArticle(String? val) => _productArticle = val;

  bool hasProductArticle() => _productArticle != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

  // "unit_of_measurement" field.
  String? _unitOfMeasurement;
  String get unitOfMeasurement => _unitOfMeasurement ?? '';
  set unitOfMeasurement(String? val) => _unitOfMeasurement = val;

  bool hasUnitOfMeasurement() => _unitOfMeasurement != null;

  // "defect_id" field.
  String? _defectId;
  String get defectId => _defectId ?? '';
  set defectId(String? val) => _defectId = val;

  bool hasDefectId() => _defectId != null;

   String? _source;
  String get source => _source ?? '';
  set source(String? val) => _source = val;

  bool hasSource() => _source != null;
  // "price" field.
  double? _price;
  double get price => _price ?? 0.0;
  set price(double? val) => _price = val;

  void incrementPrice(double amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "in_stock" field.
  bool? _inStock;
  bool get inStock => _inStock ?? false;
  set inStock(bool? val) => _inStock = val;

  bool hasInStock() => _inStock != null;

  // "service_station_comment" field.
  String? _serviceStationComment;
  String get serviceStationComment => _serviceStationComment ?? '';
  set serviceStationComment(String? val) => _serviceStationComment = val;

  bool hasServiceStationComment() => _serviceStationComment != null;

  static InventoryItemsStruct fromMap(Map<String, dynamic> data) =>
      InventoryItemsStruct(
        title: data['title'] as String?,
        productArticle: data['product_article'] as String?,
        quantity: castToType<int>(data['quantity']),
        unitOfMeasurement: data['unit_of_measurement'] as String?,
        defectId: data['defect_id'] as String?,
        source: data['source'] as String?,
        price: castToType<double>(data['price']),
        inStock: data['in_stock'] as bool?,
        serviceStationComment: data['service_station_comment'] as String?,
      );

  static InventoryItemsStruct? maybeFromMap(dynamic data) => data is Map
      ? InventoryItemsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'product_article': _productArticle,
        'quantity': _quantity,
        'unit_of_measurement': _unitOfMeasurement,
        'defect_id': _defectId,
        'source': _source,
        'price': _price,
        'in_stock': _inStock,
        'service_station_comment': _serviceStationComment,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'product_article': serializeParam(
          _productArticle,
          ParamType.String,
        ),
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
        ),
        'unit_of_measurement': serializeParam(
          _unitOfMeasurement,
          ParamType.String,
        ),
        'defect_id': serializeParam(
          _defectId,
          ParamType.String,
        ),
        'source': serializeParam(
          _source,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.double,
        ),
        'in_stock': serializeParam(
          _inStock,
          ParamType.bool,
        ),
        'service_station_comment': serializeParam(
          _serviceStationComment,
          ParamType.String,
        ),
      }.withoutNulls;

  static InventoryItemsStruct fromSerializableMap(Map<String, dynamic> data) =>
      InventoryItemsStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        productArticle: deserializeParam(
          data['product_article'],
          ParamType.String,
          false,
        ),
        quantity: deserializeParam(
          data['quantity'],
          ParamType.int,
          false,
        ),
        unitOfMeasurement: deserializeParam(
          data['unit_of_measurement'],
          ParamType.String,
          false,
        ),
        defectId: deserializeParam(
          data['defect_id'],
          ParamType.String,
          false,
        ),
        source: deserializeParam(
          data['source'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.double,
          false,
        ),
        inStock: deserializeParam(
          data['in_stock'],
          ParamType.bool,
          false,
        ),
        serviceStationComment: deserializeParam(
          data['service_station_comment'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'InventoryItemsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InventoryItemsStruct &&
        title == other.title &&
        productArticle == other.productArticle &&
        quantity == other.quantity &&
        unitOfMeasurement == other.unitOfMeasurement &&
        defectId == other.defectId &&
        source == other.source &&
        price == other.price &&
        inStock == other.inStock &&
        serviceStationComment == other.serviceStationComment;
  }

  @override
  int get hashCode => const ListEquality().hash([
        title,
        productArticle,
        quantity,
        unitOfMeasurement,
        defectId,
        source,
        price,
        inStock,
        serviceStationComment
      ]);
}

InventoryItemsStruct createInventoryItemsStruct({
  String? title,
  String? productArticle,
  int? quantity,
  String? unitOfMeasurement,
  String? defectId,
  String? source,
  double? price,
  bool? inStock,
  String? serviceStationComment,
}) =>
    InventoryItemsStruct(
      title: title,
      productArticle: productArticle,
      quantity: quantity,
      unitOfMeasurement: unitOfMeasurement,
      defectId: defectId,
      source: source,
      price: price,
      inStock: inStock,
      serviceStationComment: serviceStationComment,
    );
