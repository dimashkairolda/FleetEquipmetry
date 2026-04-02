// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class InventoryReceiveForm extends StatefulWidget {
  const InventoryReceiveForm({
    Key? key,
    this.width,
    this.height,
    required this.token,
    required this.workspaceId,
    required this.itemsData,
    required this.storehouseOrderId,
    required this.invoicesData, // Новый параметр
  }) : super(key: key);

  final double? width;
  final double? height;
  final String token;
  final String workspaceId;
  final dynamic itemsData;
  final String storehouseOrderId;
  final dynamic invoicesData; // Входящий JSON счетов

  @override
  _InventoryReceiveFormState createState() => _InventoryReceiveFormState();
}

class _InventoryReceiveFormState extends State<InventoryReceiveForm> {
  final _formKey = GlobalKey<FormState>();

  // Списки данных для Dropdown
  List<dynamic> _providers = [];
  List<dynamic> _warehouses = [];
  List<dynamic> _companies = [];

  // Выбранные значения
  String? _selectedCompanyId;
  String? _selectedProviderId;
  String? _selectedWarehouseId;

  // Поля формы шапки
  DateTime _deliveryDate = DateTime.now();
  DateTime _invoiceDate = DateTime.now(); // Сюда подставится created_at
  final TextEditingController _invoiceNumberController =
      TextEditingController(); // Сюда подставится short_id
  final TextEditingController _commentController = TextEditingController();

  // Список товаров
  List<ReceiveItemModel> _items = [];
  bool _isLoading = true;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    try {
      // 1. Парсинг товаров
      _parseItems();

      // 2. Парсинг счета (Заполняем номер и дату)
      _parseInvoiceData();

      // 3. Загрузка справочников
      await Future.wait([
        _fetchProviders(),
        _fetchWarehouses(),
        _fetchCompanies(),
      ]);
    } catch (e) {
      print('Error init data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // --- ЛОГИКА АВТОЗАПОЛНЕНИЯ СЧЕТА ---
  void _parseInvoiceData() {
    try {
      if (widget.invoicesData != null) {
        List<dynamic> invoicesList;
        // Проверка: строка это или уже JSON объект
        if (widget.invoicesData is String) {
          invoicesList = json.decode(widget.invoicesData);
        } else if (widget.invoicesData is List) {
          invoicesList = widget.invoicesData;
        } else {
          // Если пришел одиночный объект, оборачиваем в лист
          invoicesList = [widget.invoicesData];
        }

        // Ищем первый счет со статусом 'approved'
        final approvedInvoice = invoicesList.firstWhere(
          (item) => item['status'] == 'approved',
          orElse: () => null,
        );

        if (approvedInvoice != null) {
          // Заполняем номер счета (short_id)
          if (approvedInvoice['short_id'] != null) {
            _invoiceNumberController.text =
                approvedInvoice['short_id'].toString();
          }

          // Заполняем дату счета (created_at)
          if (approvedInvoice['created_at'] != null) {
            // Формат даты в JSON: "2025-12-04T14:45:15.785Z"
            // DateTime.parse отлично справляется с ISO 8601
            _invoiceDate = DateTime.parse(approvedInvoice['created_at']);
          }
        }
      }
    } catch (e) {
      print('Error parsing invoice data: $e');
    }
  }

  void _parseItems() {
    if (widget.itemsData != null) {
      Map<String, dynamic> map;
      if (widget.itemsData is String) {
        map = json.decode(widget.itemsData);
      } else {
        map = widget.itemsData as Map<String, dynamic>;
      }

      map.forEach((key, value) {
        _items.add(ReceiveItemModel(
          lineId: key,
          title: value['title'] ?? value['defect_name'] ?? 'Деталь',
          equipmentName: value['equipment_name'] ?? '',
          equipmentId: value['equipment_id'],
          defectId: value['defect_id'],
          quantityCtrl:
              TextEditingController(text: value['quantity']?.toString() ?? '1'),
          priceCtrl:
              TextEditingController(text: value['price']?.toString() ?? '0'),
          partNumberCtrl:
              TextEditingController(text: value['product_article'] ?? ''),
          nomNumberCtrl:
              TextEditingController(text: value['nomenclature_number'] ?? ''),
          unitCtrl:
              TextEditingController(text: value['unit_of_measurement'] ?? ''),
        ));
      });
    }
  }

  // --- API GET REQUESTS ---
  Map<String, String> get _headers => {
        'Authorization': widget.token,
        'Workspace': widget.workspaceId,
        'Content-Type': 'application/json',
      };

  Future<void> _fetchProviders() async {
    final uri = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/provider?workspace_id=${widget.workspaceId}');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      setState(() => _providers = json.decode(res.body) as List);
    }
  }

  Future<void> _fetchWarehouses() async {
    final uri =
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/warehouse');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      setState(() => _warehouses = json.decode(res.body) as List);
    }
  }

  Future<void> _fetchCompanies() async {
    final uri = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/companies?workspace_id=${widget.workspaceId}');
    final res = await http.get(uri, headers: _headers);
    if (res.statusCode == 200) {
      setState(() => _companies = json.decode(res.body) as List);
    }
  }

  // --- SUBMIT LOGIC ---
  Future<void> _submit() async {
    if (!_validate()) return;

    setState(() => _isSubmitting = true);

    try {
      final providerObj =
          _providers.firstWhere((e) => e['id'] == _selectedProviderId);
      final warehouseObj =
          _warehouses.firstWhere((e) => e['id'] == _selectedWarehouseId);

      List<Map<String, dynamic>> partsPayload = _items.map((item) {
        return {
          "id": null,
          "part_id": null,
          "line_id": item.lineId,
          "name": item.title,
          "part_number": item.partNumberCtrl.text,
          "quantity": double.tryParse(item.quantityCtrl.text)?.toInt() ?? 0,
          "unit_of_measurement": item.unitCtrl.text,
          "manufacturer": null,
          "price": int.tryParse(item.priceCtrl.text) ?? 0,
          "note": null,
          "currency": "KZT",
          "workspace_id": widget.workspaceId,
          "storehouse_order_id": widget.storehouseOrderId,
          "applicable_models":
              item.equipmentId != null ? [item.equipmentId] : [],
          "defect_id": item.defectId,
          "nomenclature_number": item.nomNumberCtrl.text
        };
      }).toList();

      final body = {
        "workspace_id": widget.workspaceId,
        "provider": providerObj,
        "warehouse": warehouseObj,
        "date": DateFormat('yyyy-MM-dd').format(_deliveryDate),
        "from_store_house": true,
        "comment": _commentController.text,
        "company_id": _selectedCompanyId,
        "invoiceDate": DateFormat('yyyy-MM-dd').format(_invoiceDate),
        "accountNumber": _invoiceNumberController.text,
        "part_nomenclatures": partsPayload
      };

      print("Sending Body: ${json.encode(body)}");

      final response = await http.post(
        Uri.parse(
            'https://fleet.equipmetry.kz/api/v1/workspace/inventory/receive'),
        headers: _headers,
        body: json.encode(body),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Успешно оприходовано!'),
              backgroundColor: Colors.green),
        );
        context.pop();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Ошибка: ${response.statusCode} ${response.body}'),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Ошибка отправки: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isSubmitting = false);
    }
  }

  bool _validate() {
    if (_selectedCompanyId == null ||
        _selectedProviderId == null ||
        _selectedWarehouseId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Заполните обязательные поля (Компания, Поставщик, Склад)')),
      );
      return false;
    }
    if (_invoiceNumberController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите номер счета')),
      );
      return false;
    }
    return true;
  }

  // --- UI HELPERS ---
  Future<void> _pickDate(BuildContext context, bool isDelivery) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isDelivery ? _deliveryDate : _invoiceDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isDelivery) {
          _deliveryDate = picked;
        } else {
          _invoiceDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Container(
      color: FlutterFlowTheme.of(context)
                                                        .primaryBackground,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle("Основная информация"),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        _buildDropdown(
                          label: "Компания",
                          value: _selectedCompanyId,
                          items: _companies,
                          onChanged: (val) =>
                              setState(() => _selectedCompanyId = val),
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          label: "Поставщик",
                          value: _selectedProviderId,
                          items: _providers,
                          onChanged: (val) =>
                              setState(() => _selectedProviderId = val),
                        ),
                        const SizedBox(height: 12),
                        _buildDropdown(
                          label: "Склад назначения",
                          value: _selectedWarehouseId,
                          items: _warehouses,
                          onChanged: (val) =>
                              setState(() => _selectedWarehouseId = val),
                        ),
                        const SizedBox(height: 12),

                        // Дата поставки
                        _buildDateSelector(
                            "Дата поставки", _deliveryDate, true),
                        const SizedBox(height: 12),

                        // Счет (Здесь данные подставятся автоматом)
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _invoiceNumberController,
                                decoration: _inputDecoration("Номер счета"),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: InkWell(
                                onTap: () => _pickDate(context, false),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  // Отображаем дату из state, которая обновилась из JSON
                                  child: Text(DateFormat('dd.MM.yyyy')
                                      .format(_invoiceDate)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: _commentController,
                          decoration: _inputDecoration("Комментарий"),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildSectionTitle("Список ТМЦ"),
                  const SizedBox(height: 8),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      return _buildItemCard(_items[index]);
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 4, offset: Offset(0, -2))
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4B39EF),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                child: _isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Оприходовать",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }

  // --- WIDGET BUILDERS ---
  Widget _buildSectionTitle(String title) {
    return Text(title,
        style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: FlutterFlowTheme.of(context)
                                                        .primaryText));
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<dynamic> items,
    required Function(String?) onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      isExpanded: true,
      decoration: _inputDecoration(label),
      items: items.map<DropdownMenuItem<String>>((item) {
        return DropdownMenuItem<String>(
          value: item['id'],
          child: Text(item['name'] ?? 'Без названия',
              overflow: TextOverflow.ellipsis),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildDateSelector(String label, DateTime date, bool isDelivery) {
    return InkWell(
      onTap: () => _pickDate(context, isDelivery),
      child: InputDecorator(
        decoration: _inputDecoration(label),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(DateFormat('dd.MM.yyyy').format(date)),
            const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(ReceiveItemModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context)
                                                        .alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          if (item.equipmentName.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(item.equipmentName,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ),
          const Divider(),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _miniInput(item.quantityCtrl, "Кол-во", isNumber: true),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: _miniInput(item.unitCtrl, "Ед. изм"),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 3,
                child: _miniInput(item.priceCtrl, "Цена", isNumber: true),
              )
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _miniInput(item.partNumberCtrl, "Парт-номер")),
              const SizedBox(width: 8),
              Expanded(child: _miniInput(item.nomNumberCtrl, "Номенкл. №")),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniInput(TextEditingController ctrl, String hint,
      {bool isNumber = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        SizedBox(
          height: 35,
          child: TextFormField(
            controller: ctrl,
            keyboardType: isNumber ? TextInputType.number : TextInputType.text,
            style: const TextStyle(fontSize: 13),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    );
  }
}

class ReceiveItemModel {
  String lineId;
  String title;
  String equipmentName;
  String? equipmentId;
  String? defectId;

  TextEditingController quantityCtrl;
  TextEditingController priceCtrl;
  TextEditingController partNumberCtrl;
  TextEditingController nomNumberCtrl;
  TextEditingController unitCtrl;

  ReceiveItemModel({
    required this.lineId,
    required this.title,
    required this.equipmentName,
    this.equipmentId,
    this.defectId,
    required this.quantityCtrl,
    required this.priceCtrl,
    required this.partNumberCtrl,
    required this.nomNumberCtrl,
    required this.unitCtrl,
  });
}
