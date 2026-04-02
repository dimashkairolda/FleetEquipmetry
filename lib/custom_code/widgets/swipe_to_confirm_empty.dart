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

import '/auth/custom_auth/auth_util.dart';
import 'package:swipeable_button/swipeable_button.dart';
import '/backend/api_requests/api_calls.dart';
import '/naryads/naryads_offline/naryads_offline_widget.dart';

class SwipeToConfirmEmpty extends StatefulWidget {
  final double width;
  final double height;
  final String id;
  final dynamic idd;
  final List<dynamic> defects;

  const SwipeToConfirmEmpty({
    Key? key,
    required this.id,
    required this.idd,
    required this.defects,
    this.width = double.infinity,
    this.height = 60,
  }) : super(key: key);

  @override
  _SwipeToConfirmEmptyState createState() => _SwipeToConfirmEmptyState();
}

class _SwipeToConfirmEmptyState extends State<SwipeToConfirmEmpty> {
  bool isSwiped = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        color: isSwiped ? Colors.white : Colors.green,
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.circular(7.0),
      ),
      child: SwipeableButton.simpleSlidable(
        label: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              isSwiped ? "Завершен" : "Завершить",
              style: TextStyle(
                color: isSwiped ? Colors.white : Colors.green,
                fontSize: 16.0,
              ),
            ),
          ),
        ),
        oneTime: true,
        minThumbWidth: 50,
        color: isSwiped ? Colors.green : Colors.white,
        thumbColor: isSwiped ? Colors.white : Colors.green,
        thumbIconColor: isSwiped ? Colors.green : Colors.white,
        onSwipe: () async {
          bool shouldUpdateState = false;

          // Обновляем статус дефектов
          for (var defect in widget.defects) {
            await StatusfixedCall.call(
              access: currentAuthenticationToken,
              id: getJsonField(defect, r'''$.id''').toString(),
              work: FFAppState().workspace,
            );
          }

          // Финализация наряда
          await NaryadsFinalizeCall.call(
            access: currentAuthenticationToken,
            id: widget.id,
            work: FFAppState().workspace,
          );
          shouldUpdateState = true;

          // Навигация

          if (mounted) {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => NaryadsOfflineWidget(
                  json: getJsonField(widget.idd, r'''$'''),
                ),
              ),
            );
          }

          // Обновляем UI
          if (shouldUpdateState && mounted) {
            setState(() {
              isSwiped = true;
            });
          }
        },
      ),
    );
  }
}
