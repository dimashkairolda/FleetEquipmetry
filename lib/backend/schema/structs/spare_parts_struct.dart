// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SparePartsStruct extends BaseStruct {
  SparePartsStruct({
    String? title,
    String? productArticle,
    int? quantity,
  })  : _title = title,
        _productArticle = productArticle,
        _quantity = quantity;

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

  static SparePartsStruct fromMap(Map<String, dynamic> data) =>
      SparePartsStruct(
        title: data['title'] as String?,
        productArticle: data['product_article'] as String?,
        quantity: castToType<int>(data['quantity']),
      );

  static SparePartsStruct? maybeFromMap(dynamic data) => data is Map
      ? SparePartsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'product_article': _productArticle,
        'quantity': _quantity,
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
      }.withoutNulls;

  static SparePartsStruct fromSerializableMap(Map<String, dynamic> data) =>
      SparePartsStruct(
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
      );

  @override
  String toString() => 'SparePartsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is SparePartsStruct &&
        title == other.title &&
        productArticle == other.productArticle &&
        quantity == other.quantity;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, productArticle, quantity]);
}

SparePartsStruct createSparePartsStruct({
  String? title,
  String? productArticle,
  int? quantity,
}) =>
    SparePartsStruct(
      title: title,
      productArticle: productArticle,
      quantity: quantity,
    );
