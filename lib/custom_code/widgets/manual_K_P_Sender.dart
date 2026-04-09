// ignore_for_file: unnecessary_getters_setters
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import 'dart:convert';
import 'dart:io';

class ManualKPSender extends StatefulWidget {
  const ManualKPSender({
    super.key,
    this.width,
    this.height,
    required this.procurementData,
    required this.authToken,
    required this.workspaceId,
  });

  final double? width;
  final double? height;
  final dynamic procurementData;
  final String authToken;
  final String workspaceId;

  @override
  State<ManualKPSender> createState() => _ManualKPSenderState();
}

class _ManualKPSenderState extends State<ManualKPSender> {
  List<dynamic> _suppliers = [];
  dynamic _selectedSupplier;
  String? _selectedSupplierId;
  bool _isLoadingSuppliers = true;
  bool _isUploading = false;
  bool _isSendingKp = false;
  bool _isCreatingSupplier = false;
  final List<String> _uploadedFileUrls = [];
  List<Map<String, dynamic>> _inventoryItems = [];

  final TextEditingController _deliveryPriceController =
      TextEditingController();
  final TextEditingController _deliveryTimeController =
      TextEditingController();

  final Map<String, TextEditingController> _priceControllers = {};
  final Map<String, String?> _characteristics = {};

  @override
  void initState() {
    super.initState();
    _fetchSuppliers();
    _initItemControllers();
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

  void _initItemControllers() {
    _bootstrapFromMyExistingOffer();
    final List items = widget.procurementData['inventory_items'] ?? [];
    _inventoryItems = items
        .whereType<Map>()
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
    for (var item in items) {
      final String id = item['id'].toString();
      _priceControllers[id] = TextEditingController();
      _characteristics[id] = null;
    }

    final myEmail = _currentUserEmail();
    if (myEmail.isEmpty) return;
    for (final item in _inventoryItems) {
      final id = item['id']?.toString() ?? '';
      if (id.isEmpty) continue;
      final offers = item['offers'];
      if (offers is! List) continue;
      for (final o in offers) {
        if (o is! Map) continue;
        final cp = o['counterparty'];
        final email =
            (cp is Map ? cp['email'] : null)?.toString().trim().toLowerCase() ??
                '';
        if (email.isNotEmpty && email == myEmail) {
          final price = o['price'];
          if (price != null) {
            _priceControllers[id]?.text = price.toString();
          }
          _characteristics[id] = o['characteristic']?.toString();
          break;
        }
      }
    }
  }

  String _currentUserEmail() {
    final raw = getJsonField(
      FFAppState().result,
      r'''$.user.email''',
    )?.toString();
    return raw?.trim().toLowerCase() ?? '';
  }

  void _bootstrapFromMyExistingOffer() {
    final myEmail = _currentUserEmail();
    if (myEmail.isEmpty) return;
    final offers = widget.procurementData['offers'];
    if (offers is! List) return;
    for (final o in offers) {
      if (o is! Map) continue;
      final cp = o['counterparty'];
      final email =
          (cp is Map ? cp['email'] : null)?.toString().trim().toLowerCase() ??
              '';
      if (email.isNotEmpty && email == myEmail) {
        if (cp is Map) {
          _selectedSupplier = Map<String, dynamic>.from(
            cp.map((k, v) => MapEntry(k.toString(), v)),
          );
          _selectedSupplierId = _selectedSupplier['id']?.toString();
        }
        final deliveryPrice = o['price'];
        if (deliveryPrice != null) {
          _deliveryPriceController.text = deliveryPrice.toString();
        }
        final dt = o['delivery_time']?.toString();
        if (dt != null && dt.trim().isNotEmpty) {
          _deliveryTimeController.text = dt.trim();
        }
        break;
      }
    }
  }

  Map<String, String> get _headers => {
        'Authorization': widget.authToken,
        'Workspace': widget.workspaceId,
        'workspace': widget.workspaceId,
      };

  String? _emptyToNull(String text) {
    final value = text.trim();
    return value.isEmpty ? null : value;
  }

  Future<void> _removeItem(String id) async {
    setState(() {
      _inventoryItems.removeWhere((item) => item['id'].toString() == id);
    });
  }

  Future<void> _pickFile(bool fromCamera) async {
    String? filePath;

    if (fromCamera) {
      final picker = ImagePicker();
      final XFile? photo = await picker.pickImage(source: ImageSource.camera);
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
    final url =
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/object/upload');

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll(_headers);

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

  Future<void> _fetchSuppliers() async {
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/counterparty/preview?workspace_id=${widget.workspaceId}&type=PROVIDER');
    try {
      final response = await http.get(url, headers: _headers);
      if (response.statusCode == 200) {
        setState(() {
          _suppliers = jsonDecode(response.body);
          _isLoadingSuppliers = false;
        });
      }
    } catch (e) {
      setState(() => _isLoadingSuppliers = false);
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
        final Map<String, dynamic> supplier =
            Map<String, dynamic>.from(created);

        if (!mounted) return;
        setState(() {
          _suppliers = [supplier, ..._suppliers];
          _selectedSupplier = supplier;
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
        if (mounted) {
          setStateDialog(() => _isCreatingSupplier = false);
        }
      }
    }

    await showDialog(
      context: context,
      routeSettings: const RouteSettings(name: 'CreateCounterpartyDialog'),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return Dialog(
              insetPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Добавить СТО / поставщика',
                                style: FlutterFlowTheme.of(context)
                                    .headlineSmall
                                    .copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        ValueListenableBuilder<String>(
                          valueListenable: typeController,
                          builder: (_, value, __) {
                            return DropdownButtonFormField<String>(
                              initialValue: value,
                              decoration: _labeledDecoration('Тип *'),
                              items: const [
                                DropdownMenuItem(
                                  value: 'PROVIDER',
                                  child: Text('Поставщик'),
                                ),
                                DropdownMenuItem(
                                  value: 'SERVICE_STATION',
                                  child: Text('СТО'),
                                ),
                              ],
                              onChanged: (v) {
                                if (v != null) typeController.value = v;
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: titleController,
                          decoration: _labeledDecoration('Наименование *'),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: addressController,
                          decoration: _labeledDecoration('Адрес'),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: _labeledDecoration('Номер телефона'),
                        ),
                        const SizedBox(height: 18),
                        TextField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: _labeledDecoration('Почта'),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            OutlinedButton(
                              onPressed: _isCreatingSupplier
                                  ? null
                                  : () => Navigator.of(context).pop(),
                              child: const Text('Отменить'),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 44,
                              child: ElevatedButton(
                                onPressed: _isCreatingSupplier
                                    ? null
                                    : () async => submit(setStateDialog),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                ),
                                child: Text(
                                  'Сохранить',
                                  style: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    titleController.dispose();
    addressController.dispose();
    phoneController.dispose();
    emailController.dispose();
    typeController.dispose();
  }

  Future<void> _sendKP() async {
    if (_isSendingKp || _isUploading) return;

    final String procurementId = widget.procurementData['id'].toString();
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/procurement/$procurementId/kp/send');

    final List<Map<String, dynamic>> itemOffers = _inventoryItems.map((item) {
      final String id = item['id'].toString();
      return {
        "id": id,
        "price": double.tryParse(_priceControllers[id]?.text ?? '') ?? 0,
        "characteristic": _characteristics[id],
      };
    }).toList();

    final body = {
      "offer": {
        "delivery_method": "COURIER",
        "price": double.tryParse(_deliveryPriceController.text) ?? 0.0,
        "delivery_time": _emptyToNull(_deliveryTimeController.text),
      },
      "inventory_item_offers": itemOffers,
      "counterparty": _selectedSupplier == null
          ? null
          : {
              "id": _selectedSupplier['id'],
              "title": _selectedSupplier['title'],
              "phone_number": _selectedSupplier['phone_number'],
              "email": _selectedSupplier['email'],
            },
      "file": _uploadedFileUrls.isEmpty ? null : _uploadedFileUrls,
    };

    setState(() => _isSendingKp = true);
    try {
      final response = await http.post(
        url,
        headers: {
          ..._headers,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("КП успешно добавлено")));
        Navigator.of(context).pop(true);
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка: $e"), backgroundColor: Colors.red));
    } finally {
      if (mounted) setState(() => _isSendingKp = false);
    }
  }

  bool get _formLocked => _isSendingKp || _isUploading;

  List<dynamic> get _supplierOptions {
    final List<dynamic> base = List<dynamic>.from(_suppliers);
    final seen = <String>{};
    base.removeWhere((e) {
      if (e is! Map) return true;
      final id = e['id']?.toString();
      if (id == null || id.isEmpty) return true;
      if (seen.contains(id)) return true;
      seen.add(id);
      return false;
    });
    final sel = _selectedSupplier;
    if (sel is Map) {
      final sid = sel['id']?.toString();
      final exists = sid != null &&
          sid.isNotEmpty &&
          base.any((e) => e is Map && e['id']?.toString() == sid);
      if (!exists) {
        base.insert(0, sel);
      }
    }
    return base;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: Stack(
        children: [
          AbsorbPointer(
            absorbing: _isSendingKp,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildSection("Поставщик", [
                    _isLoadingSuppliers
                        ? const Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              DropdownButtonFormField<dynamic>(
                                decoration: _inputDecoration(
                                    "Выберите поставщика (необязательно)"),
                                initialValue: _selectedSupplierId,
                                items: [
                                  const DropdownMenuItem<dynamic>(
                                    value: null,
                                    child: Text('Без поставщика'),
                                  ),
                                  ..._supplierOptions.map((s) {
                                    return DropdownMenuItem<dynamic>(
                                      value: s['id']?.toString(),
                                      child:
                                          Text(s['title']?.toString() ?? '-'),
                                    );
                                  }),
                                ],
                                onChanged: _formLocked
                                    ? null
                                    : (val) => setState(() {
                                        _selectedSupplierId = val?.toString();
                                        if (_selectedSupplierId == null) {
                                          _selectedSupplier = null;
                                          return;
                                        }
                                        final match = _supplierOptions.cast<Map?>().firstWhere(
                                          (s) => s?['id']?.toString() == _selectedSupplierId,
                                          orElse: () => null,
                                        );
                                        _selectedSupplier = match;
                                      }),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: OutlinedButton.icon(
                                  onPressed: _formLocked
                                      ? null
                                      : _showCreateSupplierDialog,
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
                      onPressed:
                          _formLocked ? null : () => _pickFile(true),
                      icon: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                      label: const Text("Камера", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primary),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed:
                          _formLocked ? null : () => _pickFile(false),
                      icon: const Icon(Icons.file_present, color: Colors.white, size: 18),
                      label: const Text("Файл", style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(backgroundColor: FlutterFlowTheme.of(context).primary),
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
                        title: Text(fileName, style: const TextStyle(fontSize: 12)),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline,
                              color: Colors.red, size: 20),
                          onPressed: _formLocked
                              ? null
                              : () => setState(
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
                    onPressed: _isSendingKp
                        ? null
                        : () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(48)),
                    child: const Text("Отмена"),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _formLocked ? null : _sendKP,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4B39EF),
                      minimumSize: const Size.fromHeight(48),
                    ),
                    child: _isSendingKp
                        ? const SizedBox(
                            height: 22,
                            width: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text("Добавить КП",
                            style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          if (_isSendingKp)
            Positioned.fill(
              child: Material(
                color: Colors.black.withValues(alpha: 0.35),
                child: Center(
                  child: Card(
                    elevation: 8,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Отправка КП…',
                            style: FlutterFlowTheme.of(context).bodyMedium
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
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
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          'Список пуст. Можно отправить КП без позиций.',
          style: TextStyle(
            color: FlutterFlowTheme.of(context).secondaryText,
          ),
        ),
      ];
    }

    return _inventoryItems.map((item) {
      final String id = item['id'].toString();
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
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
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
                    initialValue: _characteristics[id],
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
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
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
        borderSide:
            BorderSide(color: FlutterFlowTheme.of(context).alternate),
      ),
      filled: true,
      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
    );
  }
}