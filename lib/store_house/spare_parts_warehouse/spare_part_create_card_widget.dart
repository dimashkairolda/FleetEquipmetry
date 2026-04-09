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

/// Цвета экрана создания/редактирования: светлая и тёмная тема.
class _SpareCreatePalette {
  _SpareCreatePalette._({
    required this.screenBg,
    required this.locTint,
    required this.locBorder,
    required this.fieldBorder,
    required this.surface,
    required this.tabBarBg,
    required this.tabIndicator,
    required this.cardShadowA,
    required this.navCardShadowA,
    required this.unselectedChipBg,
    required this.bottomBarDividerA,
  });

  factory _SpareCreatePalette.of(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDark) {
      return _SpareCreatePalette._(
        screenBg: const Color(0xFF0E1114),
        locTint: const Color(0xFF152A38),
        locBorder: const Color(0xFF2D6A94),
        fieldBorder: const Color(0xFF3D4450),
        surface: const Color(0xFF1A1F26),
        tabBarBg: const Color(0xFF13161A),
        tabIndicator: const Color(0xFF242B35),
        cardShadowA: 0.4,
        navCardShadowA: 0.25,
        unselectedChipBg: const Color(0xFF1A1F26),
        bottomBarDividerA: 0.35,
      );
    }
    return _SpareCreatePalette._(
      screenBg: _kScreenBg,
      locTint: _kLocTint,
      locBorder: _kLocBorder,
      fieldBorder: _kFieldBorder,
      surface: Colors.white,
      tabBarBg: const Color(0xFFEDEEF2),
      tabIndicator: Colors.white,
      cardShadowA: 0.05,
      navCardShadowA: 0.04,
      unselectedChipBg: Colors.white,
      bottomBarDividerA: 0.6,
    );
  }

  final Color screenBg;
  final Color locTint;
  final Color locBorder;
  final Color fieldBorder;
  final Color surface;
  final Color tabBarBg;
  final Color tabIndicator;
  final double cardShadowA;
  final double navCardShadowA;
  final Color unselectedChipBg;
  final double bottomBarDividerA;
}

class _NamedId {
  const _NamedId(this.id, this.name);
  final String id;
  final String name;
}

/// Одна строка: поставщик, кол-во, ед. изм., цена закупа и продажи.
class _PurchaseLineRow {
  _PurchaseLineRow()
      : quantityCtrl = TextEditingController(text: '1'),
        purchasePriceCtrl = TextEditingController(),
        salePriceCtrl = TextEditingController();

  Map<String, dynamic>? providerSnapshot;
  String unitTitle = 'шт';
  final TextEditingController quantityCtrl;
  final TextEditingController purchasePriceCtrl;
  final TextEditingController salePriceCtrl;

  void dispose() {
    quantityCtrl.dispose();
    purchasePriceCtrl.dispose();
    salePriceCtrl.dispose();
  }
}

class SparePartCreateCardWidget extends StatefulWidget {
  const SparePartCreateCardWidget({
    super.key,
    this.nomenclatureId,
    this.initialBarcode,
  });

  /// Если задан — режим редактирования (GET + PUT …/part-nomenclature/{id}).
  final String? nomenclatureId;

  /// Предзаполнение поля «Штрихкод товара» при создании (например после сканирования в шлюзе).
  final String? initialBarcode;

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

  final List<_PurchaseLineRow> _purchaseLines = [];
  final List<_NamedId> _uomItems = [];
  final List<Map<String, dynamic>> _counterpartyPreview = [];
  bool _loadingPurchaseRefs = false;
  String? _purchaseRefsError;

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
  bool _loadingExistingPart = false;
  /// Цена с сервера — уходит в PUT при редактировании (в форме поля нет).
  num? _editPrice;

  bool get _isEdit {
    final id = widget.nomenclatureId?.trim();
    return id != null && id.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    if (!_isEdit) {
      final b = widget.initialBarcode?.trim();
      if (b != null && b.isNotEmpty) {
        _barcodeCtrl.text = b;
      }
    }
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (mounted) setState(() {});
    });
    _purchaseLines.add(_PurchaseLineRow());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.wait([
        _loadCategoriesAndWarehouses(),
        _loadPurchaseRefs(),
      ]);
      if (mounted && _isEdit) {
        await _loadExistingPartForEdit();
      }
    });
  }

  @override
  void dispose() {
    for (final r in _purchaseLines) {
      r.dispose();
    }
    _purchaseLines.clear();
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

  List<String> _stringListFromField(dynamic v) {
    if (v == null) return [];
    if (v is List) {
      return v.map((e) => e?.toString().trim() ?? '').where((s) => s.isNotEmpty).toList();
    }
    final s = v.toString().trim();
    if (s.isEmpty) return [];
    return s.split(RegExp(r'[,;\n]+')).map((e) => e.trim()).where((e) => e.isNotEmpty).toList();
  }

  Future<void> _loadExistingPartForEdit() async {
    final id = widget.nomenclatureId!.trim();
    final workspaceId = FFAppState().workspace.trim();
    final token = currentAuthenticationToken;
    if (workspaceId.isEmpty || token == null || token.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Нет workspace или токена.')),
        );
      }
      return;
    }

    setState(() => _loadingExistingPart = true);
    try {
      final uri = Uri.parse('$_fleetBase/part-nomenclature/$id');
      final response = await http.get(
        uri,
        headers: _fleetHeaders(workspaceId, token),
      );
      if (response.statusCode != 200) {
        throw Exception('HTTP ${response.statusCode}: ${utf8.decode(response.bodyBytes)}');
      }
      final decoded = json.decode(utf8.decode(response.bodyBytes));
      Map<String, dynamic>? d;
      if (decoded is Map) {
        final inner = decoded['data'];
        if (inner is Map) {
          d = Map<String, dynamic>.from(
            inner.map((k, v) => MapEntry(k.toString(), v)),
          );
        } else if (inner is List && inner.isNotEmpty) {
          final first = inner.first;
          if (first is Map) {
            d = Map<String, dynamic>.from(
              first.map((k, v) => MapEntry(k.toString(), v)),
            );
          }
        } else {
          d = Map<String, dynamic>.from(
            decoded.map((k, v) => MapEntry(k.toString(), v)),
          );
        }
      }
      if (d == null) throw Exception('Пустой ответ');
      final m = d;

      if (!mounted) return;
      _populatePurchaseLinesFromMap(m);
      setState(() {
        _rowCtrl.text = m['row']?.toString() ?? '';
        _shelfCtrl.text = m['shelf']?.toString() ?? '';
        _boxCtrl.text = m['box']?.toString() ?? '';
        _locationBarcodeCtrl.text = m['location_barcode']?.toString() ?? '';
        _partNumberCtrl.text = m['part_number']?.toString() ?? '';
        _nameCtrl.text = m['name']?.toString() ?? '';
        _manufacturerCtrl.text = m['manufacturer']?.toString() ?? '';
        _barcodeCtrl.text = m['barcode']?.toString() ?? '';

        String? catId = m['category_id']?.toString();
        if ((catId == null || catId.isEmpty) && m['category'] is Map) {
          catId = (m['category'] as Map)['id']?.toString();
        }
        _categoryId = catId;

        String? whId = m['warehouse_id']?.toString();
        if ((whId == null || whId.isEmpty) && m['warehouse'] is Map) {
          whId = (m['warehouse'] as Map)['id']?.toString();
        }
        if ((whId == null || whId.isEmpty) && m['warehouses'] is List) {
          final wl = m['warehouses'] as List;
          if (wl.isNotEmpty && wl.first is Map) {
            whId = (wl.first as Map)['id']?.toString();
          } else if (wl.isNotEmpty) {
            whId = wl.first?.toString();
          }
        }
        _warehouseId = whId;

        final q = m['quantity'];
        if (q is num) {
          _qtyCtrl.text = '${q.toInt()}';
        } else {
          _qtyCtrl.text = q?.toString().isNotEmpty == true ? q.toString() : '1';
        }

        final u = m['unit_of_measurement'] ?? m['unit'];
        _unitCtrl.text = u?.toString().trim().isNotEmpty == true ? u.toString() : 'шт';

        _condition = m['condition']?.toString().trim().isNotEmpty == true
            ? m['condition'].toString()
            : 'new';

        _nomenclatureNumberCtrl.text = m['nomenclature_number']?.toString() ?? '';
        _codeCtrl.text = m['code']?.toString() ?? '';
        _descriptionCtrl.text = m['description']?.toString() ?? '';
        final mq = m['min_quantity'];
        if (mq is num) {
          _minQtyCtrl.text = '${mq.toInt()}';
        } else {
          _minQtyCtrl.text = mq?.toString() ?? '';
        }

        _categoryCustomCtrl.text = m['category_custom']?.toString() ?? '';

        _oemParts
          ..clear()
          ..addAll(_stringListFromField(m['oem_numbers']));
        _crossParts
          ..clear()
          ..addAll(_stringListFromField(m['cross_numbers']));

        Map<String, dynamic>? specMap;
        final specsRaw = m['specs'];
        if (specsRaw is Map) {
          specMap = Map<String, dynamic>.from(
            specsRaw.map((k, v) => MapEntry(k.toString(), v)),
          );
        }
        if (specMap != null) {
          _massCtrl.text = specMap['mass']?.toString() ?? '';
          _materialCtrl.text = specMap['material']?.toString() ?? '';
          _pressureCtrl.text = specMap['pressure']?.toString() ?? '';
          _flowCtrl.text = specMap['flow']?.toString() ?? '';
        } else {
          _massCtrl.text = m['mass']?.toString() ?? m['weight']?.toString() ?? '';
          _materialCtrl.text = m['material']?.toString() ?? '';
          _pressureCtrl.text = m['pressure']?.toString() ?? '';
          _flowCtrl.text = m['flow']?.toString() ??
              m['flow_rate']?.toString() ??
              m['consumption']?.toString() ??
              '';
        }

        _mediaUrls.clear();
        final media = m['media'];
        if (media is List) {
          for (final e in media) {
            final url = e?.toString().trim();
            if (url != null && url.isNotEmpty) _mediaUrls.add(url);
          }
        }

        _noteCtrl.text = m['note']?.toString() ?? '';

        final pr = m['price'];
        if (pr is num) {
          _editPrice = pr;
        } else if (pr != null) {
          _editPrice = num.tryParse(pr.toString());
        } else {
          _editPrice = null;
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Не удалось загрузить запчасть: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _loadingExistingPart = false);
    }
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

  Future<void> _loadPurchaseRefs() async {
    final workspaceId = FFAppState().workspace.trim();
    final token = currentAuthenticationToken;
    if (workspaceId.isEmpty || token == null || token.isEmpty) {
      return;
    }

    setState(() {
      _loadingPurchaseRefs = true;
      _purchaseRefsError = null;
    });

    try {
      final h = _fleetHeaders(workspaceId, token);
      final uomUri =
          Uri.parse('$_fleetBase/unit-of-measurement?workspace_id=$workspaceId');
      var cpUri = Uri.parse(
        '$_fleetBase/counterparty/preview?workspace_id=$workspaceId&type=PROVIDER',
      );

      final uomRes = await http.get(uomUri, headers: h);
      var cpRes = await http.get(cpUri, headers: h);
      if (cpRes.statusCode != 200) {
        cpUri = Uri.parse(
          '$_fleetBase/counterparty/preview?workspace_id=$workspaceId',
        );
        cpRes = await http.get(cpUri, headers: h);
      }

      final nextUom = <_NamedId>[];
      if (uomRes.statusCode == 200) {
        final dec = json.decode(utf8.decode(uomRes.bodyBytes));
        final list = dec is List
            ? dec
            : (dec is Map && dec['data'] is List ? dec['data'] as List : []);
        for (final e in list) {
          if (e is Map) {
            final id = e['id']?.toString();
            final title = e['title']?.toString() ?? '';
            if (id != null && id.isNotEmpty && title.isNotEmpty) {
              nextUom.add(_NamedId(id, title));
            }
          }
        }
        nextUom.sort((a, b) => a.name.compareTo(b.name));
      }

      final nextCp = <Map<String, dynamic>>[];
      if (cpRes.statusCode == 200) {
        final dec = json.decode(utf8.decode(cpRes.bodyBytes));
        final list = dec is List
            ? dec
            : (dec is Map && dec['data'] is List ? dec['data'] as List : []);
        for (final e in list) {
          if (e is Map) {
            nextCp.add(
              Map<String, dynamic>.from(
                e.map((k, v) => MapEntry(k.toString(), v)),
              ),
            );
          }
        }
      }

      if (!mounted) return;
      setState(() {
        _uomItems
          ..clear()
          ..addAll(nextUom);
        _counterpartyPreview
          ..clear()
          ..addAll(nextCp);
      });
    } catch (e) {
      if (mounted) {
        setState(() => _purchaseRefsError = '$e');
      }
    } finally {
      if (mounted) setState(() => _loadingPurchaseRefs = false);
    }
  }

  void _disposePurchaseLines() {
    for (final r in _purchaseLines) {
      r.dispose();
    }
    _purchaseLines.clear();
  }

  void _populatePurchaseLinesFromMap(Map<String, dynamic> m) {
    _disposePurchaseLines();
    final purch = m['purchases'];
    if (purch is List && purch.isNotEmpty) {
      for (final raw in purch) {
        if (raw is! Map) continue;
        final line = _PurchaseLineRow();
        final prov = raw['provider'];
        if (prov is Map) {
          line.providerSnapshot = Map<String, dynamic>.from(
            prov.map((k, v) => MapEntry(k.toString(), v)),
          );
        }
        final q = raw['quantity'];
        line.quantityCtrl.text =
            q is num ? '${q.toInt()}' : (q?.toString() ?? '1');
        final u = raw['unit_of_measurement']?.toString().trim();
        line.unitTitle =
            u != null && u.isNotEmpty ? u : 'шт';
        line.purchasePriceCtrl.text = raw['price']?.toString() ?? '';
        line.salePriceCtrl.text = raw['sale_price']?.toString() ?? '';
        _purchaseLines.add(line);
      }
    }
    if (m['provider'] is Map && _purchaseLines.isEmpty) {
      final line = _PurchaseLineRow();
      line.providerSnapshot = Map<String, dynamic>.from(
        (m['provider'] as Map).map((k, v) => MapEntry(k.toString(), v)),
      );
      line.quantityCtrl.text = '1';
      final u = m['unit_of_measurement']?.toString().trim();
      line.unitTitle = u != null && u.isNotEmpty ? u : 'шт';
      line.purchasePriceCtrl.text = m['price']?.toString() ?? '';
      line.salePriceCtrl.text = m['sale_price']?.toString() ?? '';
      _purchaseLines.add(line);
    }
    if (_purchaseLines.isEmpty) {
      _purchaseLines.add(_PurchaseLineRow());
    }
  }

  num? _parsePriceField(String s) {
    final t = s.trim().replaceAll(' ', '').replaceAll(',', '.');
    if (t.isEmpty) return null;
    return num.tryParse(t);
  }

  List<Map<String, dynamic>> _buildPurchasePayloads() {
    final units = _unitTitlesForPurchasePicker();
    final out = <Map<String, dynamic>>[];
    for (final line in _purchaseLines) {
      final snap = line.providerSnapshot;
      if (snap == null || snap['id'] == null) continue;
      final q = int.tryParse(line.quantityCtrl.text.trim()) ?? 1;
      final pt = _parsePriceField(line.purchasePriceCtrl.text);
      final st = _parsePriceField(line.salePriceCtrl.text);
      final rawU = line.unitTitle.trim();
      final u = rawU.isNotEmpty && units.contains(rawU)
          ? rawU
          : (units.isNotEmpty ? units.first : 'шт');
      out.add(<String, dynamic>{
        'provider': snap,
        'quantity': q,
        'unit_of_measurement': u,
        'price': pt,
        'sale_price': st,
      });
    }
    return out;
  }

  void _addPurchaseLine() {
    setState(() => _purchaseLines.add(_PurchaseLineRow()));
  }

  void _removePurchaseLineAt(int index) {
    if (_purchaseLines.length <= 1) return;
    setState(() {
      final r = _purchaseLines.removeAt(index);
      r.dispose();
    });
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
    if (!_isEdit &&
        _warehouseId != null &&
        _warehouseId!.trim().isNotEmpty) {
      n++;
    }
    return n;
  }

  int get _requiredTotalFields => _isEdit ? 3 : 4;

  Future<void> _submit() async {
    final workspaceId = context.read<FFAppState>().workspace.trim();
    final userId = _resolveUserId();

    if (workspaceId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите workspace в приложении.')),
      );
      return;
    }
    if (!_isEdit && userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Не удалось определить user_id из профиля.'),
        ),
      );
      return;
    }
    if (_isEdit) {
      if (_nameCtrl.text.trim().isEmpty ||
          _partNumberCtrl.text.trim().isEmpty ||
          _categoryId == null ||
          _categoryId!.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Заполните: наименование, артикул и категорию.',
            ),
          ),
        );
        return;
      }
    } else if (_nameCtrl.text.trim().isEmpty ||
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
    final purchasePayloads = _buildPurchasePayloads();

    final Object body;
    if (_isEdit) {
      final cc = _emptyToNull(_categoryCustomCtrl.text);
      final mq = _minQtyCtrl.text.trim().isEmpty
          ? null
          : int.tryParse(_minQtyCtrl.text.trim());
      final editMap = <String, dynamic>{
        'name': _nameCtrl.text.trim(),
        'part_number': _partNumberCtrl.text.trim(),
        'unit': _unitCtrl.text.trim().isEmpty ? 'шт' : _unitCtrl.text.trim(),
        'quantity': qty,
        'category_id': _categoryId!.trim(),
        'category_custom': cc,
        'description': _descriptionCtrl.text,
        'min_quantity': mq,
        'nomenclature_number': _nomenclatureNumberCtrl.text,
        'manufacturer': _manufacturerCtrl.text.trim(),
        'price': purchasePayloads.isNotEmpty
            ? (purchasePayloads.first['price'] as num?) ?? _editPrice ?? 0
            : (_editPrice ?? 0),
        'barcode': _barcodeCtrl.text,
        'cross_numbers': cross,
        'code': _emptyToNull(_codeCtrl.text),
        'battery_parameters': null,
        'tire_parameters': null,
        'workspace_id': workspaceId,
      };
      if (purchasePayloads.isNotEmpty) {
        editMap['provider'] = purchasePayloads.first['provider'];
        editMap['sale_price'] = purchasePayloads.first['sale_price'];
        if (purchasePayloads.length > 1) {
          editMap['purchases'] = purchasePayloads;
        }
      }
      body = editMap;
    } else {
      final createMap = <String, dynamic>{
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
      if (purchasePayloads.isNotEmpty) {
        createMap['provider'] = purchasePayloads.first['provider'];
        createMap['price'] = purchasePayloads.first['price'];
        createMap['sale_price'] = purchasePayloads.first['sale_price'];
        if (purchasePayloads.length > 1) {
          createMap['purchases'] = purchasePayloads;
        }
      }
      body = createMap;
    }

    setState(() => _saving = true);
    try {
      final http.Response response;
      if (_isEdit) {
        final id = widget.nomenclatureId!.trim();
        final uri = Uri.parse('$_fleetBase/part-nomenclature/$id');
        response = await http.put(
          uri,
          headers: {
            'Authorization': token,
            'Workspace': workspaceId,
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: utf8.encode(json.encode(body)),
        );
      } else {
        final uri = Uri.parse('$_fleetBase/part-nomenclature/create');
        response = await http.post(
          uri,
          headers: {
            'Authorization': token,
            'Workspace': workspaceId,
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: utf8.encode(json.encode(body)),
        );
      }
      final okCreate = response.statusCode == 200 || response.statusCode == 201;
      final okUpdate =
          response.statusCode == 200 || response.statusCode == 204;
      if (_isEdit ? !okUpdate : !okCreate) {
        throw Exception(
          'HTTP ${response.statusCode}: ${utf8.decode(response.bodyBytes)}',
        );
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_isEdit ? 'Запчасть обновлена' : 'Запчасть создана'),
          ),
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
    // Не форсировать тёмную схему: следовать теме приложения / системы.
    final appBrightness = Theme.of(context).brightness;
    final shellColorScheme = ColorScheme.fromSeed(
      seedColor: theme.primary,
      brightness: appBrightness,
    );

    return Theme(
      data: ThemeData(
        brightness: appBrightness,
        colorScheme: shellColorScheme,
        useMaterial3: true,
        scaffoldBackgroundColor: shellColorScheme.surface,
        dividerColor: shellColorScheme.outline.withValues(alpha: 0.35),
      ),
      child: Builder(
        builder: (innerContext) {
          final pal = _SpareCreatePalette.of(innerContext);
          final onSurf = shellColorScheme.onSurface;

          return GestureDetector(
            onTap: () {
              FocusScope.of(innerContext).unfocus();
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Scaffold(
              backgroundColor: pal.screenBg,
              appBar: AppBar(
                backgroundColor: shellColorScheme.surface,
                foregroundColor: onSurf,
                surfaceTintColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: onSurf),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  color: onSurf,
                  onPressed: () => Navigator.of(innerContext).pop(),
                ),
                centerTitle: true,
                title: Text(
                  _isEdit ? 'Редактирование' : 'Новая карточка',
                  style: theme.bodyMedium.copyWith(
                    fontSize: 18.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600,
                    color: onSurf,
                  ),
                ),
          actions: [
            if (_saving)
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: theme.primary,
                  ),
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
            child: _buildTabs(theme, pal, shellColorScheme),
          ),
        ),
        body: Stack(
          children: [
            SafeArea(
              top: false,
              child: Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildMainPage(theme, pal),
                        _buildReferencePage(theme, pal),
                      ],
                    ),
                  ),
                  _buildBottomSaveBar(theme, pal),
                ],
              ),
            ),
            if (_loadingExistingPart)
              Container(
                color: pal.screenBg.withValues(alpha: 0.85),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: theme.primary),
                      const SizedBox(height: 16),
                      Text(
                        'Загрузка запчасти…',
                        style: theme.bodyMedium.copyWith(
                          color: shellColorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabs(
    FlutterFlowTheme theme,
    _SpareCreatePalette pal,
    ColorScheme scheme,
  ) {
    final i = _tabController.index;
    Color tabIconTextColor(bool selected) =>
        selected ? theme.primary : scheme.onSurfaceVariant;

    return Container(
      color: pal.tabBarBg,
      padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
      child: TabBar(
        controller: _tabController,
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        dividerColor: Colors.transparent,
        splashBorderRadius: BorderRadius.circular(20),
        indicator: BoxDecoration(
          color: pal.tabIndicator,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: pal.cardShadowA * 0.24),
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
    required _SpareCreatePalette pal,
    required String title,
    required Widget child,
    IconData? titleIcon,
    bool locationStyle = false,
    List<Widget>? titleActions,
  }) {
    final bg = locationStyle ? pal.locTint : pal.surface;
    final decoration = BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(_kRadius),
      border: locationStyle
          ? Border.all(color: pal.locBorder, width: 1)
          : Border.all(color: Colors.transparent),
      boxShadow: locationStyle
          ? null
          : [
              BoxShadow(
                color: Colors.black.withValues(alpha: pal.cardShadowA),
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
    FlutterFlowTheme theme,
    _SpareCreatePalette pal, {
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
            color: pal.surface,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: pal.fieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: effectiveValue,
              dropdownColor: pal.surface,
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
    FlutterFlowTheme theme,
    _SpareCreatePalette pal, {
    required String label,
    String? hint,
    required TextEditingController controller,
    int maxLines = 1,
    TextInputType? keyboardType,
    bool requiredField = false,
    Color? labelColor,
    bool locationFieldStyle = false,
  }) {
    final borderColor = locationFieldStyle ? pal.locBorder : pal.fieldBorder;
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
            fillColor: pal.surface,
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
    FlutterFlowTheme theme,
    _SpareCreatePalette pal, {
    required String label,
    String? hint,
    required TextEditingController controller,
    String tooltip = 'Сканировать штрихкод',
    bool locationFieldStyle = false,
    Color? labelColor,
  }) {
    final borderSideColor =
        locationFieldStyle ? pal.locBorder : pal.fieldBorder;
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
                  fillColor: pal.surface,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: BorderSide(color: borderSideColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: BorderSide(color: borderSideColor),
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
                color: pal.surface,
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
                      border: Border.all(color: borderSideColor),
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

  Widget _buildQtyStepper(FlutterFlowTheme theme, _SpareCreatePalette pal) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('КОЛ-ВО', style: _upperLabelStyle(theme)),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: pal.surface,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: pal.fieldBorder),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () => _adjustQty(-1),
                icon: Icon(Icons.remove_rounded, color: theme.primaryText),
              ),
              Expanded(
                child: TextField(
                  controller: _qtyCtrl,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    border: InputBorder.none,
                  ),
                  onChanged: (_) {
                    if (mounted) setState(() {});
                  },
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

  Widget _buildUnitDropdown(FlutterFlowTheme theme, _SpareCreatePalette pal) {
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
            color: pal.surface,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: pal.fieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: v,
              isExpanded: true,
              dropdownColor: pal.surface,
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
    FlutterFlowTheme theme,
    _SpareCreatePalette pal, {
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: pal.surface,
        borderRadius: BorderRadius.circular(_kRadius),
        elevation: 0,
        shadowColor: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(_kRadius),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_kRadius),
              border: Border.all(color: pal.fieldBorder),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: pal.navCardShadowA),
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
    FlutterFlowTheme theme,
    _SpareCreatePalette pal, {
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
                  fillColor: pal.surface,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 14,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: BorderSide(color: pal.fieldBorder),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_kRadius),
                    borderSide: BorderSide(color: pal.fieldBorder),
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
                    label: Text(e, style: theme.bodySmall),
                    backgroundColor: pal.surface,
                    side: BorderSide(color: pal.fieldBorder),
                    onDeleted: () => setState(() => items.remove(e)),
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  List<String> _unitTitlesForPurchasePicker() {
    if (_uomItems.isNotEmpty) {
      return _uomItems.map((e) => e.name).toList();
    }
    return const ['шт', 'кг', 'м', 'л', 'компл'];
  }

  Widget _buildPurchaseUomDropdown(
    FlutterFlowTheme theme,
    _SpareCreatePalette pal,
    _PurchaseLineRow line,
  ) {
    final units = _unitTitlesForPurchasePicker();
    final raw = line.unitTitle.trim();
    final v =
        raw.isNotEmpty && units.contains(raw) ? raw : units.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('ЕД. ИЗМ.', style: _upperLabelStyle(theme)),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: pal.surface,
            borderRadius: BorderRadius.circular(_kRadius),
            border: Border.all(color: pal.fieldBorder),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: v,
              isExpanded: true,
              dropdownColor: pal.surface,
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
                setState(() => line.unitTitle = x);
              },
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<String>> _supplierDropdownItems(
    _PurchaseLineRow line,
  ) {
    final seen = <String>{};
    final items = <DropdownMenuItem<String>>[];
    for (final c in _counterpartyPreview) {
      final id = c['id']?.toString();
      if (id == null || id.isEmpty || seen.contains(id)) continue;
      seen.add(id);
      items.add(
        DropdownMenuItem<String>(
          value: id,
          child: Text(
            c['title']?.toString() ?? '—',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    final snap = line.providerSnapshot;
    final sid = snap?['id']?.toString();
    if (sid != null && sid.isNotEmpty && !seen.contains(sid) && snap != null) {
      items.add(
        DropdownMenuItem<String>(
          value: sid,
          child: Text(
            snap['title']?.toString() ?? sid,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      );
    }
    return items;
  }

  Widget _buildPurchaseLineCard(
    FlutterFlowTheme theme,
    _SpareCreatePalette pal,
    int index,
  ) {
    final line = _purchaseLines[index];
    final pid = line.providerSnapshot?['id']?.toString();
    final supplierItems = _supplierDropdownItems(line);
    final effectivePid = (pid != null &&
            supplierItems.any((e) => e.value == pid))
        ? pid
        : null;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: pal.surface,
        borderRadius: BorderRadius.circular(_kRadius),
        border: Border.all(color: pal.fieldBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Поставка ${index + 1}',
                  style: theme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
              ),
              if (_purchaseLines.length > 1)
                IconButton(
                  onPressed: () => _removePurchaseLineAt(index),
                  icon: Icon(Icons.close_rounded, color: theme.secondaryText),
                  tooltip: 'Удалить строку',
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text('ПОСТАВЩИК', style: _upperLabelStyle(theme)),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: pal.surface,
              borderRadius: BorderRadius.circular(_kRadius),
              border: Border.all(color: pal.fieldBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: effectivePid,
                isExpanded: true,
                hint: Text(
                  'Выберите поставщика',
                  style: theme.bodyMedium.copyWith(
                    color: theme.secondaryText.withValues(alpha: 0.65),
                  ),
                ),
                dropdownColor: pal.surface,
                icon: Icon(Icons.keyboard_arrow_down_rounded,
                    color: theme.secondaryText),
                items: supplierItems,
                onChanged: supplierItems.isEmpty
                    ? null
                    : (id) {
                        if (id == null) return;
                        setState(() {
                          for (final e in _counterpartyPreview) {
                            if (e['id']?.toString() == id) {
                              line.providerSnapshot =
                                  Map<String, dynamic>.from(e);
                              return;
                            }
                          }
                          final s = line.providerSnapshot;
                          if (s != null && s['id']?.toString() == id) {
                            line.providerSnapshot =
                                Map<String, dynamic>.from(s);
                          } else {
                            line.providerSnapshot = null;
                          }
                        });
                      },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: _buildTextField(
                  theme,
                  pal,
                  label: 'Кол-во',
                  controller: line.quantityCtrl,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: _buildPurchaseUomDropdown(theme, pal, line),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _buildTextField(
                  theme,
                  pal,
                  label: 'Цена закупа',
                  hint: '0',
                  controller: line.purchasePriceCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTextField(
                  theme,
                  pal,
                  label: 'Цена продажи',
                  hint: '0',
                  controller: line.salePriceCtrl,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseSection(
    FlutterFlowTheme theme,
    _SpareCreatePalette pal,
  ) {
    return _buildSectionCard(
      theme: theme,
      pal: pal,
      title: 'Закупка и поставщики',
      titleIcon: Icons.local_shipping_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_loadingPurchaseRefs)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: CircularProgressIndicator(color: theme.primary),
              ),
            )
          else if (_purchaseRefsError != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                _purchaseRefsError!,
                style: theme.bodySmall.copyWith(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.red.shade300
                      : Colors.red.shade700,
                ),
              ),
            ),
          Text(
            'Можно добавить несколько поставок: поставщик, количество, единица, '
            'цена закупа и продажи.',
            style: theme.bodySmall.copyWith(
              color: theme.secondaryText,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 12),
          for (var i = 0; i < _purchaseLines.length; i++)
            _buildPurchaseLineCard(theme, pal, i),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: _addPurchaseLine,
              icon: Icon(Icons.add_rounded, color: theme.primary),
              label: Text(
                'Добавить поставщика',
                style: theme.bodyMedium.copyWith(
                  color: theme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainPage(FlutterFlowTheme theme, _SpareCreatePalette pal) {
    final locLabel = theme.primary;

    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        _buildSectionCard(
          theme: theme,
          pal: pal,
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
                pal,
                label: 'Зона / ряд',
                hint: 'напр. А-02',
                controller: _rowCtrl,
                labelColor: locLabel,
                locationFieldStyle: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Стеллаж – полка',
                hint: 'напр. ST-04 / Р-12',
                controller: _shelfCtrl,
                labelColor: locLabel,
                locationFieldStyle: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Лоток / ящик',
                hint: 'напр. Bin-15',
                controller: _boxCtrl,
                labelColor: locLabel,
                locationFieldStyle: true,
              ),
              const SizedBox(height: 12),
              _buildBarcodeField(
                theme,
                pal,
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
          pal: pal,
          title: 'Идентификация',
          titleIcon: Icons.qr_code_2_rounded,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildOcrBlock(theme),
              const SizedBox(height: 16),
              _buildTextField(
                theme,
                pal,
                label: 'Артикул',
                hint: 'напр. 708-2L-00300',
                controller: _partNumberCtrl,
                requiredField: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Наименование',
                hint: 'Гидронасос основной',
                controller: _nameCtrl,
                requiredField: true,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Бренд',
                hint: 'Komatsu',
                controller: _manufacturerCtrl,
              ),
              const SizedBox(height: 12),
              _buildBarcodeField(
                theme,
                pal,
                label: 'Штрихкод товара',
                hint: 'EAN / UPC',
                controller: _barcodeCtrl,
              ),
            ],
          ),
        ),
        _buildSectionCard(
          theme: theme,
          pal: pal,
          title: 'Реквизиты номенклатуры',
          titleIcon: Icons.folder_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_loadingRefs)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(color: theme.primary),
                  ),
                )
              else ...[
                if (_refsError != null) ...[
                  Text(
                    _refsError!,
                    style: theme.bodySmall.copyWith(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.red.shade300
                          : Colors.red.shade700,
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
                  pal,
                  label: 'Категория',
                  value: _categoryId,
                  items: _categories,
                  requiredField: true,
                  onChanged: (v) => setState(() => _categoryId = v),
                ),
                const SizedBox(height: 12),
                _buildCatalogDropdown(
                  theme,
                  pal,
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
                pal,
                label: 'Номер номенклатуры',
                controller: _nomenclatureNumberCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Код',
                controller: _codeCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Описание',
                controller: _descriptionCtrl,
                maxLines: 3,
              ),
            ],
          ),
        ),
        _buildPurchaseSection(theme, pal),
        _buildSectionCard(
          theme: theme,
          pal: pal,
          title: 'Складской факт',
          titleIcon: Icons.inventory_2_outlined,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: _buildQtyStepper(theme, pal)),
                  const SizedBox(width: 12),
                  Expanded(flex: 2, child: _buildUnitDropdown(theme, pal)),
                ],
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Мин. остаток',
                controller: _minQtyCtrl,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 14),
              Text('СОСТОЯНИЕ', style: _upperLabelStyle(theme)),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildConditionChip(theme, pal, 'Новое', 'new'),
                  const SizedBox(width: 8),
                  _buildConditionChip(theme, pal, 'Б/У', 'used'),
                  const SizedBox(width: 8),
                  _buildConditionChip(theme, pal, 'Брак', 'defect'),
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
                      color: pal.surface,
                      border: Border.all(
                        color: pal.fieldBorder,
                        width: 1.2,
                      ),
                    ),
                    child: _uploading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: theme.primary,
                            ),
                          )
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
                pal,
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
          pal,
          title: 'Далее: Справочник',
          subtitle: 'OEM-коды, кросс-номера, характеристики',
          onTap: () => _tabController.animateTo(1),
        ),
      ],
    );
  }

  Widget _buildConditionChip(
    FlutterFlowTheme theme,
    _SpareCreatePalette pal,
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
            color: selected ? _kGreenState : pal.unselectedChipBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: selected ? _kGreenState : pal.fieldBorder,
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

  Widget _buildReferencePage(FlutterFlowTheme theme, _SpareCreatePalette pal) {
    return ListView(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      children: [
        _buildSectionCard(
          theme: theme,
          pal: pal,
          title: 'OEM номера',
          titleIcon: Icons.local_offer_outlined,
          child: _buildLineListEditor(
            theme,
            pal,
            input: _oemInputCtrl,
            hint: 'напр. 708-2L-00300',
            onAdd: _addOemPart,
            items: _oemParts,
            emptyText: 'Нет OEM номеров',
          ),
        ),
        _buildSectionCard(
          theme: theme,
          pal: pal,
          title: 'Кросс-номера / Аналоги',
          titleIcon: Icons.verified_outlined,
          child: _buildLineListEditor(
            theme,
            pal,
            input: _crossInputCtrl,
            hint: 'напр. Handok HPV102',
            onAdd: _addCrossPart,
            items: _crossParts,
            emptyText: 'Нет кросс-номеров',
          ),
        ),
        _buildSectionCard(
          theme: theme,
          pal: pal,
          title: 'Характеристики',
          titleIcon: Icons.tune_rounded,
          child: Column(
            children: [
              _buildTextField(
                theme,
                pal,
                label: 'Масса',
                hint: 'напр. 45 кг',
                controller: _massCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Материал',
                hint: 'Сталь, чугун',
                controller: _materialCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Давление (если применимо)',
                hint: 'напр. 35 МПа',
                controller: _pressureCtrl,
              ),
              const SizedBox(height: 12),
              _buildTextField(
                theme,
                pal,
                label: 'Расход',
                hint: 'напр. 11',
                controller: _flowCtrl,
              ),
            ],
          ),
        ),
        _buildNextNavCard(
          theme,
          pal,
          title: 'Далее: сохранение',
          subtitle: 'Проверьте данные и нажмите галочку вверху',
          onTap: () => _tabController.animateTo(0),
        ),
      ],
    );
  }

  Widget _buildBottomSaveBar(FlutterFlowTheme theme, _SpareCreatePalette pal) {
    final filled = _requiredFilledCount();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: BoxDecoration(
        color: theme.secondaryBackground,
        border: Border(
          top: BorderSide(
            color: pal.fieldBorder.withValues(alpha: pal.bottomBarDividerA),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Text(
          'Обязательные: наименование, артикул, категория${_isEdit ? '' : ', склад'} — $filled/$_requiredTotalFields. Сохранение — кнопка с галочкой сверху.',
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
