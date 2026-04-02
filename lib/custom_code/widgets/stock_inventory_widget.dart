// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:Equipmetry/backend/api_requests/api_calls.dart';
import 'package:Equipmetry/flutter_flow/flutter_flow_widgets.dart';


class StockInventoryWidget extends StatefulWidget {
  const StockInventoryWidget({
    Key? key,
    this.width,
    this.height,
    required this.itemsRequested,
    required this.id,
    required this.authToken,
    required this.workspace,
  }) : super(key: key);

  final double? width;
  final double? height;
  final dynamic itemsRequested;
  final String id;
  final String authToken;
  final String workspace;

  @override
  _StockInventoryWidgetState createState() => _StockInventoryWidgetState();
}

class _StockInventoryWidgetState extends State<StockInventoryWidget> {
  // Список сгруппированных товаров для отображения
  List<Map<String, dynamic>> groupedList = [];

  // Контроллеры для полей ввода (ключ = название товара)
  Map<String, TextEditingController> controllers = {};

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _groupAndPrepareData();
  }

  @override
  void dispose() {
    // Очищаем контроллеры при выходе
    controllers.forEach((_, controller) => controller.dispose());
    super.dispose();
  }

  // Логика группировки (объединяем одинаковые товары)
  void _groupAndPrepareData() {
    if (widget.itemsRequested == null) return;

    Map<String, dynamic> rawMap = {};
    if (widget.itemsRequested is Map) {
      rawMap = Map<String, dynamic>.from(widget.itemsRequested);
    }

    Map<String, Map<String, dynamic>> tempGrouped = {};

    for (var value in rawMap.values) {
      final item = Map<String, dynamic>.from(value);

      String title = item['title']?.toString() ?? 'Unknown';
      String article = item['product_article']?.toString() ?? '';
      double qty = double.tryParse(item['quantity'].toString()) ?? 0.0;

      // Уникальный ключ для группировки
      String uniqueKey = '$title|$article';

      if (tempGrouped.containsKey(uniqueKey)) {
        tempGrouped[uniqueKey]!['quantity'] += qty;
      } else {
        tempGrouped[uniqueKey] = {
          ...item, // Копируем все поля
          'quantity': qty, // Обновляемое количество
          'unique_key': uniqueKey,
        };
      }
    }

    // Превращаем в список и инициализируем контроллеры
    setState(() {
      groupedList = tempGrouped.values.toList();
      for (var item in groupedList) {
        // Создаем контроллер для каждого товара
        String key = item['unique_key'];
        controllers[key] = TextEditingController();
      }
    });
  }

  // Функция сохранения и отправки
  // Функция сохранения и отправки
  Future<void> _handleSave() async {
    setState(() => isLoading = true);

    try {
      // 1. Подготовка данных для отправки
      Map<String, dynamic> itemsInStock = {};
      Map<String, dynamic> itemsOutOfStock = {};

      for (var item in groupedList) {
        String key = item['unique_key'];
        String titleKey = item['title'].toString();

        double neededQty = double.parse(item['quantity'].toString());

        String textVal = controllers[key]?.text.replaceAll(',', '.') ?? '0';
        double inStockQty = double.tryParse(textVal) ?? 0.0;

        double outOfStockQty = 0.0;
        if (inStockQty >= neededQty) {
          outOfStockQty = 0.0;
        } else {
          outOfStockQty = neededQty - inStockQty;
        }

        // --- Заполняем items_in_stock ---
        if (inStockQty > 0) {
          itemsInStock[titleKey] = {
            ...item,
            // ИСПРАВЛЕНИЕ: Добавлено .toInt()
            'quantity': inStockQty.toInt(),
            'warehouse_id': '',
            'warehouse_name': '',
          };
          itemsInStock[titleKey].remove('unique_key');
        }

        // --- Заполняем items_out_of_stock ---
        if (outOfStockQty > 0) {
          itemsOutOfStock[titleKey] = {
            ...item,
            // ИСПРАВЛЕНИЕ: Добавлено .toInt()
            'quantity': outOfStockQty.toInt(),
            'price': null,
          };
          itemsOutOfStock[titleKey].remove('unique_key');
        }
      }

      // 2. Формируем итоговый Body
      final bodyJson = {
        "items_requested": widget.itemsRequested,
        "items_in_stock": itemsInStock,
        "items_out_of_stock": itemsOutOfStock,
      };

      // 3. Вызов API
      final apiResult = await OutOfStockCall.call(
        token: widget.authToken,
        id: widget.id,
        work: widget.workspace,
        bodyJson: bodyJson,
      );

      if ((apiResult.succeeded ?? true)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Успешно сохранено!',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.green,
            duration: Duration(milliseconds: 1500),
          ),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Ошибка API: ${apiResult.statusCode} ${apiResult.jsonBody}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print('Error saving stock: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      color: FlutterFlowTheme.of(context).primaryBackground,
      child: Column(
        children: [
          // --- Список товаров ---
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 80), // Место под кнопку
              itemCount: groupedList.length,
              itemBuilder: (context, index) {
                final item = groupedList[index];
                final String uniqueKey = item['unique_key'];
                final String title = item['title'] ?? 'ТМЦ';
                final String article = item['product_article'] ?? '-';
                final double totalQty =
                    double.parse(item['quantity'].toString());

                return Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 3,
                          color: Color(0x33000000),
                          offset: Offset(0, 1),
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Заголовок
                        Text(
                          title,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'SFProText',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        SizedBox(height: 4),
                        // Артикул
                        Text(
                          'Артикул: $article',
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                                fontFamily: 'SFProText',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                              ),
                        ),
                        Divider(height: 20),

                        // Ряд с инпутом
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Требуется:',
                                  style:
                                      FlutterFlowTheme.of(context).labelSmall,
                                ),
                                Text(
                                  totalQty.toStringAsFixed(
                                      0), // или .1 если дробное
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          FlutterFlowTheme.of(context).primary),
                                ),
                              ],
                            ),

                            // Поле ввода "В наличии"
                            Container(
                              width: 140,
                              child: TextFormField(
                                controller: controllers[uniqueKey],
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                decoration: InputDecoration(
                                  labelText: 'В наличии',
                                  labelStyle:
                                      FlutterFlowTheme.of(context).labelMedium,
                                  hintText: '0',
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                ),
                                style: FlutterFlowTheme.of(context).bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // --- Кнопка Сохранить ---
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            child: FFButtonWidget(onPressed: isLoading ? null : _handleSave,
              text: 'Сохранить',
              options: FFButtonOptions(
                height: 48,
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'SFProText',
                      color: Colors.white,
                      letterSpacing: 0.0,
                    ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              showLoadingIndicator: true,)
          ),
        ],
      ),
    );
  }
}
// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
