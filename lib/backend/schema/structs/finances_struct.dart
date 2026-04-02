// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FinancesStruct extends BaseStruct {
  FinancesStruct({
    String? amortizationType,
    String? initialPrice,
    String? remainderPrice,
  })  : _amortizationType = amortizationType,
        _initialPrice = initialPrice,
        _remainderPrice = remainderPrice;

  // "amortization_type" field.
  String? _amortizationType;
  String get amortizationType => _amortizationType ?? '';
  set amortizationType(String? val) => _amortizationType = val;

  bool hasAmortizationType() => _amortizationType != null;

  // "initial_price" field.
  String? _initialPrice;
  String get initialPrice => _initialPrice ?? '';
  set initialPrice(String? val) => _initialPrice = val;

  bool hasInitialPrice() => _initialPrice != null;

  // "remainder_price" field.
  String? _remainderPrice;
  String get remainderPrice => _remainderPrice ?? '';
  set remainderPrice(String? val) => _remainderPrice = val;

  bool hasRemainderPrice() => _remainderPrice != null;

  static FinancesStruct fromMap(Map<String, dynamic> data) => FinancesStruct(
        amortizationType: data['amortization_type'] as String?,
        initialPrice: data['initial_price'] as String?,
        remainderPrice: data['remainder_price'] as String?,
      );

  static FinancesStruct? maybeFromMap(dynamic data) =>
      data is Map ? FinancesStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'amortization_type': _amortizationType,
        'initial_price': _initialPrice,
        'remainder_price': _remainderPrice,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'amortization_type': serializeParam(
          _amortizationType,
          ParamType.String,
        ),
        'initial_price': serializeParam(
          _initialPrice,
          ParamType.String,
        ),
        'remainder_price': serializeParam(
          _remainderPrice,
          ParamType.String,
        ),
      }.withoutNulls;

  static FinancesStruct fromSerializableMap(Map<String, dynamic> data) =>
      FinancesStruct(
        amortizationType: deserializeParam(
          data['amortization_type'],
          ParamType.String,
          false,
        ),
        initialPrice: deserializeParam(
          data['initial_price'],
          ParamType.String,
          false,
        ),
        remainderPrice: deserializeParam(
          data['remainder_price'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'FinancesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is FinancesStruct &&
        amortizationType == other.amortizationType &&
        initialPrice == other.initialPrice &&
        remainderPrice == other.remainderPrice;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([amortizationType, initialPrice, remainderPrice]);
}

FinancesStruct createFinancesStruct({
  String? amortizationType,
  String? initialPrice,
  String? remainderPrice,
}) =>
    FinancesStruct(
      amortizationType: amortizationType,
      initialPrice: initialPrice,
      remainderPrice: remainderPrice,
    );
