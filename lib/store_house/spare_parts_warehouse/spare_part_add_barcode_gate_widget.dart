import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'spare_part_create_card_widget.dart';
import 'spare_parts_warehouse_model.dart';

/// Перед созданием запчасти: обязательное сканирование штрихкода и проверка в номенклатуре.
class SparePartAddBarcodeGateWidget extends StatefulWidget {
  const SparePartAddBarcodeGateWidget({super.key});

  @override
  State<SparePartAddBarcodeGateWidget> createState() =>
      _SparePartAddBarcodeGateWidgetState();
}

enum _GatePhase { scanning, loading, notFound, found, error }

/// Тестовый штрихкод для эмулятора (debug), без камеры.
const String _kDebugEmulatorTestBarcode = '11123123123';

class _SparePartAddBarcodeGateWidgetState
    extends State<SparePartAddBarcodeGateWidget> {
  final MobileScannerController _scannerController = MobileScannerController();

  _GatePhase _phase = _GatePhase.scanning;
  String _scannedBarcode = '';
  String? _errorText;
  List<Map<String, dynamic>> _foundItems = [];
  int? _foundTotalCount;

  @override
  void dispose() {
    _scannerController.dispose();
    super.dispose();
  }

  Future<void> _onBarcodeRead(String raw) async {
    final code = raw.trim();
    if (code.isEmpty) return;

    await _scannerController.stop();
    if (!mounted) return;

    setState(() {
      _phase = _GatePhase.loading;
      _scannedBarcode = code;
      _errorText = null;
    });

    final result = await lookupPartNomenclatureByBarcode(code);
    if (!mounted) return;

    if (!result.ok) {
      setState(() {
        _phase = _GatePhase.error;
        _errorText = result.errorMessage ?? 'Ошибка запроса';
      });
      return;
    }

    if (result.items.isEmpty) {
      setState(() {
        _phase = _GatePhase.notFound;
        _foundItems = [];
        _foundTotalCount = result.totalCount;
      });
      return;
    }

    setState(() {
      _phase = _GatePhase.found;
      _foundItems = result.items;
      _foundTotalCount = result.totalCount ?? result.items.length;
    });
  }

  Future<void> _restartScan() async {
    await _scannerController.start();
    if (!mounted) return;
    setState(() {
      _phase = _GatePhase.scanning;
      _errorText = null;
      _foundItems = [];
    });
  }

  Future<void> _openCreateForm() async {
    final created = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => SparePartCreateCardWidget(
          initialBarcode:
              _scannedBarcode.isNotEmpty ? _scannedBarcode : null,
        ),
      ),
    );
    if (!mounted) return;
    if (created == true) {
      Navigator.of(context).pop(true);
    }
  }

  void _stubReceiveGoods() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Оприходование товара — в разработке'),
      ),
    );
  }

  Widget _buildPartCard(FlutterFlowTheme theme, Map<String, dynamic> part) {
    final name = part['name']?.toString() ?? '-';
    final partNumber = part['part_number']?.toString() ?? '-';
    final category =
        part['category_name']?.toString() ?? 'Без категории';
    final quantity = part['quantity']?.toString() ?? '0';
    final unit = part['unit_of_measurement']?.toString() ?? 'шт';
    final barcode = part['barcode']?.toString() ?? _scannedBarcode;
    final warehouses = (part['warehouses'] as List?)
            ?.whereType<String>()
            .toList() ??
        [];
    final partId = part['id']?.toString() ?? part['_id']?.toString();

    return Card(
      margin: EdgeInsets.zero,
      color: theme.secondaryBackground,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: theme.alternate.withValues(alpha: 0.35)),
      ),
      elevation: 0,
      child: InkWell(
        onTap: partId == null || partId.isEmpty
            ? null
            : () {
                context.pushNamed(
                  SparePartProfileWidget.routeName,
                  queryParameters: {'id': partId},
                );
              },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.check_circle_outline_rounded,
                      color: theme.primary, size: 22),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Запчасть найдена',
                      style: theme.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                        color: theme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                name,
                style: theme.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.primaryText,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Артикул: $partNumber',
                style: theme.bodyMedium.copyWith(
                  color: theme.secondaryText,
                  fontSize: 13,
                ),
              ),
              Text(
                'Штрихкод: $barcode',
                style: theme.bodyMedium.copyWith(
                  color: theme.secondaryText,
                  fontSize: 13,
                ),
              ),
              Text(
                'Категория: $category',
                style: theme.bodyMedium.copyWith(
                  color: theme.secondaryText,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    label: Text(
                      '$quantity $unit',
                      style: theme.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.primary,
                      ),
                    ),
                    backgroundColor: theme.primary.withValues(alpha: 0.12),
                    side: BorderSide(
                      color: theme.primary.withValues(alpha: 0.22),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      warehouses.isEmpty
                          ? 'Склад: не указан'
                          : 'Склад: ${warehouses.join(', ')}',
                      style: theme.bodySmall.copyWith(
                        color: theme.secondaryText,
                      ),
                    ),
                  ),
                ],
              ),
              if (partId != null && partId.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Нажмите карточку для профиля',
                    style: theme.bodySmall.copyWith(
                      color: theme.secondaryText.withValues(alpha: 0.8),
                      fontSize: 11,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primaryBackground,
      appBar: AppBar(
        backgroundColor: theme.secondaryBackground,
        foregroundColor: theme.primaryText,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Добавить запчасть',
          style: theme.bodyMedium.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
      ),
      body: switch (_phase) {
        _GatePhase.scanning => Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Text(
                  'Отсканируйте штрихкод товара. Без сканирования добавление недоступно.',
                  textAlign: TextAlign.center,
                  style: theme.bodyMedium.copyWith(
                    color: theme.secondaryText,
                    height: 1.35,
                  ),
                ),
              ),
              if (kDebugMode)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                  child: OutlinedButton.icon(
                    onPressed: () => _onBarcodeRead(_kDebugEmulatorTestBarcode),
                    icon: const Icon(Icons.bug_report_outlined, size: 18),
                    label: Text(
                      'Проверка (эмулятор): $_kDebugEmulatorTestBarcode',
                      textAlign: TextAlign.center,
                      style: theme.bodySmall,
                    ),
                  ),
                ),
              Expanded(
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16)),
                  child: MobileScanner(
                    controller: _scannerController,
                    onDetect: (capture) {
                      for (final b in capture.barcodes) {
                        final v = b.rawValue;
                        if (v != null && v.isNotEmpty) {
                          _onBarcodeRead(v);
                          return;
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        _GatePhase.loading => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: theme.primary),
                const SizedBox(height: 16),
                Text(
                  'Проверка по базе…',
                  style: theme.bodyMedium.copyWith(color: theme.secondaryText),
                ),
                const SizedBox(height: 8),
                Text(
                  _scannedBarcode,
                  style: theme.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        _GatePhase.notFound => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Icon(
                            Icons.search_off_rounded,
                            size: 56,
                            color: theme.secondaryText,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Такой запчасти нет',
                            textAlign: TextAlign.center,
                            style: theme.titleMedium.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'В номенклатуре не найдено позиции со штрихкодом:\n$_scannedBarcode',
                            textAlign: TextAlign.center,
                            style: theme.bodyMedium.copyWith(
                              color: theme.secondaryText,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: _openCreateForm,
                    child: const Text('Добавить запчасть'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: _restartScan,
                    child: const Text('Сканировать другой штрихкод'),
                  ),
                ],
              ),
            ),
          ),
        _GatePhase.found => SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if ((_foundTotalCount ?? _foundItems.length) > 1)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Найдено позиций: ${_foundTotalCount ?? _foundItems.length}. Ниже первая.',
                        style: theme.bodySmall.copyWith(
                          color: theme.secondaryText,
                        ),
                      ),
                    ),
                  _buildPartCard(theme, _foundItems.first),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _openCreateForm,
                    child: const Text('Добавить новую запчасть'),
                  ),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: _stubReceiveGoods,
                    child: const Text('Оприходовать товар'),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _restartScan,
                    child: const Text('Сканировать другой штрихкод'),
                  ),
                ],
              ),
            ),
          ),
        _GatePhase.error => SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(height: 24),
                          Icon(Icons.error_outline_rounded,
                              size: 56, color: theme.error),
                          const SizedBox(height: 16),
                          Text(
                            _errorText ?? 'Ошибка',
                            textAlign: TextAlign.center,
                            style: theme.bodyMedium.copyWith(
                              color: theme.primaryText,
                              height: 1.35,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  FilledButton(
                    onPressed: _restartScan,
                    child: const Text('Повторить сканирование'),
                  ),
                ],
              ),
            ),
          ),
      },
    );
  }
}
