// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ResultformStruct extends BaseStruct {
  ResultformStruct({
    String? response,
    String? comment,
    String? image,
    String? defect,
  })  : _response = response,
        _comment = comment,
        _image = image,
        _defect = defect;

  // "response" field.
  String? _response;
  String get response => _response ?? '';
  set response(String? val) => _response = val;

  bool hasResponse() => _response != null;

  // "comment" field.
  String? _comment;
  String get comment => _comment ?? '';
  set comment(String? val) => _comment = val;

  bool hasComment() => _comment != null;

  // "image" field.
  String? _image;
  String get image => _image ?? '';
  set image(String? val) => _image = val;

  bool hasImage() => _image != null;

  // "defect" field.
  String? _defect;
  String get defect => _defect ?? '';
  set defect(String? val) => _defect = val;

  bool hasDefect() => _defect != null;

  static ResultformStruct fromMap(Map<String, dynamic> data) =>
      ResultformStruct(
        response: data['response'] as String?,
        comment: data['comment'] as String?,
        image: data['image'] as String?,
        defect: data['defect'] as String?,
      );

  static ResultformStruct? maybeFromMap(dynamic data) => data is Map
      ? ResultformStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'response': _response,
        'comment': _comment,
        'image': _image,
        'defect': _defect,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'response': serializeParam(
          _response,
          ParamType.String,
        ),
        'comment': serializeParam(
          _comment,
          ParamType.String,
        ),
        'image': serializeParam(
          _image,
          ParamType.String,
        ),
        'defect': serializeParam(
          _defect,
          ParamType.String,
        ),
      }.withoutNulls;

  static ResultformStruct fromSerializableMap(Map<String, dynamic> data) =>
      ResultformStruct(
        response: deserializeParam(
          data['response'],
          ParamType.String,
          false,
        ),
        comment: deserializeParam(
          data['comment'],
          ParamType.String,
          false,
        ),
        image: deserializeParam(
          data['image'],
          ParamType.String,
          false,
        ),
        defect: deserializeParam(
          data['defect'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ResultformStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ResultformStruct &&
        response == other.response &&
        comment == other.comment &&
        image == other.image &&
        defect == other.defect;
  }

  @override
  int get hashCode =>
      const ListEquality().hash([response, comment, image, defect]);
}

ResultformStruct createResultformStruct({
  String? response,
  String? comment,
  String? image,
  String? defect,
}) =>
    ResultformStruct(
      response: response,
      comment: comment,
      image: image,
      defect: defect,
    );
