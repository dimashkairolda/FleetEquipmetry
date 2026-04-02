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
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';

class MobileInvoiceForm extends StatefulWidget {
  const MobileInvoiceForm({
    Key? key,
    this.width,
    this.height,
    required this.itemsData,
    required this.suppliersData,
    required this.storehouseOrderId,
    required this.authHeader,
    required this.workspaceHeader,
  }) : super(key: key);

  final double? width;
  final double? height;
  final dynamic itemsData;
  final dynamic suppliersData;
  final String storehouseOrderId;
  final String authHeader;
  final String workspaceHeader;

  @override
  _MobileInvoiceFormState createState() => _MobileInvoiceFormState();
}

class _MobileInvoiceFormState extends State<MobileInvoiceForm> {
  final _formKey = GlobalKey<FormState>();

  // Контроллеры шапки
  final TextEditingController _titleController = TextEditingController();
  String? _selectedProviderId;
  DateTime? _globalDeliveryDate;

  // Фото и медиа
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _uploadedMediaUrl;
  bool _isUploadingImage = false;

  // Список товаров
  List<MobileInvoiceItemModel> _items = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _parseItems();
  }

  void _parseItems() {
    try {
      if (widget.itemsData != null) {
        Map<String, dynamic> dataMap;
        if (widget.itemsData is String) {
          dataMap = json.decode(widget.itemsData);
        } else {
          dataMap = widget.itemsData as Map<String, dynamic>;
        }

        dataMap.forEach((key, value) {
          _items.add(MobileInvoiceItemModel(
            lineId: key,
            partName: value['title'] ?? key,
            productArticle: value['product_article'] ??
                value['part_number'] ??
                'Нет артикула',
            requiredQuantity: value['quantity']?.toString() ?? '1',
            defectId: value['defect_id'],
            defectName: value['defect_name'],
            equipmentId: value['equipment_id'],
            equipmentName: value['equipment_name'],
            priceController: TextEditingController(text: "0"),
            quantityController: TextEditingController(
                text: value['quantity']?.toString() ?? '1'),
            deliveryDate: null,
          ));
        });
      }
    } catch (e) {
      print("Error parsing items: $e");
    }
  }

  double get _totalAmount {
    double total = 0;
    for (var item in _items) {
      double p = double.tryParse(item.priceController.text) ?? 0;
      double q = double.tryParse(item.quantityController.text) ?? 0;
      total += (p * q);
    }
    return total;
  }

  // --- ЛОГИКА ЗАГРУЗКИ ФОТО ---

  Future<void> _pickAndUploadImage() async {
    try {
      // 1. Выбор фото (Камера или Галерея)
      // Можно сделать выбор, но пока сделаем камеру по умолчанию для удобства
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 70, // Сжимаем качество для скорости
      );

      if (photo == null) return;

      setState(() {
        _imageFile = photo;
        _isUploadingImage = true;
      });

      // 2. Загрузка на сервер
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/object/upload'),
      );

      request.headers.addAll({
        'Authorization': widget.authHeader,
        'Workspace': widget.workspaceHeader,
      });

      request.files.add(await http.MultipartFile.fromPath('files', photo.path));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        // Парсим ответ. Сервер может вернуть строку URL или JSON
        // Предполагаем, что сервер возвращает JSON вида ["url"] или {"url":...}
        // Либо просто строку. Адаптируемся:
        String responseBody = response.body;
        String? finalUrl;

        try {
          var decoded = json.decode(responseBody);
          if (decoded is List && decoded.isNotEmpty) {
            finalUrl = decoded[0].toString();
          } else if (decoded is Map && decoded.containsKey('url')) {
            finalUrl = decoded['url'];
          } else {
            finalUrl = responseBody.replaceAll('"', ''); // Очистка от кавычек
          }
        } catch (_) {
          finalUrl = responseBody; // Если не JSON, берем как есть
        }

        setState(() {
          _uploadedMediaUrl = finalUrl;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Фото успешно загружено!")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Ошибка загрузки фото: ${response.statusCode}"),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        _isUploadingImage = false;
      });
    }
  }

  // --- ЛОГИКА ОТПРАВКИ СЧЕТА ---

  Future<void> _submitInvoice() async {
    // ВАЛИДАЦИЯ УБРАНА ПО ЗАПРОСУ ("сделай поля не обязательными")
    // Если нужно вернуть - раскомментируйте проверки ниже.
    /*
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Введите название счета")));
      return;
    }
    */

    setState(() => _isLoading = true);

    try {
      List<Map<String, dynamic>> partsPayload = _items.map((item) {
        double price = double.tryParse(item.priceController.text) ?? 0;
        double qtyDouble = double.tryParse(item.quantityController.text) ?? 0;
        int qtyInt = qtyDouble.toInt();
        double amount = price * qtyDouble;

        return {
          "status": "IN_PROGRESS",
          "line_id": item.lineId,
          "part_name": item.partName,
          "quantity": qtyInt,
          "price": price,
          "amount": amount,
          "delivery_date": item.deliveryDate != null
              ? DateFormat('yyyy-MM-dd').format(item.deliveryDate!)
              : null,
          "defect_id": item.defectId,
          "defect_name": item.defectName,
          "equipment_name": item.equipmentName,
          "equipment_id": item.equipmentId,
          "product_article": item.productArticle,
          "_menu": false
        };
      }).toList();

      final Map<String, dynamic> requestBody = {
        "title": _titleController.text.isEmpty
            ? "Без названия"
            : _titleController.text, // Дефолтное значение
        "provider_id": _selectedProviderId, // Может быть null
        "workspace_id": widget.workspaceHeader,
        "amount": _totalAmount,
        "parts": partsPayload,
        "storehouse_order_id": widget.storehouseOrderId,
        "media": _uploadedMediaUrl // Добавляем ссылку на фото
      };

      print("Sending JSON: ${json.encode(requestBody)}");

      final response = await http.post(
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/invoice'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': widget.authHeader,
          'Workspace': widget.workspaceHeader,
        },
        body: json.encode(requestBody),
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Счет успешно сохранен!'),
              backgroundColor: Color(0xFF4B39EF)),
        );
        context.pop(); // Или navigateBack
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Ошибка сервера: ${response.statusCode} | ${response.body}'),
              backgroundColor: Colors.red),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _selectGlobalDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _globalDeliveryDate = picked;
        for (var item in _items) {
          item.deliveryDate = picked;
        }
      });
    }
  }

  Future<void> _selectItemDate(
      BuildContext context, MobileInvoiceItemModel item) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: item.deliveryDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        item.deliveryDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<String>> supplierItems = [];
    if (widget.suppliersData != null) {
      List<dynamic> listData = widget.suppliersData is String
          ? json.decode(widget.suppliersData)
          : widget.suppliersData;

      for (var s in listData) {
        supplierItems.add(DropdownMenuItem(
          value: s['id'],
          child:
              Text(s['name'] ?? 'Без имени', overflow: TextOverflow.ellipsis),
        ));
      }
    }

    return Container(
      color: FlutterFlowTheme.of(context)
                                                        .primaryBackground,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // --- ШАПКА ---
            Container(
              color: FlutterFlowTheme.of(context).primaryBackground,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Новый счет",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      // Кнопка фото
                      InkWell(
                        onTap:
                            _isUploadingImage ? null : () => _pickAndUploadImage(),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _uploadedMediaUrl != null
                                ? Colors.green.withOpacity(0.1)
                                : const Color(0xFF4B39EF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: _isUploadingImage
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(strokeWidth: 2))
                              : Icon(
                                  _uploadedMediaUrl != null
                                      ? Icons.check_circle
                                      : Icons.camera_alt,
                                  color: _uploadedMediaUrl != null
                                      ? Colors.green
                                      : const Color(0xFF4B39EF),
                                ),
                        ),
                      ),
                    ],
                  ),
                  
                  // Превью фото, если есть
                  if (_imageFile != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_imageFile!.path),
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Документ прикреплен", style: TextStyle(fontSize: 12, color: Colors.green))
                        ],
                      ),
                    ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _titleController,
                    decoration: _inputDecoration("Название счета (необязательно)"),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: _inputDecoration("Поставщик (необязательно)"),
                    items: supplierItems,
                    value: _selectedProviderId, // Может быть null
                    onChanged: (val) =>
                        setState(() => _selectedProviderId = val),
                  ),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () => _selectGlobalDate(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                        color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.calendar_month,
                              color: _globalDeliveryDate == null
                                  ? Colors.grey
                                  : const Color(0xFF4B39EF)),
                          const SizedBox(width: 10),
                          Text(
                            _globalDeliveryDate == null
                                ? "Установить срок поставки (всем)"
                                : "Срок: ${DateFormat('dd.MM.yyyy').format(_globalDeliveryDate!)}",
                            style: TextStyle(
                                color: _globalDeliveryDate == null
                                    ? Colors.grey[600]
                                    : Colors.black87,
                                fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            // --- СПИСОК ТОВАРОВ ---
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: Offset(0, 2))
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.partName,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text("Артикул: ${item.productArticle}",
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[500])),
                        const Divider(height: 24),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Требуется",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600])),
                                  Text(item.requiredQuantity,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFF4B39EF),
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Цена",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600])),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller: item.priceController,
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    onChanged: (_) => setState(() {}),
                                    decoration:
                                        _inputDecoration("0", isDense: true),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("В счете",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600])),
                                  const SizedBox(height: 4),
                                  TextFormField(
                                    controller: item.quantityController,
                                    keyboardType: TextInputType.number,
                                    onChanged: (_) => setState(() {}),
                                    decoration:
                                        _inputDecoration("0", isDense: true),
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        InkWell(
                          onTap: () => _selectItemDate(context, item),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                borderRadius: BorderRadius.circular(8)),
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined,
                                    size: 16, color: Colors.grey[700]),
                                const SizedBox(width: 8),
                                Text(
                                  item.deliveryDate == null
                                      ? "Дата поставки (необяз.)"
                                      : "Поставка: ${DateFormat('dd.MM.yyyy').format(item.deliveryDate!)}",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: FlutterFlowTheme.of(context)
                                                        .primaryText),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),

            // --- ПОДВАЛ ---
            Container(
              padding: const EdgeInsets.all(16),
              decoration:  BoxDecoration(
                color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, -2))
                ],
              ),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Итого:",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(
                          NumberFormat.currency(
                                  locale: 'kk', symbol: '₸', decimalDigits: 0)
                              .format(_totalAmount),
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF4B39EF)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (_isLoading || _isUploadingImage) ? null : _submitInvoice,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF4B39EF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                          elevation: 0,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white)
                            : Text(
                                _isUploadingImage ? "Загрузка фото..." : "Сохранить",
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, {bool isDense = false}) {
    return InputDecoration(
      hintText: hint,
      isDense: isDense,
      contentPadding:
          EdgeInsets.symmetric(horizontal: 12, vertical: isDense ? 10 : 16),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF4B39EF))),
      filled: true,
      fillColor: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
    );
  }
}

class MobileInvoiceItemModel {
  final String lineId;
  final String partName;
  final String productArticle;
  final String requiredQuantity;
  final String? defectId;
  final String? defectName;
  final String? equipmentId;
  final String? equipmentName;

  final TextEditingController priceController;
  final TextEditingController quantityController;
  DateTime? deliveryDate;

  MobileInvoiceItemModel({
    required this.lineId,
    required this.partName,
    required this.productArticle,
    required this.requiredQuantity,
    this.defectId,
    this.defectName,
    this.equipmentId,
    this.equipmentName,
    required this.priceController,
    required this.quantityController,
    this.deliveryDate,
  });
}