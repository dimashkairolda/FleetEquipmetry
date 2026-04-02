// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class InspectionsArchiveStruct extends BaseStruct {
  InspectionsArchiveStruct({
    int? inspectionID,
    InspectionsStruct? inspectionResponse,
  })  : _inspectionID = inspectionID,
        _inspectionResponse = inspectionResponse;

  // "InspectionID" field.
  int? _inspectionID;
  int get inspectionID => _inspectionID ?? 0;
  set inspectionID(int? val) => _inspectionID = val;

  void incrementInspectionID(int amount) =>
      inspectionID = inspectionID + amount;

  bool hasInspectionID() => _inspectionID != null;

  // "InspectionResponse" field.
  InspectionsStruct? _inspectionResponse;
  InspectionsStruct get inspectionResponse =>
      _inspectionResponse ?? InspectionsStruct();
  set inspectionResponse(InspectionsStruct? val) => _inspectionResponse = val;

  void updateInspectionResponse(Function(InspectionsStruct) updateFn) {
    updateFn(_inspectionResponse ??= InspectionsStruct());
  }

  bool hasInspectionResponse() => _inspectionResponse != null;

  static InspectionsArchiveStruct fromMap(Map<String, dynamic> data) =>
      InspectionsArchiveStruct(
        inspectionID: castToType<int>(data['InspectionID']),
        inspectionResponse: data['InspectionResponse'] is InspectionsStruct
            ? data['InspectionResponse']
            : InspectionsStruct.maybeFromMap(data['InspectionResponse']),
      );

  static InspectionsArchiveStruct? maybeFromMap(dynamic data) => data is Map
      ? InspectionsArchiveStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'InspectionID': _inspectionID,
        'InspectionResponse': _inspectionResponse?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'InspectionID': serializeParam(
          _inspectionID,
          ParamType.int,
        ),
        'InspectionResponse': serializeParam(
          _inspectionResponse,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static InspectionsArchiveStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      InspectionsArchiveStruct(
        inspectionID: deserializeParam(
          data['InspectionID'],
          ParamType.int,
          false,
        ),
        inspectionResponse: deserializeStructParam(
          data['InspectionResponse'],
          ParamType.DataStruct,
          false,
          structBuilder: InspectionsStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'InspectionsArchiveStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is InspectionsArchiveStruct &&
        inspectionID == other.inspectionID &&
        inspectionResponse == other.inspectionResponse;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([inspectionID, inspectionResponse]);
}

InspectionsArchiveStruct createInspectionsArchiveStruct({
  int? inspectionID,
  InspectionsStruct? inspectionResponse,
}) =>
    InspectionsArchiveStruct(
      inspectionID: inspectionID,
      inspectionResponse: inspectionResponse ?? InspectionsStruct(),
    );
