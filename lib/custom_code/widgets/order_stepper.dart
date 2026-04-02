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



class OrderStepper extends StatefulWidget {
  const OrderStepper({
    super.key,
    this.width,
    this.height,
    required this.currentStatus,
  });

  final double? width;
  final double? height;
  final String currentStatus;

  @override
  State<OrderStepper> createState() => _OrderStepperState();
}

class _OrderStepperState extends State<OrderStepper> {
  // Определяем визуальные этапы на основе вашей логики PROCUREMENT
  final List<Map<String, dynamic>> visualSteps = [
    {'title': 'Создана', 'description': 'Заявка опубликована', 'stepId': 1.0},
    {'title': 'Предложения', 'description': 'Получены КП', 'stepId': 2.0},
    {'title': 'Подтверждено', 'description': 'Поставщик принял', 'stepId': 3.0},
    {'title': 'Оплата', 'description': 'Счет оплачен', 'stepId': 4.0},
    {'title': 'Отгрузка', 'description': 'Товар отправлен', 'stepId': 5.0},
    {'title': 'Приемка', 'description': 'На складе', 'stepId': 6.0},
    {'title': 'Завершена', 'description': 'Сделка закрыта', 'stepId': 8.0},
  ];

  // Мапа для получения числового значения шага из технического статуса
  double getStepValue(String status) {
    final Map<String, double> statusToStep = {
      'NEW': 1.0,
      'AWAITING_APPROVAL_PUBLICATION': 1.05,
      'APPROVAL_PUBLICATION_DENIED': 1.05,
      'AWAITING_PUBLICATION': 1.1,
      'DRAFT': 1.2,
      'PUBLISHED': 2.0,
      'COMPARE_OFFERS': 2.0,
      'AWAITING_APPROVAL_APPROVER': 2.5,
      'APPROVAL_DENIED': 2.5,
      'AWAITING_APPROVAL_COUNTERPARTY': 3.0,
      'DENIED': 3.0,
      'AWAITING_PAYMENT': 4.0,
      'PAID': 4.0,
      'AWAITING_PAYMENT_VERIFICATION': 4.0,
      'CONFIRMED_PAYMENT': 5.0,
      'AWAITING_ORDER_CONFIRMATION': 6.0,
      'FINISHED': 8.0,
    };
    return statusToStep[status] ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    double currentStepValue = getStepValue(widget.currentStatus);

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: FlutterFlowTheme.of(context)
                                                        .alternate, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Прогресс заявки',
              style: TextStyle(
                fontFamily: 'Readex Pro',
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Divider(height: 1, thickness: 1, color: FlutterFlowTheme.of(context)
                                                        .alternate),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: visualSteps.length,
              itemBuilder: (context, index) {
                final step = visualSteps[index];
                final double stepId = step['stepId'];

                bool isDone = currentStepValue > stepId ||
                    (currentStepValue == 8.0 && stepId == 8.0);
                bool isCurrent = (currentStepValue >= stepId &&
                        currentStepValue <
                            (visualSteps.length > index + 1
                                ? visualSteps[index + 1]['stepId']
                                : 9.0)) &&
                    !isDone;

                // Специальная логика для "Завершена"
                if (widget.currentStatus == 'FINISHED' && stepId == 8.0) {
                  isDone = true;
                  isCurrent = false;
                }

                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Линия и иконка
                      Column(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: isCurrent
                                  ? Colors.blue
                                  : (isDone ? Colors.green : FlutterFlowTheme.of(context)
                                                        .primaryBackground),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isCurrent || isDone
                                    ? Colors.transparent
                                    : FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                width: 1,
                              ),
                            ),
                            child: Icon(
                              isDone
                                  ? Icons.check
                                  : (isCurrent
                                      ? Icons.circle
                                      : Icons.circle_outlined),
                              size: isCurrent ? 12 : 18,
                              color: isCurrent || isDone
                                  ? Colors.white
                                  : Color(0xFF94A3B8),
                            ),
                          ),
                          if (index != visualSteps.length - 1)
                            Expanded(
                              child: Container(
                                width: 2,
                                color: FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                              ),
                            ),
                        ],
                      ),
                      SizedBox(width: 12),
                      // Текст
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              step['title'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: isCurrent
                                    ? Colors.blue
                                    : (isDone ? Colors.green : FlutterFlowTheme.of(context)
                                                        .primaryText),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              step['description'],
                              style: TextStyle(
                                color: Color(0xFF64748B),
                                fontSize: 12,
                              ),
                            ),
                            if (isCurrent)
                              Container(
                                margin: EdgeInsets.only(top: 4),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.circle,
                                        size: 8, color: Colors.blue),
                                    SizedBox(width: 4),
                                    Text(
                                      'Текущий этап',
                                      style: TextStyle(
                                          fontSize: 11, color: Colors.blue),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}