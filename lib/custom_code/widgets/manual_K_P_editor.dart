// ignore_for_file: unnecessary_getters_setters
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class ManualKPEditor extends StatefulWidget {
  const ManualKPEditor({
    super.key,
    this.width,
    this.height,
    required this.procurementId,
    required this.authToken,
    required this.workspaceId,
    required this.offerData,
    required this.inventoryItems,
  });

  final double? width;
  final double? height;
  final String procurementId;
  final String authToken;
  final String workspaceId;
  final dynamic offerData;
  final List<dynamic> inventoryItems;

  @override
  State<ManualKPEditor> createState() => _ManualKPEditorState();
}

class _ManualKPEditorState extends State<ManualKPEditor> {
  static const Set<String> _allowedCharacteristics = {
    'Оригинал',
    'Аналог',
  };
  bool _isUploading = false;
  bool _isLoadingSuppliers = true;
  bool _isCreatingSupplier = false;
  List<String> _uploadedFileUrls = [];
  List<Map<String, dynamic>> _inventoryItems = [];
  List<dynamic> _suppliers = [];

  final TextEditingController _deliveryPriceController =
      TextEditingController();
  final TextEditingController _deliveryTimeController =
      TextEditingController();

  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, String?> _characteristics = {};

  String _offerId = '';
  Map<String, dynamic> _counterparty = {};
  String? _selectedSupplierId;

  @override
  void initState() {
    super.initState();
    _prefillData();
    _fetchSuppliers();
  }

  void _prefillData() {
    final offer = widget.offerData;

    _offerId = offer['id']?.toString() ?? '';
    _counterparty = Map<String, dynamic>.from(offer['counterparty'] ?? {});
    _selectedSupplierId = _counterparty['id']?.toString();

    _deliveryPriceController.text =
        (offer['price'] ?? '').toString();
    _deliveryTimeController.text =
        (offer['delivery_time'] ?? '').toString();

    final List<dynamic> existingFiles = offer['file'] ?? [];
    _uploadedFileUrls = existingFiles.map((f) => f.toString()).toList();

    final List<dynamic> existingItemOffers =
        offer['inventory_item_offers'] ?? [];

    _inventoryItems = widget.inventoryItems
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();

    for (var item in _inventoryItems) {
      String id = item['id'].toString();
      _priceControllers[id] = TextEditingController();
      _characteristics[id] = null;

      final matchingOffer = _findMatchingOffer(
        existingItemOffers,
        item,
        offer,
      );

      if (matchingOffer != null) {
        _priceControllers[id]!.text =
            (matchingOffer['price'] ?? '').toString();
        final rawCharacteristic =
            matchingOffer['characteristic']?.toString().trim();
        _characteristics[id] = (rawCharacteristic != null &&
                _allowedCharacteristics.contains(rawCharacteristic))
            ? rawCharacteristic
            : null;
      }
    }
  }

  @override
  void dispose() {
    _deliveryPriceController.dispose();
    _deliveryTimeController.dispose();
    for (final c in _priceControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  String? _emptyToNull(String text) {
    final value = text.trim();
    return value.isEmpty ? null : value;
  }

  Map<String, String> get _headers => {
        'Authorization': widget.authToken,
        'Workspace': widget.workspaceId,
        'workspace': widget.workspaceId,
      };

  Future<void> _fetchSuppliers() async {
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/counterparty/preview?workspace_id=${widget.workspaceId}&type=PROVIDER');
    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        final list = jsonDecode(response.body);
        if (!mounted) return;
        setState(() {
          _suppliers = list is List ? list : <dynamic>[];
          _isLoadingSuppliers = false;
        });
      } else {
        if (mounted) setState(() => _isLoadingSuppliers = false);
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingSuppliers = false);
    }
  }

  Future<void> _showCreateSupplierDialog() async {
    final typeController = ValueNotifier<String>('PROVIDER');
    final titleController = TextEditingController();
    final addressController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();

    Future<void> submit(StateSetter setStateDialog) async {
      if (titleController.text.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Заполните наименование')),
        );
        return;
      }

      setStateDialog(() => _isCreatingSupplier = true);
      try {
        final response = await http.post(
          Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/counterparty'),
          headers: {
            ..._headers,
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'type': typeController.value,
            'title': titleController.text.trim(),
            'address': _emptyToNull(addressController.text),
            'phone_number': _emptyToNull(phoneController.text),
            'email': _emptyToNull(emailController.text),
          }),
        );

        if (response.statusCode != 200 && response.statusCode != 201) {
          throw Exception(
            utf8.decode(response.bodyBytes).trim().isEmpty
                ? 'HTTP ${response.statusCode}'
                : utf8.decode(response.bodyBytes),
          );
        }

        dynamic created = jsonDecode(utf8.decode(response.bodyBytes));
        if (created is Map && created['data'] != null) {
          created = created['data'];
        }
        if (created is List && created.isNotEmpty) {
          created = created.first;
        }
        if (created is! Map) {
          throw Exception('Неожиданный ответ сервера: $created');
        }

        final supplier = Map<String, dynamic>.from(created);
        if (!mounted) return;
        setState(() {
          _suppliers = [supplier, ..._suppliers];
          _counterparty = supplier;
          _selectedSupplierId = supplier['id']?.toString();
        });
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Поставщик создан')),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка создания поставщика: $e')),
        );
      } finally {
        if (mounted) setStateDialog(() => _isCreatingSupplier = false);
      }
    }

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) => Dialog(
            insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ValueListenableBuilder<String>(
                      valueListenable: typeController,
                      builder: (_, value, __) => DropdownButtonFormField<String>(
                        initialValue: value,
                        decoration: _labeledDecoration('Тип *'),
                        items: const [
                          DropdownMenuItem(value: 'PROVIDER', child: Text('Поставщик')),
                          DropdownMenuItem(value: 'SERVICE_STATION', child: Text('СТО')),
                        ],
                        onChanged: (v) {
                          if (v != null) typeController.value = v;
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: titleController,
                      decoration: _labeledDecoration('Наименование *'),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: addressController,
                      decoration: _labeledDecoration('Адрес'),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: _labeledDecoration('Номер телефона'),
                    ),
                    const SizedBox(height: 14),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: _labeledDecoration('Почта'),
                    ),
                    const SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: _isCreatingSupplier ? null : () => submit(setStateDialog),
                      child: _isCreatingSupplier
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    titleController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    typeController.dispose();
  }

  List<Map<String, dynamic>> get _supplierOptions {
    final seen = <String>{};
    final options = <Map<String, dynamic>>[];
    for (final raw in _suppliers) {
      if (raw is! Map) continue;
      final m = Map<String, dynamic>.from(raw.map((k, v) => MapEntry(k.toString(), v)));
      final id = m['id']?.toString();
      if (id == null || id.isEmpty || seen.contains(id)) continue;
      seen.add(id);
      options.add(m);
    }
    final cpId = _counterparty['id']?.toString();
    if (cpId != null &&
        cpId.isNotEmpty &&
        !options.any((e) => e['id']?.toString() == cpId)) {
      options.insert(0, Map<String, dynamic>.from(_counterparty));
    }
    return options;
  }

  Future<void> _removeItem(String id) async {
    setState(() {
      _inventoryItems.removeWhere((item) => item['id'].toString() == id);
    });
  }

  dynamic _findMatchingOffer(
    List<dynamic> existingItemOffers,
    dynamic item,
    dynamic offer,
  ) {
    final counterpartyId = _counterparty['id'];

    for (var eio in existingItemOffers) {
      if (eio['id'] == item['id']) return eio;
    }

    final List<dynamic> itemOffers = item['offers'] ?? [];
    for (var io in itemOffers) {
      if (io['counterparty']?['id'] == counterpartyId) {
        return io;
      }
    }

    return null;
  }

  Future<void> _pickFile(bool fromCamera) async {
    String? filePath;

    if (fromCamera) {
      final picker = ImagePicker();
      final XFile? photo =
          await picker.pickImage(source: ImageSource.camera);
      filePath = photo?.path;
    } else {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      filePath = result?.files.single.path;
    }

    if (filePath != null) {
      await _uploadFileToApi(File(filePath));
    }
  }

  Future<void> _uploadFileToApi(File file) async {
    setState(() => _isUploading = true);
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/object/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Authorization': widget.authToken,
        'workspace': widget.workspaceId,
      });

      request.files.add(await http.MultipartFile.fromPath(
        'files',
        file.path,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        String uploadedUrl = response.body;
        try {
          final decoded = jsonDecode(response.body);
          if (decoded is List) {
            uploadedUrl = decoded.first.toString();
          } else {
            uploadedUrl = decoded.toString();
          }
        } catch (_) {
          uploadedUrl = response.body;
        }

        if (uploadedUrl.isNotEmpty) {
          setState(() {
            _uploadedFileUrls.add(uploadedUrl);
          });
        }
      } else {
        throw Exception("Ошибка загрузки: ${response.body}");
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ошибка загрузки файла: $e"),
          backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  Future<void> _updateKP() async {
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${widget.procurementId}/kp/update');

    List<Map<String, dynamic>> itemOffers =
        _inventoryItems.map((item) {
      String id = item['id'].toString();
      return {
        "id": id,
        "price": double.tryParse(_priceControllers[id]?.text ?? '') ?? 0.0,
        "characteristic": _characteristics[id],
      };
    }).toList();

    final body = {
      "offer_id": _offerId,
      "counterparty": _counterparty.isEmpty
          ? null
          : {
              "id": _counterparty['id'],
              "title": _counterparty['title'],
              "phone_number": _counterparty['phone_number'],
              "email": _counterparty['email'],
            },
      "offer": {
        "delivery_method": "COURIER",
        "price":
            double.tryParse(_deliveryPriceController.text) ?? 0.0,
        "delivery_time": _emptyToNull(_deliveryTimeController.text),
      },
      "inventory_item_offers": itemOffers,
      "file": _uploadedFileUrls.isEmpty ? null : _uploadedFileUrls,
    };

    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': widget.authToken,
          'workspace': widget.workspaceId,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("КП успешно обновлено"),
            backgroundColor: Color(0xFF32C680)));
        Navigator.of(context).pop(true);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Ошибка: $e"),
          backgroundColor: Colors.red));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSection("Поставщик", [
              _isLoadingSuppliers
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: [
                        DropdownButtonFormField<String?>(
                          initialValue: _supplierOptions.any(
                                  (s) => s['id']?.toString() == _selectedSupplierId)
                              ? _selectedSupplierId
                              : null,
                          decoration: _inputDecoration("Выберите поставщика"),
                          items: [
                            const DropdownMenuItem<String?>(
                              value: null,
                              child: Text('Без поставщика'),
                            ),
                            ..._supplierOptions.map(
                              (s) => DropdownMenuItem<String?>(
                                value: s['id']?.toString(),
                                child: Text(s['title']?.toString() ?? '-'),
                              ),
                            ),
                          ],
                          onChanged: (val) {
                            setState(() {
                              _selectedSupplierId = val;
                              if (val == null) {
                                _counterparty = {};
                                return;
                              }
                              final match = _supplierOptions.firstWhere(
                                (s) => s['id']?.toString() == val,
                                orElse: () => <String, dynamic>{},
                              );
                              _counterparty = Map<String, dynamic>.from(match);
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButton.icon(
                            onPressed: _showCreateSupplierDialog,
                            icon: const Icon(Icons.add_business_outlined),
                            label: const Text('Добавить нового поставщика'),
                          ),
                        ),
                      ],
                    ),
            ]),
            const SizedBox(height: 16),
            _buildSection("Документы", [
              if (_isUploading) const LinearProgressIndicator(),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickFile(true),
                      icon: const Icon(Icons.camera_alt,
                          color: Colors.white, size: 18),
                      label: const Text("Камера",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickFile(false),
                      icon: const Icon(Icons.file_present,
                          color: Colors.white, size: 18),
                      label: const Text("Файл",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              FlutterFlowTheme.of(context).primary),
                    ),
                  ),
                ],
              ),
              if (_uploadedFileUrls.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    children: _uploadedFileUrls.map((url) {
                      String fileName = url.split('/').last;
                      if (fileName.length > 30) {
                        fileName =
                            "...${fileName.substring(fileName.length - 25)}";
                      }
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.check_circle,
                            color: Colors.green, size: 20),
                        title:
                            Text(fileName, style: const TextStyle(fontSize: 12)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red, size: 20),
                          onPressed: () => setState(
                              () => _uploadedFileUrls.remove(url)),
                        ),
                      );
                    }).toList(),
                  ),
                ),
            ]),
            const SizedBox(height: 16),
            _buildSection("Список запчастей", _buildItemsList()),
            const SizedBox(height: 16),
            _buildSection("Доставка", [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _deliveryPriceController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Стоимость доставки"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _deliveryTimeController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration("Срок доставки (дн)"),
                    ),
                  ),
                ],
              ),
            ]),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48)),
                    child: const Text("Отмена"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isUploading ? null : _updateKP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B39EF),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: const Text("Сохранить КП",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          ...children,
        ],
      ),
    );
  }

  List<Widget> _buildItemsList() {
    if (_inventoryItems.isEmpty) {
      return [
        Text(
          'Список пуст. Можно сохранить КП без позиций.',
          style: TextStyle(
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
      ];
    }

    return _inventoryItems.map((item) {
      String id = item['id'].toString();
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                      "${item['title']} (${item['quantity']} ${item['unit_of_measurement'] ?? 'шт'})",
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                ),
                IconButton(
                  onPressed: () => _removeItem(id),
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                  tooltip: 'Удалить запчасть',
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _priceControllers[id],
                    keyboardType: TextInputType.number,
                    decoration: _inputDecoration("Цена за ед."),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String?>(
                    initialValue: _allowedCharacteristics
                            .contains(_characteristics[id])
                        ? _characteristics[id]
                        : null,
                    decoration: _inputDecoration("Тип"),
                    items: const [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text('Без типа'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'Оригинал',
                        child: Text('Оригинал'),
                      ),
                      DropdownMenuItem<String?>(
                        value: 'Аналог',
                        child: Text('Аналог'),
                      ),
                    ],
                    onChanged: (val) =>
                        setState(() => _characteristics[id] = val),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border:
          OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).primaryBackground,
    );
  }

  InputDecoration _labeledDecoration(String label) {
    return InputDecoration(
      labelText: label,
      hintText: 'Введите',
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: FlutterFlowTheme.of(context).alternate),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
    );
  }
}
