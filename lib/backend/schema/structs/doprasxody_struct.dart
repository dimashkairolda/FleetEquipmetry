// ignore_for_file: unnecessary_getters_setters

import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DoprasxodyStruct extends BaseStruct {
  DoprasxodyStruct({
    String? technic,
    String? type,
    String? name,
    int? kolvo,
    int? cena,
    String? statya,
    int? summashtrafa,
    bool? skidka,
    DateTime? date,
    List<String>? images,
  })  : _technic = technic,
        _type = type,
        _name = name,
        _kolvo = kolvo,
        _cena = cena,
        _statya = statya,
        _summashtrafa = summashtrafa,
        _skidka = skidka,
        _date = date,
        _images = images;

  // "technic" field.
  String? _technic;
  String get technic => _technic ?? '';
  set technic(String? val) => _technic = val;

  bool hasTechnic() => _technic != null;

  // "type" field.
  String? _type;
  String get type => _type ?? '';
  set type(String? val) => _type = val;

  bool hasType() => _type != null;

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "kolvo" field.
  int? _kolvo;
  int get kolvo => _kolvo ?? 0;
  set kolvo(int? val) => _kolvo = val;

  void incrementKolvo(int amount) => kolvo = kolvo + amount;

  bool hasKolvo() => _kolvo != null;

  // "cena" field.
  int? _cena;
  int get cena => _cena ?? 0;
  set cena(int? val) => _cena = val;

  void incrementCena(int amount) => cena = cena + amount;

  bool hasCena() => _cena != null;

  // "statya" field.
  String? _statya;
  String get statya => _statya ?? '';
  set statya(String? val) => _statya = val;

  bool hasStatya() => _statya != null;

  // "summashtrafa" field.
  int? _summashtrafa;
  int get summashtrafa => _summashtrafa ?? 0;
  set summashtrafa(int? val) => _summashtrafa = val;

  void incrementSummashtrafa(int amount) =>
      summashtrafa = summashtrafa + amount;

  bool hasSummashtrafa() => _summashtrafa != null;

  // "skidka" field.
  bool? _skidka;
  bool get skidka => _skidka ?? false;
  set skidka(bool? val) => _skidka = val;

  bool hasSkidka() => _skidka != null;

  // "date" field.
  DateTime? _date;
  DateTime? get date => _date;
  set date(DateTime? val) => _date = val;

  bool hasDate() => _date != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  set images(List<String>? val) => _images = val;

  void updateImages(Function(List<String>) updateFn) {
    updateFn(_images ??= []);
  }

  bool hasImages() => _images != null;

  static DoprasxodyStruct fromMap(Map<String, dynamic> data) =>
      DoprasxodyStruct(
        technic: data['technic'] as String?,
        type: data['type'] as String?,
        name: data['name'] as String?,
        kolvo: castToType<int>(data['kolvo']),
        cena: castToType<int>(data['cena']),
        statya: data['statya'] as String?,
        summashtrafa: castToType<int>(data['summashtrafa']),
        skidka: data['skidka'] as bool?,
        date: data['date'] as DateTime?,
        images: getDataList(data['images']),
      );

  static DoprasxodyStruct? maybeFromMap(dynamic data) => data is Map
      ? DoprasxodyStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'technic': _technic,
        'type': _type,
        'name': _name,
        'kolvo': _kolvo,
        'cena': _cena,
        'statya': _statya,
        'summashtrafa': _summashtrafa,
        'skidka': _skidka,
        'date': _date,
        'images': _images,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'technic': serializeParam(
          _technic,
          ParamType.String,
        ),
        'type': serializeParam(
          _type,
          ParamType.String,
        ),
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'kolvo': serializeParam(
          _kolvo,
          ParamType.int,
        ),
        'cena': serializeParam(
          _cena,
          ParamType.int,
        ),
        'statya': serializeParam(
          _statya,
          ParamType.String,
        ),
        'summashtrafa': serializeParam(
          _summashtrafa,
          ParamType.int,
        ),
        'skidka': serializeParam(
          _skidka,
          ParamType.bool,
        ),
        'date': serializeParam(
          _date,
          ParamType.DateTime,
        ),
        'images': serializeParam(
          _images,
          ParamType.String,
          isList: true,
        ),
      }.withoutNulls;

  static DoprasxodyStruct fromSerializableMap(Map<String, dynamic> data) =>
      DoprasxodyStruct(
        technic: deserializeParam(
          data['technic'],
          ParamType.String,
          false,
        ),
        type: deserializeParam(
          data['type'],
          ParamType.String,
          false,
        ),
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        kolvo: deserializeParam(
          data['kolvo'],
          ParamType.int,
          false,
        ),
        cena: deserializeParam(
          data['cena'],
          ParamType.int,
          false,
        ),
        statya: deserializeParam(
          data['statya'],
          ParamType.String,
          false,
        ),
        summashtrafa: deserializeParam(
          data['summashtrafa'],
          ParamType.int,
          false,
        ),
        skidka: deserializeParam(
          data['skidka'],
          ParamType.bool,
          false,
        ),
        date: deserializeParam(
          data['date'],
          ParamType.DateTime,
          false,
        ),
        images: deserializeParam<String>(
          data['images'],
          ParamType.String,
          true,
        ),
      );

  @override
  String toString() => 'DoprasxodyStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is DoprasxodyStruct &&
        technic == other.technic &&
        type == other.type &&
        name == other.name &&
        kolvo == other.kolvo &&
        cena == other.cena &&
        statya == other.statya &&
        summashtrafa == other.summashtrafa &&
        skidka == other.skidka &&
        date == other.date &&
        listEquality.equals(images, other.images);
  }

  @override
  int get hashCode => const ListEquality().hash([
        technic,
        type,
        name,
        kolvo,
        cena,
        statya,
        summashtrafa,
        skidka,
        date,
        images
      ]);
}

DoprasxodyStruct createDoprasxodyStruct({
  String? technic,
  String? type,
  String? name,
  int? kolvo,
  int? cena,
  String? statya,
  int? summashtrafa,
  bool? skidka,
  DateTime? date,
}) =>
    DoprasxodyStruct(
      technic: technic,
      type: type,
      name: name,
      kolvo: kolvo,
      cena: cena,
      statya: statya,
      summashtrafa: summashtrafa,
      skidka: skidka,
      date: date,
    );
