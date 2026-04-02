import 'dart:convert';

import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

const String _fleetBase = 'https://fleet.equipmetry.kz/api/v1/workspace';

/// Оттенки как на макетах
const Color _kScreenBg = Color(0xFFF2F4F7);
const Color _kLocTint = Color(0xFFE8F4FC);
const Color _kLocBorder = Color(0xFFB8D4F5);
const Color _kFieldBorder = Color(0xFFE0E4EB);
const Color _kGreenState = Color(0xFF00C37B);
const double _kRadius = 14.0;

class _NamedId {
  const _NamedId(this.id, this.name);
  final String id;
  final String name;
}

class SparePartCreateCardWidget extends StatefulWidget {
  const SparePartCreateCardWidget({super.key});

  @override
  State<SparePartCreateCardWidget> createState() =>
      _SparePartCreateCardWidgetState();
}

class _SparePartCreateCardWidgetState extends State<SparePartCreateCardWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _rowCtrl = TextEditingController();
  final _shelfCtrl = TextEditingController();
  final _boxCtrl = TextEditingController();
  final _locationBarcodeCtrl = TextEditingController();

  final _partNumberCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _manufacturerCtrl = TextEditingController();
  final _barcodeCtrl = TextEditingController();

  String? _categoryId;
  String? _warehouseId;
  final List<_NamedId> _categories = [];
  final List<_NamedId> _warehouses = [];
  bool _loadingRefs = false;
  String? _refsError;

  final _qtyCtrl = TextEditingController(text: '1');
  final _unitCtrl = TextEditingController(text: 'шт');
  final _noteCtrl = TextEditingController();

  final _oemInputCtrl = TextEditingController();
  final _crossInputCtrl = TextEditingController();
  final List<String> _oemParts = [];
  final List<String> _crossParts = [];
  final _massCtrl = TextEditingController();
  final _materialCtrl = TextEditingController();
  final _pressureCtrl = TextEditingController();
  final _flowCtrl = TextEditingController();

  final _nomenclatureNumberCtrl = TextEditingController();
  final _descriptionCtrl = TextEditingController();
  final _minQtyCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _categoryCustomCtrl = TextEditingController();

  String _condition = 'new';
  final List<String> _mediaUrls = [];

  bool _uploading = false;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategoriesAndWarehouses();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _rowCtrl.dispose();
    _shelfCtrl.dispose();
    _boxCtrl.dispose();
    _locationBarcodeCtrl.dispose();
    _partNumberCtrl.dispose();
    _nameCtrl.dispose();
    _manufacturerCtrl.dispose();
    _barcodeCtrl.dispose();
    _qtyCtrl.dispose();
    _unitCtrl.dispose();
    _noteCtrl.dispose();
    _oemInputCtrl.dispose();
    _crossInputCtrl.dispose();
    _massCtrl.dispose();
    _materialCtrl.dispose();
    _pressureCtrl.dispose();
    _flowCtrl.dispose();
    _nomenclatureNumberCtrl.dispose();
    _descriptionCtrl.dispose();
    _minQtyCtrl.dispose();
    _codeCtrl.dispose();
    _categoryCustomCtrl.dispose();
    super.dispose();
  }

  String? _emptyToNull(String s) {
    final t = s.trim();
    return t.isEmpty ? null : t;
  }

  Map<String, String>? _buildSpecs() {
    final m = <String, String>{};
    void put(String k, String v) {
      final t = v.trim();
      if (t.isNotEmpty) m[k] = t;
    }

    put('mass', _massCtrl.text);
    put('material', _materialCtrl.text);
    put('pressure', _pressureCtrl.text);
    put('flow', _flowCtrl.text);
    return m.isEmpty ? null : m;
  }

  String _resolveUserId() {
    final v = getJsonField(
      FFAppState().result,
      r'''$.user.id''',
    );
    if (v == null) return '';
    return v.toString().trim();
  }

  Map<String, String> _fleetHeaders(String workspaceId, String token) {
    return {
      'Authorization': token,
      'Workspace': workspaceId,
    };
  }

  Future<void> _loadCategoriesAndWarehouses() async {
    final workspaceId = FFAppState().workspace.trim();
    final token = currentAuthenticationToken;
    if (workspaceId.isEmpty || token == null || token.isEmpty) {
      if (mounted) {
        setState(() {
          _refsError = 'Нет workspace или токена — войдите снова.';
        });
      }
      return;
    }

    setState(() {
      _loadingRefs = true;
      _refsError = null;
    });

    try {
      final h = _fleetHeaders(workspaceId, token);
      final catUri = Uri.parse('$_fleetBase/categories');
      final whUri = Uri.parse('$_fleetBase/warehouse');

      final responses = await Future.wait([
        http.get(catUri, headers: h),
        http.get(whUri, headers: h),
      ]);

      final catRes = responses[0];
      final whRes = responses[1];

      if (catRes.statusCode != 200) {
        throw Exception(
          'Категории: HTTP ${catRes.statusCode} ${catRes.body}',
        );
      }
      if (whRes.statusCode != 200) {
        throw Exception(
          'Склады: HTTP ${whRes.statusCode} ${whRes.body}',
        );
      }

      final catDecoded = json.decode(utf8.decode(catRes.bodyBytes));
      final whDecoded = json.decode(utf8.decode(whRes.bodyBytes));

      final nextCategories = <_NamedId>[];
      if (catDecoded is Map && catDecoded['data'] is List) {
        for (final e in catDecoded['data'] as List) {
          if (e is Map) {
            final id = e['id']?.toString();
            final name = e['name']?.toString() ?? '';
            if (id != null && id.isNotEmpty) {
              nextCategories.add(_NamedId(id, name));
            }
          }
        }
      }
      nextCategories.sort((a, b) => a.name.compareTo(b.name));

      final nextWarehouses = <_NamedId>[];
      if (whDecoded is List) {
        for (final e in whDecoded) {
          if (e is Map) {
            final id = e['id']?.toString();
            final name = e['name']?.toString() ?? '';
            if (id != null && id.isNotEmpty) {
              nextWarehouses.add(_NamedId(id, name));
            }
          }
        }
      }
      nextWarehouses.sort((a, b) => a.name.compareTo(b.name));

      if (!mounted) return;
      setState(() {
        _categories
          ..clear()
          ..addAll(nextCategories);
        _warehouses
          ..clear()
          ..addAll(nextWarehouses);
        if (_categoryId != null &&
            !_categories.any((c) => c.id == _categoryId)) {
          _categoryId = null;
        }
        if (_warehouseId != null &&
            !_warehouses.any((w) => w.id == _warehouseId)) {
          _warehouseId = null;
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _refsError = '$e';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Справочники: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingRefs = false);
    }
  }

  Future<String?> _uploadFileBytes(Uint8List bytes, String filename) async {
    final workspaceId = FFAppState().workspace.trim();
    if (workspaceId.isEmpty) {
      throw Exception('Workspace не выбран.');
    }
    final token = currentAuthenticationToken;
    if (token == null || token.isEmpty) {
      throw Exception('Нет токена авторизации.');
    }

    final uri = Uri.parse('$_fleetBase/object/upload');
    final request = http.MultipartRequest('POST', uri);
    request.headers.addAll({
      'Authorization': token,
      'Workspace': workspaceId,
    });
    request.files.add(
      http.MultipartFile.fromBytes(
        'files',
        bytes,
        filename: filename,
      ),
    );

    final streamed = await request.send();
    final response = await http.Response.fromStream(streamed);
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Загрузка: HTTP ${response.statusCode}: ${response.body}');
    }

    var uploaded = response.body.trim();
    try {
      final decoded = json.decode(response.body);
      if (decoded is List && decoded.isNotEmpty) {
        uploaded = decoded.first.toString();
      } else if (decoded is String) {
        uploaded = decoded;
      }
    } catch (_) {}
    if (uploaded.startsWith('"') && uploaded.endsWith('"')) {
      uploaded = json.decode(uploaded) as String;
    }
    return uploaded.isEmpty ? null : uploaded;
  }

  Future<void> _pickAndUploadPhoto() async {
    final selected = await selectMediaWithSourceBottomSheet(
      context: context,
      maxWidth: 1600,
      maxHeight: 1600,
      imageQuality: 85,
      allowPhoto: true,
    );
    if (selected == null || selected.isEmpty) return;

    setState(() => _uploading = true);
    try {
      final file = selected.first;
      final name = file.storagePath.isNotEmpty
          ? file.storagePath.split('/').last
          : 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final url = await _uploadFileBytes(file.bytes, name);
      if (url != null && mounted) {
        setState(() => _mediaUrls.add(url));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Фото загружено')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    } finally {
      if (mounted) setState(() => _uploading = false);
    }
  }

  int _requiredFilledCount() {
    var n = 0;
    if (_nameCtrl.text.trim().isNotEmpty) n++;
    if (_partNumberCtrl.text.trim().isNotEmpty) n++;
    if (_categoryId != null && _categoryId!.trim().isNotEmpty) n++;
    if (_warehouseId != null && _warehouseId!.trim().isNotEmpty) n++;
    return n;
  }

  Future<void> _submit() async {
    final workspaceId = context.read<FFAppState>().workspace.trim();
    final userId = _resolveUserId();

    if (workspaceId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите workspace в приложении.')),
      );
      return;
    }
    if (userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось определить user_id из профиля.'),
        ),
      );
      return;
    }
    if (_nameCtrl.text.trim().isEmpty ||
        _partNumberCtrl.text.trim().isEmpty ||
        _categoryId == null ||
        _categoryId!.trim().isEmpty ||
        _warehouseId == null ||
        _warehouseId!.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Заполните: наименование, артикул, категорию и склад.',
          ),
        ),
      );
      return;
    }

    final token = currentAuthenticationToken;
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Нет токена авторизации.')),
      );
      return;
    }

    final qty = int.tryParse(_qtyCtrl.text.trim()) ?? 1;
    final oem = List<String>.from(_oemParts);
    final cross = List<String>.from(_crossParts);
    final specs = _buildSpecs();

    final body = <String, dynamic>{
      'workspace_id': workspaceId,
      'user_id': userId,
      'name': _nameCtrl.text.trim(),
      'part_number': _partNumberCtrl.text.trim(),
      'barcode': _emptyToNull(_barcodeCtrl.text),
      'nomenclature_number': _emptyToNull(_nomenclatureNumberCtrl.text),
      'manufacturer': _emptyToNull(_manufacturerCtrl.text),
      'category_id': _categoryId!.trim(),
      'category_custom': _emptyToNull(_categoryCustomCtrl.text),
      'warehouse_id': _warehouseId!.trim(),
      'quantity': qty,
      'condition': _condition,
      'unit_of_measurement': _unitCtrl.text.trim().isEmpty
          ? 'шт'
          : _unitCtrl.text.trim(),
      'row': _emptyToNull(_rowCtrl.text),
      'shelf': _emptyToNull(_shelfCtrl.text),
      'box': _emptyToNull(_boxCtrl.text),
      'location_barcode': _emptyToNull(_locationBarcodeCtrl.text),
      'description': _emptyToNull(_descriptionCtrl.text),
      'min_quantity': _minQtyCtrl.text.trim().isEmpty
          ? null
          : int.tryParse(_minQtyCtrl.text.trim()),
      'code': _emptyToNull(_codeCtrl.text),
      'oem_numbers': oem,
      'cross_numbers': cross,
      'specs': specs,
      'battery_parameters': null,
      'tire_parameters': null,
      'provider': null,
      'price': null,
      'sale_price': null,
      'media': _mediaUrls.isEmpty ? <String>[] : List<String>.from(_mediaUrls),
      'note': _emptyToNull(_noteCtrl.text),
    };

    setState(() => _saving = true);
    try {
      final uri = Uri.parse('$_fleetBase/part-nomenclature/create');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': token,
          'Workspace': workspaceId,
          'Content-Type': 'application/json; charset=utf-8',
        },
        body: utf8.encode(json.encode(body)),
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(
          'HTTP ${response.statusCode}: ${utf8.decode(response.bodyBytes)}',
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Запчасть создана')),
        );
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    final theme = FlutterFlowTheme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: _kScreenBg,
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            color: theme.primaryText,
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          title: Text(
            'Новая карточка',
            style: theme.bodyMedium.copyWith(
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              color: theme.primaryText,
            ),
          ),
          actions: [
            if (_saving)
              const Padding(
                padding: EdgeInsets.all(16),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Material(
                  color: theme.primary,
                  shape: const CircleBorder(),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: _submit,
                    child: const SizedBox(
                      width: 40,
                      height: 40,
                      child: Icon(Icons.check_rounded, color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(52),
            child: _buildTabs(theme),
          ),
        ),
        body: SafeArea(
          top: false,
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    _buildMainPage(theme),
                    _buildReferencePage(theme),
                  ],
                ),
              ),
              _buildBottomSaveBar(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs(FlutterFlowTheme theme) {
    final i = _tabController.index;
    Color tabIconTextColor(bool selected) =>
        selected ? theme.primary : theme.secondaryText;

    return Container(
      color: const Color(0xFFEDEEF2),
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(20),
        indicator: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        tabs: [
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 18,
                  color: tabIconTextColor(i == 0),
                ),
                const SizedBox(width: 6),
                Text(
                  'Основные',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: tabIconTextColor(i == 0),
                  ),
                ),
              ],
            ),
          ),
          Tab(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.sell_outlined,
                  size: 18,
                  color: tabIconTextColor(i == 1),
                ),
                const SizedBox(width: 6),
                Text(
                  'Справочник',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: tabIconTextColor(i == 1),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard({
    required FlutterFlowTheme theme,
    required String title,
    required Widget child,
    IconData? titleIcon,
    bool locationStyle = false,
    List<Widget>? titleActions,
  }) {
    final bg = locationStyle ? _kLocTint : Colors.white;
    final decoration = BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(_kRadius),
      border: locationStyle
          ? Border.all(color: _kLocBorder, width: 1)
          : Border.all(color: Colors.transparent),
      boxShadow: locationStyle
          ? null
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 14,
                offset: const Offset(0, 3),
              ),
            ],
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: decoration,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (titleIcon != null) ...[
                  Icon(titleIcon, color: theme.primary, size: 22),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: theme.bodyMedium.copyWith(
                      fontSize: 15,
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700,
                      color: theme.primaryText,
                    ),
                  ),
                ),
                if (titleActions != null) ...titleActions,
              ],
            ),
            const SizedBox(height: 14),
            child,
          ],
        ),
      ),
    );
  }

  TextStyle _upperLabelStyle(
    FlutterFlowTheme theme, {
    Color? color,
  }) {
    return TextStyle(
      fontSize: 11,
      letterSpacing: 0.55,
      fontWeight: FontWeight.w600,
      color: color ?? theme.secondaryText,
    );
  }

  Widget _buildCatalogDropdown(
    FlutterFlowTheme theme, {
    required String label,
    required String? value,
    required List<_NamedId> items,
    required ValueChanged<String?> onChanged,
    bool requiredField = false,
  }) {
    final effectiveValue =
        value != null && items.any((e) => e.id == value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label.toUpperCase(),
              style: _upperLabelStyle(theme),
            ),
            if (requiredField)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: _kFieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: effectiveValue,
              hint: Text(
                items.isEmpty ? 'Нет вариантов' : 'Выберите',
                style: theme.bodyMedium.copyWith(
                  color: theme.secondaryText.withValues(alpha: 0.65),
                  fontSize: 14,
                ),
              ),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: theme.secondaryText,
              ),
              items: items
                  .map(
                    (e) => DropdownMenuItem<String>(
                      value: e.id,
                      child: Text(
                        e.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.bodyMedium.copyWith(fontSize: 15),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: items.isEmpty ? null : onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    FlutterFlowTheme theme, {
    required String label,
    String? hint,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool requiredField = false,
    Color? labelColor,
    bool locationFieldStyle = false,
  }) {
    final borderColor = locationFieldStyle ? _kLocBorder : _kFieldBorder;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label.toUpperCase(),
              style: _upperLabelStyle(theme, color: labelColor),
            ),
            if (requiredField)
              Text(
                ' *',
                style: TextStyle(
                  color: Colors.red.shade400,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
          ],
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: theme.bodyMedium.copyWith(fontSize: 15),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.bodyMedium.copyWith(
              color: theme.secondaryText.withValues(alpha: 0.55),
              fontSize: 14,
            ),
            filled: true,
            fillColor: Colors.white,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_kRadius),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_kRadius),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(_kRadius),
              borderSide: BorderSide(color: theme.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _scanBarcodeInto(TextEditingController target) async {
    final code = await Navigator.of(context).push<String>(
      MaterialPageRoute(
        builder: (context) => const _BarcodeScannerPage(),
      ),
    );
    if (!mounted || code == null || code.isEmpty) return;
    setState(() {
      target.text = code.trim();
    });
  }

  Widget _buildBarcodeField(
    FlutterFlowTheme theme, {
    required String label,
    String? hint,
    required TextEditingController controller,
    String tooltip = 'Сканировать штрихкод',
    bool locationFieldStyle = false,
    Color? labelColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: _upperLabelStyle(theme, color: labelColor),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                style: theme.bodyMedium.copyWith(fontSize: 15),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: theme.bodyMedium.copyWith(
                    color: theme.secondaryText.withValues(alpha: 0.55),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: BorderSide(
                      color:
                          locationFieldStyle ? _kLocBorder : _kFieldBorder,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: BorderSide(
                      color:
                          locationFieldStyle ? _kLocBorder : _kFieldBorder,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide:
                        BorderSide(color: theme.primary, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Tooltip(
              message: tooltip,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                child: InkWell(
                  onTap: () => _scanBarcodeInto(controller),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 48,
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            locationFieldStyle ? _kLocBorder : _kFieldBorder,
                      ),
                    ),
                    child: Icon(
                      Icons.qr_code_scanner_rounded,
                      color: theme.primary,
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _adjustQty(int delta) {
    final n = int.tryParse(_qtyCtrl.text.trim()) ?? 1;
    final v = (n + delta).clamp(1, 999999);
    setState(() => _qtyCtrl.text = '$v');
  }

  Widget _buildQtyStepper(FlutterFlowTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('КОЛ-ВО', style: _upperLabelStyle(theme)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: _kFieldBorder),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => _adjustQty(-1),
                icon: Icon(Icons.remove_rounded, color: theme.primaryText),
              ),
              Expanded(
                child: Text(
                  _qtyCtrl.text.trim().isEmpty ? '1' : _qtyCtrl.text.trim(),
                  textAlign: TextAlign.center,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => _adjustQty(1),
                icon: Icon(Icons.add_rounded, color: theme.primaryText),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUnitDropdown(FlutterFlowTheme theme) {
    const units = ['шт', 'кг', 'м', 'л', 'компл'];
    var v = _unitCtrl.text.trim();
    if (v.isEmpty || !units.contains(v)) v = 'шт';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ЕД. ИЗМ.', style: _upperLabelStyle(theme)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: _kFieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: v,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: theme.secondaryText),
              items: units
                  .map(
                    (u) => DropdownMenuItem(
                      value: u,
                      child: Text(u, style: theme.bodyMedium),
                    ),
                  )
                  .toList(),
              onChanged: (x) {
                if (x == null) return;
                setState(() => _unitCtrl.text = x);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNextNavCard(
    FlutterFlowTheme theme, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(_kRadius),
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_kRadius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_kRadius),
              border: Border.all(color: _kFieldBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: theme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.chevron_right_rounded,
                      color: theme.primary,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: theme.bodyMedium.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: theme.bodySmall.copyWith(
                            color: theme.secondaryText,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOcrBlock(FlutterFlowTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: theme.primary,
          borderRadius: BorderRadius.circular(_kRadius),
          child: InkWell(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('OCR будет доступен в следующей версии'),
                ),
              );
            },
            borderRadius: BorderRadius.circular(_kRadius),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.camera_alt_outlined,
                      color: Colors.white, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    'Сканировать этикетку (OCR)',
                    style: theme.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '✨ AI распознает артикул, бренд и наименование',
          textAlign: TextAlign.center,
          style: theme.bodySmall.copyWith(
            color: theme.secondaryText,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  void _addOemPart() {
    final t = _oemInputCtrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _oemParts.add(t);
      _oemInputCtrl.clear();
    });
  }

  void _addCrossPart() {
    final t = _crossInputCtrl.text.trim();
    if (t.isEmpty) return;
    setState(() {
      _crossParts.add(t);
      _crossInputCtrl.clear();
    });
  }

  Widget _buildLineListEditor(
    FlutterFlowTheme theme, {
    required TextEditingController input,
    required String hint,
    required VoidCallback onAdd,
    required List<String> items,
    required String emptyText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                controller: input,
                style: theme.bodyMedium.copyWith(fontSize: 15),
                onSubmitted: (_) => onAdd(),
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: theme.bodyMedium.copyWith(
                    color: theme.secondaryText.withValues(alpha: 0.55),
                    fontSize: 14,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: const BorderSide(color: _kFieldBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: const BorderSide(color: _kFieldBorder),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide:
                        BorderSide(color: theme.primary, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Material(
              color: theme.primary,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: onAdd,
                borderRadius: BorderRadius.circular(12),
                child: const SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(Icons.add_rounded, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        if (items.isEmpty)
          Center(
            child: Text(
              emptyText,
              style: theme.bodySmall.copyWith(
                color: theme.secondaryText,
                fontSize: 13,
              ),
            ),
          )
        else
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: items
                .map(
                  (e) => Chip(
                    label: Text(e),
                    onDeleted: () => setState(() => items.remove(e)),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  Widget _buildMainPage(FlutterFlowTheme theme) {
    final locLabel = theme.primary;

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        _buildSectionCard(
          theme: theme,
          title: 'Местоположение',
          titleIcon: Icons.location_on_outlined,
          locationStyle: true,
          titleActions: [
            IconButton(
              icon: Icon(Icons.lock_outline_rounded,
                  color: theme.primary, size: 22),
              onPressed: () {},
              tooltip: 'Ячейка',
            ),
            IconButton(
              icon: Icon(Icons.qr_code_scanner_rounded,
                  color: theme.primary, size: 22),
              onPressed: () => _scanBarcodeInto(_locationBarcodeCtrl),
              tooltip: 'Сканировать штрихкод ячейки',
            ),
          ],
          child: Column(
            children: [
              _buildTextField(
                theme,
                label: 'Зона / ряд',
                hint: 'напр. А-02',
                controller: _rowCtrl,
                labelColor: locLabel,
                locationFieldStyle: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Стеллаж – полка',
                hint: 'напр. ST-04 / Р-12',
                controller: _shelfCtrl,
                labelColor: locLabel,
                locationFieldStyle: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Лоток / ящик',
                hint: 'напр. Bin-15',
                controller: _boxCtrl,
                labelColor: locLabel,
                locationFieldStyle: true,
              ),
              const SizedBox(height: 12),
              _buildBarcodeField(
                theme,
                label: 'Штрихкод ячейки',
                hint: 'EAN / ячейка',
                controller: _locationBarcodeCtrl,
                locationFieldStyle: true,
                labelColor: locLabel,
              ),
            ],
          ),
        ),
        _buildSectionCard(
          theme: theme,
          title: 'Идентификация',
          titleIcon: Icons.qr_code_2_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildOcrBlock(theme),
              const SizedBox(height: 16),
              _buildTextField(
                theme,
                label: 'Артикул',
                hint: 'напр. 708-2L-00300',
                controller: _partNumberCtrl,
                requiredField: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Наименование',
                hint: 'Гидронасос основной',
                controller: _nameCtrl,
                requiredField: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Бренд',
                hint: 'Komatsu',
                controller: _manufacturerCtrl,
              ),
              const SizedBox(height: 12),
              _buildBarcodeField(
                theme,
                label: 'Штрихкод товара',
                hint: 'EAN / UPC',
                controller: _barcodeCtrl,
              ),
            ],
          ),
        ),
        _buildSectionCard(
          theme: theme,
          title: 'Реквизиты номенклатуры',
          titleIcon: Icons.folder_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_loadingRefs)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(child: CircularProgressIndicator()),
                )
              else ...[
                if (_refsError != null) ...[
                  Text(
                    _refsError!,
                    style: theme.bodySmall.copyWith(
                      color: Colors.red.shade700,
                      fontSize: 12,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: _loadCategoriesAndWarehouses,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Обновить'),
                  ),
                  const SizedBox(height: 8),
                ],
                _buildCatalogDropdown(
                  theme,
                  label: 'Категория',
                  value: _categoryId,
                  items: _categories,
                  requiredField: true,
                  onChanged: (v) => setState(() => _categoryId = v),
                ),
                const SizedBox(height: 12),
                _buildCatalogDropdown(
                  theme,
                  label: 'Склад',
                  value: _warehouseId,
                  items: _warehouses,
                  requiredField: true,
                  onChanged: (v) => setState(() => _warehouseId = v),
                ),
                const SizedBox(height: 12),
              ],
              _buildTextField(
                theme,
                label: 'Номер номенклатуры',
                controller: _nomenclatureNumberCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Код',
                controller: _codeCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Описание',
                controller: _descriptionCtrl,
                maxLines: 3,
              ),
            ],
          ),
        ),
        _buildSectionCard(
          theme: theme,
          title: 'Складской факт',
          titleIcon: Icons.inventory_2_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildQtyStepper(theme)),
                  const SizedBox(width: 12),
                  Expanded(flex: 2, child: _buildUnitDropdown(theme)),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Мин. остаток',
                controller: _minQtyCtrl,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),
              Text('СОСТОЯНИЕ', style: _upperLabelStyle(theme)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildConditionChip(theme, 'Новое', 'new'),
                  const SizedBox(width: 8),
                  _buildConditionChip(theme, 'Б/У', 'used'),
                  const SizedBox(width: 8),
                  _buildConditionChip(theme, 'Брак', 'defect'),
                ],
              ),
              const SizedBox(height: 16),
              Text('ФОТО', style: _upperLabelStyle(theme)),
              const SizedBox(height: 8),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _uploading ? null : _pickAndUploadPhoto,
                  borderRadius: BorderRadius.circular(_kRadius),
                  child: Container(
                    width: double.infinity,
                    constraints: const BoxConstraints(minHeight: 120),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_kRadius),
                      color: Colors.white,
                      border: Border.all(
                        color: _kFieldBorder,
                        width: 1.2,
                      ),
                    ),
                    child: _uploading
                        ? const Center(child: CircularProgressIndicator())
                        : _mediaUrls.isEmpty
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_photo_alternate_outlined,
                                      color: theme.secondaryText,
                                      size: 36,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Добавить',
                                      style: theme.bodyMedium.copyWith(
                                        color: theme.secondaryText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8),
                                child: Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: [
                                    ..._mediaUrls.map(
                                      (u) => ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          u,
                                          width: 72,
                                          height: 72,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) =>
                                              Container(
                                            width: 72,
                                            height: 72,
                                            color: theme.alternate,
                                            child: Icon(
                                              Icons.broken_image_outlined,
                                              color: theme.secondaryText,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: _pickAndUploadPhoto,
                                      icon: Icon(
                                        Icons.add_circle_outline,
                                        color: theme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                theme,
                label: 'Примечание',
                hint: 'Заметки кладовщика...',
                controller: _noteCtrl,
                maxLines: 3,
              ),
            ],
          ),
        ),
        _buildNextNavCard(
          theme,
          title: 'Далее: Справочник',
          subtitle: 'OEM-коды, кросс-номера, характеристики',
          onTap: () => _tabController.animateTo(1),
        ),
      ],
    );
  }

  Widget _buildConditionChip(
    FlutterFlowTheme theme,
    String label,
    String value,
  ) {
    final selected = _condition == value;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _condition = value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? _kGreenState : Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? _kGreenState : _kFieldBorder,
            ),
          ),
          child: Text(
            label,
            style: theme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: selected ? Colors.white : theme.primaryText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReferencePage(FlutterFlowTheme theme) {
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        _buildSectionCard(
          theme: theme,
          title: 'OEM номера',
          titleIcon: Icons.local_offer_outlined,
          child: _buildLineListEditor(
            theme,
            input: _oemInputCtrl,
            hint: 'напр. 708-2L-00300',
            onAdd: _addOemPart,
            items: _oemParts,
            emptyText: 'Нет OEM номеров',
          ),
        ),
        _buildSectionCard(
          theme: theme,
          title: 'Кросс-номера / Аналоги',
          titleIcon: Icons.verified_outlined,
          child: _buildLineListEditor(
            theme,
            input: _crossInputCtrl,
            hint: 'напр. Handok HPV102',
            onAdd: _addCrossPart,
            items: _crossParts,
            emptyText: 'Нет кросс-номеров',
          ),
        ),
        _buildSectionCard(
          theme: theme,
          title: 'Характеристики',
          titleIcon: Icons.tune_rounded,
          child: Column(
            children: [
              _buildTextField(
                theme,
                label: 'Масса',
                hint: 'напр. 45 кг',
                controller: _massCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Материал',
                hint: 'Сталь, чугун',
                controller: _materialCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Давление (если применимо)',
                hint: 'напр. 35 МПа',
                controller: _pressureCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                label: 'Расход',
                hint: 'напр. 11',
                controller: _flowCtrl,
              ),
            ],
          ),
        ),
        _buildNextNavCard(
          theme,
          title: 'Далее: сохранение',
          subtitle: 'Проверьте данные и нажмите галочку вверху',
          onTap: () => _tabController.animateTo(0),
        ),
      ],
    );
  }

  Widget _buildBottomSaveBar(FlutterFlowTheme theme) {
    final filled = _requiredFilledCount();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(
          top: BorderSide(color: _kFieldBorder.withValues(alpha: 0.6)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Text(
          'Обязательные: наименование, артикул, категория, склад — $filled/4. Сохранение — кнопка с галочкой сверху.',
          textAlign: TextAlign.center,
          style: theme.bodyMedium.copyWith(
            fontSize: 11.5,
            letterSpacing: 0,
            color: theme.secondaryText,
            height: 1.35,
          ),
        ),
      ),
    );
  }
}

class _BarcodeScannerPage extends StatefulWidget {
  const _BarcodeScannerPage();

  @override
  State<_BarcodeScannerPage> createState() => _BarcodeScannerPageState();
}

class _BarcodeScannerPageState extends State<_BarcodeScannerPage> {
  final MobileScannerController _controller = MobileScannerController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Штрихкод'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop<String>(),
        ),
      ),
      body: MobileScanner(
        controller: _controller,
        onDetect: (capture) {
          for (final b in capture.barcodes) {
            final v = b.rawValue;
            if (v != null && v.isNotEmpty) {
              _controller.stop();
              Navigator.of(context).pop<String>(v);
              return;
            }
          }
        },
      ),
    );
  }
}
