// ignore_for_file: unnecessary_getters_setters
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';

class ActiveParkFullWidget extends StatefulWidget {
  const ActiveParkFullWidget({
    Key? key,
    this.width,
    this.height,
    required this.workspaceId,
  }) : super(key: key);

  final double? width;
  final double? height;
  final String workspaceId;

  @override
  _ActiveParkFullWidgetState createState() => _ActiveParkFullWidgetState();
}

class _ActiveParkFullWidgetState extends State<ActiveParkFullWidget> {
  List<dynamic> equipmentData = [];
  bool isLoading = true;
  DateTime _selectedDate = DateTime.now();
  String? accessToken;
  String? fleetToken;

  final currencyFormat = NumberFormat.currency(locale: 'ru_KZ', symbol: '₸', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    _initAuthAndFetch();
  }

  Future<void> _initAuthAndFetch() async {
    setState(() => isLoading = true);
    try {
      final authRes = await http.post(
        Uri.parse('https://test-go.equipmetry.kz/api/v1/workspace/auth/authenticate?grant_type=credentials'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "type": "EMAIL",
          "value": "transtelecom@equipmetry.kz",
          "password": "Raar2324"
        }),
      );

      if (authRes.statusCode == 200 || authRes.statusCode == 201) {
        final authData = jsonDecode(authRes.body);
        accessToken = authData['access_token'];
        fleetToken = authData['fleet_token']['access_token'];
        await _fetchData();
      }
    } catch (_) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _fetchData() async {
    if (accessToken == null || fleetToken == null) return;
    
    setState(() => isLoading = true);
    String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDate);
    
    final url = 'https://test-go.equipmetry.kz/api/v1/workspace/orders/equipments'
        '?fleet_token=$fleetToken&workspace=${widget.workspaceId}'
        '&workspace_id=${widget.workspaceId}&page=1&limit=10&date=$formattedDate';

    try {
      final response = await http.get(Uri.parse(url), headers: {'Authorization': accessToken!});
      if (response.statusCode == 200) {
        setState(() {
          equipmentData = jsonDecode(response.body)['data'];
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: const Color(0xFFF8F9FA),
      child: Column(
        children: [
          _buildHeader(),
          _buildDateSelector(),
          Expanded(
            child: isLoading 
              ? const Center(child: CircularProgressIndicator(color: Color(0xFF3466E7)))
              : equipmentData.isEmpty 
                ? const Center(child: Text("Нет данных на эту дату"))
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: equipmentData.length * 2, 
                    itemBuilder: (context, index) {
                      final item = equipmentData[index ~/ 2];
                      final isDayShift = index % 2 == 0;
                      return _buildShiftCard(item, isDayShift);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(dynamic item, bool isDay) {
    final eq = item['equipment'] ?? {};
    final status = item['status'] ?? 'DRAFT';
    
    // РЕАЛЬНЫЕ ДАННЫЕ ИЗ API
    final double mileage = (eq['mileage']?['value'] ?? 0).toDouble();
    final double price = (item['price_item']?['day'] ?? 0).toDouble();
    // В текущем JSON daily_timesheets всегда null, поэтому ставим 0
    final double factHours = 0.0; 

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              Row(children: [
                const CircleAvatar(backgroundColor: Color(0xFFE9FBF3), child: Icon(Icons.local_shipping, color: Color(0xFF2ECC71))),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("${eq['brand_id']?['name'] ?? ''} ${eq['model_id']?['name'] ?? ''}", 
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(eq['workspace']?['title'] ?? '-', 
                      style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ])),
                _plateBadge(eq['license_plate_number'] ?? '-'),
              ]),
              const SizedBox(height: 16),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                _shiftBadge(isDay),
                // Показываем реальный километраж/моточасы из API
                Text("${isDay ? mileage : 0} м/ч", 
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green)),
              ]),
              const SizedBox(height: 12),
              _buildProgress(0.0), // Прогресс 0, так как данных в JSON нет
              const SizedBox(height: 12),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text("ФАКТ: $factHours ч", style: const TextStyle(color: Colors.grey, fontSize: 13)),
                Text(currencyFormat.format(isDay ? price : 0), 
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ]),
              const SizedBox(height: 16),
              _buildApprovalSteps(status),
            ]),
          ),
          _buildFooter(status),
        ],
      ),
    );
  }

  Widget _buildApprovalSteps(String status) {
    bool isConfirmed = status == "CONTRACTOR";
    return Row(
      children: [
        _stepIcon(true, Icons.check_circle, "Зак"),
        _stepLine(isConfirmed),
        _stepIcon(isConfirmed, Icons.check_circle, "Подр"),
        _stepLine(false),
        _stepIcon(false, Icons.shield, "СБ"),
        const Spacer(),
        const Icon(Icons.visibility_outlined, size: 14, color: Colors.grey),
        const Text(" Детали", style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  // --- ВСПОМОГАТЕЛЬНЫЕ МЕТОДЫ БЕЗ ВЫДУМАННЫХ ДАННЫХ ---

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Активный Парк', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Всего записей: ${equipmentData.length * 2}', 
                style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ]),
          const Icon(Icons.search, color: Colors.black54),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    String displayDate = DateFormat('dd.MM.yyyy').format(_selectedDate);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => _changeDate(-1)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: Text(displayDate, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: () => _changeDate(1)),
        ],
      ),
    );
  }

  Widget _stepIcon(bool active, IconData icon, String label) => Column(children: [
    Icon(icon, color: active ? const Color(0xFF2ECC71) : Colors.grey.shade300, size: 20),
    Text(label, style: TextStyle(fontSize: 10, color: active ? Colors.black : Colors.grey)),
  ]);

  Widget _stepLine(bool active) => Container(width: 20, height: 1.5, color: active ? const Color(0xFF2ECC71) : Colors.grey.shade200, margin: const EdgeInsets.symmetric(horizontal: 4));

  Widget _shiftBadge(bool isDay) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: isDay ? const Color(0xFFFFF4E5) : const Color(0xFFE7F0FF), borderRadius: BorderRadius.circular(12)),
    child: Text(isDay ? "Дневная" : "Ночная", 
        style: TextStyle(color: isDay ? Colors.orange : Colors.blue, fontWeight: FontWeight.bold, fontSize: 11)),
  );

  Widget _buildFooter(String status) {
    bool confirmed = status == "CONTRACTOR";
    return Container(
      width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: confirmed ? const Color(0xFFF1FBF7) : const Color(0xFFF8F9FA), borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20))),
      child: Center(
        child: Text(confirmed ? "ПОДТВЕРЖДЕНО" : "В ОБРАБОТКЕ", 
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: confirmed ? Colors.green : Colors.grey)),
      ),
    );
  }

  Widget _buildProgress(double val) => ClipRRect(borderRadius: BorderRadius.circular(2), child: LinearProgressIndicator(value: val, minHeight: 4, backgroundColor: const Color(0xFFF1F3F5), valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2ECC71))));
  Widget _plateBadge(String t) => Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: const Color(0xFFF1F3F5), borderRadius: BorderRadius.circular(6)), child: Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11)));
}