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

import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ContractorOfferWidget extends StatefulWidget {
  const ContractorOfferWidget({
    super.key,
    this.width,
    this.height,
    required this.procurementData,
    required this.authToken,
  });

  final double? width;
  final double? height;
  final dynamic procurementData;
  final String authToken;

  @override
  State<ContractorOfferWidget> createState() => _ContractorOfferWidgetState();
}

class _ContractorOfferWidgetState extends State<ContractorOfferWidget> {
  // Контроллеры для общей доставки
  final TextEditingController _deliveryPriceController =
      TextEditingController();
  final TextEditingController _deliveryTimeController =
      TextEditingController();
  String _deliveryMethod = "COURIER";
  bool _isPriceGuaranteed = false;

  // Данные для каждой запчасти
  Map<String, TextEditingController> _priceControllers = {};
  Map<String, String> _characteristics = {};

  @override
  void initState() {
    super.initState();
    // Инициализируем контроллеры для каждой запчасти из пришедшего JSON
    List items = widget.procurementData['inventory_items'] ?? [];
    for (var item in items) {
      String id = item['id'];
      _priceControllers[id] = TextEditingController(text: "");
      _characteristics[id] = "Оригинал";
    }
  }

  Future<void> _sendOffer() async {
    if (!_isPriceGuaranteed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Подтвердите, что цены не изменятся')),
      );
      return;
    }

    String procurementId = widget.procurementData['id'];
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/procurement/$procurementId/kp/send');

    // Формируем inventory_item_offers
    List items = widget.procurementData['inventory_items'] ?? [];
    List<Map<String, dynamic>> itemOffers = items.map((item) {
      String id = item['id'];
      return {
        "id": id,
        "price": int.tryParse(_priceControllers[id]!.text) ?? 0,
        "characteristic": _characteristics[id]
      };
    }).toList();

    // Формируем финальный body
    final body = {
      "offer": {
        "delivery_method": _deliveryMethod,
        "price": int.tryParse(_deliveryPriceController.text) ?? 0,
        "delivery_time": _deliveryTimeController.text
      },
      "inventory_item_offers": itemOffers
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': widget.authToken,
          'workspace': FFAppState().workspace,
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('КП успешно отправлено!'),
              backgroundColor: Colors.green),
        );
        context.pop(); // Возврат назад после успеха
      } else {
        throw Exception('Ошибка: ${response.body}');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Ошибка отправки: $e'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List items = widget.procurementData['inventory_items'] ?? [];

    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Заявка #${widget.procurementData['short_id']}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            // Список запчастей
            ...items.map((item) {
              String id = item['id'];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text("Артикул: ${item['product_article']}",
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12)),
                      const Divider(),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _priceControllers[id],
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  labelText: 'Цена за ед.', suffixText: '₸'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          DropdownButton<String>(
                            value: _characteristics[id],
                            items: ["Оригинал", "Аналог"].map((String value) {
                              return DropdownMenuItem<String>(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (val) =>
                                setState(() => _characteristics[id] = val!),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),

            const SizedBox(height: 16),
            const Text("Данные по доставке",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    TextField(
                      controller: _deliveryPriceController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Стоимость доставки', suffixText: '₸'),
                    ),
                    TextField(
                      controller: _deliveryTimeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          labelText: 'Срок доставки (дней)'),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
            CheckboxListTile(
              value: _isPriceGuaranteed,
              onChanged: (val) => setState(() => _isPriceGuaranteed = val!),
              title: const Text(
                  "Я подтверждаю, что цены на запчасти не изменятся в течение срока действия предложения",
                  style: TextStyle(fontSize: 12)),
              controlAffinity: ListTileControlAffinity.leading,
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _sendOffer,
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4B39EF)),
                child: const Text("ОТПРАВИТЬ ПРЕДЛОЖЕНИЕ",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}