// ignore_for_file: unnecessary_getters_setters
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/widgets/manual_K_P_editor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

/// Ручное редактирование КП — только до этапа утверждения заказа (после сравнения предложений кнопку убираем).
bool _procurementAllowsEditManualKp(String status) {
  switch (status) {
    case 'AWAITING_APPROVAL_COUNTERPARTY':
    case 'CONFIRMED_KP':
    case 'CONFIRMED_PARTIALLY_KP':
    case 'AWAITING_PAYMENT':
    case 'PAID':
    case 'AWAITING_PAYMENT_VERIFICATION':
    case 'AWAITING_SHIPMENT':
    case 'CONFIRMED_PAYMENT':
    case 'SENT':
    case 'AWAITING_ORDER_CONFIRMATION':
    case 'FINISHED':
    case 'REJECTED_KP':
    case 'DENIED':
      return false;
    default:
      return true;
  }
}

class ProcurementOffersList extends StatefulWidget {
  const ProcurementOffersList({
    Key? key,
    this.width,
    this.height,
    required this.sentCounterpartyOffers,
    required this.sentInventoryItems,
    required this.currentUserId,
    required this.procurementId,
    required this.procurementStatus,
    required this.authToken,
    this.confirmOrderAction,
    this.onRefresh,
  }) : super(key: key);

  final double? width;
  final double? height;
  final List<dynamic>? sentCounterpartyOffers;
  final List<dynamic>? sentInventoryItems;
  final String currentUserId;
  final String procurementId;
  final String procurementStatus;
  final String authToken;
  final Future<dynamic> Function(String? itemId, String? offerId)? confirmOrderAction;
  final Future<dynamic> Function()? onRefresh;

  @override
  _ProcurementOffersListState createState() => _ProcurementOffersListState();
}

class _ProcurementOffersListState extends State<ProcurementOffersList> {
  final currencyFormat = NumberFormat.currency(locale: 'ru_KZ', symbol: '₸', decimalDigits: 0);
  
  bool _isProcessing = false;
  bool _grnGenerated = false;
  bool _waybillGenerated = false;
  
  // Изменено на Set для отслеживания конкретных офферов
  Set<String> _uploadedPaymentOfferIds = {};

  double calculateItemPrice(dynamic price, dynamic quantity) {
    if (price == null || quantity == null) return 0.0;
    double p = (price is int) ? price.toDouble() : (price is double) ? price : double.tryParse(price.toString()) ?? 0.0;
    double q = (quantity is int) ? quantity.toDouble() : (quantity is double) ? quantity : double.tryParse(quantity.toString()) ?? 0.0;
    return p * q;
  }

  // --- ЛОГИКА API ---

  Future<void> _generateDocument(String type) async {
    setState(() => _isProcessing = true);
    final url = 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${widget.procurementId}/$type';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': widget.authToken,
          'workspace': FFAppState().workspace,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          if (type == 'grn') _grnGenerated = true;
          if (type == 'waybill') _waybillGenerated = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Документ сформирован"), backgroundColor: Color(0xFF22C55E)),
        );
        if (widget.onRefresh != null) await widget.onRefresh!();
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _confirmPayment(String cpId) async {
    setState(() => _isProcessing = true);
    final url = 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${widget.procurementId}/payment/confirm';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': widget.authToken,
          'workspace': FFAppState().workspace,
          'Content-Type': 'application/json',
        },
        body: jsonEncode({"counterparty_id": cpId}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Оплата подтверждена"), backgroundColor: Color(0xFF22C55E)),
        );
        if (widget.onRefresh != null) await widget.onRefresh!();
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<String?> _uploadToStore(File file) async {
    final url = Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/object/upload');
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll({'Authorization': widget.authToken, 'workspace': FFAppState().workspace});
    request.files.add(await http.MultipartFile.fromPath('files', file.path, contentType: MediaType('application', 'octet-stream')));

    var response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200 || response.statusCode == 201) {
      final dynamic data = jsonDecode(response.body);
      return (data is List) ? data.first.toString() : data.toString();
    }
    return null;
  }

  Future<void> _pickAndUploadPaymentProof(String offerId) async {
    final result = await _pickFileFlow();
    if (result != null) {
      setState(() => _isProcessing = true);
      try {
        final fileUrl = await _uploadToStore(File(result));
        if (fileUrl != null) {
          await _submitPaymentProof(offerId, fileUrl);
        }
      } finally {
        setState(() => _isProcessing = false);
      }
    }
  }

  Future<void> _submitPaymentProof(String offerId, String fileUrl) async {
    final url = 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${widget.procurementId}/kp/proof-of-payment';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Authorization': widget.authToken, 'workspace': FFAppState().workspace, 'Content-Type': 'application/json'},
      body: jsonEncode({"offer_id": offerId, "proof_of_payment": fileUrl}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      setState(() => _uploadedPaymentOfferIds.add(offerId));
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Платежка загружена"), backgroundColor: Colors.green));
      if (widget.onRefresh != null) await widget.onRefresh!();
    }
  }

  // --- ЛОГИКА УТВЕРЖДЕНИЯ ---

  Map<String, String> get _procurementHttpHeaders => {
        'Authorization': widget.authToken,
        'workspace': FFAppState().workspace,
      };

  Future<Map<String, List<dynamic>>> _fetchCompaniesAndWarehouses() async {
    final ws = FFAppState().workspace.trim();
    if (ws.isEmpty) {
      throw Exception('Workspace не выбран');
    }
    final cUri = Uri.parse(
        'https://fleet.equipmetry.kz/api/v1/workspace/companies?workspace_id=$ws');
    final wUri =
        Uri.parse('https://fleet.equipmetry.kz/api/v1/workspace/warehouse');
    final cRes = await http.get(cUri, headers: _procurementHttpHeaders);
    final wRes = await http.get(wUri, headers: _procurementHttpHeaders);
    if (cRes.statusCode != 200) {
      throw Exception('Компании: HTTP ${cRes.statusCode}');
    }
    if (wRes.statusCode != 200) {
      throw Exception('Склады: HTTP ${wRes.statusCode}');
    }
    final cDecoded = jsonDecode(utf8.decode(cRes.bodyBytes));
    final wDecoded = jsonDecode(utf8.decode(wRes.bodyBytes));
    final companies = cDecoded is List ? cDecoded : <dynamic>[];
    final warehouses = wDecoded is List ? wDecoded : <dynamic>[];
    return {'companies': companies, 'warehouses': warehouses};
  }

  Future<void> _showConfirmDialog(List<Map<String, String>> confirmedOffers, String counterpartyId, bool isInternal) async {
    final TextEditingController commentController = TextEditingController();
    final TextEditingController titleController = TextEditingController();
    String? invoiceUrl;
    DateTime? invoiceDate;
    bool isUploadingInvoice = false;
    String? selectedCompanyId;
    String? selectedWarehouseId;
    final refsFuture = _fetchCompaniesAndWarehouses();

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setStateSheet) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
            child: SingleChildScrollView(
              child: Column(
            mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  Text("Утверждение заказа",
                      style: FlutterFlowTheme.of(context).headlineSmall),
                  const SizedBox(height: 16),
                  FutureBuilder<Map<String, List<dynamic>>>(
                    future: refsFuture,
                    builder: (context, snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                              child: SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2))),
                        );
                      }
                      if (snap.hasError) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(
                            'Не удалось загрузить компании и склады: ${snap.error}',
                            style: TextStyle(
                                color: Colors.red.shade700, fontSize: 13),
                          ),
                        );
                      }
                      final companies = snap.data!['companies'] ?? <dynamic>[];
                      final warehouses =
                          snap.data!['warehouses'] ?? <dynamic>[];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Компания",
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedCompanyId,
                            decoration: InputDecoration(
                              hintText: "Выберите компанию",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                            items: [
                              for (final c in companies)
                                if (c is Map &&
                                    c['id'] != null &&
                                    c['id'].toString().isNotEmpty)
                                  DropdownMenuItem<String>(
                                    value: c['id'].toString(),
                                    child: Text(
                                      c['name']?.toString() ?? '—',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            ],
                            onChanged: (v) =>
                                setStateSheet(() => selectedCompanyId = v),
                          ),
                          const SizedBox(height: 16),
                          Text("Склад назначения",
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .copyWith(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: selectedWarehouseId,
                            decoration: InputDecoration(
                              hintText: "Выберите склад",
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 10),
                            ),
                            items: [
                              for (final w in warehouses)
                                if (w is Map &&
                                    w['id'] != null &&
                                    w['id'].toString().isNotEmpty)
                                  DropdownMenuItem<String>(
                                    value: w['id'].toString(),
                                    child: Text(
                                      w['name']?.toString() ?? '—',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                            ],
                            onChanged: (v) =>
                                setStateSheet(() => selectedWarehouseId = v),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),

                  // Счёт на оплату (загрузка файла)
                  Text("Счёт на оплату",
                      style: FlutterFlowTheme.of(context).bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                  if (isUploadingInvoice) const LinearProgressIndicator(),
                  if (invoiceUrl == null)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Загрузить счёт"),
                    onPressed: () async {
                      final path = await _pickFileFlow();
                      if (path != null) {
                            setStateSheet(() => isUploadingInvoice = true);
                        final url = await _uploadToStore(File(path));
                            setStateSheet(() {
                              invoiceUrl = url;
                              isUploadingInvoice = false;
                            });
                      }
                    },
                      ),
                  )
                else
                  Row(children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 8),
                      const Expanded(
                          child: Text("Файл загружен",
                              style: TextStyle(fontSize: 12))),
                      IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () =>
                              setStateSheet(() => invoiceUrl = null)),
                    ]),

                  const SizedBox(height: 16),

                  // Название счёта
                  Text("Название счёта",
                      style: FlutterFlowTheme.of(context).bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      hintText: "Введите название",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Дата счёта
                  Text("Дата счёта",
                      style: FlutterFlowTheme.of(context).bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setStateSheet(() => invoiceDate = picked);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: FlutterFlowTheme.of(context).alternate),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        invoiceDate != null
                            ? "${invoiceDate!.year}-${invoiceDate!.month.toString().padLeft(2, '0')}-${invoiceDate!.day.toString().padLeft(2, '0')}"
                            : "Выберите дату",
                        style: TextStyle(
                          color: invoiceDate != null
                              ? FlutterFlowTheme.of(context).primaryText
                              : FlutterFlowTheme.of(context).secondaryText,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Комментарий
                  Text("Комментарий",
                      style: FlutterFlowTheme.of(context).bodyMedium
                          .copyWith(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: commentController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Введите комментарий",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8)),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                              minimumSize: const Size.fromHeight(48)),
                          child: const Text("Отмена"),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isUploadingInvoice
                              ? null
                              : () async {
                                  if (selectedCompanyId == null ||
                                      selectedWarehouseId == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Выберите компанию и склад назначения'),
                                      ),
                                    );
                                    return;
                                  }
                                  Navigator.pop(context);
                                  await _sendConfirmationApi(
                                    confirmedOffers,
                                    commentController.text,
                                    invoiceUrl,
                                    counterpartyId,
                                    invoiceTitle: titleController.text,
                                    invoiceDate: invoiceDate,
                                    companyId: selectedCompanyId!,
                                    warehouseId: selectedWarehouseId!,
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF22C55E),
                            minimumSize: const Size.fromHeight(48),
                          ),
                          child: const Text("Утвердить",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
              ),
            ],
          ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _sendConfirmationApi(
    List<Map<String, String>> offers,
    String comment,
    String? invoiceUrl,
    String cpId, {
    String? invoiceTitle,
    DateTime? invoiceDate,
    required String companyId,
    required String warehouseId,
  }) async {
    setState(() => _isProcessing = true);
    final url =
        'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${widget.procurementId}/kp/confirm';
    final String? invoiceDateStr = invoiceDate != null
        ? "${invoiceDate.year}-${invoiceDate.month.toString().padLeft(2, '0')}-${invoiceDate.day.toString().padLeft(2, '0')}"
        : null;
    final body = jsonEncode({
      "offers_confirmed": offers,
      "comment": comment.isEmpty ? null : comment,
      "invoice_for_payment": invoiceUrl,
      "counterparty_id": cpId,
      "price_new": null,
      "invoice_title": (invoiceTitle?.isEmpty ?? true) ? null : invoiceTitle,
      "invoice_date": invoiceDateStr,
      "company_id": companyId,
      "warehouse_id": warehouseId,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': widget.authToken,
          'workspace': FFAppState().workspace,
          'Content-Type': 'application/json'
        },
        body: body,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Заказ утвержден"),
              backgroundColor: Colors.green),
        );
        if (widget.onRefresh != null) await widget.onRefresh!();
      }
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  // --- ХЕЛПЕРЫ ВЫБОРА ФАЙЛА ---

  Future<String?> _pickFileFlow() async {
    final source = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(leading: const Icon(Icons.camera_alt), title: const Text('Камера'), onTap: () => Navigator.pop(context, 'camera')),
            ListTile(leading: const Icon(Icons.file_upload), title: const Text('Файл'), onTap: () => Navigator.pop(context, 'file')),
          ],
        ),
      ),
    );
    if (source == null) return null;
    if (source == 'camera') {
      final picker = ImagePicker();
      final photo = await picker.pickImage(source: ImageSource.camera);
      return photo?.path;
    } else {
      final result = await FilePicker.platform.pickFiles();
      return result?.files.single.path;
    }
  }

  // --- ЛОГИКА ПРИЕМА ТОВАРА ---

  Future<void> _showAcceptGoodsDialog(List<Map<String, String>> itemsToConfirm) async {
    bool? result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Принять товар"),
        content: const Text("Вы подтверждаете получение товаров?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Нет")),
          ElevatedButton(onPressed: () => Navigator.pop(context, true), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF22C55E)), child: const Text("Да, принять")),
        ],
      ),
    );
    if (result == true) {
      setState(() => _isProcessing = true);
      final url = 'https://fleet.equipmetry.kz/api/v1/workspace/procurement/${widget.procurementId}/order/confirm';
      try {
        final res = await http.post(Uri.parse(url), headers: {'Authorization': widget.authToken, 'workspace': FFAppState().workspace, 'Content-Type': 'application/json'}, body: jsonEncode({"offers_confirmed": itemsToConfirm}));
        if (res.statusCode == 200 || res.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Товары приняты"), backgroundColor: Colors.green));
          if (widget.onRefresh != null) await widget.onRefresh!();
        }
      } finally {
        setState(() => _isProcessing = false);
      }
    }
  }

  // --- РЕДАКТИРОВАНИЕ КП ---

  Future<void> _openEditKP(dynamic deliveryOffer) async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor:
              FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor:
                FlutterFlowTheme.of(context).secondaryBackground,
            leading: IconButton(
              icon: Icon(Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).primaryText),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'Редактировать КП',
              style: TextStyle(
                fontFamily: 'SFProText',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: FlutterFlowTheme.of(context).primaryText,
              ),
            ),
            elevation: 0,
          ),
          body: ManualKPEditor(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.9,
            procurementId: widget.procurementId,
            authToken: widget.authToken,
            workspaceId: FFAppState().workspace,
            offerData: deliveryOffer,
            inventoryItems: widget.sentInventoryItems ?? [],
          ),
        ),
      ),
    );

    if (result == true && widget.onRefresh != null) {
      await widget.onRefresh!();
    }
  }

  // --- UI ВЕРСТКА ---

  Widget _smallActionBtn(String text, IconData icon, VoidCallback onTap, {Color color = const Color(0xFF3466E7)}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(icon, size: 14, color: color), const SizedBox(width: 4), Text(text, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600))]),
      ),
    );
  }

  void _showDocumentsBottomSheet(dynamic offer) {
    final docs = [
      {'title': 'Счет на оплату', 'url': offer['invoice_for_payment']},
      {'title': 'Платёжка', 'url': offer['proof_of_payment']},
      {'title': 'GRN', 'url': offer['goods_receipt_note']},
      {'title': 'Накладная', 'url': offer['waybill']},
    ].where((d) => d['url'] != null && d['url'].toString().isNotEmpty).toList();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground, borderRadius: const BorderRadius.vertical(top: Radius.circular(20))),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Документы', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            if (docs.isEmpty) const Center(child: Text('Нет документов')),
            ...docs.map((doc) => ListTile(leading: const Icon(Icons.description_outlined), title: Text(doc['title']!), trailing: const Icon(Icons.open_in_new), onTap: () => launchURL(doc['url']!))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final rootOffers = (widget.sentCounterpartyOffers ?? []).where((o) => o['status'] != 'REJECTED').toList();
    final allItems = widget.sentInventoryItems ?? [];
    final isSupplier = FFAppState().STO == "Поставщик";
    final currentUserEmail = (getJsonField(
          FFAppState().result,
          r'''$.user.email''',
        )?.toString() ??
            '')
        .trim()
        .toLowerCase();

    final filteredOffers = isSupplier
        ? rootOffers.where((offer) => offer['counterparty']?['id']?.toString() == widget.currentUserId).toList()
        : rootOffers;

    if (filteredOffers.isEmpty) return Center(child: Text("Нет предложений", style: FlutterFlowTheme.of(context).bodyMedium));

    return Stack(
      children: [
        ListView.builder(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 250),
          itemCount: filteredOffers.length,
          itemBuilder: (context, index) {
            final deliveryOffer = filteredOffers[index];
            final String offerId = deliveryOffer['id'].toString();
            final counterparty = deliveryOffer['counterparty'] ?? {};
            final supplierId = counterparty['id'];
            final supplierTitle = counterparty['title'] ?? 'Неизвестный поставщик';
            final supplierEmail =
                (counterparty['email']?.toString() ?? '').trim().toLowerCase();
            final bool isInternal = deliveryOffer['counterparty_type'] == 'INTERNAL';

            bool hasGrn = deliveryOffer['goods_receipt_note'] != null && deliveryOffer['goods_receipt_note'].toString().isNotEmpty;
            bool hasWaybill = deliveryOffer['waybill'] != null && deliveryOffer['waybill'].toString().isNotEmpty;
            bool hasPaymentProof = deliveryOffer['proof_of_payment'] != null && deliveryOffer['proof_of_payment'].toString().isNotEmpty;

            List<Map<String, dynamic>> supplierGoods = [];
            List<Map<String, String>> confirmedItemsForKp = [];
            List<Map<String, String>> confirmedItemsForOrder = [];
            double goodsTotalCost = 0.0;
            final List<dynamic> deliveryItemOffers =
                deliveryOffer['inventory_item_offers'] ?? [];

            for (var item in allItems) {
              List<dynamic> itemOffers = item['offers'] ?? [];
              var matched = itemOffers.firstWhere((off) => off['counterparty']?['id'] == supplierId && (off['status'] != 'REJECTED'), orElse: () => null);

              if (matched == null && deliveryItemOffers.isNotEmpty) {
                final dynamic manualMatched = deliveryItemOffers.firstWhere(
                  (off) => off['id']?.toString() == item['id']?.toString(),
                  orElse: () => null,
                );
                if (manualMatched != null) {
                  matched = {
                    ...Map<String, dynamic>.from(deliveryOffer),
                    ...Map<String, dynamic>.from(manualMatched),
                    'counterparty': deliveryOffer['counterparty'],
                    'status': manualMatched['status'] ?? deliveryOffer['status'],
                  };
                }
              }

              if (matched != null) {
                supplierGoods.add({'inventory_item': item, 'offer': matched});
                goodsTotalCost += calculateItemPrice(matched['price'], item['quantity']);
                if (matched['status'] == 'SELECTED') confirmedItemsForKp.add({"inventory_item_id": item['id'].toString(), "offer_id": matched['id'].toString()});
                if (matched['status'] == 'SENT') confirmedItemsForOrder.add({"inventory_item_id": item['id'].toString(), "offer_id": matched['id'].toString()});
              }
            }

            bool usedEmptyPlaceholder = false;
            if (supplierGoods.isEmpty && allItems.isNotEmpty) {
              usedEmptyPlaceholder = true;
              supplierGoods = allItems
                  .map((item) => {
                        'inventory_item': item,
                        'offer': {
                          ...Map<String, dynamic>.from(deliveryOffer),
                          'id': deliveryOffer['id'],
                          'price': 0,
                          'characteristic': null,
                        },
                      })
                  .toList();
            }

            if (supplierGoods.isEmpty) return const SizedBox();

            final bool isOwnOffer =
                supplierId?.toString() == widget.currentUserId ||
                    (currentUserEmail.isNotEmpty &&
                        supplierEmail == currentUserEmail);
            final bool showEditKp = isOwnOffer ||
                (!isSupplier &&
                    (isInternal ||
                        usedEmptyPlaceholder ||
                        deliveryOffer['is_manual'] == true ||
                        deliveryOffer['manual_kp'] == true ||
                        deliveryOffer['manual_kp_entry'] == true ||
                        deliveryOffer['counterparty_type']?.toString().toUpperCase() ==
                            'MANUAL'));
            double grandTotal = goodsTotalCost + (deliveryOffer['price'] ?? 0).toDouble();

            // --- УСЛОВИЯ ВИДИМОСТИ КНОПОК ---
            bool canManage = isSupplier || (!isSupplier && isInternal);
            
            bool isAwaitingApproval = widget.procurementStatus == 'AWAITING_APPROVAL_COUNTERPARTY';
            bool isAwaitingPayment = widget.procurementStatus == 'AWAITING_PAYMENT';
            bool isPaid = widget.procurementStatus == 'PAID';
            bool isAwaitingShipment = widget.procurementStatus == 'AWAITING_SHIPMENT';
            bool isAwaitingOrder = widget.procurementStatus == 'AWAITING_ORDER_CONFIRMATION';

            bool showConfirmBtn = isAwaitingApproval && confirmedItemsForKp.isNotEmpty && canManage;
            bool showPaymentBtn = isAwaitingPayment && !isSupplier && !hasPaymentProof && !_uploadedPaymentOfferIds.contains(offerId);
            bool showPaymentConfirmBtn = isPaid && !isSupplier && isInternal; // КНОПКА ПОДТВЕРДИТЬ ОПЛАТУ
            bool showGenerateDocs = isAwaitingShipment && canManage;
            bool showAcceptGoodsBtn = isAwaitingOrder && confirmedItemsForOrder.isNotEmpty && !isSupplier;

            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                decoration: BoxDecoration(color: FlutterFlowTheme.of(context).secondaryBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: FlutterFlowTheme.of(context).alternate)),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(width: 40, height: 40, decoration: BoxDecoration(color: const Color(0xFFE8F0FE), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.business, color: Color(0xFF3466E7))),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text(supplierTitle, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))), _buildStatusBadge(deliveryOffer['status'])]),
                                    const SizedBox(height: 8),
                                    Wrap(
                                      spacing: 8, runSpacing: 8,
                                      children: [
                                        _smallActionBtn('Документы', Icons.folder_open, () => _showDocumentsBottomSheet(deliveryOffer)),
                                        if (showEditKp &&
                                            _procurementAllowsEditManualKp(
                                                widget.procurementStatus))
                                          _smallActionBtn(
                                              'Редактировать КП',
                                              Icons.edit,
                                              () => _openEditKP(deliveryOffer),
                                              color: const Color(0xFF6C63FF)),
                                        if (showPaymentBtn) _smallActionBtn('Загрузить платежку', Icons.payment, () => _pickAndUploadPaymentProof(offerId), color: const Color(0xFF4B39EF)),
                                        if (showPaymentConfirmBtn) _smallActionBtn('Подтвердить оплату', Icons.check_circle_outline, () => _confirmPayment(supplierId.toString()), color: const Color(0xFF22C55E)),
                                        if (showGenerateDocs) ...[
                                          if (!hasGrn && !_grnGenerated) _smallActionBtn('Сформировать GRN', Icons.assignment_turned_in, () => _generateDocument('grn'), color: const Color(0xFFFB8C00)),
                                          if (!hasWaybill && !_waybillGenerated) _smallActionBtn('Сформировать накладную', Icons.receipt_long, () => _generateDocument('waybill'), color: const Color(0xFF3466E7)),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          _buildStats(goodsTotalCost, (deliveryOffer['price'] ?? 0).toDouble(), grandTotal, deliveryOffer['delivery_time']),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: FlutterFlowTheme.of(context).alternate),
                    ...supplierGoods.map((g) => _buildItemCard(g['inventory_item'], g['offer'])),
                    
                    if (showConfirmBtn)
                      Padding(padding: const EdgeInsets.all(16.0), child: FFButtonWidget(onPressed: () => _showConfirmDialog(confirmedItemsForKp, supplierId.toString(), isInternal), text: 'Утвердить заказ', options: FFButtonOptions(width: double.infinity, height: 48, color: const Color(0xFF22C55E), textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), borderRadius: BorderRadius.circular(12)))),
                    
                    if (showAcceptGoodsBtn)
                       Padding(padding: const EdgeInsets.all(16.0), child: FFButtonWidget(onPressed: () => _showAcceptGoodsDialog(confirmedItemsForOrder), text: 'Принять товар', options: FFButtonOptions(width: double.infinity, height: 48, color: const Color(0xFF3466E7), textStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold), borderRadius: BorderRadius.circular(12)))),
                  ],
                ),
              ),
            );
          },
        ),
        if (_isProcessing) Container(color: Colors.black26, child: const Center(child: CircularProgressIndicator())),
      ],
    );
  }

  Widget _buildStats(double goods, double delivery, double total, dynamic time) {
    return Column(children: [Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_statCol("Товары:", currencyFormat.format(goods)), _statCol("Доставка:", currencyFormat.format(delivery))]), const SizedBox(height: 12), Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [_statCol("Итого:", currencyFormat.format(total), isPrimary: true), _statCol("Срок:", "${time ?? '-'} дн.")])]);
  }

  Widget _statCol(String label, String val, {bool isPrimary = false}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: const TextStyle(fontSize: 11, color: Color(0xFF8291B0))), Text(val, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isPrimary ? const Color(0xFF3466E7) : Colors.black))]);
  }

  Widget _buildItemCard(dynamic item, dynamic offer) {
    bool isSel = offer['status'] == 'SELECTED' || offer['status'] == 'FINISHED' || offer['status'] == 'SENT';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: FlutterFlowTheme.of(context).primaryBackground, borderRadius: BorderRadius.circular(12), border: Border.all(color: isSel ? const Color(0xFFFFB366) : Colors.transparent, width: 1.5)),
      child: Row(children: [
        Icon(isSel ? Icons.access_time_filled : Icons.inventory_2, color: isSel ? const Color(0xFFFB8C00) : Colors.grey),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item['title'] ?? 'Товар', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Арт: ${item['product_article'] ?? '-'} • ${item['quantity']} шт", style: const TextStyle(fontSize: 11, color: Colors.grey)),
          Text("${currencyFormat.format(offer['price'])} x ${item['quantity']} = ${currencyFormat.format(calculateItemPrice(offer['price'], item['quantity']))}", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
        ])),
      ]),
    );
  }

  Widget _buildStatusBadge(String? status) {
    String label = "В процессе"; Color color = const Color(0xFFFB8C00);
    if (status == 'FINISHED') { label = "Завершено"; color = const Color(0xFF22C55E); }
    if (status == 'SENT') { label = "Отгружено"; color = const Color(0xFF3466E7); }
    return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)));
  }
}