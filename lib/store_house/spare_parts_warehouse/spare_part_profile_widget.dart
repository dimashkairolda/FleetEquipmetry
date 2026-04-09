import 'dart:convert';

import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/store_house/spare_parts_warehouse/spare_part_create_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const String _fleetBase = 'https://fleet.equipmetry.kz/api/v1/workspace';

Future<dynamic> _workspaceGet(String pathAndQuery) async {
  final workspaceId = FFAppState().workspace.trim();
  if (workspaceId.isEmpty) {
    throw Exception('Workspace не выбран в приложении.');
  }
  final uri = Uri.parse('$_fleetBase/$pathAndQuery');
  final response = await http.get(uri, headers: {
    'Authorization': currentAuthenticationToken ?? '',
    'Workspace': workspaceId,
  });
  final bodyStr = utf8.decode(response.bodyBytes);
  if (response.statusCode != 200) {
    throw Exception('HTTP ${response.statusCode}: $bodyStr');
  }
  return json.decode(bodyStr);
}

/// ID номенклатуры для API: сначала из навигации (тот же, что в списке), затем из ответа профиля.
String _resolvePartNomenclatureId(String? routeId, Map<String, dynamic> data) {
  final fromRoute = routeId?.trim();
  if (fromRoute != null && fromRoute.isNotEmpty) return fromRoute;
  final fromData = data['id']?.toString().trim();
  if (fromData != null && fromData.isNotEmpty) return fromData;
  return '';
}

String _fmtCharField(dynamic v) {
  if (v == null) return '—';
  final s = v.toString().trim();
  return s.isEmpty ? '—' : s;
}

String _fmtDateShort(dynamic d) {
  if (d == null) return '—';
  final dt = DateTime.tryParse(d.toString());
  if (dt == null) return d.toString();
  return DateFormat('dd.MM.yyyy').format(dt);
}

String _fmtDateDash(dynamic d) {
  if (d == null) return '—';
  final dt = DateTime.tryParse(d.toString());
  if (dt == null) return d.toString();
  return DateFormat('dd-MM-yyyy').format(dt);
}

class SparePartProfileWidget extends StatefulWidget {
  const SparePartProfileWidget({super.key, this.id});

  final String? id;

  static String routeName = 'sparePartProfile';
  static String routePath = '/sparePartProfile';

  @override
  State<SparePartProfileWidget> createState() => _SparePartProfileWidgetState();
}

class _SparePartProfileWidgetState extends State<SparePartProfileWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;
  Future<Map<String, dynamic>?>? _loadFuture;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _loadFuture = _fetchPart();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> _fetchPart() async {
    final id = widget.id;
    if (id == null || id.isEmpty) return null;
    final workspaceId = FFAppState().workspace.toString();
    final uri = Uri.parse(
      'https://fleet.equipmetry.kz/api/v1/workspace/part-nomenclature/$id',
    );
    final response = await http.get(uri, headers: {
      'Authorization': currentAuthenticationToken ?? '',
      'Workspace': workspaceId,
    });
    if (response.statusCode != 200) return null;
    final decoded = json.decode(utf8.decode(response.bodyBytes));
    if (decoded is! Map) return null;
    final root = Map<String, dynamic>.from(
      decoded.map((k, v) => MapEntry(k.toString(), v)),
    );
    final inner = root['data'];
    if (inner is Map) {
      return Map<String, dynamic>.from(
        inner.map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    if (inner is List && inner.isNotEmpty && inner.first is Map) {
      return Map<String, dynamic>.from(
        (inner.first as Map).map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    return root;
  }

  static String _fmtMoney(num? n, String currency) {
    if (n == null) return 'Не указан';
    final fmt = NumberFormat('#,##0.00', 'ru_RU');
    return '${fmt.format(n)} $currency';
  }

  static String _strOrDash(dynamic v) {
    if (v == null) return 'Не указан';
    final s = v.toString().trim();
    return s.isEmpty ? 'Не указан' : s;
  }

  /// OEM / кросс-номера приходят массивом строк.
  static String _listOrDash(dynamic v) {
    if (v == null) return 'Не указан';
    if (v is List) {
      final parts = v
          .map((e) => e?.toString().trim() ?? '')
          .where((s) => s.isNotEmpty)
          .toList();
      return parts.isEmpty ? 'Не указан' : parts.join(', ');
    }
    return _strOrDash(v);
  }

  static Map<String, dynamic>? _specsMap(Map<String, dynamic> data) {
    final s = data['specs'];
    if (s is! Map) return null;
    return Map<String, dynamic>.from(
      s.map((k, v) => MapEntry(k.toString(), v)),
    );
  }

  static String _descOrEmpty(dynamic v) {
    if (v == null) return 'Не указано';
    final s = v.toString().trim();
    return s.isEmpty ? 'Не указано' : s;
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
      child: FutureBuilder<Map<String, dynamic>?>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: theme.primaryBackground,
              body: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(theme.primaryText),
                ),
              ),
            );
          }

          final data = snapshot.data;
          if (data == null) {
            return Scaffold(
              backgroundColor: theme.primaryBackground,
              appBar: AppBar(
                backgroundColor: theme.secondaryBackground,
                elevation: 0,
                title: Text(
                  'Склад запчастей',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                    'Не удалось загрузить профиль запчасти.',
                    textAlign: TextAlign.center,
                    style: theme.bodyMedium,
                  ),
                ),
              ),
            );
          }

          final name = data['name']?.toString() ?? '—';
          final partNumber = data['part_number']?.toString() ?? '';
          final categoryName = data['category_name']?.toString() ?? '';
          final nomenclatureNumber = data['nomenclature_number']?.toString() ?? '';
          final unit = data['unit']?.toString() ?? 'шт';
          final quantity = data['quantity'];
          final reserved = data['reserved_quantity'];
          final price = data['price'];
          final avg = data['average_price'];
          final currency = data['currency']?.toString() ?? 'KZT';
          final manufacturer = _strOrDash(data['manufacturer']);

          final qtyStr = quantity is num
              ? '${NumberFormat('#,##0', 'ru_RU').format(quantity)} $unit'
              : '—';
          final resStr = reserved is num
              ? '${NumberFormat('#,##0', 'ru_RU').format(reserved)} $unit'
              : '—';
          final partId = _resolvePartNomenclatureId(widget.id, data);

          return Scaffold(
            backgroundColor: theme.primaryBackground,
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverAppBar(
                    pinned: true,
                    floating: false,
                    elevation: 0,
                    backgroundColor: theme.secondaryBackground,
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => context.safePop(),
                    ),
                    title: Text(
                      'Склад запчастей',
                      style: theme.bodyMedium.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Center(
                          child: PopupMenuButton<String>(
                            onSelected: (value) async {
                              if (value != 'edit') return;
                              if (partId.isEmpty) return;
                              final ok = await Navigator.of(context).push<bool>(
                                MaterialPageRoute(
                                  builder: (_) => SparePartCreateCardWidget(
                                    nomenclatureId: partId,
                                  ),
                                ),
                              );
                              if (ok == true && context.mounted) {
                                setState(() {
                                  _loadFuture = _fetchPart();
                                });
                              }
                            },
                            offset: const Offset(0, 44),
                            color: theme.secondaryBackground,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? theme.primary
                                    : const Color(0xFF14181B),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Действие',
                                    style: theme.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                            itemBuilder: (ctx) {
                              if (partId.isEmpty) {
                                return [
                                  PopupMenuItem<String>(
                                    value: 'noop',
                                    enabled: false,
                                    child: Text(
                                      'Нет id для редактирования',
                                      style: theme.bodySmall.copyWith(
                                        color: theme.secondaryText,
                                      ),
                                    ),
                                  ),
                                ];
                              }
                              return [
                                PopupMenuItem<String>(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.edit_outlined,
                                        size: 20,
                                        color: theme.primary,
                                      ),
                                      const SizedBox(width: 10),
                                      Text(
                                        'Редактировать',
                                        style: theme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Container(
                      color: theme.secondaryBackground,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: theme.primaryBackground,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: theme.alternate.withOpacity(0.3),
                                  ),
                                ),
                                child: Icon(
                                  Icons.settings_outlined,
                                  color: theme.primary,
                                  size: 26,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: theme.titleMedium.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8,
                                      runSpacing: 6,
                                      children: [
                                        if (partNumber.isNotEmpty)
                                          _pill(
                                            context,
                                            partNumber,
                                            bg: theme.primaryBackground,
                                            fg: theme.primaryText,
                                          ),
                                        if (categoryName.isNotEmpty)
                                          _pill(
                                            context,
                                            categoryName,
                                            bg: theme.primary.withOpacity(0.12),
                                            fg: theme.primary,
                                          ),
                                        if (nomenclatureNumber.isNotEmpty)
                                          _pill(
                                            context,
                                            nomenclatureNumber,
                                            bg: theme.primaryBackground,
                                            fg: theme.primaryText,
                                            icon: Icons.label_outline,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TabBar(
                            controller: _tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            indicatorColor: theme.primary,
                            labelColor: theme.primary,
                            unselectedLabelColor: theme.secondaryText,
                            labelStyle: theme.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: theme.bodySmall,
                            tabs: const [
                              Tab(text: 'Основные данные'),
                              Tab(text: 'Список складов'),
                              Tab(text: 'Список поставщиков'),
                              Tab(text: 'Список связанных техник'),
                              Tab(text: 'Установленные техники'),
                              Tab(text: 'Номера счетов'),
                              Tab(text: 'Список забронированных техник'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: [
                  _MainDataTab(
                    theme: theme,
                    data: data,
                    qtyStr: qtyStr,
                    resStr: resStr,
                    manufacturer: manufacturer,
                    priceStr: _fmtMoney(
                      price is num ? price : null,
                      currency,
                    ),
                    avgStr: _fmtMoney(
                      avg is num ? avg : null,
                      currency,
                    ),
                    categoryName: categoryName,
                    nomenclatureNumber: nomenclatureNumber,
                  ),
                  _WarehousesTab(partId: partId, theme: theme),
                  _ProvidersTab(partId: partId, theme: theme),
                  _ApplicableModelsTab(partId: partId, theme: theme),
                  _InstalledEquipmentTab(partId: partId, theme: theme),
                  _AccountNumbersTab(partId: partId, theme: theme),
                  _PlaceholderTab(
                    theme: theme,
                    message:
                        'Список забронированных техник: API не подключён.',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _pill(
    BuildContext context,
    String text, {
    required Color bg,
    required Color fg,
    IconData? icon,
  }) {
    final theme = FlutterFlowTheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.alternate.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 14, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: theme.bodySmall.copyWith(
              color: fg,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _MainDataTab extends StatelessWidget {
  const _MainDataTab({
    required this.theme,
    required this.data,
    required this.qtyStr,
    required this.resStr,
    required this.manufacturer,
    required this.priceStr,
    required this.avgStr,
    required this.categoryName,
    required this.nomenclatureNumber,
  });

  final FlutterFlowTheme theme;
  final Map<String, dynamic> data;
  final String qtyStr;
  final String resStr;
  final String manufacturer;
  final String priceStr;
  final String avgStr;
  final String categoryName;
  final String nomenclatureNumber;

  @override
  Widget build(BuildContext context) {
    final success = theme.success;
    final specs = _SparePartProfileWidgetState._specsMap(data);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 720;
          final mainDetails = _card(
            context,
            title: 'ОСНОВНЫЕ ДЕТАЛИ',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kv(
                  context,
                  'Количество на складах',
                  qtyStr,
                  valueColor: success,
                ),
                _kv(
                  context,
                  'Забронированное количество',
                  resStr,
                  valueColor: success,
                ),
                _kv(
                  context,
                  'Минимальный запас',
                  'Не указан',
                  valueMuted: true,
                ),
                _kv(context, 'Категория', categoryName.isEmpty ? '—' : categoryName),
                _kv(
                  context,
                  'Партийный номер',
                  nomenclatureNumber.isEmpty ? '—' : nomenclatureNumber,
                ),
                _kv(
                  context,
                  'Описание',
                  _SparePartProfileWidgetState._descOrEmpty(data['description']),
                  valueMuted:
                      _SparePartProfileWidgetState._descOrEmpty(
                              data['description']) ==
                          'Не указано',
                ),
                _kv(context, 'Производитель', manufacturer,
                    valueMuted: manufacturer == 'Не указан'),
                _kv(context, 'Цена', priceStr),
                _kv(context, 'Средняя цена', avgStr),
                _kv(
                  context,
                  'Штрих код',
                  _SparePartProfileWidgetState._strOrDash(data['barcode']),
                  valueMuted: true,
                ),
                _kv(
                  context,
                  'Кросс номера',
                  _SparePartProfileWidgetState._listOrDash(
                    data['cross_numbers'],
                  ),
                  valueMuted: true,
                ),
                _kv(
                  context,
                  'Код ТНВЭД',
                  _SparePartProfileWidgetState._strOrDash(data['hs_code']),
                  valueMuted: true,
                ),
              ],
            ),
          );

          final identification = _card(
            context,
            title: 'ИДЕНТИФИКАЦИЯ',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionLine(
                  context,
                  'OEM НОМЕРА',
                  _SparePartProfileWidgetState._listOrDash(
                    data['oem_numbers'],
                  ),
                ),
                const SizedBox(height: 12),
                _sectionLine(
                  context,
                  'КРОСС-НОМЕРА / АНАЛОГИ',
                  _SparePartProfileWidgetState._listOrDash(
                    data['cross_numbers'],
                  ),
                ),
                const SizedBox(height: 12),
                _sectionLine(
                  context,
                  'КАТЕГОРИЯ',
                  categoryName.isEmpty ? '—' : categoryName,
                ),
              ],
            ),
          );

          final characteristics = _card(
            context,
            title: 'ХАРАКТЕРИСТИКИ',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _kv(
                  context,
                  'Масса',
                  _fmtCharField(
                    specs?['mass'] ?? data['mass'] ?? data['weight'],
                  ),
                  valueMuted: true,
                ),
                _kv(
                  context,
                  'Материал',
                  _fmtCharField(specs?['material'] ?? data['material']),
                  valueMuted: true,
                ),
                _kv(
                  context,
                  'Давление',
                  _fmtCharField(specs?['pressure'] ?? data['pressure']),
                  valueMuted: true,
                ),
                _kv(
                  context,
                  'Расход',
                  _fmtCharField(
                    specs?['flow'] ??
                        data['flow'] ??
                        data['flow_rate'] ??
                        data['consumption'],
                  ),
                  valueMuted: true,
                ),
              ],
            ),
          );

          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      mainDetails,
                      const SizedBox(height: 12),
                      characteristics,
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      identification,
                    ],
                  ),
                ),
              ],
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              mainDetails,
              const SizedBox(height: 12),
              identification,
              const SizedBox(height: 12),
              characteristics,
            ],
          );
        },
      ),
    );
  }

  Widget _card(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final t = FlutterFlowTheme.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: t.secondaryBackground,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: t.alternate.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: t.bodySmall.copyWith(
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
              color: t.primaryText.withOpacity(0.75),
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Widget _kv(
    BuildContext context,
    String label,
    String value, {
    Color? valueColor,
    bool valueMuted = false,
  }) {
    final t = FlutterFlowTheme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              '$label:',
              style: t.bodySmall.copyWith(color: t.secondaryText),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: t.bodyMedium.copyWith(
                color: valueColor ??
                    (valueMuted ? t.secondaryText : t.primaryText),
                fontWeight:
                    valueColor != null ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLine(
    BuildContext context,
    String upper,
    String value,
  ) {
    final t = FlutterFlowTheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          upper,
          style: t.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: t.secondaryText,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: t.bodyMedium.copyWith(color: t.primaryText),
        ),
      ],
    );
  }
}

String _equipmentShortTitle(Map<String, dynamic>? e) {
  if (e == null) return '—';
  final brand = (e['brand_id'] is Map)
      ? (e['brand_id'] as Map)['name']?.toString()
      : null;
  final model = (e['model_id'] is Map)
      ? (e['model_id'] as Map)['name']?.toString()
      : null;
  final plate = e['license_plate_number']?.toString().trim() ?? '';
  final cls = (e['classification_id'] is Map)
      ? (e['classification_id'] as Map)['name']?.toString()
      : null;
  final bm = <String>[
    if (brand != null && brand.isNotEmpty) brand,
    if (model != null && model.isNotEmpty) model,
  ].join(' ');
  if (bm.isEmpty && plate.isEmpty) return cls ?? 'Техника';
  if (bm.isEmpty) return plate;
  return plate.isEmpty ? bm : '$bm · $plate';
}

String _equipmentBrandModelLine(Map<String, dynamic>? e) {
  if (e == null) return '—';
  final brand = (e['brand_id'] is Map)
      ? (e['brand_id'] as Map)['name']?.toString()
      : null;
  final model = (e['model_id'] is Map)
      ? (e['model_id'] as Map)['name']?.toString()
      : null;
  final bm = <String>[
    if (brand != null && brand.isNotEmpty) brand,
    if (model != null && model.isNotEmpty) model,
  ].join(' ');
  return bm.isEmpty ? '—' : bm;
}

String _equipmentIdLine(Map<String, dynamic>? e) {
  if (e == null) return '';
  final id = e['id']?.toString().trim() ?? e['_id']?.toString().trim() ?? '';
  return id;
}

String _supplierNameFromInstalledRow(Map<String, dynamic> row) {
  final p = row['provider'];
  if (p is Map) {
    final n = p['name']?.toString().trim();
    if (n != null && n.isNotEmpty) return n;
  }
  for (final k in ['supplier_name', 'part_nomenclature_name', 'name']) {
    final s = row[k]?.toString().trim();
    if (s != null && s.isNotEmpty) return s;
  }
  return '—';
}

class _WarehousesTab extends StatefulWidget {
  const _WarehousesTab({required this.partId, required this.theme});

  final String partId;
  final FlutterFlowTheme theme;

  @override
  State<_WarehousesTab> createState() => _WarehousesTabState();
}

class _WarehousesTabState extends State<_WarehousesTab> {
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = widget.partId.isEmpty
        ? Future.error(Exception('Пустой ID номенклатуры'))
        : _workspaceGet(
            'part-nomenclature/${widget.partId}/warehouses?page=1&limit=50',
          );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(widget.theme.primaryText),
            ),
          );
        }
        if (snapshot.hasError) {
          return _tabError(widget.theme, 'Не удалось загрузить склады.');
        }
        final body = snapshot.data;
        final list = (body is Map && body['data'] is List)
            ? body['data'] as List
            : <dynamic>[];
        if (list.isEmpty) {
          return _tabEmpty(widget.theme, 'Склады не найдены.');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final row = list[i] as Map<String, dynamic>;
            final name = row['warehouse_name']?.toString() ?? '—';
            final qty = row['quantity'];
            final unit = row['unit']?.toString() ?? '';
            final qtyStr = qty is num
                ? '${NumberFormat('#,##0', 'ru_RU').format(qty)} $unit'.trim()
                : '—';
            return _listCard(
              context,
              title: name,
              subtitle:
                  '${row['part_number'] ?? ''} · ${row['category_name'] ?? ''}',
              trailing: Text(
                qtyStr,
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ProvidersTab extends StatefulWidget {
  const _ProvidersTab({required this.partId, required this.theme});

  final String partId;
  final FlutterFlowTheme theme;

  @override
  State<_ProvidersTab> createState() => _ProvidersTabState();
}

class _ProvidersTabState extends State<_ProvidersTab> {
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = _workspaceGet(
      'part-nomenclature/${widget.partId}/providers?page=1&limit=50',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(widget.theme.primaryText),
            ),
          );
        }
        if (snapshot.hasError) {
          return _tabError(widget.theme, 'Не удалось загрузить поставщиков.');
        }
        final body = snapshot.data;
        final list = (body is Map && body['data'] is List)
            ? body['data'] as List
            : <dynamic>[];
        if (list.isEmpty) {
          return _tabEmpty(widget.theme, 'Поставщики не найдены.');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final row = list[i] as Map<String, dynamic>;
            final price = row['price'];
            final cur = row['currency']?.toString() ?? 'KZT';
            final priceStr = price is num
                ? '${NumberFormat('#,##0.00', 'ru_RU').format(price)} $cur'
                : '—';
            final dateStr = _fmtDateShort(row['date']);
            return _listCard(
              context,
              title: row['provider_name']?.toString() ?? '—',
              subtitle: '${row['name'] ?? ''} · ${row['part_number'] ?? ''}',
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    priceStr,
                    style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    dateStr,
                    style: FlutterFlowTheme.of(context).bodySmall.copyWith(
                          color: FlutterFlowTheme.of(context).secondaryText,
                        ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class _ApplicableModelsTab extends StatefulWidget {
  const _ApplicableModelsTab({required this.partId, required this.theme});

  final String partId;
  final FlutterFlowTheme theme;

  @override
  State<_ApplicableModelsTab> createState() => _ApplicableModelsTabState();
}

class _ApplicableModelsTabState extends State<_ApplicableModelsTab> {
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = _workspaceGet(
      'part-nomenclature/${widget.partId}/applicable-models',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(widget.theme.primaryText),
            ),
          );
        }
        if (snapshot.hasError) {
          return _tabError(
            widget.theme,
            'Не удалось загрузить связанную технику.',
          );
        }
        final data = snapshot.data;
        final list = data is List
            ? data
            : (data is Map && data['data'] is List)
                ? data['data'] as List
                : <dynamic>[];
        if (list.isEmpty) {
          return _tabEmpty(widget.theme, 'Связанная техника не найдена.');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final row = list[i] as Map<String, dynamic>;
            final sector = (row['sector'] is Map)
                ? (row['sector'] as Map)['title']?.toString()
                : null;
            final col = (row['column'] is Map)
                ? (row['column'] as Map)['title']?.toString()
                : null;
            final subParts = <String>[];
            if (col != null && col.isNotEmpty) subParts.add(col);
            if (sector != null && sector.isNotEmpty) subParts.add(sector);
            final sub = subParts.join(' · ');
            return _listCard(
              context,
              title: _equipmentShortTitle(row),
              subtitle: sub.isEmpty ? '—' : sub,
            );
          },
        );
      },
    );
  }
}

class _InstalledEquipmentTab extends StatefulWidget {
  const _InstalledEquipmentTab({required this.partId, required this.theme});

  final String partId;
  final FlutterFlowTheme theme;

  @override
  State<_InstalledEquipmentTab> createState() =>
      _InstalledEquipmentTabState();
}

class _InstalledEquipmentTabState extends State<_InstalledEquipmentTab> {
  static const List<int> _limitOptions = [10, 25, 50];

  int _page = 1;
  int _limit = 10;
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = _loadPage();
  }

  Future<dynamic> _loadPage() {
    if (widget.partId.isEmpty) {
      return Future.error(Exception('Пустой ID номенклатуры'));
    }
    return _workspaceGet(
      'equipment-item/${widget.partId}?page=$_page&limit=$_limit',
    );
  }

  void _setPage(int p) {
    if (p < 1) return;
    setState(() {
      _page = p;
      _future = _loadPage();
    });
  }

  void _setLimit(int v) {
    if (v == _limit) return;
    setState(() {
      _limit = v;
      _page = 1;
      _future = _loadPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.theme;
    return FutureBuilder<dynamic>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(t.primaryText),
            ),
          );
        }
        if (snapshot.hasError) {
          return _tabError(
            t,
            'Не удалось загрузить установленную технику.',
          );
        }
        final body = snapshot.data;
        final list = (body is Map && body['data'] is List)
            ? body['data'] as List
            : <dynamic>[];
        final countRaw = body is Map ? body['count'] : null;
        final count = countRaw is num
            ? countRaw.toInt()
            : (list.isEmpty ? 0 : list.length);
        if (count == 0 && list.isEmpty) {
          return _tabEmpty(t, 'Установленная техника не найдена.');
        }
        final totalPages = max(1, (count + _limit - 1) ~/ _limit);
        final safePage = min(_page, totalPages);
        if (safePage != _page) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _page = safePage;
                _future = _loadPage();
              });
            }
          });
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(t.primaryText),
            ),
          );
        }
        final from = count == 0 ? 0 : (_page - 1) * _limit + 1;
        final to = min(_page * _limit, count);

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Список Техники',
                      style: t.titleMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Показано',
                      style: t.bodySmall.copyWith(color: t.secondaryText),
                    ),
                    const SizedBox(width: 8),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _limit,
                        items: _limitOptions
                            .map(
                              (n) => DropdownMenuItem(
                                value: n,
                                child: Text('$n'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) {
                          if (v != null) _setLimit(v);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$from - $to из $count',
                      style: t.bodySmall.copyWith(color: t.secondaryText),
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: _page > 1 ? () => _setPage(_page - 1) : null,
                      tooltip: 'Предыдущая страница',
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: _page < totalPages
                          ? () => _setPage(_page + 1)
                          : null,
                      tooltip: 'Следующая страница',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final w = max(
                      720.0,
                      MediaQuery.sizeOf(context).width - 32,
                    );
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: w,
                        height: constraints.maxHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _installedTableHeaderRow(context, t),
                            const Divider(height: 1),
                            Expanded(
                              child: ListView.separated(
                                itemCount: list.length,
                                separatorBuilder: (_, __) => Divider(
                                  height: 1,
                                  color: t.alternate.withOpacity(0.35),
                                ),
                                itemBuilder: (context, i) {
                                  final row =
                                      list[i] as Map<String, dynamic>;
                                  final globalIndex =
                                      (_page - 1) * _limit + i + 1;
                                  return _installedTableDataRow(
                                    context,
                                    t,
                                    row: row,
                                    rowNumber: globalIndex,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: totalPages <= 12
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: _page > 1
                                ? () => _setPage(_page - 1)
                                : null,
                          ),
                          ...List.generate(totalPages, (i) {
                            final p = i + 1;
                            final selected = p == _page;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: InkWell(
                                onTap: () => _setPage(p),
                                customBorder: const CircleBorder(),
                                child: Container(
                                  width: 36,
                                  height: 36,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? t.primary
                                        : t.secondaryBackground,
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: selected
                                          ? t.primary
                                          : t.alternate.withOpacity(0.4),
                                    ),
                                  ),
                                  child: Text(
                                    '$p',
                                    style: t.bodySmall.copyWith(
                                      color: selected
                                          ? t.secondaryBackground
                                          : t.primaryText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: _page < totalPages
                                ? () => _setPage(_page + 1)
                                : null,
                          ),
                        ],
                      )
                    : Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chevron_left),
                            onPressed: _page > 1
                                ? () => _setPage(_page - 1)
                                : null,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '$_page / $totalPages',
                              style: t.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.chevron_right),
                            onPressed: _page < totalPages
                                ? () => _setPage(_page + 1)
                                : null,
                          ),
                        ],
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget _installedTableHeaderRow(BuildContext context, FlutterFlowTheme t) {
  TextStyle hdr() => t.bodySmall.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: 0.4,
        color: t.secondaryText,
      );
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 36, child: Text('№', style: hdr())),
        Expanded(flex: 4, child: Text('ТЕХНИКА', style: hdr())),
        Expanded(flex: 3, child: Text('НАИМЕНОВАНИЕ ОТ ПОСТАВЩИКА', style: hdr())),
        Expanded(flex: 2, child: Text('ГОС НОМЕР', style: hdr())),
        SizedBox(width: 100, child: Text('КОЛИЧЕСТВО', style: hdr())),
        SizedBox(width: 120, child: Text('ДАТА СПИСАНИЯ', style: hdr())),
        Expanded(flex: 2, child: Text('КОММЕНТАРИИ', style: hdr())),
        SizedBox(width: 40, child: Text('', style: hdr())),
      ],
    ),
  );
}

Widget _installedTableDataRow(
  BuildContext context,
  FlutterFlowTheme t, {
  required Map<String, dynamic> row,
  required int rowNumber,
}) {
  final eq = row['equipment'] is Map
      ? row['equipment'] as Map<String, dynamic>
      : null;
  final plate = eq?['license_plate_number']?.toString().trim() ?? '—';
  final qty = row['quantity'];
  final unit = row['unit']?.toString().trim() ?? '';
  final qtyStr = qty is num
      ? '${NumberFormat('#,##0', 'ru_RU').format(qty)}${unit.isNotEmpty ? ' $unit' : ' шт'}'
          .trim()
      : '—';
  final comment = row['comment']?.toString().trim();
  final commentStr = (comment != null && comment.isNotEmpty) ? comment : '—';
  final supplier = _supplierNameFromInstalledRow(row);
  final bm = _equipmentBrandModelLine(eq);
  final idLine = _equipmentIdLine(eq);
  final imgUrl = eq?['avatar']?.toString() ?? eq?['image']?.toString();
  const green = Color(0xFF2E7D32);

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 36,
          child: Text(
            '$rowNumber',
            style: t.bodySmall.copyWith(color: t.secondaryText),
          ),
        ),
        Expanded(
          flex: 4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: (imgUrl != null &&
                        imgUrl.isNotEmpty &&
                        (imgUrl.startsWith('http')))
                    ? Image.network(
                        imgUrl,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => _installedEquipPlaceholder(t),
                      )
                    : _installedEquipPlaceholder(t),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bm,
                      style: t.bodyMedium.copyWith(fontWeight: FontWeight.w600),
                    ),
                    if (idLine.isNotEmpty)
                      Text(
                        idLine,
                        style: t.bodySmall.copyWith(color: t.secondaryText),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            supplier,
            style: t.bodySmall,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(plate, style: t.bodySmall),
        ),
        SizedBox(
          width: 100,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                qtyStr,
                style: t.bodySmall.copyWith(
                  color: green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Text(
            _fmtDateDash(row['date']),
            style: t.bodySmall,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            commentStr,
            style: t.bodySmall.copyWith(color: t.secondaryText),
          ),
        ),
        SizedBox(
          width: 40,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
            icon: Icon(Icons.more_vert, color: t.secondaryText, size: 20),
            onPressed: () {},
            tooltip: 'Действия',
          ),
        ),
      ],
    ),
  );
}

Widget _installedEquipPlaceholder(FlutterFlowTheme t) {
  return Container(
    width: 48,
    height: 48,
    color: t.alternate.withOpacity(0.35),
    alignment: Alignment.center,
    child: Icon(Icons.directions_car, color: t.secondaryText, size: 24),
  );
}

class _AccountNumbersTab extends StatefulWidget {
  const _AccountNumbersTab({required this.partId, required this.theme});

  final String partId;
  final FlutterFlowTheme theme;

  @override
  State<_AccountNumbersTab> createState() => _AccountNumbersTabState();
}

class _AccountNumbersTabState extends State<_AccountNumbersTab> {
  late Future<dynamic> _future;

  @override
  void initState() {
    super.initState();
    _future = _workspaceGet(
      'account-numbers/${widget.partId}?page=1&limit=50',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(widget.theme.primaryText),
            ),
          );
        }
        if (snapshot.hasError) {
          return _tabError(widget.theme, 'Не удалось загрузить номера счетов.');
        }
        final body = snapshot.data;
        final list = (body is Map && body['data'] is List)
            ? body['data'] as List
            : <dynamic>[];
        if (list.isEmpty) {
          return _tabEmpty(widget.theme, 'Счета не найдены.');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, i) {
            final row = list[i] as Map<String, dynamic>;
            final prov = row['provider'] is Map
                ? (row['provider'] as Map)['name']?.toString()
                : null;
            final wh = row['warehouse'] is Map
                ? (row['warehouse'] as Map)['name']?.toString()
                : null;
            final acc = row['account_number']?.toString();
            final amount = row['amount'];
            final cur = row['currency']?.toString() ?? 'KZT';
            final amtStr = amount is num
                ? '${NumberFormat('#,##0.00', 'ru_RU').format(amount)} $cur'
                : '—';
            final sub = [
              if (prov != null && prov.isNotEmpty) prov,
              if (wh != null && wh.isNotEmpty) wh,
              'Кол-во: ${row['quantity'] ?? '—'}',
            ].join(' · ');
            return _listCard(
              context,
              title: (acc == null || acc.isEmpty) ? '—' : acc,
              subtitle: '${_fmtDateShort(row['date'] ?? row['invoice_date'])} · $sub',
              trailing: Text(
                amtStr,
                style: FlutterFlowTheme.of(context).bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}

Widget _listCard(
  BuildContext context, {
  required String title,
  required String subtitle,
  Widget? trailing,
}) {
  final t = FlutterFlowTheme.of(context);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: t.secondaryBackground,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: t.alternate.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: t.bodyMedium.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: t.bodySmall.copyWith(color: t.secondaryText),
              ),
            ],
          ),
        ),
        if (trailing != null) ...[
          const SizedBox(width: 8),
          trailing,
        ],
      ],
    ),
  );
}

Widget _tabEmpty(FlutterFlowTheme theme, String text) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.bodyMedium.copyWith(color: theme.secondaryText),
      ),
    ),
  );
}

Widget _tabError(FlutterFlowTheme theme, String text) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: theme.bodyMedium.copyWith(color: theme.error),
      ),
    ),
  );
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.theme, required this.message});

  final FlutterFlowTheme theme;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: theme.bodyMedium.copyWith(color: theme.secondaryText),
        ),
      ),
    );
  }
}
