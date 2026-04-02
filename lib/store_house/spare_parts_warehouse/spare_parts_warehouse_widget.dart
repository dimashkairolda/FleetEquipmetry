import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spare_parts_warehouse_model.dart';
import 'spare_part_create_card_widget.dart';
export 'spare_parts_warehouse_model.dart';

class SparePartsWarehouseWidget extends StatefulWidget {
  const SparePartsWarehouseWidget({super.key});

  static String routeName = 'sparePartsWarehouse';
  static String routePath = '/sparePartsWarehouse';

  @override
  State<SparePartsWarehouseWidget> createState() =>
      _SparePartsWarehouseWidgetState();
}

class _SparePartsWarehouseWidgetState extends State<SparePartsWarehouseWidget> {
  late SparePartsWarehouseModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  late TextEditingController _nameFilterCtrl;
  late TextEditingController _partNumberFilterCtrl;

  @override
  void initState() {
    super.initState();
    _model = SparePartsWarehouseModel();
    _model.addListener(_onModelUpdate);
    _nameFilterCtrl = TextEditingController();
    _partNumberFilterCtrl = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _model.loadFilterOptions();
      await _model.fetchParts();
    });
  }

  void _onModelUpdate() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _model.removeListener(_onModelUpdate);
    _nameFilterCtrl.dispose();
    _partNumberFilterCtrl.dispose();
    _model.dispose();
    super.dispose();
  }

  Future<void> _applyFilters() async {
    await _model.applyFiltersAndReload(
      name: _nameFilterCtrl.text,
      partNumber: _partNumberFilterCtrl.text,
      categoryId: _model.filterCategoryId,
      warehouseId: _model.filterWarehouseId,
      inStock: _model.filterInStock,
    );
  }

  String _formatSum(num? v) {
    if (v == null) return '—';
    return NumberFormat.decimalPattern('ru_RU').format(v);
  }

  void _showFilterDialog() {
    _nameFilterCtrl.text = _model.filterName;
    _partNumberFilterCtrl.text = _model.filterPartNumber;
    final snap = _FilterSnapshot.capture(_model, _nameFilterCtrl, _partNumberFilterCtrl);
    final theme = FlutterFlowTheme.of(context);

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final dialogW = MediaQuery.sizeOf(dialogContext).width;
            final contentW = (dialogW - 28).clamp(300.0, 440.0);

            return AlertDialog(
              insetPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 24,
              ),
              title: Text(
                'Фильтры',
                style: theme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              content: SizedBox(
                width: contentW,
                child: SingleChildScrollView(
                  child: _buildFilterForm(theme, setDialogState),
                ),
              ),
              actions: [
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onPressed: () {
                    snap.restore(_model, _nameFilterCtrl, _partNumberFilterCtrl);
                    setState(() {});
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    'Отмена',
                    style: theme.bodyMedium.copyWith(fontSize: 15),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                  onPressed: _model.isLoading
                      ? null
                      : () async {
                          _nameFilterCtrl.clear();
                          _partNumberFilterCtrl.clear();
                          _model.resetFiltersToDefaults();
                          setDialogState(() {});
                          await _model.fetchParts();
                          if (dialogContext.mounted) {
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: Text(
                    'Сбросить',
                    style: theme.bodyMedium.copyWith(fontSize: 15),
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                  ),
                  onPressed: _model.isLoading
                      ? null
                      : () async {
                          await _applyFilters();
                          if (dialogContext.mounted) {
                            Navigator.of(dialogContext).pop();
                          }
                        },
                  child: Text(
                    'Применить',
                    style: theme.bodyMedium.copyWith(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: theme.info,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStatsBar(FlutterFlowTheme theme) {
    final n = _model.totalCountFromApi;
    final sum = _model.totalSumFromApi;
    final ti = _model.totalItemsFromApi;

    return Material(
      color: theme.secondaryBackground,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Позиций найдено',
                        style: theme.bodySmall.copyWith(
                          fontSize: 11,
                          color: theme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        n != null ? '$n' : '—',
                        style: theme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: theme.primaryText,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Сумма по фильтру',
                        style: theme.bodySmall.copyWith(
                          fontSize: 11,
                          color: theme.secondaryText,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatSum(sum),
                        style: theme.bodyMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: theme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (ti != null) ...[
              const SizedBox(height: 6),
              Text(
                'Позиций на странице: $ti',
                textAlign: TextAlign.center,
                style: theme.bodySmall.copyWith(
                  fontSize: 11,
                  color: theme.secondaryText,
                ),
              ),
            ],
          ],
        ),
      ),
    );
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
        key: scaffoldKey,
        backgroundColor: theme.primaryBackground,
        appBar: AppBar(
          backgroundColor: theme.secondaryBackground,
          foregroundColor: theme.primaryText,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: theme.primaryText),
          title: Text(
            'Склад запчастей',
            style: theme.bodyMedium.copyWith(
              fontSize: 18.0,
              letterSpacing: 0.0,
              fontWeight: FontWeight.w600,
              color: theme.primaryText,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.filter_list_rounded, color: theme.primary),
              tooltip: 'Фильтры',
              onPressed: _showFilterDialog,
            ),
            IconButton(
              icon: Icon(Icons.add_rounded, color: theme.primary),
              tooltip: 'Добавить запчасть',
              onPressed: () async {
                final created = await Navigator.of(context).push<bool>(
                  MaterialPageRoute(
                    builder: (_) => const SparePartCreateCardWidget(),
                  ),
                );
                if (created == true && mounted) {
                  await _model.fetchParts();
                }
              },
            ),
          ],
          elevation: 0,
        ),
        body: SafeArea(
          child: RefreshIndicator(
            color: theme.primary,
            onRefresh: () => _model.fetchParts(),
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(child: _buildStatsBar(theme)),
                ..._buildListSlivers(theme),
                SliverToBoxAdapter(child: _buildPaginationBar(theme)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _filterBorder = Color(0xFFE0E4EB);
  static const _filterRadius = 6.0;
  static const _dialogFilterRadius = 12.0;

  InputDecoration _compactFieldDecoration(
    FlutterFlowTheme theme,
    String label,
    String hint, {
    bool forDialog = false,
  }) {
    final r = BorderRadius.circular(
      forDialog ? _dialogFilterRadius : _filterRadius,
    );
    final pad = forDialog
        ? const EdgeInsets.symmetric(horizontal: 14, vertical: 14)
        : const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
    return InputDecoration(
      labelText: label,
      hintText: hint,
      isDense: !forDialog,
      filled: true,
      fillColor: theme.primaryBackground,
      labelStyle: theme.bodySmall.copyWith(
        fontSize: forDialog ? 13 : 10,
        height: 1.0,
        fontWeight: forDialog ? FontWeight.w600 : null,
      ),
      hintStyle: theme.bodySmall.copyWith(
        fontSize: forDialog ? 14 : 11,
        color: theme.secondaryText.withValues(alpha: 0.55),
      ),
      contentPadding: pad,
      border: OutlineInputBorder(borderRadius: r),
      enabledBorder: OutlineInputBorder(
        borderRadius: r,
        borderSide: const BorderSide(color: _filterBorder),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: r,
        borderSide: BorderSide(color: theme.primary, width: forDialog ? 1.8 : 1.2),
      ),
    );
  }

  Widget _buildFilterForm(FlutterFlowTheme theme, StateSetter setDialogState) {
    final r = BorderRadius.circular(_dialogFilterRadius);

    void updateDialog(void Function() fn) {
      setDialogState(fn);
    }

    final itemStyle = theme.bodyMedium.copyWith(fontSize: 15, height: 1.25);

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_model.filtersOptionsLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            if (_model.filtersOptionsError != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _model.filtersOptionsError!,
                  style: theme.bodyMedium.copyWith(
                    color: Colors.red.shade700,
                    fontSize: 13,
                  ),
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameFilterCtrl,
                    style: theme.bodyMedium.copyWith(fontSize: 15, height: 1.3),
                    decoration: _compactFieldDecoration(
                      theme,
                      'Название',
                      'Название',
                      forDialog: true,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _partNumberFilterCtrl,
                    style:
                        theme.bodyMedium.copyWith(fontSize: 15, height: 1.3),
                    decoration: _compactFieldDecoration(
                      theme,
                      'Артикул',
                      'Артикул',
                      forDialog: true,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildFilterDropdown(
                    theme,
                    label: 'Категория',
                    value: _model.filterCategoryId,
                    forDialog: true,
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text(
                          'Все',
                          overflow: TextOverflow.ellipsis,
                          style: itemStyle,
                        ),
                      ),
                      ..._model.categories.map(
                        (c) => DropdownMenuItem<String?>(
                          value: c.id,
                          child: Text(
                            c.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: itemStyle,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      updateDialog(() => _model.filterCategoryId = v);
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildFilterDropdown(
                    theme,
                    label: 'Склад',
                    value: _model.filterWarehouseId,
                    forDialog: true,
                    items: [
                      DropdownMenuItem<String?>(
                        value: null,
                        child: Text(
                          'Все',
                          overflow: TextOverflow.ellipsis,
                          style: itemStyle,
                        ),
                      ),
                      ..._model.warehouses.map(
                        (w) => DropdownMenuItem<String?>(
                          value: w.id,
                          child: Text(
                            w.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: itemStyle,
                          ),
                        ),
                      ),
                    ],
                    onChanged: (v) {
                      updateDialog(() => _model.filterWarehouseId = v);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'В наличии',
                isDense: false,
                filled: true,
                fillColor: theme.primaryBackground,
                labelStyle: theme.bodySmall.copyWith(
                  fontSize: 13,
                  height: 1.0,
                  fontWeight: FontWeight.w600,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                border: OutlineInputBorder(borderRadius: r),
                enabledBorder: OutlineInputBorder(
                  borderRadius: r,
                  borderSide: const BorderSide(color: _filterBorder),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<bool?>(
                  isExpanded: true,
                  value: _model.filterInStock,
                  hint: Text(
                    '—',
                    style: theme.bodyMedium.copyWith(fontSize: 15),
                  ),
                  iconSize: 24,
                  style: theme.bodyMedium.copyWith(fontSize: 15),
                  items: [
                    DropdownMenuItem<bool?>(
                      value: null,
                      child: Text('Не важно', style: itemStyle),
                    ),
                    DropdownMenuItem<bool?>(
                      value: true,
                      child: Text('Да', style: itemStyle),
                    ),
                    DropdownMenuItem<bool?>(
                      value: false,
                      child: Text('Нет', style: itemStyle),
                    ),
                  ],
                  onChanged: (v) {
                    updateDialog(() => _model.filterInStock = v);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterDropdown(
    FlutterFlowTheme theme, {
    required String label,
    required String? value,
    required List<DropdownMenuItem<String?>> items,
    required ValueChanged<String?> onChanged,
    bool forDialog = false,
  }) {
    final r = BorderRadius.circular(
      forDialog ? _dialogFilterRadius : _filterRadius,
    );
    final pad = forDialog
        ? const EdgeInsets.symmetric(horizontal: 12, vertical: 12)
        : const EdgeInsets.symmetric(horizontal: 4, vertical: 0);

    return InputDecorator(
      decoration: InputDecoration(
        labelText: label,
        isDense: !forDialog,
        filled: true,
        fillColor: theme.primaryBackground,
        labelStyle: theme.bodySmall.copyWith(
          fontSize: forDialog ? 13 : 10,
          height: 1.0,
          fontWeight: forDialog ? FontWeight.w600 : null,
        ),
        contentPadding: pad,
        border: OutlineInputBorder(borderRadius: r),
        enabledBorder: OutlineInputBorder(
          borderRadius: r,
          borderSide: const BorderSide(color: _filterBorder),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String?>(
          isExpanded: true,
          value: value,
          hint: Text(
            '—',
            style: forDialog
                ? theme.bodyMedium.copyWith(fontSize: 15)
                : theme.bodySmall.copyWith(fontSize: 11),
          ),
          iconSize: forDialog ? 24 : 16,
          style: forDialog
              ? theme.bodyMedium.copyWith(fontSize: 15)
              : theme.bodySmall.copyWith(fontSize: 11),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }

  List<Widget> _buildListSlivers(FlutterFlowTheme theme) {
    if (_model.isLoading && _model.parts.isEmpty) {
      return [
        SliverFillRemaining(
          child: Center(
            child: CircularProgressIndicator(color: theme.primary),
          ),
        ),
      ];
    }

    if (_model.hasError && _model.parts.isEmpty) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Не удалось загрузить данные.\nПроверьте сеть и попробуйте снова.',
                textAlign: TextAlign.center,
                style: theme.bodyMedium.copyWith(color: theme.primaryText),
              ),
            ),
          ),
        ),
      ];
    }

    if (_model.parts.isEmpty) {
      return [
        SliverFillRemaining(
          child: Center(
            child: Text(
              'Запчасти не найдены',
              style: theme.bodyMedium.copyWith(color: theme.secondaryText),
            ),
          ),
        ),
      ];
    }

    return [
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final part = _model.parts[index] as Map<String, dynamic>;
              final name = part['name']?.toString() ?? '-';
              final partNumber = part['part_number']?.toString() ?? '-';
              final category =
                  part['category_name']?.toString() ?? 'Без категории';
              final quantity = part['quantity']?.toString() ?? '0';
              final unit = part['unit_of_measurement']?.toString() ?? 'шт';
              final warehouses = (part['warehouses'] as List?)
                      ?.whereType<String>()
                      .toList() ??
                  [];
              final partId =
                  part['id']?.toString() ?? part['_id']?.toString();

              return InkWell(
                onTap: partId == null || partId.isEmpty
                    ? null
                    : () {
                        context.pushNamed(
                          SparePartProfileWidget.routeName,
                          queryParameters: {'id': partId},
                        );
                      },
                borderRadius: BorderRadius.circular(12),
                child: Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  color: theme.secondaryBackground,
                  surfaceTintColor: Colors.transparent,
                  shadowColor: theme.primaryText.withValues(alpha: 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: theme.alternate.withValues(alpha: 0.35),
                    ),
                  ),
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: theme.titleMedium.copyWith(
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            color: theme.primaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Артикул: $partNumber',
                          style: theme.bodyMedium.copyWith(
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            color: theme.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Категория: $category',
                          style: theme.bodyMedium.copyWith(
                            fontSize: 13.0,
                            letterSpacing: 0.0,
                            color: theme.secondaryText,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Chip(
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              label: Text(
                                '$quantity $unit',
                                style: theme.bodySmall.copyWith(
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w600,
                                  color: theme.primary,
                                ),
                              ),
                              backgroundColor:
                                  theme.primary.withValues(alpha: 0.12),
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
                                style: theme.bodyMedium.copyWith(
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  color: theme.secondaryText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: _model.parts.length,
          ),
        ),
      ),
    ];
  }

  Widget _buildPaginationBar(FlutterFlowTheme theme) {
    final totalPagesLabel =
        _model.totalPages?.toString() ?? '—';

    return Container(
      width: double.infinity,
      color: theme.secondaryBackground,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 15),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FFButtonWidget(
              onPressed: _model.isLoading || !_model.canGoPrev
                  ? null
                  : () async {
                      await _model.goToPage(_model.page - 1);
                    },
              text: 'Назад',
              icon: const Icon(
                Icons.chevron_left,
                size: 15,
              ),
              options: FFButtonOptions(
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconColor: theme.primary,
                color: theme.secondaryBackground,
                textStyle: theme.titleSmall.copyWith(
                  color: theme.primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
                elevation: 0,
                borderSide: BorderSide(
                  color: theme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  '${_model.page} из $totalPagesLabel',
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.bodyMedium.copyWith(
                    fontSize: 16,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                    color: theme.primaryText,
                  ),
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: _model.isLoading || !_model.canGoNext
                  ? null
                  : () async {
                      await _model.goToPage(_model.page + 1);
                    },
              text: 'Вперед',
              icon: const Icon(
                Icons.chevron_right,
                size: 15,
              ),
              options: FFButtonOptions(
                height: 40,
                padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                iconAlignment: IconAlignment.end,
                iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconColor: theme.primary,
                color: theme.secondaryBackground,
                textStyle: theme.titleSmall.copyWith(
                  color: theme.primary,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                ),
                elevation: 0,
                borderSide: BorderSide(
                  color: theme.primary,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterSnapshot {
  _FilterSnapshot({
    required this.name,
    required this.part,
    required this.categoryId,
    required this.warehouseId,
    required this.inStock,
  });

  final String name;
  final String part;
  final String? categoryId;
  final String? warehouseId;
  final bool? inStock;

  factory _FilterSnapshot.capture(
    SparePartsWarehouseModel model,
    TextEditingController nameC,
    TextEditingController partC,
  ) {
    return _FilterSnapshot(
      name: nameC.text,
      part: partC.text,
      categoryId: model.filterCategoryId,
      warehouseId: model.filterWarehouseId,
      inStock: model.filterInStock,
    );
  }

  void restore(
    SparePartsWarehouseModel model,
    TextEditingController nameC,
    TextEditingController partC,
  ) {
    nameC.text = name;
    partC.text = part;
    model.filterCategoryId = categoryId;
    model.filterWarehouseId = warehouseId;
    model.filterInStock = inStock;
  }
}
