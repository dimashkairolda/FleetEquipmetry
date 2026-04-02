// ignore_for_file: unnecessary_getters_setters


import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CreateEquipmentStruct extends BaseStruct {
  CreateEquipmentStruct({
    String? workspaceId,
    String? companyId,
    String? departmentId,
    String? classificationId,
    String? brandId,
    String? modelId,
    List<String>? responsibleEmployees,
    String? licensePlateNumber,
    String? garageNumber,
    String? passportNumber,
    bool? odometerCounter,
    bool? odometerInMiles,
    String? engineHoursCounter,
    String? avatar,
    List<String>? media,
    String? columnId,
    String? sectorId,
    int? year,
    String? identificationNumber,
    String? serialNumber,
    String? engineNumber,
    String? gpsSource,
    String? gpsId,
    String? chassis,
    String? ownershipType,
    List<String>? relatedEquipments,
    String? fuelType,
    double? avgFuelConsumption,
    String? initialMileage,
    String? datePurchased,
    FinancesStruct? finances,
    DriverStruct? paramVals,
    DoprasxodyStruct? specVals,
  })  : _workspaceId = workspaceId,
        _companyId = companyId,
        _departmentId = departmentId,
        _classificationId = classificationId,
        _brandId = brandId,
        _modelId = modelId,
        _responsibleEmployees = responsibleEmployees,
        _licensePlateNumber = licensePlateNumber,
        _garageNumber = garageNumber,
        _passportNumber = passportNumber,
        _odometerCounter = odometerCounter,
        _odometerInMiles = odometerInMiles,
        _engineHoursCounter = engineHoursCounter,
        _avatar = avatar,
        _media = media,
        _columnId = columnId,
        _sectorId = sectorId,
        _year = year,
        _identificationNumber = identificationNumber,
        _serialNumber = serialNumber,
        _engineNumber = engineNumber,
        _gpsSource = gpsSource,
        _gpsId = gpsId,
        _chassis = chassis,
        _ownershipType = ownershipType,
        _relatedEquipments = relatedEquipments,
        _fuelType = fuelType,
        _avgFuelConsumption = avgFuelConsumption,
        _initialMileage = initialMileage,
        _datePurchased = datePurchased,
        _finances = finances,
        _paramVals = paramVals,
        _specVals = specVals;

  // "workspace_id" field.
  String? _workspaceId;
  String get workspaceId => _workspaceId ?? '';
  set workspaceId(String? val) => _workspaceId = val;

  bool hasWorkspaceId() => _workspaceId != null;

  // "company_id" field.
  String? _companyId;
  String get companyId => _companyId ?? '';
  set companyId(String? val) => _companyId = val;

  bool hasCompanyId() => _companyId != null;

  // "department_id" field.
  String? _departmentId;
  String get departmentId => _departmentId ?? '';
  set departmentId(String? val) => _departmentId = val;

  bool hasDepartmentId() => _departmentId != null;

  // "classification_id" field.
  String? _classificationId;
  String get classificationId => _classificationId ?? '';
  set classificationId(String? val) => _classificationId = val;

  bool hasClassificationId() => _classificationId != null;

  // "brand_id" field.
  String? _brandId;
  String get brandId => _brandId ?? '';
  set brandId(String? val) => _brandId = val;

  bool hasBrandId() => _brandId != null;

  // "model_id" field.
  String? _modelId;
  String get modelId => _modelId ?? '';
  set modelId(String? val) => _modelId = val;

  bool hasModelId() => _modelId != null;

  // "responsible_employees" field.
  List<String>? _responsibleEmployees;
  List<String> get responsibleEmployees => _responsibleEmployees ?? const [];
  set responsibleEmployees(List<String>? val) => _responsibleEmployees = val;

  void updateResponsibleEmployees(Function(List<String>) updateFn) {
    updateFn(_responsibleEmployees ??= []);
  }

  bool hasResponsibleEmployees() => _responsibleEmployees != null;

  // "license_plate_number" field.
  String? _licensePlateNumber;
  String get licensePlateNumber => _licensePlateNumber ?? '';
  set licensePlateNumber(String? val) => _licensePlateNumber = val;

  bool hasLicensePlateNumber() => _licensePlateNumber != null;

  // "garage_number" field.
  String? _garageNumber;
  String get garageNumber => _garageNumber ?? '';
  set garageNumber(String? val) => _garageNumber = val;

  bool hasGarageNumber() => _garageNumber != null;

  // "passport_number" field.
  String? _passportNumber;
  String get passportNumber => _passportNumber ?? '';
  set passportNumber(String? val) => _passportNumber = val;

  bool hasPassportNumber() => _passportNumber != null;

  // "odometer_counter" field.
  bool? _odometerCounter;
  bool get odometerCounter => _odometerCounter ?? false;
  set odometerCounter(bool? val) => _odometerCounter = val;

  bool hasOdometerCounter() => _odometerCounter != null;

  // "odometer_in_miles" field.
  bool? _odometerInMiles;
  bool get odometerInMiles => _odometerInMiles ?? false;
  set odometerInMiles(bool? val) => _odometerInMiles = val;

  bool hasOdometerInMiles() => _odometerInMiles != null;

  // "engine_hours_counter" field.
  String? _engineHoursCounter;
  String get engineHoursCounter => _engineHoursCounter ?? '';
  set engineHoursCounter(String? val) => _engineHoursCounter = val;

  bool hasEngineHoursCounter() => _engineHoursCounter != null;

  // "avatar" field.
  String? _avatar;
  String get avatar => _avatar ?? '';
  set avatar(String? val) => _avatar = val;

  bool hasAvatar() => _avatar != null;

  // "media" field.
  List<String>? _media;
  List<String> get media => _media ?? const [];
  set media(List<String>? val) => _media = val;

  void updateMedia(Function(List<String>) updateFn) {
    updateFn(_media ??= []);
  }

  bool hasMedia() => _media != null;

  // "column_id" field.
  String? _columnId;
  String get columnId => _columnId ?? '';
  set columnId(String? val) => _columnId = val;

  bool hasColumnId() => _columnId != null;

  // "sector_id" field.
  String? _sectorId;
  String get sectorId => _sectorId ?? '';
  set sectorId(String? val) => _sectorId = val;

  bool hasSectorId() => _sectorId != null;

  // "year" field.
  int? _year;
  int get year => _year ?? 0;
  set year(int? val) => _year = val;

  void incrementYear(int amount) => year = year + amount;

  bool hasYear() => _year != null;

  // "identification_number" field.
  String? _identificationNumber;
  String get identificationNumber => _identificationNumber ?? '';
  set identificationNumber(String? val) => _identificationNumber = val;

  bool hasIdentificationNumber() => _identificationNumber != null;

  // "serial_number" field.
  String? _serialNumber;
  String get serialNumber => _serialNumber ?? '';
  set serialNumber(String? val) => _serialNumber = val;

  bool hasSerialNumber() => _serialNumber != null;

  // "engine_number" field.
  String? _engineNumber;
  String get engineNumber => _engineNumber ?? '';
  set engineNumber(String? val) => _engineNumber = val;

  bool hasEngineNumber() => _engineNumber != null;

  // "gps_source" field.
  String? _gpsSource;
  String get gpsSource => _gpsSource ?? '';
  set gpsSource(String? val) => _gpsSource = val;

  bool hasGpsSource() => _gpsSource != null;

  // "gps_id" field.
  String? _gpsId;
  String get gpsId => _gpsId ?? '';
  set gpsId(String? val) => _gpsId = val;

  bool hasGpsId() => _gpsId != null;

  // "chassis" field.
  String? _chassis;
  String get chassis => _chassis ?? '';
  set chassis(String? val) => _chassis = val;

  bool hasChassis() => _chassis != null;

  // "ownership_type" field.
  String? _ownershipType;
  String get ownershipType => _ownershipType ?? '';
  set ownershipType(String? val) => _ownershipType = val;

  bool hasOwnershipType() => _ownershipType != null;

  // "related_equipments" field.
  List<String>? _relatedEquipments;
  List<String> get relatedEquipments => _relatedEquipments ?? const [];
  set relatedEquipments(List<String>? val) => _relatedEquipments = val;

  void updateRelatedEquipments(Function(List<String>) updateFn) {
    updateFn(_relatedEquipments ??= []);
  }

  bool hasRelatedEquipments() => _relatedEquipments != null;

  // "fuel_type" field.
  String? _fuelType;
  String get fuelType => _fuelType ?? '';
  set fuelType(String? val) => _fuelType = val;

  bool hasFuelType() => _fuelType != null;

  // "avg_fuel_consumption" field.
  double? _avgFuelConsumption;
  double get avgFuelConsumption => _avgFuelConsumption ?? 0.0;
  set avgFuelConsumption(double? val) => _avgFuelConsumption = val;

  void incrementAvgFuelConsumption(double amount) =>
      avgFuelConsumption = avgFuelConsumption + amount;

  bool hasAvgFuelConsumption() => _avgFuelConsumption != null;

  // "initial_mileage" field.
  String? _initialMileage;
  String get initialMileage => _initialMileage ?? '';
  set initialMileage(String? val) => _initialMileage = val;

  bool hasInitialMileage() => _initialMileage != null;

  // "date_purchased" field.
  String? _datePurchased;
  String get datePurchased => _datePurchased ?? '';
  set datePurchased(String? val) => _datePurchased = val;

  bool hasDatePurchased() => _datePurchased != null;

  // "finances" field.
  FinancesStruct? _finances;
  FinancesStruct get finances => _finances ?? FinancesStruct();
  set finances(FinancesStruct? val) => _finances = val;

  void updateFinances(Function(FinancesStruct) updateFn) {
    updateFn(_finances ??= FinancesStruct());
  }

  bool hasFinances() => _finances != null;

  // "param_vals" field.
  DriverStruct? _paramVals;
  DriverStruct get paramVals => _paramVals ?? DriverStruct();
  set paramVals(DriverStruct? val) => _paramVals = val;

  void updateParamVals(Function(DriverStruct) updateFn) {
    updateFn(_paramVals ??= DriverStruct());
  }

  bool hasParamVals() => _paramVals != null;

  // "spec_vals" field.
  DoprasxodyStruct? _specVals;
  DoprasxodyStruct get specVals => _specVals ?? DoprasxodyStruct();
  set specVals(DoprasxodyStruct? val) => _specVals = val;

  void updateSpecVals(Function(DoprasxodyStruct) updateFn) {
    updateFn(_specVals ??= DoprasxodyStruct());
  }

  bool hasSpecVals() => _specVals != null;

  static CreateEquipmentStruct fromMap(Map<String, dynamic> data) =>
      CreateEquipmentStruct(
        workspaceId: data['workspace_id'] as String?,
        companyId: data['company_id'] as String?,
        departmentId: data['department_id'] as String?,
        classificationId: data['classification_id'] as String?,
        brandId: data['brand_id'] as String?,
        modelId: data['model_id'] as String?,
        responsibleEmployees: getDataList(data['responsible_employees']),
        licensePlateNumber: data['license_plate_number'] as String?,
        garageNumber: data['garage_number'] as String?,
        passportNumber: data['passport_number'] as String?,
        odometerCounter: data['odometer_counter'] as bool?,
        odometerInMiles: data['odometer_in_miles'] as bool?,
        engineHoursCounter: data['engine_hours_counter'] as String?,
        avatar: data['avatar'] as String?,
        media: getDataList(data['media']),
        columnId: data['column_id'] as String?,
        sectorId: data['sector_id'] as String?,
        year: castToType<int>(data['year']),
        identificationNumber: data['identification_number'] as String?,
        serialNumber: data['serial_number'] as String?,
        engineNumber: data['engine_number'] as String?,
        gpsSource: data['gps_source'] as String?,
        gpsId: data['gps_id'] as String?,
        chassis: data['chassis'] as String?,
        ownershipType: data['ownership_type'] as String?,
        relatedEquipments: getDataList(data['related_equipments']),
        fuelType: data['fuel_type'] as String?,
        avgFuelConsumption: castToType<double>(data['avg_fuel_consumption']),
        initialMileage: data['initial_mileage'] as String?,
        datePurchased: data['date_purchased'] as String?,
        finances: data['finances'] is FinancesStruct
            ? data['finances']
            : FinancesStruct.maybeFromMap(data['finances']),
        paramVals: data['param_vals'] is DriverStruct
            ? data['param_vals']
            : DriverStruct.maybeFromMap(data['param_vals']),
        specVals: data['spec_vals'] is DoprasxodyStruct
            ? data['spec_vals']
            : DoprasxodyStruct.maybeFromMap(data['spec_vals']),
      );

  static CreateEquipmentStruct? maybeFromMap(dynamic data) => data is Map
      ? CreateEquipmentStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'workspace_id': _workspaceId,
        'company_id': _companyId,
        'department_id': _departmentId,
        'classification_id': _classificationId,
        'brand_id': _brandId,
        'model_id': _modelId,
        'responsible_employees': _responsibleEmployees,
        'license_plate_number': _licensePlateNumber,
        'garage_number': _garageNumber,
        'passport_number': _passportNumber,
        'odometer_counter': _odometerCounter,
        'odometer_in_miles': _odometerInMiles,
        'engine_hours_counter': _engineHoursCounter,
        'avatar': _avatar,
        'media': _media,
        'column_id': _columnId,
        'sector_id': _sectorId,
        'year': _year,
        'identification_number': _identificationNumber,
        'serial_number': _serialNumber,
        'engine_number': _engineNumber,
        'gps_source': _gpsSource,
        'gps_id': _gpsId,
        'chassis': _chassis,
        'ownership_type': _ownershipType,
        'related_equipments': _relatedEquipments,
        'fuel_type': _fuelType,
        'avg_fuel_consumption': _avgFuelConsumption,
        'initial_mileage': _initialMileage,
        'date_purchased': _datePurchased,
        'finances': _finances?.toMap(),
        'param_vals': _paramVals?.toMap(),
        'spec_vals': _specVals?.toMap(),
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'workspace_id': serializeParam(
          _workspaceId,
          ParamType.String,
        ),
        'company_id': serializeParam(
          _companyId,
          ParamType.String,
        ),
        'department_id': serializeParam(
          _departmentId,
          ParamType.String,
        ),
        'classification_id': serializeParam(
          _classificationId,
          ParamType.String,
        ),
        'brand_id': serializeParam(
          _brandId,
          ParamType.String,
        ),
        'model_id': serializeParam(
          _modelId,
          ParamType.String,
        ),
        'responsible_employees': serializeParam(
          _responsibleEmployees,
          ParamType.String,
          isList: true,
        ),
        'license_plate_number': serializeParam(
          _licensePlateNumber,
          ParamType.String,
        ),
        'garage_number': serializeParam(
          _garageNumber,
          ParamType.String,
        ),
        'passport_number': serializeParam(
          _passportNumber,
          ParamType.String,
        ),
        'odometer_counter': serializeParam(
          _odometerCounter,
          ParamType.bool,
        ),
        'odometer_in_miles': serializeParam(
          _odometerInMiles,
          ParamType.bool,
        ),
        'engine_hours_counter': serializeParam(
          _engineHoursCounter,
          ParamType.String,
        ),
        'avatar': serializeParam(
          _avatar,
          ParamType.String,
        ),
        'media': serializeParam(
          _media,
          ParamType.String,
          isList: true,
        ),
        'column_id': serializeParam(
          _columnId,
          ParamType.String,
        ),
        'sector_id': serializeParam(
          _sectorId,
          ParamType.String,
        ),
        'year': serializeParam(
          _year,
          ParamType.int,
        ),
        'identification_number': serializeParam(
          _identificationNumber,
          ParamType.String,
        ),
        'serial_number': serializeParam(
          _serialNumber,
          ParamType.String,
        ),
        'engine_number': serializeParam(
          _engineNumber,
          ParamType.String,
        ),
        'gps_source': serializeParam(
          _gpsSource,
          ParamType.String,
        ),
        'gps_id': serializeParam(
          _gpsId,
          ParamType.String,
        ),
        'chassis': serializeParam(
          _chassis,
          ParamType.String,
        ),
        'ownership_type': serializeParam(
          _ownershipType,
          ParamType.String,
        ),
        'related_equipments': serializeParam(
          _relatedEquipments,
          ParamType.String,
          isList: true,
        ),
        'fuel_type': serializeParam(
          _fuelType,
          ParamType.String,
        ),
        'avg_fuel_consumption': serializeParam(
          _avgFuelConsumption,
          ParamType.double,
        ),
        'initial_mileage': serializeParam(
          _initialMileage,
          ParamType.String,
        ),
        'date_purchased': serializeParam(
          _datePurchased,
          ParamType.String,
        ),
        'finances': serializeParam(
          _finances,
          ParamType.DataStruct,
        ),
        'param_vals': serializeParam(
          _paramVals,
          ParamType.DataStruct,
        ),
        'spec_vals': serializeParam(
          _specVals,
          ParamType.DataStruct,
        ),
      }.withoutNulls;

  static CreateEquipmentStruct fromSerializableMap(Map<String, dynamic> data) =>
      CreateEquipmentStruct(
        workspaceId: deserializeParam(
          data['workspace_id'],
          ParamType.String,
          false,
        ),
        companyId: deserializeParam(
          data['company_id'],
          ParamType.String,
          false,
        ),
        departmentId: deserializeParam(
          data['department_id'],
          ParamType.String,
          false,
        ),
        classificationId: deserializeParam(
          data['classification_id'],
          ParamType.String,
          false,
        ),
        brandId: deserializeParam(
          data['brand_id'],
          ParamType.String,
          false,
        ),
        modelId: deserializeParam(
          data['model_id'],
          ParamType.String,
          false,
        ),
        responsibleEmployees: deserializeParam<String>(
          data['responsible_employees'],
          ParamType.String,
          true,
        ),
        licensePlateNumber: deserializeParam(
          data['license_plate_number'],
          ParamType.String,
          false,
        ),
        garageNumber: deserializeParam(
          data['garage_number'],
          ParamType.String,
          false,
        ),
        passportNumber: deserializeParam(
          data['passport_number'],
          ParamType.String,
          false,
        ),
        odometerCounter: deserializeParam(
          data['odometer_counter'],
          ParamType.bool,
          false,
        ),
        odometerInMiles: deserializeParam(
          data['odometer_in_miles'],
          ParamType.bool,
          false,
        ),
        engineHoursCounter: deserializeParam(
          data['engine_hours_counter'],
          ParamType.String,
          false,
        ),
        avatar: deserializeParam(
          data['avatar'],
          ParamType.String,
          false,
        ),
        media: deserializeParam<String>(
          data['media'],
          ParamType.String,
          true,
        ),
        columnId: deserializeParam(
          data['column_id'],
          ParamType.String,
          false,
        ),
        sectorId: deserializeParam(
          data['sector_id'],
          ParamType.String,
          false,
        ),
        year: deserializeParam(
          data['year'],
          ParamType.int,
          false,
        ),
        identificationNumber: deserializeParam(
          data['identification_number'],
          ParamType.String,
          false,
        ),
        serialNumber: deserializeParam(
          data['serial_number'],
          ParamType.String,
          false,
        ),
        engineNumber: deserializeParam(
          data['engine_number'],
          ParamType.String,
          false,
        ),
        gpsSource: deserializeParam(
          data['gps_source'],
          ParamType.String,
          false,
        ),
        gpsId: deserializeParam(
          data['gps_id'],
          ParamType.String,
          false,
        ),
        chassis: deserializeParam(
          data['chassis'],
          ParamType.String,
          false,
        ),
        ownershipType: deserializeParam(
          data['ownership_type'],
          ParamType.String,
          false,
        ),
        relatedEquipments: deserializeParam<String>(
          data['related_equipments'],
          ParamType.String,
          true,
        ),
        fuelType: deserializeParam(
          data['fuel_type'],
          ParamType.String,
          false,
        ),
        avgFuelConsumption: deserializeParam(
          data['avg_fuel_consumption'],
          ParamType.double,
          false,
        ),
        initialMileage: deserializeParam(
          data['initial_mileage'],
          ParamType.String,
          false,
        ),
        datePurchased: deserializeParam(
          data['date_purchased'],
          ParamType.String,
          false,
        ),
        finances: deserializeStructParam(
          data['finances'],
          ParamType.DataStruct,
          false,
          structBuilder: FinancesStruct.fromSerializableMap,
        ),
        paramVals: deserializeStructParam(
          data['param_vals'],
          ParamType.DataStruct,
          false,
          structBuilder: DriverStruct.fromSerializableMap,
        ),
        specVals: deserializeStructParam(
          data['spec_vals'],
          ParamType.DataStruct,
          false,
          structBuilder: DoprasxodyStruct.fromSerializableMap,
        ),
      );

  @override
  String toString() => 'CreateEquipmentStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    const listEquality = ListEquality();
    return other is CreateEquipmentStruct &&
        workspaceId == other.workspaceId &&
        companyId == other.companyId &&
        departmentId == other.departmentId &&
        classificationId == other.classificationId &&
        brandId == other.brandId &&
        modelId == other.modelId &&
        listEquality.equals(responsibleEmployees, other.responsibleEmployees) &&
        licensePlateNumber == other.licensePlateNumber &&
        garageNumber == other.garageNumber &&
        passportNumber == other.passportNumber &&
        odometerCounter == other.odometerCounter &&
        odometerInMiles == other.odometerInMiles &&
        engineHoursCounter == other.engineHoursCounter &&
        avatar == other.avatar &&
        listEquality.equals(media, other.media) &&
        columnId == other.columnId &&
        sectorId == other.sectorId &&
        year == other.year &&
        identificationNumber == other.identificationNumber &&
        serialNumber == other.serialNumber &&
        engineNumber == other.engineNumber &&
        gpsSource == other.gpsSource &&
        gpsId == other.gpsId &&
        chassis == other.chassis &&
        ownershipType == other.ownershipType &&
        listEquality.equals(relatedEquipments, other.relatedEquipments) &&
        fuelType == other.fuelType &&
        avgFuelConsumption == other.avgFuelConsumption &&
        initialMileage == other.initialMileage &&
        datePurchased == other.datePurchased &&
        finances == other.finances &&
        paramVals == other.paramVals &&
        specVals == other.specVals;
  }

  @override
  int get hashCode => const ListEquality().hash([
        workspaceId,
        companyId,
        departmentId,
        classificationId,
        brandId,
        modelId,
        responsibleEmployees,
        licensePlateNumber,
        garageNumber,
        passportNumber,
        odometerCounter,
        odometerInMiles,
        engineHoursCounter,
        avatar,
        media,
        columnId,
        sectorId,
        year,
        identificationNumber,
        serialNumber,
        engineNumber,
        gpsSource,
        gpsId,
        chassis,
        ownershipType,
        relatedEquipments,
        fuelType,
        avgFuelConsumption,
        initialMileage,
        datePurchased,
        finances,
        paramVals,
        specVals
      ]);
}

CreateEquipmentStruct createCreateEquipmentStruct({
  String? workspaceId,
  String? companyId,
  String? departmentId,
  String? classificationId,
  String? brandId,
  String? modelId,
  String? licensePlateNumber,
  String? garageNumber,
  String? passportNumber,
  bool? odometerCounter,
  bool? odometerInMiles,
  String? engineHoursCounter,
  String? avatar,
  String? columnId,
  String? sectorId,
  int? year,
  String? identificationNumber,
  String? serialNumber,
  String? engineNumber,
  String? gpsSource,
  String? gpsId,
  String? chassis,
  String? ownershipType,
  String? fuelType,
  double? avgFuelConsumption,
  String? initialMileage,
  String? datePurchased,
  FinancesStruct? finances,
  DriverStruct? paramVals,
  DoprasxodyStruct? specVals,
}) =>
    CreateEquipmentStruct(
      workspaceId: workspaceId,
      companyId: companyId,
      departmentId: departmentId,
      classificationId: classificationId,
      brandId: brandId,
      modelId: modelId,
      licensePlateNumber: licensePlateNumber,
      garageNumber: garageNumber,
      passportNumber: passportNumber,
      odometerCounter: odometerCounter,
      odometerInMiles: odometerInMiles,
      engineHoursCounter: engineHoursCounter,
      avatar: avatar,
      columnId: columnId,
      sectorId: sectorId,
      year: year,
      identificationNumber: identificationNumber,
      serialNumber: serialNumber,
      engineNumber: engineNumber,
      gpsSource: gpsSource,
      gpsId: gpsId,
      chassis: chassis,
      ownershipType: ownershipType,
      fuelType: fuelType,
      avgFuelConsumption: avgFuelConsumption,
      initialMileage: initialMileage,
      datePurchased: datePurchased,
      finances: finances ?? FinancesStruct(),
      paramVals: paramVals ?? DriverStruct(),
      specVals: specVals ?? DoprasxodyStruct(),
    );
