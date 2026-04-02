// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SparePartsCTOStruct extends BaseStruct {
  SparePartsCTOStruct({
    String? title,
    String? productArticle,
    int? quantity,
    String? unit,
    int? price,
    int? sum,
    String? comment,
  })  : _title = title,
        _productArticle = productArticle,
        _quantity = quantity,
        _unit = unit,
        _price = price,
        _sum = sum,
        _comment = comment;

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

  // "unit" field.
  String? _unit;
  String get unit => _unit ?? '';
  set unit(String? val) => _unit = val;

  bool hasUnit() => _unit != null;

  // "price" field.
  int? _price;
  int get price => _price ?? 0;
  set price(int? val) => _price = val;

  void incrementPrice(int amount) => price = price + amount;

  bool hasPrice() => _price != null;

  // "sum" field.
  int? _sum;
  int get sum => _sum ?? 0;
  set sum(int? val) => _sum = val;

  void incrementSum(int amount) => sum = sum + amount;

  bool hasSum() => _sum != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  static SparePartsCTOStruct fromMap(Map<String, dynamic> data) =>
      SparePartsCTOStruct(
        title: data['title'] as String?,
        productArticle: data['product_article'] as String?,
        quantity: castToType<int>(data['quantity']),
        unit: data['unit'] as String?,
        price: castToType<int>(data['price']),
        sum: castToType<int>(data['sum']),
        comment: data['comment'] as String?,
      );

  static SparePartsCTOStruct? maybeFromMap(dynamic data) => data is Map
      ? SparePartsCTOStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'product_article': _productArticle,
        'quantity': _quantity,
        'unit': _unit,
        'price': _price,
        'sum': _sum,
        'comment': _comment,
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
        'unit': serializeParam(
          _unit,
          ParamType.String,
        ),
        'price': serializeParam(
          _price,
          ParamType.int,
        ),
        'sum': serializeParam(
          _sum,
          ParamType.int,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
      }.withoutNulls;

  static SparePartsCTOStruct fromSerializableMap(Map<String, dynamic> data) =>
      SparePartsCTOStruct(
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
        unit: deserializeParam(
          data['unit'],
          ParamType.String,
          false,
        ),
        price: deserializeParam(
          data['price'],
          ParamType.int,
          false,
        ),
        sum: deserializeParam(
          data['sum'],
          ParamType.int,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'SparePartsCTOStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SparePartsCTOStruct &&
        title == other.title &&
        productArticle == other.productArticle &&
        quantity == other.quantity &&
        unit == other.unit &&
        price == other.price &&
        sum == other.sum &&
        comment == other.comment;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([title, productArticle, quantity, unit, price, sum, comment]);
}

SparePartsCTOStruct createSparePartsCTOStruct({
  String? title,
  String? productArticle,
  int? quantity,
  String? unit,
  int? price,
  int? sum,
  String? comment,
}) =>
    SparePartsCTOStruct(
      title: title,
      productArticle: productArticle,
      quantity: quantity,
      unit: unit,
      price: price,
      sum: sum,
      comment: comment,
    );
