// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ApprovalInvoicesStruct extends BaseStruct {
  ApprovalInvoicesStruct({
    String? invoiceId,
    String? name,
    String? accountantIds,
    String? buyerId,
    String? storekeeperId,
    bool? sendToBuyer,
    String? powerOfAttorney,
    String? paymentOrder,
  })  : _invoiceId = invoiceId,
        _name = name,
        _accountantIds = accountantIds,
        _buyerId = buyerId,
        _storekeeperId = storekeeperId,
        _sendToBuyer = sendToBuyer,
        _powerOfAttorney = powerOfAttorney,
        _paymentOrder = paymentOrder;

  // "invoice_id" field.
  String? _invoiceId;
  String get invoiceId => _invoiceId ?? '';
  set invoiceId(String? val) => _invoiceId = val;

  bool hasInvoiceId() => _invoiceId != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "accountant_ids" field.
  String? _accountantIds;
  String get accountantIds => _accountantIds ?? '';
  set accountantIds(String? val) => _accountantIds = val;

  bool hasAccountantIds() => _accountantIds != null;

  // "buyer_id" field.
  String? _buyerId;
  String get buyerId => _buyerId ?? '';
  set buyerId(String? val) => _buyerId = val;

  bool hasBuyerId() => _buyerId != null;

  // "storekeeper_id" field.
  String? _storekeeperId;
  String get storekeeperId => _storekeeperId ?? '';
  set storekeeperId(String? val) => _storekeeperId = val;

  bool hasStorekeeperId() => _storekeeperId != null;

  // "send_to_buyer" field.
  bool? _sendToBuyer;
  bool get sendToBuyer => _sendToBuyer ?? false;
  set sendToBuyer(bool? val) => _sendToBuyer = val;

  bool hasSendToBuyer() => _sendToBuyer != null;

  // "power_of_attorney" field.
  String? _powerOfAttorney;
  String get powerOfAttorney => _powerOfAttorney ?? '';
  set powerOfAttorney(String? val) => _powerOfAttorney = val;

  bool hasPowerOfAttorney() => _powerOfAttorney != null;

  // "payment_order" field.
  String? _paymentOrder;
  String get paymentOrder => _paymentOrder ?? '';
  set paymentOrder(String? val) => _paymentOrder = val;

  bool hasPaymentOrder() => _paymentOrder != null;

  static ApprovalInvoicesStruct fromMap(Map<String, dynamic> data) =>
      ApprovalInvoicesStruct(
        invoiceId: data['invoice_id'] as String?,
        name: data['name'] as String?,
        accountantIds: data['accountant_ids'] as String?,
        buyerId: data['buyer_id'] as String?,
        storekeeperId: data['storekeeper_id'] as String?,
        sendToBuyer: data['send_to_buyer'] as bool?,
        powerOfAttorney: data['power_of_attorney'] as String?,
        paymentOrder: data['payment_order'] as String?,
      );

  static ApprovalInvoicesStruct? maybeFromMap(dynamic data) => data is Map
      ? ApprovalInvoicesStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'invoice_id': _invoiceId,
        'name': _name,
        'accountant_ids': _accountantIds,
        'buyer_id': _buyerId,
        'storekeeper_id': _storekeeperId,
        'send_to_buyer': _sendToBuyer,
        'power_of_attorney': _powerOfAttorney,
        'payment_order': _paymentOrder,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'invoice_id': serializeParam(
          _invoiceId,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'accountant_ids': serializeParam(
          _accountantIds,
          ParamType.String,
        ),
        'buyer_id': serializeParam(
          _buyerId,
          ParamType.String,
        ),
        'storekeeper_id': serializeParam(
          _storekeeperId,
          ParamType.String,
        ),
        'send_to_buyer': serializeParam(
          _sendToBuyer,
          ParamType.bool,
        ),
        'power_of_attorney': serializeParam(
          _powerOfAttorney,
          ParamType.String,
        ),
        'payment_order': serializeParam(
          _paymentOrder,
          ParamType.String,
        ),
      }.withoutNulls;

  static ApprovalInvoicesStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ApprovalInvoicesStruct(
        invoiceId: deserializeParam(
          data['invoice_id'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        accountantIds: deserializeParam(
          data['accountant_ids'],
          ParamType.String,
          false,
        ),
        buyerId: deserializeParam(
          data['buyer_id'],
          ParamType.String,
          false,
        ),
        storekeeperId: deserializeParam(
          data['storekeeper_id'],
          ParamType.String,
          false,
        ),
        sendToBuyer: deserializeParam(
          data['send_to_buyer'],
          ParamType.bool,
          false,
        ),
        powerOfAttorney: deserializeParam(
          data['power_of_attorney'],
          ParamType.String,
          false,
        ),
        paymentOrder: deserializeParam(
          data['payment_order'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ApprovalInvoicesStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ApprovalInvoicesStruct &&
        invoiceId == other.invoiceId &&
        name == other.name &&
        accountantIds == other.accountantIds &&
        buyerId == other.buyerId &&
        storekeeperId == other.storekeeperId &&
        sendToBuyer == other.sendToBuyer &&
        powerOfAttorney == other.powerOfAttorney &&
        paymentOrder == other.paymentOrder;
  }

  @override
  int get hashCode => const ListEquality().hash([
        invoiceId,
        name,
        accountantIds,
        buyerId,
        storekeeperId,
        sendToBuyer,
        powerOfAttorney,
        paymentOrder
      ]);
}

ApprovalInvoicesStruct createApprovalInvoicesStruct({
  String? invoiceId,
  String? name,
  String? accountantIds,
  String? buyerId,
  String? storekeeperId,
  bool? sendToBuyer,
  String? powerOfAttorney,
  String? paymentOrder,
}) =>
    ApprovalInvoicesStruct(
      invoiceId: invoiceId,
      name: name,
      accountantIds: accountantIds,
      buyerId: buyerId,
      storekeeperId: storekeeperId,
      sendToBuyer: sendToBuyer,
      powerOfAttorney: powerOfAttorney,
      paymentOrder: paymentOrder,
    );
