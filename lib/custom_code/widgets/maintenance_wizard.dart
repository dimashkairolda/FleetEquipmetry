// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:convert';
import 'package:http/http.dart' as http;

class MaintenanceWizard extends StatefulWidget {
  const MaintenanceWizard({
    Key? key,
    this.width,
    this.height,
    required this.maintenanceId,
    required this.workspaceId,
    required this.token,
    required this.onFinish,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String maintenanceId;
  final String workspaceId;
  final String token;
  final Future<dynamic> Function() onFinish;

  @override
  _MaintenanceWizardState createState() => _MaintenanceWizardState();
}

class _MaintenanceWizardState extends State<MaintenanceWizard> {
  // --- STATE ---
  int _currentStep = 1; // 1: Выбор задач, 2: Выбор ТМЦ
  bool _isLoading = true;
  String _searchQuery = "";
  
  // Данные API
  Map<String, dynamic>? _maintenanceData;
  List<dynamic> _tasks = [];
  List<dynamic> _relatedParts = [];
  String? _equipmentId;

  // Выбор
  Set<String> _selectedTaskIds = {}; 
  Set<String> _expandedTaskIds = {}; // Для раскрытия списка работ
  
  // Хранилище выбранных запчастей
  Map<String, dynamic> _selectedPartsMap = {}; 

  @override
  void initState() {
    super.initState();
    _fetchMaintenanceData();
  }

  // --- API ---
  Future<void> _fetchMaintenanceData() async {
    setState(() => _isLoading = true);
    try {
      final url = Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/service/maintenances/${widget.maintenanceId}');
      final response = await http.get(url, headers: {'Authorization': widget.token, 'Workspace': widget.workspaceId});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _maintenanceData = data;
          _tasks = List.from(data['schedule_info']['tasks'] ?? []);
          _equipmentId = data['equipment_info']['id'];
        });
      }
    } catch (e) { print('Error tasks: $e'); } 
    finally { setState(() => _isLoading = false); }
  }

  Future<void> _fetchRelatedParts() async {
    if (_equipmentId == null) return;
    try {
      final url = Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/part-nomenclature/spare-parts?workspace_id=${widget.workspaceId}&equipment_id=$_equipmentId');
      final response = await http.get(url, headers: {'Authorization': widget.token, 'Workspace': widget.workspaceId});
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() => _relatedParts = List.from(data['data'] ?? []));
      }
    } catch (e) { print('Error parts: $e'); }
  }

  // --- LOGIC ---

  void _toggleTaskSelection(String taskId) {
    setState(() {
      if (_selectedTaskIds.contains(taskId)) _selectedTaskIds.remove(taskId);
      else _selectedTaskIds.add(taskId);
    });
  }

  void _toggleTaskExpansion(String taskId) {
    setState(() {
      if (_expandedTaskIds.contains(taskId)) _expandedTaskIds.remove(taskId);
      else _expandedTaskIds.add(taskId);
    });
  }

  void _selectPart(dynamic originalPart, int qty, {String? uniqueKey}) {
    // Генерируем ключ
    final key = uniqueKey ?? originalPart['id'] ?? originalPart['product_article'] ?? originalPart['part_number'];
    
    setState(() {
      if (qty > 0) {
        final partToSave = Map<String, dynamic>.from(originalPart);
        partToSave['quantity'] = qty; // Записываем выбранное количество
        _selectedPartsMap[key] = partToSave;
      } else {
        _selectedPartsMap.remove(key);
      }
    });
  }

  Future<void> _finish() async {
    // 1. Сохраняем Задачи в AppState.todo
    final selectedTasksList = _tasks.where((t) => _selectedTaskIds.contains(t['task_id'])).toList();
    try {
      FFAppState().todo = selectedTasksList
          .map((t) => TodoStruct.maybeFromMap(t))
          .where((e) => e != null).cast<TodoStruct>().toList();
    } catch (e) { print("Err saving tasks: $e"); }

    // 2. Сохраняем Запчасти в AppState.spareparts (List<SparePartsStruct>)
    try {
       List<SparePartsStruct> resultStructs = [];

       _selectedPartsMap.values.forEach((partMap) {
          // Маппинг полей из разных источников API в единую структуру
          // API может вернуть 'title' или 'name'
          String titleVal = partMap['title'] ?? partMap['name'] ?? '';
          
          // API может вернуть 'product_article' или 'part_number'
          String articleVal = partMap['product_article'] ?? partMap['part_number'] ?? '';
          
          // Количество берем то, которое выбрал юзер
          int qtyVal = partMap['quantity'] is int ? partMap['quantity'] : (int.tryParse(partMap['quantity'].toString()) ?? 0);

          resultStructs.add(createSparePartsStruct(
            title: titleVal,
            productArticle: articleVal,
            quantity: qtyVal,
          ));
       });

       // Записываем в App State
       FFAppState().spareparts = resultStructs;
       
    } catch (e) { 
      print("Err saving parts to struct: $e"); 
    }

    await widget.onFinish();
  }

  // --- UI BUILD ---

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Center(child: CircularProgressIndicator());
    if (_maintenanceData == null) return const Center(child: Text("Нет данных"));

    return Container(
      color: const Color(0xFFF1F4F8),
      child: Column(
        children: [
          // 1. ТОП БАР
          _buildTopNavBar(),
          
          // 2. Инфо о технике
          _buildCompactHeader(),
          
          // 3. Поиск
          _buildSearchBar(),

          // 4. Основной контент
          Expanded(
            child: _currentStep == 1 ? _buildStep1_Tasks() : _buildStep2_Parts(),
          ),
        ],
      ),
    );
  }

  // --- TOP NAV BAR ---
  Widget _buildTopNavBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: () {
               if (_currentStep == 2) setState(() => _currentStep = 1);
               else Navigator.pop(context);
            },
            child: Text(_currentStep == 1 ? "Отменить" : "Назад", style: const TextStyle(fontSize: 16, color: Colors.black54)),
          ),
          Text(
            _currentStep == 1 ? "Выберите работы" : "Выберите ТМЦ",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              if (_currentStep == 1) {
                if (_selectedTaskIds.isEmpty) {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Выберите работы")));
                   return;
                }
                _fetchRelatedParts();
                setState(() { _currentStep = 2; _searchQuery = ""; });
              } else {
                _finish();
              }
            },
            child: Text(
              _currentStep == 1 ? "Далее" : "Готово", 
              style: const TextStyle(fontSize: 16, color: Color(0xFF4B39EF), fontWeight: FontWeight.bold)
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCompactHeader() {
    final equip = _maintenanceData!['equipment_info'];
    return Container(
      width: double.infinity,
      color: const Color(0xFFE8F0FE),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("${equip['brand_id']['name']} ${equip['model_id']['name']} (${equip['license_plate_number']})", 
             style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF14181B))),
          Text("Пробег: ${_maintenanceData!['current_value']} км", style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        decoration: InputDecoration(
          hintText: _currentStep == 1 ? 'Поиск работ...' : 'Поиск запчастей...',
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: BorderSide.none),
        ),
        onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
      ),
    );
  }

  // --- ШАГ 1: ЗАДАЧИ ---
  Widget _buildStep1_Tasks() {
    final filtered = _tasks.where((t) => (t['title'] ?? '').toLowerCase().contains(_searchQuery)).toList();
    
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Всего: ${filtered.length}"),
              TextButton(
                onPressed: () => setState(() => _selectedTaskIds = _tasks.map((e) => e['task_id'].toString()).toSet()),
                child: const Text("Выбрать все", style: TextStyle(color: Color(0xFF4B39EF))),
              )
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final task = filtered[index];
              final id = task['task_id'].toString();
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: CheckboxListTile(
                  activeColor: const Color(0xFF4B39EF),
                  title: Text(task['title'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  value: _selectedTaskIds.contains(id),
                  onChanged: (v) => _toggleTaskSelection(id),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // --- ШАГ 2: ТМЦ ---
  int _tabIndex = 0;
  
  Widget _buildStep2_Parts() {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            children: [
              _buildTabBtn("РАБОТЫ И ЗАПЧАСТИ", 0),
              _buildTabBtn("СВЯЗАННЫЕ ЗАПЧАСТИ", 1),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: _tabIndex == 0 ? _buildPartsFromTasks() : _buildRelatedParts(),
        ),
      ],
    );
  }

  Widget _buildTabBtn(String title, int idx) {
    bool active = _tabIndex == idx;
    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _tabIndex = idx),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 2, color: active ? const Color(0xFF4B39EF) : Colors.transparent))),
          child: Text(title, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: active ? const Color(0xFF4B39EF) : Colors.grey)),
        ),
      ),
    );
  }

  // ВКЛАДКА 1
  Widget _buildPartsFromTasks() {
    final activeTasks = _tasks.where((t) => _selectedTaskIds.contains(t['task_id'])).toList();
    if (activeTasks.isEmpty) return const Center(child: Text("Нет выбранных работ"));

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: activeTasks.length,
      itemBuilder: (context, index) {
        final task = activeTasks[index];
        final taskId = task['task_id'].toString();
        final inventoryItems = task['inventory_items'] as List<dynamic>? ?? [];
        final isExpanded = _expandedTaskIds.contains(taskId);

        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => _toggleTaskExpansion(taskId),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(child: Text(task['title'] ?? '', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
                      if (inventoryItems.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(4)),
                          child: Text("${inventoryItems.length} ТМЦ", style: TextStyle(fontSize: 10, color: Colors.blue.shade800)),
                        )
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                if (inventoryItems.isEmpty)
                  const Padding(padding: EdgeInsets.all(12), child: Text("Нет привязанных запчастей", style: TextStyle(color: Colors.grey, fontSize: 12)))
                else
                  Column(
                    children: inventoryItems.map((item) => _buildMobilePartCard(item, isFromTask: true)).toList(),
                  )
            ],
          ),
        );
      },
    );
  }

  // ВКЛАДКА 2
  Widget _buildRelatedParts() {
    final filteredParts = _relatedParts.where((p) {
       final name = (p['name'] ?? '').toLowerCase();
       return name.contains(_searchQuery);
    }).toList();

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredParts.length,
      itemBuilder: (context, index) => _buildMobilePartCard(filteredParts[index]),
    );
  }

  // КАРТОЧКА ЗАПЧАСТИ
  Widget _buildMobilePartCard(dynamic item, {bool isFromTask = false}) {
    String name = item['title'] ?? item['name'] ?? 'Без названия';
    String article = item['product_article'] ?? item['part_number'] ?? '';
    String uom = item['unit_of_measurement'] ?? 'шт';
    String uniqueKey = item['id'] ?? (article + name); 
    
    bool isSelected = _selectedPartsMap.containsKey(uniqueKey);
    // Для карточки: если выбрано, берем кол-во из карты. Если нет - из API.
    int currentQty = isSelected ? _selectedPartsMap[uniqueKey]['quantity'] : (item['quantity'] ?? 0);
    
    // Если это запчасть из задачи и она еще не выбрана явно, предлагаем дефолтное кол-во из задачи
    if (!isSelected && isFromTask) {
       currentQty = item['quantity'] ?? 1;
    } else if (!isSelected) {
       currentQty = 1; 
    }

    TextEditingController qtyCtrl = TextEditingController(text: currentQty.toString());

    return Container(
      margin: EdgeInsets.only(bottom: 8, left: isFromTask ? 8 : 0, right: isFromTask ? 8 : 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isFromTask ? Colors.grey.shade50 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: isFromTask ? null : Border.all(color: Colors.grey.shade200),
        boxShadow: isFromTask ? null : [BoxShadow(color: Colors.grey.shade100, blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Checkbox(
            value: isSelected,
            activeColor: const Color(0xFF4B39EF),
            onChanged: (val) {
               int q = int.tryParse(qtyCtrl.text) ?? 1;
               if (val == true) {
                 _selectPart(item, q, uniqueKey: uniqueKey);
               } else {
                 _selectPart(item, 0, uniqueKey: uniqueKey);
               }
            },
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    if (article.isNotEmpty) 
                      _badge(article, Colors.blue.shade50, Colors.blue.shade700),
                    const SizedBox(width: 8),
                    if (!isFromTask) 
                      Text("На складе: ${item['quantity']}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Text("Кол-во: ", style: TextStyle(fontSize: 12)),
                    SizedBox(
                      width: 60,
                      height: 35,
                      child: TextField(
                        controller: qtyCtrl,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 13),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (val) {
                          if (isSelected) {
                             int? q = int.tryParse(val);
                             if (q != null) _selectPart(item, q, uniqueKey: uniqueKey);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(uom, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _badge(String text, Color bg, Color fg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(4)),
      child: Text(text, style: TextStyle(fontSize: 10, color: fg, fontWeight: FontWeight.w500)),
    );
  }
}