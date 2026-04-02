// Automatic FlutterFlow imports
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

Future<void> showDateRangePickerDialog(BuildContext context) async {
  DateTimeRange? pickedRange = await showDateRangePicker(
    context: context,
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
    initialDateRange: FFAppState().dateot != null && FFAppState().datedo != null
        ? DateTimeRange(start: FFAppState().dateot!, end: FFAppState().datedo!)
        : null,
  );

  if (pickedRange != null) {
    FFAppState().dateot = pickedRange.start;
    FFAppState().datedo = pickedRange.end;
  }
}
// Set your action name, define your arguments and return parameter,
// and then add the boilerplate code using the green button on the right!
