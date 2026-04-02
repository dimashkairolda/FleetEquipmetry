// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

class WarehouseSelectionPage extends StatefulWidget {
  const WarehouseSelectionPage({
    super.key,
    this.width,
    this.height,
    required this.authToken,
    required this.workspaceId,
  }) : super();

  final double? width;
  final double? height;
  final String authToken;
  final String workspaceId;

  @override
  State<WarehouseSelectionPage> createState() => _WarehouseSelectionPageState();
}

class _WarehouseSelectionPageState extends State<WarehouseSelectionPage> {
  late TextEditingController _searchController;
  List<dynamic> allParts = [];
  List<dynamic> filteredParts = [];
  Set<String> selectedIds = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/part-nomenclature/spare-parts');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': widget.authToken,
          'Workspace': widget.workspaceId,
        },
      );

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        setState(() {
          allParts = decodedData['data'] ?? [];
          filteredParts = allParts;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _onSearchChanged(String query) {
    setState(() {
      filteredParts = allParts
          .where((part) =>
              (part['name']?.toString().toLowerCase() ?? "")
                  .contains(query.toLowerCase()) ||
              (part['part_number']?.toString().toLowerCase() ?? "")
                  .contains(query.toLowerCase()))
          .toList();
    });
  }

  void _saveAndExit() {
    // Формируем список структур InventoryItemsStruct из выбранных запчастей
    List<InventoryItemsStruct> selectedItems = allParts
        .where((part) => selectedIds.contains(part['id'].toString()))
        .map((part) {
      // Приводим цену к double, так как в JSON может быть int или null
      double partPrice = 0.0;
      if (part['price'] != null) {
        partPrice =
            (part['price'] is num) ? (part['price'] as num).toDouble() : 0.0;
      }

      return createInventoryItemsStruct(
        title: part['name']?.toString() ?? '',
        productArticle: part['part_number']?.toString() ?? '',
        quantity: 1, // По умолчанию 1 при выборе
        unitOfMeasurement: part['unit_of_measurement']?.toString() ?? 'шт',
        price: partPrice,
        inStock: true, // Раз выбираем со склада, значит в наличии
        defectId: '',
        source: 'WAREHOUSE', // Пустое поле, если не требуется иное
        serviceStationComment: '',
      );
    }).toList();

    // Обновляем CTOInventoryItems в AppState
    FFAppState().update(() {
      FFAppState().CTOInventoryItems = selectedItems;
    });

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? double.infinity,
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Поле поиска
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      hintText: 'Поиск по имени или артикулу...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: FlutterFlowTheme.of(context).secondaryBackground,
                    ),
                  ),
                ),
                // Список данных
                Expanded(
                  child: ListView.separated(
                    itemCount: filteredParts.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final part = filteredParts[index];
                      final id = part['id'].toString();
                      final isSelected = selectedIds.contains(id);

                      return CheckboxListTile(
                        value: isSelected,
                        activeColor: const Color(0xFF4B39EF),
                        title: Text(
                          part['name'] ?? 'Без названия',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        subtitle: Text(
                          'Арт: ${part['part_number'] ?? '-'} • ${part['quantity']} ${part['unit_of_measurement'] ?? ''} • ${part['price'] ?? 0} KZT',
                          style: const TextStyle(fontSize: 12),
                        ),
                        onChanged: (val) {
                          setState(() {
                            if (val == true) {
                              selectedIds.add(id);
                            } else {
                              selectedIds.remove(id);
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
                // Кнопки управления
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => context.pop(),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Color(0xFF4B39EF)),
                          ),
                          child: const Text('Отмена'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _saveAndExit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4B39EF),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            'Сохранить',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}