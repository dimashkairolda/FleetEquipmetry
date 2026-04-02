// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DriverStruct extends BaseStruct {
  DriverStruct({
    String? id,
    String? shift,
    String? title,
    String? dateArrival,
    String? dateDeparture,
    String? daysLeft,
  })  : _id = id,
        _shift = shift,
        _title = title,
        _dateArrival = dateArrival,
        _dateDeparture = dateDeparture,
        _daysLeft = daysLeft;

  // "id" field.
  String? _id;
  String get id => _id ?? '';
  set id(String? val) => _id = val;

  bool hasId() => _id != null;

  // "shift" field.
  String? _shift;
  String get shift => _shift ?? '';
  set shift(String? val) => _shift = val;

  bool hasShift() => _shift != null;

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "date_arrival" field.
  String? _dateArrival;
  String get dateArrival => _dateArrival ?? '';
  set dateArrival(String? val) => _dateArrival = val;

  bool hasDateArrival() => _dateArrival != null;

  // "date_departure" field.
  String? _dateDeparture;
  String get dateDeparture => _dateDeparture ?? '';
  set dateDeparture(String? val) => _dateDeparture = val;

  bool hasDateDeparture() => _dateDeparture != null;

  // "days_left" field.
  String? _daysLeft;
  String get daysLeft => _daysLeft ?? '';
  set daysLeft(String? val) => _daysLeft = val;

  bool hasDaysLeft() => _daysLeft != null;

  static DriverStruct fromMap(Map<String, dynamic> data) => DriverStruct(
        id: data['id'] as String?,
        shift: data['shift'] as String?,
        title: data['title'] as String?,
        dateArrival: data['date_arrival'] as String?,
        dateDeparture: data['date_departure'] as String?,
        daysLeft: data['days_left'] as String?,
      );

  static DriverStruct? maybeFromMap(dynamic data) =>
      data is Map ? DriverStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'id': _id,
        'shift': _shift,
        'title': _title,
        'date_arrival': _dateArrival,
        'date_departure': _dateDeparture,
        'days_left': _daysLeft,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'id': serializeParam(
          _id,
          ParamType.String,
        ),
        'shift': serializeParam(
          _shift,
          ParamType.String,
        ),
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'date_arrival': serializeParam(
          _dateArrival,
          ParamType.String,
        ),
        'date_departure': serializeParam(
          _dateDeparture,
          ParamType.String,
        ),
        'days_left': serializeParam(
          _daysLeft,
          ParamType.String,
        ),
      }.withoutNulls;

  static DriverStruct fromSerializableMap(Map<String, dynamic> data) =>
      DriverStruct(
        id: deserializeParam(
          data['id'],
          ParamType.String,
          false,
        ),
        shift: deserializeParam(
          data['shift'],
          ParamType.String,
          false,
        ),
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        dateArrival: deserializeParam(
          data['date_arrival'],
          ParamType.String,
          false,
        ),
        dateDeparture: deserializeParam(
          data['date_departure'],
          ParamType.String,
          false,
        ),
        daysLeft: deserializeParam(
          data['days_left'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'DriverStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is DriverStruct &&
        id == other.id &&
        shift == other.shift &&
        title == other.title &&
        dateArrival == other.dateArrival &&
        dateDeparture == other.dateDeparture &&
        daysLeft == other.daysLeft;
  }

  @override
  int get hashCode => const ListEquality()
      .hash([id, shift, title, dateArrival, dateDeparture, daysLeft]);
}

DriverStruct createDriverStruct({
  String? id,
  String? shift,
  String? title,
  String? dateArrival,
  String? dateDeparture,
  String? daysLeft,
}) =>
    DriverStruct(
      id: id,
      shift: shift,
      title: title,
      dateArrival: dateArrival,
      dateDeparture: dateDeparture,
      daysLeft: daysLeft,
    );
