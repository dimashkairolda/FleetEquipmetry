// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class MobileCompareOffers extends StatefulWidget {
  const MobileCompareOffers({
    super.key,
    this.width,
    this.height,
    required this.procurementData,
    this.onAddToCart,
  });

  final double? width;
  final double? height;
  final dynamic procurementData;
  final Future<dynamic> Function(dynamic selectedOffers)? onAddToCart;

  @override
  State<MobileCompareOffers> createState() => _MobileCompareOffersState();
}

class _MobileCompareOffersState extends State<MobileCompareOffers> {
  // Карта выбора: { inventory_item_id: offer_id }
  Map<String, String?> _selectedOffers = {};
  final currencyFormat =
      NumberFormat.currency(locale: 'ru_KZ', symbol: '₸', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    // Инициализация пустых выборов для каждого товара
    List items = widget.procurementData['inventory_items'] ?? [];
    for (var item in items) {
      _selectedOffers[item['id'].toString()] = null;
    }
  }

  // Расчет итогов (логика из Vue)
  Map<String, double> _calculateTotals() {
    double itemsTotal = 0;
    Set<String> uniqueSuppliers = {};

    _selectedOffers.forEach((itemId, offerId) {
      if (offerId != null) {
        // Находим товар и оффер для расчета
        var item = (widget.procurementData['inventory_items'] as List)
            .firstWhere((i) => i['id'].toString() == itemId);
        var offer = (item['offers'] as List)
            .firstWhere((o) => o['id'].toString() == offerId);

        double price = (offer['price'] ?? 0).toDouble();
        double qty = (item['quantity'] ?? 0).toDouble();
        itemsTotal += price * qty;

        uniqueSuppliers.add(offer['counterparty']['id'].toString());
      }
    });

    // Считаем доставку только для выбранных поставщиков
    double deliveryTotal = 0;
    List allOffers = widget.procurementData['offers'] ?? [];
    for (var supplierId in uniqueSuppliers) {
      var deliveryOffer = allOffers.firstWhere(
        (o) => o['counterparty']['id'].toString() == supplierId,
        orElse: () => null,
      );
      if (deliveryOffer != null) {
        deliveryTotal += (deliveryOffer['price'] ?? 0).toDouble();
      }
    }

    return {
      "items": itemsTotal,
      "delivery": deliveryTotal,
      "total": itemsTotal + deliveryTotal
    };
  }

  @override
  Widget build(BuildContext context) {
    final totals = _calculateTotals();
    final selectedCount = _selectedOffers.values.where((v) => v != null).length;
    final totalItems =
        (widget.procurementData['inventory_items'] as List).length;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            elevation: 0,
            title: Text("RFQ${widget.procurementData['short_id']}",
                style: TextStyle(
                    color: FlutterFlowTheme.of(context).primaryText,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            bottom: const TabBar(
              labelColor: Color(0xFF3466E7),
              unselectedLabelColor: Colors.grey,
              indicatorColor: Color(0xFF3466E7),
              tabs: [
                Tab(text: "По товарам"),
                Tab(text: "По поставщикам"),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                _buildByItemsList(),
                _buildBySuppliersList(),
              ],
            ),
            // Фиксированный футер с итогами (аналог sticky sidebar)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomSummary(totals, selectedCount, totalItems),
            ),
          ],
        ),
      ),
    );
  }

  // Режим просмотра "По товарам"
  Widget _buildByItemsList() {
    List items = widget.procurementData['inventory_items'] ?? [];
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final String itemId = item['id'].toString();
        List offers = item['offers'] ?? [];

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                leading:
                    const Icon(Icons.inventory_2, color: Color(0xFF3466E7)),
                title: Text(item['title'],
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                    "Арт: ${item['product_article'] ?? '-'} • ${item['quantity']} шт"),
              ),
              const Divider(height: 1),
              ...offers.map((offer) {
                bool isSelected =
                    _selectedOffers[itemId] == offer['id'].toString();
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedOffers[itemId] =
                          isSelected ? null : offer['id'].toString();
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? FlutterFlowTheme.of(context).accent1
                          : Colors.transparent,
                      border: Border(
                          bottom: BorderSide(color: Colors.grey.shade100)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                            isSelected
                                ? Icons.check_box
                                : Icons.check_box_outline_blank,
                            color: isSelected
                                ? const Color(0xFF3466E7)
                                : Colors.grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(offer['counterparty']['title'],
                                  style: const TextStyle(fontSize: 13)),
                              Text(offer['characteristic'],
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Text(currencyFormat.format(offer['price']),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3466E7))),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  // Режим просмотра "По поставщикам" (Группировка)
  Widget _buildBySuppliersList() {
    List suppliers = widget.procurementData['offers'] ?? [];
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
      itemCount: suppliers.length,
      itemBuilder: (context, index) {
        final supplierOffer = suppliers[index];
        final String supplierId =
            supplierOffer['counterparty']['id'].toString();

        // Фильтруем товары, которые предлагает этот поставщик
        List items =
            (widget.procurementData['inventory_items'] as List).where((item) {
          return (item['offers'] as List)
              .any((o) => o['counterparty']['id'].toString() == supplierId);
        }).toList();

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ExpansionTile(
            leading: const Icon(Icons.business, color: Colors.orange),
            title: Text(supplierOffer['counterparty']['title']),
            subtitle: Text(
                "Доставка: ${supplierOffer['price']} ₸ • ${supplierOffer['delivery_time']} дн."),
            children: items.map((item) {
              var offer = (item['offers'] as List).firstWhere(
                  (o) => o['counterparty']['id'].toString() == supplierId);
              bool isSelected = _selectedOffers[item['id'].toString()] ==
                  offer['id'].toString();

              return ListTile(
                title:
                    Text(item['title'], style: const TextStyle(fontSize: 13)),
                trailing: Text("${offer['price']} ₸"),
                leading: Checkbox(
                  value: isSelected,
                  onChanged: (val) {
                    setState(() {
                      _selectedOffers[item['id'].toString()] =
                          val! ? offer['id'].toString() : null;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildBottomSummary(
      Map<String, double> totals, int selected, int total) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, -2))
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Выбрано: $selected из $total",
                  style: const TextStyle(color: Colors.grey)),
              Text("Итого: ${currencyFormat.format(totals['total'])}",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3466E7))),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: selected > 0
                  ? () {
                      // 1. Трансформируем Map в List<Map<String, String>>
                      final formattedOffers = _selectedOffers.entries
                          .where((entry) => entry.value != null)
                          .map((entry) => {
                                "inventory_item_id": entry.key,
                                "offer_id": entry.value!,
                              })
                          .toList();

                      // 2. Отправляем отформатированный список
                      widget.onAddToCart?.call(formattedOffers);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3466E7),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: const Text("В КОРЗИНУ",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!