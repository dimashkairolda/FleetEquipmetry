// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InventoryWriteOffForm extends StatefulWidget {
  const InventoryWriteOffForm({
    Key? key,
    this.width,
    this.height,
    required this.token,
    required this.workspaceId,
    required this.storehouseOrderId,
    required this.orderJson, // Полный JSON ордера (исходный)
    this.costCenterId,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String token;
  final String workspaceId;
  final String storehouseOrderId;
  final dynamic orderJson;
  final String? costCenterId;

  @override
  _InventoryWriteOffFormState createState() => _InventoryWriteOffFormState();
}

class _InventoryWriteOffFormState extends State<InventoryWriteOffForm> {
  // Поля формы
  DateTime _writeOffDate = DateTime.now();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();

  // Данные
  String? _selectedCostCenterId;
  List<WriteOffItemModel> _items = [];
  
  // Справочники
  List<dynamic> _uomList = [];
  List<dynamic> _warehouseList = [];
  List<dynamic> _costCentersList = [];

  bool _isLoading = true;
  bool _isSubmitting = false;

  // Храним исходный Map ордера для формирования PUT запроса
  Map<String, dynamic> _originalOrderMap = {};

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      await Future.wait([
        _fetchUoms(),
        _fetchWarehouses(),
        _fetchCostCenters(),
      ]);

      if (widget.orderJson != null) {
        if (widget.orderJson is String) {
          _originalOrderMap = json.decode(widget.orderJson);
        } else {
          _originalOrderMap = Map<String, dynamic>.from(widget.orderJson);
        }

        // --- Cost Center ---
        String? initialCcId;
        if (widget.costCenterId != null && widget.costCenterId!.isNotEmpty) {
          initialCcId = widget.costCenterId;
        } else if (_originalOrderMap['cost_center_id'] != null) {
          initialCcId = _originalOrderMap['cost_center_id'];
        }
        _selectedCostCenterId = initialCcId;

        // --- Парсинг товаров ---
        final itemsInStock = _originalOrderMap['items_in_stock'] as Map<String, dynamic>? ?? {};
        final itemsRequested = _originalOrderMap['items_requested'] as Map<String, dynamic>? ?? {};

        itemsInStock.forEach((key, value) {
          // Fallback логика для пустых полей (берем из requested если нет в stock)
          String pId = value['part_id'] ?? '';
          String pNumber = value['product_article'] ?? value['part_number'] ?? '';
          String uom = value['unit_of_measurement'] ?? '';
          
          if (pId.isEmpty || pNumber.isEmpty || uom.isEmpty) {
             if (itemsRequested.containsKey(key)) {
               final reqItem = itemsRequested[key];
               if (pId.isEmpty) pId = reqItem['part_id'] ?? reqItem['id'] ?? '';
               if (pNumber.isEmpty) pNumber = reqItem['product_article'] ?? reqItem['part_number'] ?? '';
               if (uom.isEmpty) uom = reqItem['unit_of_measurement'] ?? '';
             }
          }

          List<String> invIds = [];
          if (value['invoice_ids'] != null && value['invoice_ids'] is List) {
            invIds = List<String>.from(value['invoice_ids']);
          }

          // Dropdown Defaults
          String initialWarehouseId = value['warehouse_id'] ?? '';
          if (_warehouseList.isNotEmpty && initialWarehouseId.isNotEmpty) {
             final exists = _warehouseList.any((w) => w['id'] == initialWarehouseId);
             if (!exists) initialWarehouseId = ''; 
          }
          if (_uomList.isNotEmpty && uom.isNotEmpty) {
             final exists = _uomList.any((u) => u['title'] == uom);
             if (!exists) uom = '';
          }

          _items.add(WriteOffItemModel(
            originalKey: key, // Важно сохранить ключ для PUT запроса
            id: pId,
            partId: pId,
            title: value['title'] ?? key,
            partNumberCtrl: TextEditingController(text: pNumber),
            quantityCtrl: TextEditingController(text: value['quantity']?.toString() ?? '1'),
            maxQuantity: (value['quantity'] is num) ? value['quantity'].toInt() : 1,
            equipmentId: value['equipment_id'] ?? '',
            invoiceIds: invIds,
            selectedWarehouseId: initialWarehouseId.isEmpty ? null : initialWarehouseId,
            selectedUomTitle: uom.isEmpty ? null : uom,
          ));
        });
      }
    } catch (e) {
      print('Error parsing data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- API GET Helpers ---
  Map<String, String> get _headers => {
    'Authorization': widget.token,
    'Workspace': widget.workspaceId,
    'Content-Type': 'application/json',
  };

  Future<void> _fetchUoms() async {
    try {
      final res = await http.get(Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/unit-of-measurement?workspace_id=${widget.workspaceId}'), headers: _headers);
      if (res.statusCode == 200) setState(() => _uomList = json.decode(res.body) as List);
    } catch (_) {}
  }
  Future<void> _fetchWarehouses() async {
    try {
      final res = await http.get(Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/warehouse'), headers: _headers);
      if (res.statusCode == 200) setState(() => _warehouseList = json.decode(res.body) as List);
    } catch (_) {}
  }
  Future<void> _fetchCostCenters() async {
    try {
      final res = await http.get(Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/storehouse/cost-center?workspace_id=${widget.workspaceId}'), headers: _headers);
      if (res.statusCode == 200) setState(() => _costCentersList = json.decode(res.body) as List);
    } catch (_) {}
  }

  // --- MAIN TRANSACTION LOGIC ---

  Future<void> _processTransaction() async {
    if (_items.isEmpty) return;
    
    // Валидация
    if (_selectedCostCenterId == null) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Выберите Центр Затрат')));
       return;
    }
    for (var item in _items) {
      if (item.selectedWarehouseId == null) {
         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Выберите склад для "${item.title}"')));
         return;
      }
    }

    setState(() => _isSubmitting = true);

    try {
      // 1. Выполняем POST запрос (Списание)
      bool postSuccess = await _executePostWriteOff();
      
      if (!postSuccess) {
        throw Exception("Ошибка при списании (POST)");
      }

      // 2. Выполняем PUT запрос (Обновление ордера)
      bool putSuccess = await _executePutOrderUpdate();

      if (!putSuccess) {
         throw Exception("Списание прошло, но ошибка обновления ордера (PUT)");
      }

      // 3. Если всё ОК
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Успешно списано и обновлено!'), backgroundColor: Colors.green),
      );
      
      // Возвращаемся назад
      if (mounted) {
        Navigator.pop(context);
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  // --- STEP 1: POST REQUEST ---
  Future<bool> _executePostWriteOff() async {
    try {
      List<Map<String, dynamic>> partsPayload = _items.map((item) {
        int qty = int.tryParse(item.quantityCtrl.text) ?? 0;
        return {
          "id": item.partId,
          "part_id": item.partId,
          "name": item.title,
          "part_number": item.partNumberCtrl.text,
          "quantity": qty,
          "unit_of_measurement": item.selectedUomTitle ?? "",
          "note": null,
          "warehouse_id": item.selectedWarehouseId,
          "equipment_id": item.equipmentId,
          "workspace_id": widget.workspaceId,
          "invoice_ids": item.invoiceIds,
        };
      }).toList();

      final body = {
        "workspace_id": widget.workspaceId,
        "comment": _commentController.text.isEmpty ? null : _commentController.text,
        "reason": _reasonController.text.isEmpty ? null : _reasonController.text,
        "storehouse_order": widget.storehouseOrderId,
        "date": DateFormat('yyyy-MM-dd').format(_writeOffDate),
        "cost_center_id": _selectedCostCenterId,
        "part_nomenclatures": partsPayload
      };

      print("POST Body: ${json.encode(body)}");

      final response = await http.post(
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/inventory/write-off/storehouse-order'),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        print("POST Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("POST Exception: $e");
      return false;
    }
  }

  // --- STEP 2: PUT REQUEST ---
  Future<bool> _executePutOrderUpdate() async {
    try {
      // Клонируем исходный Map, чтобы модифицировать его
      Map<String, dynamic> updatedOrder = Map<String, dynamic>.from(_originalOrderMap);
      
      // Обновляем статус
      updatedOrder['status'] = "ISSUED";

      // Обновляем items_in_stock на основе введенных пользователем данных
      // Мы используем originalKey, чтобы найти правильный объект в Map
      if (updatedOrder['items_in_stock'] is Map) {
        Map<String, dynamic> stockItems = Map<String, dynamic>.from(updatedOrder['items_in_stock']);
        
        for (var item in _items) {
          if (stockItems.containsKey(item.originalKey)) {
            var itemData = Map<String, dynamic>.from(stockItems[item.originalKey]);
            
            // Обновляем поля, делая вид что товар списан
            int qty = int.tryParse(item.quantityCtrl.text) ?? 0;
            itemData['is_written_off'] = true;
            itemData['written_off_quantity'] = qty;
            itemData['status'] = "ISSUED";
            
            // Сохраняем обратно в Map
            stockItems[item.originalKey] = itemData;
          }
        }
        updatedOrder['items_in_stock'] = stockItems;
      }

      print("PUT Body: ${json.encode(updatedOrder)}");

      final response = await http.put(
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/storehouse/orders/${widget.storehouseOrderId}'),
        headers: _headers,
        body: json.encode(updatedOrder),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
         print("PUT Error: ${response.body}");
        return false;
      }
    } catch (e) {
      print("PUT Exception: $e");
      return false;
    }
  }

  // --- UI PART ---

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _writeOffDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) setState(() => _writeOffDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());

    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader("Списание"),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: FlutterFlowTheme.of(context)
                                                        .primaryBackground, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Дата списания"),
                        InkWell(
                          onTap: _pickDate,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                            decoration: BoxDecoration(border: Border.all(color: FlutterFlowTheme.of(context)
                                                        .secondaryText), borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(DateFormat('dd.MM.yyyy').format(_writeOffDate)),
                                const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildLabel("Код затрат"),
                        DropdownButtonFormField<String>(
                          value: _selectedCostCenterId,
                          isExpanded: true,
                          decoration: _inputDecoration("Выберите центр затрат"),
                          items: _costCentersList.map((cc) {
                            return DropdownMenuItem<String>(
                              value: cc['id'],
                              child: Text(cc['title'] ?? 'Без названия', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)),
                            );
                          }).toList(),
                          onChanged: (val) => setState(() => _selectedCostCenterId = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader("Список ТМЦ"),
                  const SizedBox(height: 12),
                  if (_items.isEmpty) const Center(child: Text("Нет позиций")),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (context, index) => _buildItemCard(_items[index]),
                  ),
                  const SizedBox(height: 24),
                  _buildSectionHeader("Дополнительно"),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: FlutterFlowTheme.of(context)
                                                        .primaryBackground, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Причина"),
                        TextFormField(controller: _reasonController, decoration: _inputDecoration("Введите причину")),
                        const SizedBox(height: 16),
                        _buildLabel("Комментарии"),
                        TextFormField(controller: _commentController, decoration: _inputDecoration("Введите комментарий"), maxLines: 3),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: FlutterFlowTheme.of(context)
                                                        .primaryBackground, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -4))]),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      side: const BorderSide(color: Colors.grey),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text("Отмена", style: TextStyle(color: FlutterFlowTheme.of(context)
                                                        .primaryText)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    // ИЗМЕНЕНИЕ: Вызов новой функции
                    onPressed: _isSubmitting ? null : _processTransaction,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF4B39EF),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: _isSubmitting
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                        : Text("Списать", style: TextStyle(color: FlutterFlowTheme.of(context)
                                                        .primaryText, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) => Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context)
                                                        .primaryText));
  Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 6.0), child: Text(text, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: FlutterFlowTheme.of(context)
                                                        .secondaryText)));
  
  Widget _buildItemCard(WriteOffItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: FlutterFlowTheme.of(context)
                                                        .primaryBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: FlutterFlowTheme.of(context)
                                                        .alternate)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          TextFormField(
            controller: item.partNumberCtrl,
            style: const TextStyle(fontSize: 14),
            decoration: InputDecoration(labelText: "Артикул", contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: item.selectedWarehouseId,
            isExpanded: true,
            decoration: InputDecoration(labelText: "Склад", contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
            items: _warehouseList.map((w) => DropdownMenuItem<String>(value: w['id'], child: Text(w['name'] ?? 'Без имени', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)))).toList(),
            onChanged: (val) => setState(() => item.selectedWarehouseId = val),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Кол-во (макс: ${item.maxQuantity})", style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                  const SizedBox(height: 4),
                  SizedBox(height: 48, child: TextFormField(controller: item.quantityCtrl, keyboardType: TextInputType.number, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))))),
                ]),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 3,
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Ед. изм.", style: TextStyle(fontSize: 12, color: FlutterFlowTheme.of(context)
                                                        .secondaryText)),
                  const SizedBox(height: 4),
                  SizedBox(height: 48, child: DropdownButtonFormField<String>(value: item.selectedUomTitle, isExpanded: true, decoration: InputDecoration(contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))), hint: const Text("Ед.", style: TextStyle(fontSize: 13)), items: _uomList.map((u) => DropdownMenuItem<String>(value: u['title'], child: Text(u['title'] ?? '', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14)))).toList(), onChanged: (val) => setState(() => item.selectedUomTitle = val))),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) => InputDecoration(hintText: hint, contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14), border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide(color: Colors.grey.shade300)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFF4B39EF), width: 2)));
}

class WriteOffItemModel {
  String originalKey; // Ключ в JSON Map (для PUT запроса)
  String id;
  String partId;
  String title;
  int maxQuantity;
  String equipmentId;
  List<String> invoiceIds;
  TextEditingController quantityCtrl;
  TextEditingController partNumberCtrl;
  String? selectedWarehouseId;
  String? selectedUomTitle;

  WriteOffItemModel({
    required this.originalKey,
    required this.id,
    required this.partId,
    required this.title,
    required this.partNumberCtrl,
    required this.maxQuantity,
    required this.quantityCtrl,
    this.equipmentId = '',
    this.invoiceIds = const [],
    this.selectedWarehouseId,
    this.selectedUomTitle,
  });
}