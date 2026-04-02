// ignore_for_file: unnecessary_getters_setters
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:Equipmetry/approvement/approvement/approvement_widget.dart';
import 'package:http/http.dart' as http;

// Импорт вашего виджета списка согласований для навигации назад
import '/index.dart'; 

class MobileApprovalPage extends StatefulWidget {
  const MobileApprovalPage({
    Key? key,
    this.width,
    this.height,
    required this.approvalData,
    required this.authToken,
    required this.currentUserId,
  }) : super(key: key);

  final double? width;
  final double? height;
  final dynamic approvalData;
  final String authToken;
  final String currentUserId;

  @override
  _MobileApprovalPageState createState() => _MobileApprovalPageState();
}

class _MobileApprovalPageState extends State<MobileApprovalPage> {
  bool _isProcessing = false;
  String? _localStatus; // Для отслеживания статуса после нажатия кнопок
  final currencyFormat = NumberFormat.currency(locale: 'ru_KZ', symbol: '₸', decimalDigits: 0);

  @override
  void initState() {
    super.initState();
    // Инициализируем статус из пришедших данных
    _localStatus = widget.approvalData['status'];
  }

  Future<void> _submitDecision(bool isApproved) async {
    String? comment;
    
    // Диалог ввода комментария
    await showDialog(
      context: context,
      builder: (context) {
        TextEditingController _commentController = TextEditingController();
        return AlertDialog(
          title: Text(isApproved ? "Согласовать" : "Отклонить"),
          content: TextField(
            controller: _commentController,
            decoration: const InputDecoration(hintText: "Ваш комментарий..."),
            maxLines: 3,
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text("Отмена")),
            ElevatedButton(
              onPressed: () {
                comment = _commentController.text;
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isApproved ? const Color(0xFF36B37E) : const Color(0xFFDE350B),
              ),
              child: const Text("Подтвердить", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );

    if (comment == null) return;

    setState(() => _isProcessing = true);
    final approvalId = widget.approvalData['id'];
    final url = 'https://fleet.equipmetry.kz/api/v1/workspace/approval/$approvalId';

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Authorization': widget.authToken,
          'workspace': FFAppState().workspace,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "approver_id": widget.currentUserId,
          "approved": isApproved,
          "comment": comment
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          // Меняем статус на любой отличный от pending, чтобы кнопки исчезли
          _localStatus = isApproved ? 'approved' : 'rejected';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isApproved ? "Заявка согласована" : "Заявка отклонена"),
            backgroundColor: isApproved ? Colors.green : Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.approvalData;
    final mainObject = (data['objects'] != null && data['objects'].isNotEmpty) ? data['objects'][0] : null;
    final bool isPending = _localStatus == 'pending';

    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30,
          borderWidth: 1,
          buttonSize: 60,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: FlutterFlowTheme.of(context).primaryText,
            size: 30,
          ),
          onPressed: () async {
            // Переход на страницу списка согласований
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Согласование #${data['short_id']}',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
                fontFamily: 'SFProText',
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
        ),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatusBadge(_localStatus),
                  const SizedBox(height: 8),
                  Text(data['title'] ?? 'Без названия', 
                      style: FlutterFlowTheme.of(context).headlineSmall.override(
                        fontFamily: 'SFProText', 
                        fontWeight: FontWeight.bold
                      )),
                  const SizedBox(height: 20),
                  
                  _buildSectionTitle("Детали заявки"),
                  _buildInfoCard([
                    _infoRow("Адрес доставки", mainObject?['delivery_address'] ?? '-'),
                    _infoRow("Закупщик", mainObject?['buyer']?['title'] ?? '-'),
                    _infoRow("Инициатор", data['author_name'] ?? '-'),
                    _infoRow("Дата создания", _formatDate(data['created_at'])),
                  ]),
                  
                  const SizedBox(height: 20),
                  _buildSectionTitle("Товары (${mainObject?['inventory_items']?.length ?? 0})"),
                  if (mainObject?['inventory_items'] != null)
                    ...mainObject['inventory_items'].map<Widget>((item) => _buildItemCard(item)).toList(),
                  
                  const SizedBox(height: 20),
                  _buildSectionTitle("Маршрут согласования"),
                  _buildApprovalRoute(data['approvers'] ?? []),
                ],
              ),
            ),

            // ПАНЕЛЬ КНОПОК
            if (isPending)
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () => _submitDecision(false),
                          text: 'Отклонить',
                          options: FFButtonOptions(
                            height: 50,
                            color: Colors.white,
                            textStyle: const TextStyle(color: Color(0xFFDE350B), fontWeight: FontWeight.bold),
                            borderSide: const BorderSide(color: Color(0xFFDE350B), width: 1.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: FFButtonWidget(
                          onPressed: () => _submitDecision(true),
                          text: 'Согласовать',
                          options: FFButtonOptions(
                            height: 50,
                            color: const Color(0xFF36B37E),
                            textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            
            if (_isProcessing)
              Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
          ],
        ),
      ),
    );
  }

  // --- ХЕЛПЕРЫ ВЕРСТКИ ---

  Widget _buildStatusBadge(String? status) {
    Color color = const Color(0xFF0052CC);
    String label = "Ожидает согласования";
    
    if (status == 'approved') { color = Colors.green; label = "Согласовано"; }
    if (status == 'rejected') { color = Colors.red; label = "Отклонено"; }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildItemCard(dynamic item) {
    // Находим цену из первого доступного оффера
    final offers = item['offers'] as List?;
    final price = (offers != null && offers.isNotEmpty) ? offers[0]['price'] : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item['title'] ?? 'Товар', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Text("Артикул: ${item['product_article'] ?? '-'}", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _miniStat("Кол-во", "${item['quantity']} ${item['unit_of_measurement']}"),
              _miniStat("Цена за ед.", currencyFormat.format(price)),
              _miniStat("Сумма", currencyFormat.format((item['quantity'] ?? 0) * price)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildApprovalRoute(List approvers) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...approvers.map((a) {
            // Определяем статус на основе поля 'approved'
            final bool? isApproved = a['approved'];
            
            String statusText;
            Color statusColor;
            IconData statusIcon;

            if (isApproved == true) {
              statusText = "Согласовано";
              statusColor = const Color(0xFF36B37E); // Зеленый
              statusIcon = Icons.check_circle;
            } else if (isApproved == false) {
              statusText = "Отклонено";
              statusColor = const Color(0xFFDE350B); // Красный
              statusIcon = Icons.cancel;
            } else {
              statusText = "Ожидает"; // Или "Неизвестно"
              statusColor = const Color(0xFFFF991F); // Оранжевый
              statusIcon = Icons.access_time_filled;
            }

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  Icon(statusIcon, color: statusColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          a['approver_name']?.toString().trim() ?? 'Неизвестный участник',
                          style: FlutterFlowTheme.of(context).bodyLarge.override(
                                fontFamily: 'SFProText',
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        Text(
                          statusText,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildInfoCard(List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context).alternate),
      ),
      child: Column(children: children),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 12),
          Expanded(child: Text(value, textAlign: TextAlign.end, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13))),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(title.toUpperCase(), style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1)),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return '-';
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd.MM.y HH:mm').format(date);
    } catch (e) { return dateStr; }
  }
}