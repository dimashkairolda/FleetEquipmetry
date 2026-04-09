// Проверка, можно ли открыть экран сравнения КП: хотя бы у одного предложения
// должны быть положительные цены по всем позициям заявки.

Map<String, dynamic> _procurementRoot(dynamic jsonBody) {
  if (jsonBody is! Map) return {};
  final m = Map<String, dynamic>.from(jsonBody);
  final data = m['data'];
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  return m;
}

double? _positivePrice(dynamic p) {
  if (p == null) return null;
  final v = p is num ? p.toDouble() : double.tryParse(p.toString());
  if (v == null || v <= 0) return null;
  return v;
}

/// У [deliveryOffer] есть ненулевая цена по каждой строке [inventory_items]
/// (через item.offers по поставщику и/или через inventory_item_offers).
bool procurementOfferHasAllItemPrices(
  Map<String, dynamic> root,
  dynamic deliveryOffer,
) {
  if (deliveryOffer is! Map) return false;
  final offer = Map<String, dynamic>.from(deliveryOffer);
  final rawItems = root['inventory_items'];
  if (rawItems is! List || rawItems.isEmpty) return false;

  final supplierId = offer['counterparty']?['id']?.toString();
  final deliveryLines = offer['inventory_item_offers'] as List? ?? [];

  for (final raw in rawItems) {
    if (raw is! Map) return false;
    final item = Map<String, dynamic>.from(raw);
    final itemId = item['id']?.toString() ?? '';
    if (itemId.isEmpty) return false;

    var ok = false;

    final itemOffers = item['offers'] as List? ?? [];
    for (final o in itemOffers) {
      if (o is! Map) continue;
      if (o['counterparty']?['id']?.toString() == supplierId &&
          o['status'] != 'REJECTED') {
        if (_positivePrice(o['price']) != null) {
          ok = true;
          break;
        }
      }
    }

    if (!ok && deliveryLines.isNotEmpty) {
      for (final line in deliveryLines) {
        if (line is! Map) continue;
        if (line['id']?.toString() == itemId) {
          if (_positivePrice(line['price']) != null) {
            ok = true;
          }
          break;
        }
      }
    }

    if (!ok) return false;
  }
  return true;
}

/// true, если есть хотя бы одно не отклонённое КП с ценами по всем позициям.
bool procurementHasComparableOffers(dynamic jsonBody) {
  final root = _procurementRoot(jsonBody);
  final offers = root['offers'];
  if (offers is! List || offers.isEmpty) return false;

  for (final o in offers) {
    if (o is! Map) continue;
    if (o['status'] == 'REJECTED') continue;
    if (procurementOfferHasAllItemPrices(root, o)) return true;
  }
  return false;
}
