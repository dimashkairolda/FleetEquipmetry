// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TodoCTOStruct extends BaseStruct {
  TodoCTOStruct({
    String? title,
    int? quantity,
    int? price,
    int? sum,
    String? comment,
  })  : _title = title,
        _quantity = quantity,
        _price = price,
        _sum = sum,
        _comment = comment;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "quantity" field.
  int? _quantity;
  int get quantity => _quantity ?? 0;
  set quantity(int? val) => _quantity = val;

  void incrementQuantity(int amount) => quantity = quantity + amount;

  bool hasQuantity() => _quantity != null;

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

  static TodoCTOStruct fromMap(Map<String, dynamic> data) => TodoCTOStruct(
        title: data['title'] as String?,
        quantity: castToType<int>(data['quantity']),
        price: castToType<int>(data['price']),
        sum: castToType<int>(data['sum']),
        comment: data['comment'] as String?,
      );

  static TodoCTOStruct? maybeFromMap(dynamic data) =>
      data is Map ? TodoCTOStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'quantity': _quantity,
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
        'quantity': serializeParam(
          _quantity,
          ParamType.int,
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

  static TodoCTOStruct fromSerializableMap(Map<String, dynamic> data) =>
      TodoCTOStruct(
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
  String toString() => 'TodoCTOStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TodoCTOStruct &&
        title == other.title &&
        quantity == other.quantity &&
        price == other.price &&
        sum == other.sum &&
        comment == other.comment;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([title, quantity, price, sum, comment]);
}

TodoCTOStruct createTodoCTOStruct({
  String? title,
  int? quantity,
  int? price,
  int? sum,
  String? comment,
}) =>
    TodoCTOStruct(
      title: title,
      quantity: quantity,
      price: price,
      sum: sum,
      comment: comment,
    );
