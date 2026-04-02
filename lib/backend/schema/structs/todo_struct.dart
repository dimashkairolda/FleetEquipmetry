// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class TodoStruct extends BaseStruct {
  TodoStruct({
    String? title,
    int? quantity,
  })  : _title = title,
        _quantity = quantity;

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

  static TodoStruct fromMap(Map<String, dynamic> data) => TodoStruct(
        title: data['title'] as String?,
        quantity: castToType<int>(data['quantity']),
      );

  static TodoStruct? maybeFromMap(dynamic data) =>
      data is Map ? TodoStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'quantity': _quantity,
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
      }.withoutNulls;

  static TodoStruct fromSerializableMap(Map<String, dynamic> data) =>
      TodoStruct(
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
      );

  @override
  String toString() => 'TodoStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is TodoStruct &&
        title == other.title &&
        quantity == other.quantity;
  }

  @override
  int get hashCode => const ListEquality().hash([title, quantity]);
}

TodoStruct createTodoStruct({
  String? title,
  int? quantity,
}) =>
    TodoStruct(
      title: title,
      quantity: quantity,
    );
