import '/auth/custom_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String _fleetBase = 'https://fleet.equipmetry.kz/api/v1/workspace';

class NamedId {
  const NamedId(this.id, this.name);
  final String id;
  final String name;
}

class SparePartsWarehouseModel extends ChangeNotifier {
  bool isLoading = false;
  bool hasError = false;
  List<dynamic> parts = [];
  /// Поле `count` — всего позиций по фильтру (для пагинации и «найдено»).
  int? totalCountFromApi;
  /// Поле `total_sum` — сумма по текущему фильтру.
  num? totalSumFromApi;
  /// Поле `total_items` — напр. сумма количеств на странице (если отдаёт бэкенд).
  int? totalItemsFromApi;

  int page = 1;
  int limit = 10;

  String filterName = '';
  String filterPartNumber = '';
  String? filterCategoryId;
  String? filterWarehouseId;
  /// null — все, true — в наличии, false — нет в наличии
  bool? filterInStock;

  List<NamedId> categories = [];
  List<NamedId> warehouses = [];
  bool filtersOptionsLoading = false;
  String? filtersOptionsError;

  Uri _buildListUri() {
    final q = <String, String>{
      'page': '$page',
      'limit': '$limit',
    };
    if (filterName.trim().isNotEmpty) {
      q['name'] = filterName.trim();
    }
    if (filterPartNumber.trim().isNotEmpty) {
      q['part_number'] = filterPartNumber.trim();
    }
    if (filterCategoryId != null && filterCategoryId!.trim().isNotEmpty) {
      q['category_id'] = filterCategoryId!.trim();
    }
    if (filterWarehouseId != null && filterWarehouseId!.trim().isNotEmpty) {
      q['warehouse_id'] = filterWarehouseId!.trim();
    }
    if (filterInStock != null) {
      q['in_stock'] = filterInStock! ? 'true' : 'false';
    }

    return Uri.parse('$_fleetBase/part-nomenclature').replace(
      queryParameters: q,
    );
  }

  Future<void> loadFilterOptions() async {
    final workspaceId = FFAppState().workspace.trim();
    final token = currentAuthenticationToken;
    if (workspaceId.isEmpty || token == null || token.isEmpty) {
      filtersOptionsError = 'Нет workspace или токена';
      notifyListeners();
      return;
    }

    filtersOptionsLoading = true;
    filtersOptionsError = null;
    notifyListeners();

    try {
      final h = {
        'Authorization': token,
        'Workspace': workspaceId,
      };
      final catUri = Uri.parse('$_fleetBase/categories');
      final whUri = Uri.parse('$_fleetBase/warehouse');

      final responses = await Future.wait([
        http.get(catUri, headers: h),
        http.get(whUri, headers: h),
      ]);

      if (responses[0].statusCode != 200) {
        throw Exception('Категории: HTTP ${responses[0].statusCode}');
      }
      if (responses[1].statusCode != 200) {
        throw Exception('Склады: HTTP ${responses[1].statusCode}');
      }

      final catDecoded = json.decode(utf8.decode(responses[0].bodyBytes));
      final whDecoded = json.decode(utf8.decode(responses[1].bodyBytes));

      final nextCategories = <NamedId>[];
      if (catDecoded is Map && catDecoded['data'] is List) {
        for (final e in catDecoded['data'] as List) {
          if (e is Map) {
            final id = e['id']?.toString();
            final name = e['name']?.toString() ?? '';
            if (id != null && id.isNotEmpty) {
              nextCategories.add(NamedId(id, name));
            }
          }
        }
      }
      nextCategories.sort((a, b) => a.name.compareTo(b.name));

      final nextWarehouses = <NamedId>[];
      if (whDecoded is List) {
        for (final e in whDecoded) {
          if (e is Map) {
            final id = e['id']?.toString();
            final name = e['name']?.toString() ?? '';
            if (id != null && id.isNotEmpty) {
              nextWarehouses.add(NamedId(id, name));
            }
          }
        }
      }
      nextWarehouses.sort((a, b) => a.name.compareTo(b.name));

      categories = nextCategories;
      warehouses = nextWarehouses;
      filtersOptionsError = null;
    } catch (e) {
      filtersOptionsError = '$e';
    } finally {
      filtersOptionsLoading = false;
      notifyListeners();
    }
  }

  void resetFiltersToDefaults() {
    filterName = '';
    filterPartNumber = '';
    filterCategoryId = null;
    filterWarehouseId = null;
    filterInStock = null;
    page = 1;
    notifyListeners();
  }

  Future<void> fetchParts() async {
    isLoading = true;
    hasError = false;
    notifyListeners();

    try {
      final workspaceId = FFAppState().workspace.trim();
      final token = currentAuthenticationToken;
      if (workspaceId.isEmpty || token == null || token.isEmpty) {
        hasError = true;
        parts = [];
        totalCountFromApi = null;
        totalSumFromApi = null;
        totalItemsFromApi = null;
        return;
      }

      final uri = _buildListUri();
      final response = await http.get(
        uri,
        headers: {
          'Authorization': token,
          'Workspace': workspaceId,
        },
      );

      if (response.statusCode == 200) {
        final decoded = json.decode(utf8.decode(response.bodyBytes));
        if (decoded is Map<String, dynamic>) {
          parts = (decoded['data'] as List?) ?? [];
          final c = decoded['count'];
          final t = decoded['total'];
          if (c is int) {
            totalCountFromApi = c;
          } else if (c is num) {
            totalCountFromApi = c.toInt();
          } else if (t is int) {
            totalCountFromApi = t;
          } else if (t is num) {
            totalCountFromApi = t.toInt();
          } else {
            totalCountFromApi = null;
          }

          final ts = decoded['total_sum'];
          if (ts is num) {
            totalSumFromApi = ts;
          } else if (ts is String) {
            totalSumFromApi = num.tryParse(ts.replaceAll(',', '.').replaceAll(' ', ''));
          } else {
            totalSumFromApi = null;
          }

          final ti = decoded['total_items'];
          if (ti is int) {
            totalItemsFromApi = ti;
          } else if (ti is num) {
            totalItemsFromApi = ti.toInt();
          } else {
            totalItemsFromApi = null;
          }
        } else {
          parts = [];
          totalCountFromApi = null;
          totalSumFromApi = null;
          totalItemsFromApi = null;
          hasError = true;
        }
        hasError = false;
      } else {
        hasError = true;
        parts = [];
        totalCountFromApi = null;
        totalSumFromApi = null;
        totalItemsFromApi = null;
      }
    } catch (e) {
      hasError = true;
      parts = [];
      totalCountFromApi = null;
      totalSumFromApi = null;
      totalItemsFromApi = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  /// Сколько страниц, если бэкенд отдал total/count.
  int? get totalPages {
    final n = totalCountFromApi;
    if (n == null || n <= 0) return null;
    final p = (n + limit - 1) ~/ limit;
    return p < 1 ? 1 : p;
  }

  bool get canGoPrev => page > 1;

  bool get canGoNext {
    final n = totalCountFromApi;
    if (n != null && n > 0) {
      return page * limit < n;
    }
    return parts.length >= limit;
  }

  Future<void> goToPage(int newPage) async {
    if (newPage < 1) return;
    final tp = totalPages;
    if (tp != null && newPage > tp) return;
    if (newPage == page) return;
    page = newPage;
    notifyListeners();
    await fetchParts();
  }

  Future<void> applyFiltersAndReload({
    required String name,
    required String partNumber,
    String? categoryId,
    String? warehouseId,
    bool? inStock,
  }) async {
    filterName = name;
    filterPartNumber = partNumber;
    filterCategoryId = categoryId;
    filterWarehouseId = warehouseId;
    filterInStock = inStock;
    page = 1;
    notifyListeners();
    await fetchParts();
  }

  void disposeModel() {}
}
