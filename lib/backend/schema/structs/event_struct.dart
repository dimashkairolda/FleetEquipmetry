// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventStruct extends BaseStruct {
  EventStruct({
    String? title,
    DateTime? start,
    DateTime? end,
  })  : _title = title,
        _start = start,
        _end = end;

  // "title" field.
  String? _title;
  String get title => _title ?? ' фывфыв';
  set title(String? val) => _title = val;

  bool hasTitle() => _title != null;

  // "start" field.
  DateTime? _start;
  DateTime get start =>
      _start ?? DateTime.fromMicrosecondsSinceEpoch(1713207600000000);
  set start(DateTime? val) => _start = val;

  bool hasStart() => _start != null;

  // "end" field.
  DateTime? _end;
  DateTime get end =>
      _end ?? DateTime.fromMicrosecondsSinceEpoch(1713211200000000);
  set end(DateTime? val) => _end = val;

  bool hasEnd() => _end != null;

  static EventStruct fromMap(Map<String, dynamic> data) => EventStruct(
        title: data['title'] as String?,
        start: data['start'] as DateTime?,
        end: data['end'] as DateTime?,
      );

  static EventStruct? maybeFromMap(dynamic data) =>
      data is Map ? EventStruct.fromMap(data.cast<String, dynamic>()) : null;

  Map<String, dynamic> toMap() => {
        'title': _title,
        'start': _start,
        'end': _end,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'title': serializeParam(
          _title,
          ParamType.String,
        ),
        'start': serializeParam(
          _start,
          ParamType.DateTime,
        ),
        'end': serializeParam(
          _end,
          ParamType.DateTime,
        ),
      }.withoutNulls;

  static EventStruct fromSerializableMap(Map<String, dynamic> data) =>
      EventStruct(
        title: deserializeParam(
          data['title'],
          ParamType.String,
          false,
        ),
        start: deserializeParam(
          data['start'],
          ParamType.DateTime,
          false,
        ),
        end: deserializeParam(
          data['end'],
          ParamType.DateTime,
          false,
        ),
      );

  @override
  String toString() => 'EventStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is EventStruct &&
        title == other.title &&
        start == other.start &&
        end == other.end;
  }

  @override
  int get hashCode => const ListEquality().hash([title, start, end]);
}

EventStruct createEventStruct({
  String? title,
  DateTime? start,
  DateTime? end,
}) =>
    EventStruct(
      title: title,
      start: start,
      end: end,
    );
