import 'package:flutter/material.dart';
import 'flutter_flow/request_manager.dart';
import '/backend/schema/structs/index.dart';
import '/backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'flutter_flow/flutter_flow_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {
    prefs = await SharedPreferences.getInstance();
    _safeInit(() {
      if (prefs.containsKey('ff_offline')) {
        try {
          final serializedData = prefs.getString('ff_offline') ?? '{}';
          _offline = OfflineDefectsStruct.fromSerializableMap(
              jsonDecode(serializedData));
        } catch (e) {
          print("Can't decode persisted data type. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_checkCache')) {
        try {
          _checkCache = jsonDecode(prefs.getString('ff_checkCache') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_result')) {
        try {
          _result = jsonDecode(prefs.getString('ff_result') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _AllEquipments = prefs.getStringList('ff_AllEquipments')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _AllEquipments;
    });
    _safeInit(() {
      _EventTimeTable = prefs
              .getStringList('ff_EventTimeTable')
              ?.map((x) {
                try {
                  return EventStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _EventTimeTable;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_categories')) {
        try {
          _categories = jsonDecode(prefs.getString('ff_categories') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _InspectionsResponses = prefs
              .getStringList('ff_InspectionsResponses')
              ?.map((x) {
                try {
                  return InspectionsArchiveStruct.fromSerializableMap(
                      jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _InspectionsResponses;
    });
    _safeInit(() {
      _endedInspections = prefs.getStringList('ff_endedInspections')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _endedInspections;
    });
    _safeInit(() {
      _rememberEmail = prefs.getString('ff_rememberEmail') ?? _rememberEmail;
    });
    _safeInit(() {
      _rememberPassword =
          prefs.getString('ff_rememberPassword') ?? _rememberPassword;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_alldefects')) {
        try {
          _alldefects = jsonDecode(prefs.getString('ff_alldefects') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_users')) {
        try {
          _users = jsonDecode(prefs.getString('ff_users') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_usersofchosendepartments')) {
        try {
          _usersofchosendepartments =
              jsonDecode(prefs.getString('ff_usersofchosendepartments') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_departments')) {
        try {
          _departments = jsonDecode(prefs.getString('ff_departments') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _Technic = prefs.getStringList('ff_Technic') ?? _Technic;
    });
    _safeInit(() {
      _doprasxody = prefs
              .getStringList('ff_doprasxody')
              ?.map((x) {
                try {
                  return DoprasxodyStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _doprasxody;
    });
    _safeInit(() {
      _saveddefects = prefs
              .getStringList('ff_saveddefects')
              ?.map((x) {
                try {
                  return CreateDefectStruct.fromSerializableMap(jsonDecode(x));
                } catch (e) {
                  print("Can't decode persisted data type. Error: $e.");
                  return null;
                }
              })
              .withoutNulls
              .toList() ??
          _saveddefects;
    });
    _safeInit(() {
      _Equiptree = prefs.getStringList('ff_Equiptree')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _Equiptree;
    });
    _safeInit(() {
      if (prefs.containsKey('ff_allnaryads')) {
        try {
          _allnaryads = jsonDecode(prefs.getString('ff_allnaryads') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_inpectionsShablon')) {
        try {
          _inpectionsShablon =
              jsonDecode(prefs.getString('ff_inpectionsShablon') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_servicemaintenance')) {
        try {
          _servicemaintenance =
              jsonDecode(prefs.getString('ff_servicemaintenance') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      if (prefs.containsKey('ff_centrzatrat')) {
        try {
          _centrzatrat = jsonDecode(prefs.getString('ff_centrzatrat') ?? '');
        } catch (e) {
          print("Can't decode persisted json. Error: $e.");
        }
      }
    });
    _safeInit(() {
      _assignees = prefs.getStringList('ff_assignees') ?? _assignees;
    });
    _safeInit(() {
      _acceptor = prefs.getString('ff_acceptor') ?? _acceptor;
    });
    _safeInit(() {
      _role = prefs.getString('ff_role') ?? _role;
    });
    _safeInit(() {
      _columns = prefs.getStringList('ff_columns')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _columns;
    });
    _safeInit(() {
      _employees = prefs.getStringList('ff_employees')?.map((x) {
            try {
              return jsonDecode(x);
            } catch (e) {
              print("Can't decode persisted json. Error: $e.");
              return {};
            }
          }).toList() ??
          _employees;
    });
    _safeInit(() {
      _workspace = prefs.getString('ff_workspace') ?? _workspace;
    });
    _safeInit(() {
      _STO = prefs.getString('ff_STO') ?? _STO;
    });
    _safeInit(() {
      _fcmtoken = prefs.getString('ff_fcmtoken') ?? _fcmtoken;
    });
  }

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  late SharedPreferences prefs;

  String _accesstoken = '';
  String get accesstoken => _accesstoken;
  set accesstoken(String value) {
    _accesstoken = value;
  }

  bool _online = true;
  bool get online => _online;
  set online(bool value) {
    _online = value;
  }

  OfflineDefectsStruct _offline = OfflineDefectsStruct.fromSerializableMap(
      jsonDecode('{\"spare_parts\":\"[]\"}'));
  OfflineDefectsStruct get offline => _offline;
  set offline(OfflineDefectsStruct value) {
    _offline = value;
    prefs.setString('ff_offline', value.serialize());
  }

  void updateOfflineStruct(Function(OfflineDefectsStruct) updateFn) {
    updateFn(_offline);
    prefs.setString('ff_offline', _offline.serialize());
  }

  int _loopCounterDefects = 0;
  int get loopCounterDefects => _loopCounterDefects;
  set loopCounterDefects(int value) {
    _loopCounterDefects = value;
  }

  int _sendDefectCounter = 0;
  int get sendDefectCounter => _sendDefectCounter;
  set sendDefectCounter(int value) {
    _sendDefectCounter = value;
  }

  int _loopAddingEquipTree = 0;
  int get loopAddingEquipTree => _loopAddingEquipTree;
  set loopAddingEquipTree(int value) {
    _loopAddingEquipTree = value;
  }

  int _loopaddingequips = 0;
  int get loopaddingequips => _loopaddingequips;
  set loopaddingequips(int value) {
    _loopaddingequips = value;
  }

  dynamic _checkCache;
  dynamic get checkCache => _checkCache;
  set checkCache(dynamic value) {
    _checkCache = value;
    prefs.setString('ff_checkCache', jsonEncode(value));
  }

  List<InspectionsStruct> _sendInspections = [];
  List<InspectionsStruct> get sendInspections => _sendInspections;
  set sendInspections(List<InspectionsStruct> value) {
    _sendInspections = value;
  }

  void addToSendInspections(InspectionsStruct value) {
    sendInspections.add(value);
  }

  void removeFromSendInspections(InspectionsStruct value) {
    sendInspections.remove(value);
  }

  void removeAtIndexFromSendInspections(int index) {
    sendInspections.removeAt(index);
  }

  void updateSendInspectionsAtIndex(
    int index,
    InspectionsStruct Function(InspectionsStruct) updateFn,
  ) {
    sendInspections[index] = updateFn(_sendInspections[index]);
  }

  void insertAtIndexInSendInspections(int index, InspectionsStruct value) {
    sendInspections.insert(index, value);
  }

  List<dynamic> _inspectionsRadio = [];
  List<dynamic> get inspectionsRadio => _inspectionsRadio;
  set inspectionsRadio(List<dynamic> value) {
    _inspectionsRadio = value;
  }

  void addToInspectionsRadio(dynamic value) {
    inspectionsRadio.add(value);
  }

  void removeFromInspectionsRadio(dynamic value) {
    inspectionsRadio.remove(value);
  }

  void removeAtIndexFromInspectionsRadio(int index) {
    inspectionsRadio.removeAt(index);
  }

  void updateInspectionsRadioAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    inspectionsRadio[index] = updateFn(_inspectionsRadio[index]);
  }

  void insertAtIndexInInspectionsRadio(int index, dynamic value) {
    inspectionsRadio.insert(index, value);
  }

  dynamic _result;
  dynamic get result => _result;
  set result(dynamic value) {
    _result = value;
    prefs.setString('ff_result', jsonEncode(value));
  }

  ResultformStruct _result1 =
      ResultformStruct.fromSerializableMap(jsonDecode('{}'));
  ResultformStruct get result1 => _result1;
  set result1(ResultformStruct value) {
    _result1 = value;
  }

  void updateResult1Struct(Function(ResultformStruct) updateFn) {
    updateFn(_result1);
  }

  List<FormResultStruct> _formresult1 = [];
  List<FormResultStruct> get formresult1 => _formresult1;
  set formresult1(List<FormResultStruct> value) {
    _formresult1 = value;
  }

  void addToFormresult1(FormResultStruct value) {
    formresult1.add(value);
  }

  void removeFromFormresult1(FormResultStruct value) {
    formresult1.remove(value);
  }

  void removeAtIndexFromFormresult1(int index) {
    formresult1.removeAt(index);
  }

  void updateFormresult1AtIndex(
    int index,
    FormResultStruct Function(FormResultStruct) updateFn,
  ) {
    formresult1[index] = updateFn(_formresult1[index]);
  }

  void insertAtIndexInFormresult1(int index, FormResultStruct value) {
    formresult1.insert(index, value);
  }

  List<InspectionsStruct> _inspections = [];
  List<InspectionsStruct> get inspections => _inspections;
  set inspections(List<InspectionsStruct> value) {
    _inspections = value;
  }

  void addToInspections(InspectionsStruct value) {
    inspections.add(value);
  }

  void removeFromInspections(InspectionsStruct value) {
    inspections.remove(value);
  }

  void removeAtIndexFromInspections(int index) {
    inspections.removeAt(index);
  }

  void updateInspectionsAtIndex(
    int index,
    InspectionsStruct Function(InspectionsStruct) updateFn,
  ) {
    inspections[index] = updateFn(_inspections[index]);
  }

  void insertAtIndexInInspections(int index, InspectionsStruct value) {
    inspections.insert(index, value);
  }

  int _inspectionsTemp = 0;
  int get inspectionsTemp => _inspectionsTemp;
  set inspectionsTemp(int value) {
    _inspectionsTemp = value;
  }

  int _loopFormResult = 0;
  int get loopFormResult => _loopFormResult;
  set loopFormResult(int value) {
    _loopFormResult = value;
  }

  int _loopInspections = 0;
  int get loopInspections => _loopInspections;
  set loopInspections(int value) {
    _loopInspections = value;
  }

  List<RadiobuttondataStruct> _inspec = [];
  List<RadiobuttondataStruct> get inspec => _inspec;
  set inspec(List<RadiobuttondataStruct> value) {
    _inspec = value;
  }

  void addToInspec(RadiobuttondataStruct value) {
    inspec.add(value);
  }

  void removeFromInspec(RadiobuttondataStruct value) {
    inspec.remove(value);
  }

  void removeAtIndexFromInspec(int index) {
    inspec.removeAt(index);
  }

  void updateInspecAtIndex(
    int index,
    RadiobuttondataStruct Function(RadiobuttondataStruct) updateFn,
  ) {
    inspec[index] = updateFn(_inspec[index]);
  }

  void insertAtIndexInInspec(int index, RadiobuttondataStruct value) {
    inspec.insert(index, value);
  }

  List<dynamic> _AllEquipments = [];
  List<dynamic> get AllEquipments => _AllEquipments;
  set AllEquipments(List<dynamic> value) {
    _AllEquipments = value;
    prefs.setStringList(
        'ff_AllEquipments', value.map((x) => jsonEncode(x)).toList());
  }

  void addToAllEquipments(dynamic value) {
    AllEquipments.add(value);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void removeFromAllEquipments(dynamic value) {
    AllEquipments.remove(value);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromAllEquipments(int index) {
    AllEquipments.removeAt(index);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void updateAllEquipmentsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    AllEquipments[index] = updateFn(_AllEquipments[index]);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInAllEquipments(int index, dynamic value) {
    AllEquipments.insert(index, value);
    prefs.setStringList(
        'ff_AllEquipments', _AllEquipments.map((x) => jsonEncode(x)).toList());
  }

  int _loopTimeTable = 0;
  int get loopTimeTable => _loopTimeTable;
  set loopTimeTable(int value) {
    _loopTimeTable = value;
  }

  List<EventStruct> _EventTimeTable = [
    EventStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"1\",\"start\":\"1713244957800\",\"end\":\"1713248520000\"}')),
    EventStruct.fromSerializableMap(jsonDecode(
        '{\"title\":\"2\",\"start\":\"1713331860000\",\"end\":\"1713418260000\"}'))
  ];
  List<EventStruct> get EventTimeTable => _EventTimeTable;
  set EventTimeTable(List<EventStruct> value) {
    _EventTimeTable = value;
    prefs.setStringList(
        'ff_EventTimeTable', value.map((x) => x.serialize()).toList());
  }

  void addToEventTimeTable(EventStruct value) {
    EventTimeTable.add(value);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void removeFromEventTimeTable(EventStruct value) {
    EventTimeTable.remove(value);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromEventTimeTable(int index) {
    EventTimeTable.removeAt(index);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void updateEventTimeTableAtIndex(
    int index,
    EventStruct Function(EventStruct) updateFn,
  ) {
    EventTimeTable[index] = updateFn(_EventTimeTable[index]);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInEventTimeTable(int index, EventStruct value) {
    EventTimeTable.insert(index, value);
    prefs.setStringList('ff_EventTimeTable',
        _EventTimeTable.map((x) => x.serialize()).toList());
  }

  dynamic _categories;
  dynamic get categories => _categories;
  set categories(dynamic value) {
    _categories = value;
    prefs.setString('ff_categories', jsonEncode(value));
  }

  GetAreaStruct _CreateDefectArea = GetAreaStruct();
  GetAreaStruct get CreateDefectArea => _CreateDefectArea;
  set CreateDefectArea(GetAreaStruct value) {
    _CreateDefectArea = value;
  }

  void updateCreateDefectAreaStruct(Function(GetAreaStruct) updateFn) {
    updateFn(_CreateDefectArea);
  }

  GetAreaStruct _CreateDefectEquip = GetAreaStruct();
  GetAreaStruct get CreateDefectEquip => _CreateDefectEquip;
  set CreateDefectEquip(GetAreaStruct value) {
    _CreateDefectEquip = value;
  }

  void updateCreateDefectEquipStruct(Function(GetAreaStruct) updateFn) {
    updateFn(_CreateDefectEquip);
  }

  List<InspectionsArchiveStruct> _InspectionsResponses = [];
  List<InspectionsArchiveStruct> get InspectionsResponses =>
      _InspectionsResponses;
  set InspectionsResponses(List<InspectionsArchiveStruct> value) {
    _InspectionsResponses = value;
    prefs.setStringList(
        'ff_InspectionsResponses', value.map((x) => x.serialize()).toList());
  }

  void addToInspectionsResponses(InspectionsArchiveStruct value) {
    InspectionsResponses.add(value);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void removeFromInspectionsResponses(InspectionsArchiveStruct value) {
    InspectionsResponses.remove(value);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromInspectionsResponses(int index) {
    InspectionsResponses.removeAt(index);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void updateInspectionsResponsesAtIndex(
    int index,
    InspectionsArchiveStruct Function(InspectionsArchiveStruct) updateFn,
  ) {
    InspectionsResponses[index] = updateFn(_InspectionsResponses[index]);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInInspectionsResponses(
      int index, InspectionsArchiveStruct value) {
    InspectionsResponses.insert(index, value);
    prefs.setStringList('ff_InspectionsResponses',
        _InspectionsResponses.map((x) => x.serialize()).toList());
  }

  List<dynamic> _endedInspections = [];
  List<dynamic> get endedInspections => _endedInspections;
  set endedInspections(List<dynamic> value) {
    _endedInspections = value;
    prefs.setStringList(
        'ff_endedInspections', value.map((x) => jsonEncode(x)).toList());
  }

  void addToEndedInspections(dynamic value) {
    endedInspections.add(value);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void removeFromEndedInspections(dynamic value) {
    endedInspections.remove(value);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromEndedInspections(int index) {
    endedInspections.removeAt(index);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void updateEndedInspectionsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    endedInspections[index] = updateFn(_endedInspections[index]);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInEndedInspections(int index, dynamic value) {
    endedInspections.insert(index, value);
    prefs.setStringList('ff_endedInspections',
        _endedInspections.map((x) => jsonEncode(x)).toList());
  }

  int _loadingTimeTable = 0;
  int get loadingTimeTable => _loadingTimeTable;
  set loadingTimeTable(int value) {
    _loadingTimeTable = value;
  }

  int _loadingDefects = 0;
  int get loadingDefects => _loadingDefects;
  set loadingDefects(int value) {
    _loadingDefects = value;
  }

  int _loadingInspections = 0;
  int get loadingInspections => _loadingInspections;
  set loadingInspections(int value) {
    _loadingInspections = value;
  }

  int _loadingEquips = 0;
  int get loadingEquips => _loadingEquips;
  set loadingEquips(int value) {
    _loadingEquips = value;
  }

  int _loadingEquipTree = 0;
  int get loadingEquipTree => _loadingEquipTree;
  set loadingEquipTree(int value) {
    _loadingEquipTree = value;
  }

  String _rememberEmail = '';
  String get rememberEmail => _rememberEmail;
  set rememberEmail(String value) {
    _rememberEmail = value;
    prefs.setString('ff_rememberEmail', value);
  }

  String _rememberPassword = '';
  String get rememberPassword => _rememberPassword;
  set rememberPassword(String value) {
    _rememberPassword = value;
    prefs.setString('ff_rememberPassword', value);
  }

  DateTime? _selectedDay = DateTime.fromMillisecondsSinceEpoch(1704045600000);
  DateTime? get selectedDay => _selectedDay;
  set selectedDay(DateTime? value) {
    _selectedDay = value;
  }

  dynamic _alldefects;
  dynamic get alldefects => _alldefects;
  set alldefects(dynamic value) {
    _alldefects = value;
    prefs.setString('ff_alldefects', jsonEncode(value));
  }

  dynamic _users;
  dynamic get users => _users;
  set users(dynamic value) {
    _users = value;
    prefs.setString('ff_users', jsonEncode(value));
  }

  dynamic _usersofchosendepartments;
  dynamic get usersofchosendepartments => _usersofchosendepartments;
  set usersofchosendepartments(dynamic value) {
    _usersofchosendepartments = value;
    prefs.setString('ff_usersofchosendepartments', jsonEncode(value));
  }

  dynamic _departments;
  dynamic get departments => _departments;
  set departments(dynamic value) {
    _departments = value;
    prefs.setString('ff_departments', jsonEncode(value));
  }

  List<ConfirmdefectStruct> _confirmedDefects = [];
  List<ConfirmdefectStruct> get confirmedDefects => _confirmedDefects;
  set confirmedDefects(List<ConfirmdefectStruct> value) {
    _confirmedDefects = value;
  }

  void addToConfirmedDefects(ConfirmdefectStruct value) {
    confirmedDefects.add(value);
  }

  void removeFromConfirmedDefects(ConfirmdefectStruct value) {
    confirmedDefects.remove(value);
  }

  void removeAtIndexFromConfirmedDefects(int index) {
    confirmedDefects.removeAt(index);
  }

  void updateConfirmedDefectsAtIndex(
    int index,
    ConfirmdefectStruct Function(ConfirmdefectStruct) updateFn,
  ) {
    confirmedDefects[index] = updateFn(_confirmedDefects[index]);
  }

  void insertAtIndexInConfirmedDefects(int index, ConfirmdefectStruct value) {
    confirmedDefects.insert(index, value);
  }

  List<ConfirmdefectStruct> _rejectedDefects = [];
  List<ConfirmdefectStruct> get rejectedDefects => _rejectedDefects;
  set rejectedDefects(List<ConfirmdefectStruct> value) {
    _rejectedDefects = value;
  }

  void addToRejectedDefects(ConfirmdefectStruct value) {
    rejectedDefects.add(value);
  }

  void removeFromRejectedDefects(ConfirmdefectStruct value) {
    rejectedDefects.remove(value);
  }

  void removeAtIndexFromRejectedDefects(int index) {
    rejectedDefects.removeAt(index);
  }

  void updateRejectedDefectsAtIndex(
    int index,
    ConfirmdefectStruct Function(ConfirmdefectStruct) updateFn,
  ) {
    rejectedDefects[index] = updateFn(_rejectedDefects[index]);
  }

  void insertAtIndexInRejectedDefects(int index, ConfirmdefectStruct value) {
    rejectedDefects.insert(index, value);
  }

  int _loopConfirm = 0;
  int get loopConfirm => _loopConfirm;
  set loopConfirm(int value) {
    _loopConfirm = value;
  }

  int _loopReject = 0;
  int get loopReject => _loopReject;
  set loopReject(int value) {
    _loopReject = value;
  }

  List<String> _Technic = [
    'Toyota Camry, 077YES02',
    'Toyota Camry, 521ALL02',
    'BMW 540, 749AUG02'
  ];
  List<String> get Technic => _Technic;
  set Technic(List<String> value) {
    _Technic = value;
    prefs.setStringList('ff_Technic', value);
  }

  void addToTechnic(String value) {
    Technic.add(value);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void removeFromTechnic(String value) {
    Technic.remove(value);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void removeAtIndexFromTechnic(int index) {
    Technic.removeAt(index);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void updateTechnicAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    Technic[index] = updateFn(_Technic[index]);
    prefs.setStringList('ff_Technic', _Technic);
  }

  void insertAtIndexInTechnic(int index, String value) {
    Technic.insert(index, value);
    prefs.setStringList('ff_Technic', _Technic);
  }

  List<DoprasxodyStruct> _doprasxody = [];
  List<DoprasxodyStruct> get doprasxody => _doprasxody;
  set doprasxody(List<DoprasxodyStruct> value) {
    _doprasxody = value;
    prefs.setStringList(
        'ff_doprasxody', value.map((x) => x.serialize()).toList());
  }

  void addToDoprasxody(DoprasxodyStruct value) {
    doprasxody.add(value);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void removeFromDoprasxody(DoprasxodyStruct value) {
    doprasxody.remove(value);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromDoprasxody(int index) {
    doprasxody.removeAt(index);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void updateDoprasxodyAtIndex(
    int index,
    DoprasxodyStruct Function(DoprasxodyStruct) updateFn,
  ) {
    doprasxody[index] = updateFn(_doprasxody[index]);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInDoprasxody(int index, DoprasxodyStruct value) {
    doprasxody.insert(index, value);
    prefs.setStringList(
        'ff_doprasxody', _doprasxody.map((x) => x.serialize()).toList());
  }

  List<String> _fotki = [];
  List<String> get fotki => _fotki;
  set fotki(List<String> value) {
    _fotki = value;
  }

  void addToFotki(String value) {
    fotki.add(value);
  }

  void removeFromFotki(String value) {
    fotki.remove(value);
  }

  void removeAtIndexFromFotki(int index) {
    fotki.removeAt(index);
  }

  void updateFotkiAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    fotki[index] = updateFn(_fotki[index]);
  }

  void insertAtIndexInFotki(int index, String value) {
    fotki.insert(index, value);
  }

  String _scannedNFCTag = '';
  String get scannedNFCTag => _scannedNFCTag;
  set scannedNFCTag(String value) {
    _scannedNFCTag = value;
  }

  int _loopFixed = 0;
  int get loopFixed => _loopFixed;
  set loopFixed(int value) {
    _loopFixed = value;
  }

  String _nfcData = '';
  String get nfcData => _nfcData;
  set nfcData(String value) {
    _nfcData = value;
  }

  DateTime? _startedon = DateTime.fromMillisecondsSinceEpoch(1704045600000);
  DateTime? get startedon => _startedon;
  set startedon(DateTime? value) {
    _startedon = value;
  }

  List<SparePartsStruct> _spareparts = [];
  List<SparePartsStruct> get spareparts => _spareparts;
  set spareparts(List<SparePartsStruct> value) {
    _spareparts = value;
  }

  void addToSpareparts(SparePartsStruct value) {
    spareparts.add(value);
  }

  void removeFromSpareparts(SparePartsStruct value) {
    spareparts.remove(value);
  }

  void removeAtIndexFromSpareparts(int index) {
    spareparts.removeAt(index);
  }

  void updateSparepartsAtIndex(
    int index,
    SparePartsStruct Function(SparePartsStruct) updateFn,
  ) {
    spareparts[index] = updateFn(_spareparts[index]);
  }

  void insertAtIndexInSpareparts(int index, SparePartsStruct value) {
    spareparts.insert(index, value);
  }

  DateTime? _defecttime = DateTime.fromMillisecondsSinceEpoch(1704045600000);
  DateTime? get defecttime => _defecttime;
  set defecttime(DateTime? value) {
    _defecttime = value;
  }

  List<TodoStruct> _todo = [];
  List<TodoStruct> get todo => _todo;
  set todo(List<TodoStruct> value) {
    _todo = value;
  }

  void addToTodo(TodoStruct value) {
    todo.add(value);
  }

  void removeFromTodo(TodoStruct value) {
    todo.remove(value);
  }

  void removeAtIndexFromTodo(int index) {
    todo.removeAt(index);
  }

  void updateTodoAtIndex(
    int index,
    TodoStruct Function(TodoStruct) updateFn,
  ) {
    todo[index] = updateFn(_todo[index]);
  }

  void insertAtIndexInTodo(int index, TodoStruct value) {
    todo.insert(index, value);
  }

  String _chosenEquip = '';
  String get chosenEquip => _chosenEquip;
  set chosenEquip(String value) {
    _chosenEquip = value;
  }

  List<CreateDefectStruct> _saveddefects = [];
  List<CreateDefectStruct> get saveddefects => _saveddefects;
  set saveddefects(List<CreateDefectStruct> value) {
    _saveddefects = value;
    prefs.setStringList(
        'ff_saveddefects', value.map((x) => x.serialize()).toList());
  }

  void addToSaveddefects(CreateDefectStruct value) {
    saveddefects.add(value);
    prefs.setStringList(
        'ff_saveddefects', _saveddefects.map((x) => x.serialize()).toList());
  }

  void removeFromSaveddefects(CreateDefectStruct value) {
    saveddefects.remove(value);
    prefs.setStringList(
        'ff_saveddefects', _saveddefects.map((x) => x.serialize()).toList());
  }

  void removeAtIndexFromSaveddefects(int index) {
    saveddefects.removeAt(index);
    prefs.setStringList(
        'ff_saveddefects', _saveddefects.map((x) => x.serialize()).toList());
  }

  void updateSaveddefectsAtIndex(
    int index,
    CreateDefectStruct Function(CreateDefectStruct) updateFn,
  ) {
    saveddefects[index] = updateFn(_saveddefects[index]);
    prefs.setStringList(
        'ff_saveddefects', _saveddefects.map((x) => x.serialize()).toList());
  }

  void insertAtIndexInSaveddefects(int index, CreateDefectStruct value) {
    saveddefects.insert(index, value);
    prefs.setStringList(
        'ff_saveddefects', _saveddefects.map((x) => x.serialize()).toList());
  }

  List<String> _photos = [];
  List<String> get photos => _photos;
  set photos(List<String> value) {
    _photos = value;
  }

  void addToPhotos(String value) {
    photos.add(value);
  }

  void removeFromPhotos(String value) {
    photos.remove(value);
  }

  void removeAtIndexFromPhotos(int index) {
    photos.removeAt(index);
  }

  void updatePhotosAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    photos[index] = updateFn(_photos[index]);
  }

  void insertAtIndexInPhotos(int index, String value) {
    photos.insert(index, value);
  }

  List<dynamic> _searchOutput = [];
  List<dynamic> get searchOutput => _searchOutput;
  set searchOutput(List<dynamic> value) {
    _searchOutput = value;
  }

  void addToSearchOutput(dynamic value) {
    searchOutput.add(value);
  }

  void removeFromSearchOutput(dynamic value) {
    searchOutput.remove(value);
  }

  void removeAtIndexFromSearchOutput(int index) {
    searchOutput.removeAt(index);
  }

  void updateSearchOutputAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    searchOutput[index] = updateFn(_searchOutput[index]);
  }

  void insertAtIndexInSearchOutput(int index, dynamic value) {
    searchOutput.insert(index, value);
  }

  String _statusfilter = '';
  String get statusfilter => _statusfilter;
  set statusfilter(String value) {
    _statusfilter = value;
  }

  String _typefilter = '';
  String get typefilter => _typefilter;
  set typefilter(String value) {
    _typefilter = value;
  }

  String _groupfilter = '';
  String get groupfilter => _groupfilter;
  set groupfilter(String value) {
    _groupfilter = value;
  }

  List<dynamic> _Equiptree = [];
  List<dynamic> get Equiptree => _Equiptree;
  set Equiptree(List<dynamic> value) {
    _Equiptree = value;
    prefs.setStringList(
        'ff_Equiptree', value.map((x) => jsonEncode(x)).toList());
  }

  void addToEquiptree(dynamic value) {
    Equiptree.add(value);
    prefs.setStringList(
        'ff_Equiptree', _Equiptree.map((x) => jsonEncode(x)).toList());
  }

  void removeFromEquiptree(dynamic value) {
    Equiptree.remove(value);
    prefs.setStringList(
        'ff_Equiptree', _Equiptree.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromEquiptree(int index) {
    Equiptree.removeAt(index);
    prefs.setStringList(
        'ff_Equiptree', _Equiptree.map((x) => jsonEncode(x)).toList());
  }

  void updateEquiptreeAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    Equiptree[index] = updateFn(_Equiptree[index]);
    prefs.setStringList(
        'ff_Equiptree', _Equiptree.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInEquiptree(int index, dynamic value) {
    Equiptree.insert(index, value);
    prefs.setStringList(
        'ff_Equiptree', _Equiptree.map((x) => jsonEncode(x)).toList());
  }

  bool _isShowFullList = true;
  bool get isShowFullList => _isShowFullList;
  set isShowFullList(bool value) {
    _isShowFullList = value;
  }

  String _searchfilter = '';
  String get searchfilter => _searchfilter;
  set searchfilter(String value) {
    _searchfilter = value;
  }

  String _searchDefect = '';
  String get searchDefect => _searchDefect;
  set searchDefect(String value) {
    _searchDefect = value;
  }

  bool _isShowFullList1 = true;
  bool get isShowFullList1 => _isShowFullList1;
  set isShowFullList1(bool value) {
    _isShowFullList1 = value;
  }

  List<dynamic> _searchOutput1 = [];
  List<dynamic> get searchOutput1 => _searchOutput1;
  set searchOutput1(List<dynamic> value) {
    _searchOutput1 = value;
  }

  void addToSearchOutput1(dynamic value) {
    searchOutput1.add(value);
  }

  void removeFromSearchOutput1(dynamic value) {
    searchOutput1.remove(value);
  }

  void removeAtIndexFromSearchOutput1(int index) {
    searchOutput1.removeAt(index);
  }

  void updateSearchOutput1AtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    searchOutput1[index] = updateFn(_searchOutput1[index]);
  }

  void insertAtIndexInSearchOutput1(int index, dynamic value) {
    searchOutput1.insert(index, value);
  }

  List<String> _assigneeids = [];
  List<String> get assigneeids => _assigneeids;
  set assigneeids(List<String> value) {
    _assigneeids = value;
  }

  void addToAssigneeids(String value) {
    assigneeids.add(value);
  }

  void removeFromAssigneeids(String value) {
    assigneeids.remove(value);
  }

  void removeAtIndexFromAssigneeids(int index) {
    assigneeids.removeAt(index);
  }

  void updateAssigneeidsAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    assigneeids[index] = updateFn(_assigneeids[index]);
  }

  void insertAtIndexInAssigneeids(int index, String value) {
    assigneeids.insert(index, value);
  }

  List<dynamic> _fixedDefects = [];
  List<dynamic> get fixedDefects => _fixedDefects;
  set fixedDefects(List<dynamic> value) {
    _fixedDefects = value;
  }

  void addToFixedDefects(dynamic value) {
    fixedDefects.add(value);
  }

  void removeFromFixedDefects(dynamic value) {
    fixedDefects.remove(value);
  }

  void removeAtIndexFromFixedDefects(int index) {
    fixedDefects.removeAt(index);
  }

  void updateFixedDefectsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    fixedDefects[index] = updateFn(_fixedDefects[index]);
  }

  void insertAtIndexInFixedDefects(int index, dynamic value) {
    fixedDefects.insert(index, value);
  }

  dynamic _allnaryads;
  dynamic get allnaryads => _allnaryads;
  set allnaryads(dynamic value) {
    _allnaryads = value;
    prefs.setString('ff_allnaryads', jsonEncode(value));
  }

  bool _isShowFullListNaryad = true;
  bool get isShowFullListNaryad => _isShowFullListNaryad;
  set isShowFullListNaryad(bool value) {
    _isShowFullListNaryad = value;
  }

  List<dynamic> _searchOutputNaryad = [];
  List<dynamic> get searchOutputNaryad => _searchOutputNaryad;
  set searchOutputNaryad(List<dynamic> value) {
    _searchOutputNaryad = value;
  }

  void addToSearchOutputNaryad(dynamic value) {
    searchOutputNaryad.add(value);
  }

  void removeFromSearchOutputNaryad(dynamic value) {
    searchOutputNaryad.remove(value);
  }

  void removeAtIndexFromSearchOutputNaryad(int index) {
    searchOutputNaryad.removeAt(index);
  }

  void updateSearchOutputNaryadAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    searchOutputNaryad[index] = updateFn(_searchOutputNaryad[index]);
  }

  void insertAtIndexInSearchOutputNaryad(int index, dynamic value) {
    searchOutputNaryad.insert(index, value);
  }

  String _searchNaryad = '';
  String get searchNaryad => _searchNaryad;
  set searchNaryad(String value) {
    _searchNaryad = value;
  }

  dynamic _inpectionsShablon;
  dynamic get inpectionsShablon => _inpectionsShablon;
  set inpectionsShablon(dynamic value) {
    _inpectionsShablon = value;
    prefs.setString('ff_inpectionsShablon', jsonEncode(value));
  }

  String _chosenInspectionsEquip = '';
  String get chosenInspectionsEquip => _chosenInspectionsEquip;
  set chosenInspectionsEquip(String value) {
    _chosenInspectionsEquip = value;
  }

  List<OptionsStruct> _options = [];
  List<OptionsStruct> get options => _options;
  set options(List<OptionsStruct> value) {
    _options = value;
  }

  void addToOptions(OptionsStruct value) {
    options.add(value);
  }

  void removeFromOptions(OptionsStruct value) {
    options.remove(value);
  }

  void removeAtIndexFromOptions(int index) {
    options.removeAt(index);
  }

  void updateOptionsAtIndex(
    int index,
    OptionsStruct Function(OptionsStruct) updateFn,
  ) {
    options[index] = updateFn(_options[index]);
  }

  void insertAtIndexInOptions(int index, OptionsStruct value) {
    options.insert(index, value);
  }

  List<QuestionsStruct> _questions = [];
  List<QuestionsStruct> get questions => _questions;
  set questions(List<QuestionsStruct> value) {
    _questions = value;
  }

  void addToQuestions(QuestionsStruct value) {
    questions.add(value);
  }

  void removeFromQuestions(QuestionsStruct value) {
    questions.remove(value);
  }

  void removeAtIndexFromQuestions(int index) {
    questions.removeAt(index);
  }

  void updateQuestionsAtIndex(
    int index,
    QuestionsStruct Function(QuestionsStruct) updateFn,
  ) {
    questions[index] = updateFn(_questions[index]);
  }

  void insertAtIndexInQuestions(int index, QuestionsStruct value) {
    questions.insert(index, value);
  }

  InspectionsShablonStruct _createInspection = InspectionsShablonStruct();
  InspectionsShablonStruct get createInspection => _createInspection;
  set createInspection(InspectionsShablonStruct value) {
    _createInspection = value;
  }

  void updateCreateInspectionStruct(
      Function(InspectionsShablonStruct) updateFn) {
    updateFn(_createInspection);
  }

  List<ReferencesStruct> _references = [];
  List<ReferencesStruct> get references => _references;
  set references(List<ReferencesStruct> value) {
    _references = value;
  }

  void addToReferences(ReferencesStruct value) {
    references.add(value);
  }

  void removeFromReferences(ReferencesStruct value) {
    references.remove(value);
  }

  void removeAtIndexFromReferences(int index) {
    references.removeAt(index);
  }

  void updateReferencesAtIndex(
    int index,
    ReferencesStruct Function(ReferencesStruct) updateFn,
  ) {
    references[index] = updateFn(_references[index]);
  }

  void insertAtIndexInReferences(int index, ReferencesStruct value) {
    references.insert(index, value);
  }

  dynamic _servicemaintenance;
  dynamic get servicemaintenance => _servicemaintenance;
  set servicemaintenance(dynamic value) {
    _servicemaintenance = value;
    prefs.setString('ff_servicemaintenance', jsonEncode(value));
  }

  bool _isShowFullListMaintenance = true;
  bool get isShowFullListMaintenance => _isShowFullListMaintenance;
  set isShowFullListMaintenance(bool value) {
    _isShowFullListMaintenance = value;
  }

  List<dynamic> _searchOutputMaintenance = [];
  List<dynamic> get searchOutputMaintenance => _searchOutputMaintenance;
  set searchOutputMaintenance(List<dynamic> value) {
    _searchOutputMaintenance = value;
  }

  void addToSearchOutputMaintenance(dynamic value) {
    searchOutputMaintenance.add(value);
  }

  void removeFromSearchOutputMaintenance(dynamic value) {
    searchOutputMaintenance.remove(value);
  }

  void removeAtIndexFromSearchOutputMaintenance(int index) {
    searchOutputMaintenance.removeAt(index);
  }

  void updateSearchOutputMaintenanceAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    searchOutputMaintenance[index] = updateFn(_searchOutputMaintenance[index]);
  }

  void insertAtIndexInSearchOutputMaintenance(int index, dynamic value) {
    searchOutputMaintenance.insert(index, value);
  }

  String _searchMaintenance = '';
  String get searchMaintenance => _searchMaintenance;
  set searchMaintenance(String value) {
    _searchMaintenance = value;
  }

  dynamic _centrzatrat;
  dynamic get centrzatrat => _centrzatrat;
  set centrzatrat(dynamic value) {
    _centrzatrat = value;
    prefs.setString('ff_centrzatrat', jsonEncode(value));
  }

  List<dynamic> _photosedit = [];
  List<dynamic> get photosedit => _photosedit;
  set photosedit(List<dynamic> value) {
    _photosedit = value;
  }

  void addToPhotosedit(dynamic value) {
    photosedit.add(value);
  }

  void removeFromPhotosedit(dynamic value) {
    photosedit.remove(value);
  }

  void removeAtIndexFromPhotosedit(int index) {
    photosedit.removeAt(index);
  }

  void updatePhotoseditAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    photosedit[index] = updateFn(_photosedit[index]);
  }

  void insertAtIndexInPhotosedit(int index, dynamic value) {
    photosedit.insert(index, value);
  }

  dynamic _itemsOutOfStock;
  dynamic get itemsOutOfStock => _itemsOutOfStock;
  set itemsOutOfStock(dynamic value) {
    _itemsOutOfStock = value;
  }

  DateTime? _tmctime = DateTime.fromMillisecondsSinceEpoch(1704088800000);
  DateTime? get tmctime => _tmctime;
  set tmctime(DateTime? value) {
    _tmctime = value;
  }

  List<String> _assignees = [];
  List<String> get assignees => _assignees;
  set assignees(List<String> value) {
    _assignees = value;
    prefs.setStringList('ff_assignees', value);
  }

  void addToAssignees(String value) {
    assignees.add(value);
    prefs.setStringList('ff_assignees', _assignees);
  }

  void removeFromAssignees(String value) {
    assignees.remove(value);
    prefs.setStringList('ff_assignees', _assignees);
  }

  void removeAtIndexFromAssignees(int index) {
    assignees.removeAt(index);
    prefs.setStringList('ff_assignees', _assignees);
  }

  void updateAssigneesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    assignees[index] = updateFn(_assignees[index]);
    prefs.setStringList('ff_assignees', _assignees);
  }

  void insertAtIndexInAssignees(int index, String value) {
    assignees.insert(index, value);
    prefs.setStringList('ff_assignees', _assignees);
  }

  String _acceptor = '';
  String get acceptor => _acceptor;
  set acceptor(String value) {
    _acceptor = value;
    prefs.setString('ff_acceptor', value);
  }

  String _role = '';
  String get role => _role;
  set role(String value) {
    _role = value;
    prefs.setString('ff_role', value);
  }

  List<dynamic> _searchRaport = [];
  List<dynamic> get searchRaport => _searchRaport;
  set searchRaport(List<dynamic> value) {
    _searchRaport = value;
  }

  void addToSearchRaport(dynamic value) {
    searchRaport.add(value);
  }

  void removeFromSearchRaport(dynamic value) {
    searchRaport.remove(value);
  }

  void removeAtIndexFromSearchRaport(int index) {
    searchRaport.removeAt(index);
  }

  void updateSearchRaportAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    searchRaport[index] = updateFn(_searchRaport[index]);
  }

  void insertAtIndexInSearchRaport(int index, dynamic value) {
    searchRaport.insert(index, value);
  }

  bool _isShowRaport = true;
  bool get isShowRaport => _isShowRaport;
  set isShowRaport(bool value) {
    _isShowRaport = value;
  }

  List<dynamic> _columns = [];
  List<dynamic> get columns => _columns;
  set columns(List<dynamic> value) {
    _columns = value;
    prefs.setStringList('ff_columns', value.map((x) => jsonEncode(x)).toList());
  }

  void addToColumns(dynamic value) {
    columns.add(value);
    prefs.setStringList(
        'ff_columns', _columns.map((x) => jsonEncode(x)).toList());
  }

  void removeFromColumns(dynamic value) {
    columns.remove(value);
    prefs.setStringList(
        'ff_columns', _columns.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromColumns(int index) {
    columns.removeAt(index);
    prefs.setStringList(
        'ff_columns', _columns.map((x) => jsonEncode(x)).toList());
  }

  void updateColumnsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    columns[index] = updateFn(_columns[index]);
    prefs.setStringList(
        'ff_columns', _columns.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInColumns(int index, dynamic value) {
    columns.insert(index, value);
    prefs.setStringList(
        'ff_columns', _columns.map((x) => jsonEncode(x)).toList());
  }

  String _columnfilter = '';
  String get columnfilter => _columnfilter;
  set columnfilter(String value) {
    _columnfilter = value;
  }

  bool _isSelected = false;
  bool get isSelected => _isSelected;
  set isSelected(bool value) {
    _isSelected = value;
  }

  String _gpstoken = '';
  String get gpstoken => _gpstoken;
  set gpstoken(String value) {
    _gpstoken = value;
  }

  dynamic _profile;
  dynamic get profile => _profile;
  set profile(dynamic value) {
    _profile = value;
  }

  List<dynamic> _selectedRaports = [];
  List<dynamic> get selectedRaports => _selectedRaports;
  set selectedRaports(List<dynamic> value) {
    _selectedRaports = value;
  }

  void addToSelectedRaports(dynamic value) {
    selectedRaports.add(value);
  }

  void removeFromSelectedRaports(dynamic value) {
    selectedRaports.remove(value);
  }

  void removeAtIndexFromSelectedRaports(int index) {
    selectedRaports.removeAt(index);
  }

  void updateSelectedRaportsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    selectedRaports[index] = updateFn(_selectedRaports[index]);
  }

  void insertAtIndexInSelectedRaports(int index, dynamic value) {
    selectedRaports.insert(index, value);
  }

  String _regionfilter = '';
  String get regionfilter => _regionfilter;
  set regionfilter(String value) {
    _regionfilter = value;
  }

  String _projectfilter = '';
  String get projectfilter => _projectfilter;
  set projectfilter(String value) {
    _projectfilter = value;
  }

  int _raports = 0;
  int get raports => _raports;
  set raports(int value) {
    _raports = value;
  }

  List<DriverStruct> _currentdriver = [];
  List<DriverStruct> get currentdriver => _currentdriver;
  set currentdriver(List<DriverStruct> value) {
    _currentdriver = value;
  }

  void addToCurrentdriver(DriverStruct value) {
    currentdriver.add(value);
  }

  void removeFromCurrentdriver(DriverStruct value) {
    currentdriver.remove(value);
  }

  void removeAtIndexFromCurrentdriver(int index) {
    currentdriver.removeAt(index);
  }

  void updateCurrentdriverAtIndex(
    int index,
    DriverStruct Function(DriverStruct) updateFn,
  ) {
    currentdriver[index] = updateFn(_currentdriver[index]);
  }

  void insertAtIndexInCurrentdriver(int index, DriverStruct value) {
    currentdriver.insert(index, value);
  }

  List<DriverStruct> _nextdriver = [];
  List<DriverStruct> get nextdriver => _nextdriver;
  set nextdriver(List<DriverStruct> value) {
    _nextdriver = value;
  }

  void addToNextdriver(DriverStruct value) {
    nextdriver.add(value);
  }

  void removeFromNextdriver(DriverStruct value) {
    nextdriver.remove(value);
  }

  void removeAtIndexFromNextdriver(int index) {
    nextdriver.removeAt(index);
  }

  void updateNextdriverAtIndex(
    int index,
    DriverStruct Function(DriverStruct) updateFn,
  ) {
    nextdriver[index] = updateFn(_nextdriver[index]);
  }

  void insertAtIndexInNextdriver(int index, DriverStruct value) {
    nextdriver.insert(index, value);
  }

  List<dynamic> _employees = [];
  List<dynamic> get employees => _employees;
  set employees(List<dynamic> value) {
    _employees = value;
    prefs.setStringList(
        'ff_employees', value.map((x) => jsonEncode(x)).toList());
  }

  void addToEmployees(dynamic value) {
    employees.add(value);
    prefs.setStringList(
        'ff_employees', _employees.map((x) => jsonEncode(x)).toList());
  }

  void removeFromEmployees(dynamic value) {
    employees.remove(value);
    prefs.setStringList(
        'ff_employees', _employees.map((x) => jsonEncode(x)).toList());
  }

  void removeAtIndexFromEmployees(int index) {
    employees.removeAt(index);
    prefs.setStringList(
        'ff_employees', _employees.map((x) => jsonEncode(x)).toList());
  }

  void updateEmployeesAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    employees[index] = updateFn(_employees[index]);
    prefs.setStringList(
        'ff_employees', _employees.map((x) => jsonEncode(x)).toList());
  }

  void insertAtIndexInEmployees(int index, dynamic value) {
    employees.insert(index, value);
    prefs.setStringList(
        'ff_employees', _employees.map((x) => jsonEncode(x)).toList());
  }

  bool _toggleon = false;
  bool get toggleon => _toggleon;
  set toggleon(bool value) {
    _toggleon = value;
  }

  bool _isScrolling = false;
  bool get isScrolling => _isScrolling;
  set isScrolling(bool value) {
    _isScrolling = value;
  }

  int _tmccounter = 0;
  int get tmccounter => _tmccounter;
  set tmccounter(int value) {
    _tmccounter = value;
  }

  List<dynamic> _RaportOpened = [];
  List<dynamic> get RaportOpened => _RaportOpened;
  set RaportOpened(List<dynamic> value) {
    _RaportOpened = value;
  }

  void addToRaportOpened(dynamic value) {
    RaportOpened.add(value);
  }

  void removeFromRaportOpened(dynamic value) {
    RaportOpened.remove(value);
  }

  void removeAtIndexFromRaportOpened(int index) {
    RaportOpened.removeAt(index);
  }

  void updateRaportOpenedAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    RaportOpened[index] = updateFn(_RaportOpened[index]);
  }

  void insertAtIndexInRaportOpened(int index, dynamic value) {
    RaportOpened.insert(index, value);
  }

  String _customer = '';
  String get customer => _customer;
  set customer(String value) {
    _customer = value;
  }

  String _expstatus = '';
  String get expstatus => _expstatus;
  set expstatus(String value) {
    _expstatus = value;
  }

  String _techstatus = '';
  String get techstatus => _techstatus;
  set techstatus(String value) {
    _techstatus = value;
  }

  String _inspstatus = '';
  String get inspstatus => _inspstatus;
  set inspstatus(String value) {
    _inspstatus = value;
  }

  String _licencenumber = '';
  String get licencenumber => _licencenumber;
  set licencenumber(String value) {
    _licencenumber = value;
  }

  bool _statuseditraport = false;
  bool get statuseditraport => _statuseditraport;
  set statuseditraport(bool value) {
    _statuseditraport = value;
  }

  String _workspace = '';
  String get workspace => _workspace;
  set workspace(String value) {
    _workspace = value;
    prefs.setString('ff_workspace', value);
  }

  String _statusnaryad = '';
  String get statusnaryad => _statusnaryad;
  set statusnaryad(String value) {
    _statusnaryad = value;
  }

  double _swipe = -1.0;
  double get swipe => _swipe;
  set swipe(double value) {
    _swipe = value;
  }

  DateTime? _dateot;
  DateTime? get dateot => _dateot;
  set dateot(DateTime? value) {
    _dateot = value;
  }

  DateTime? _datedo;
  DateTime? get datedo => _datedo;
  set datedo(DateTime? value) {
    _datedo = value;
  }

  List<dynamic> _classificationsPark = [];
  List<dynamic> get classificationsPark => _classificationsPark;
  set classificationsPark(List<dynamic> value) {
    _classificationsPark = value;
  }

  void addToClassificationsPark(dynamic value) {
    classificationsPark.add(value);
  }

  void removeFromClassificationsPark(dynamic value) {
    classificationsPark.remove(value);
  }

  void removeAtIndexFromClassificationsPark(int index) {
    classificationsPark.removeAt(index);
  }

  void updateClassificationsParkAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    classificationsPark[index] = updateFn(_classificationsPark[index]);
  }

  void insertAtIndexInClassificationsPark(int index, dynamic value) {
    classificationsPark.insert(index, value);
  }

  List<dynamic> _brands = [];
  List<dynamic> get brands => _brands;
  set brands(List<dynamic> value) {
    _brands = value;
  }

  void addToBrands(dynamic value) {
    brands.add(value);
  }

  void removeFromBrands(dynamic value) {
    brands.remove(value);
  }

  void removeAtIndexFromBrands(int index) {
    brands.removeAt(index);
  }

  void updateBrandsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    brands[index] = updateFn(_brands[index]);
  }

  void insertAtIndexInBrands(int index, dynamic value) {
    brands.insert(index, value);
  }

  List<dynamic> _models = [];
  List<dynamic> get models => _models;
  set models(List<dynamic> value) {
    _models = value;
  }

  void addToModels(dynamic value) {
    models.add(value);
  }

  void removeFromModels(dynamic value) {
    models.remove(value);
  }

  void removeAtIndexFromModels(int index) {
    models.removeAt(index);
  }

  void updateModelsAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    models[index] = updateFn(_models[index]);
  }

  void insertAtIndexInModels(int index, dynamic value) {
    models.insert(index, value);
  }

  CreateEquipmentStruct _equipment = CreateEquipmentStruct();
  CreateEquipmentStruct get equipment => _equipment;
  set equipment(CreateEquipmentStruct value) {
    _equipment = value;
  }

  void updateEquipmentStruct(Function(CreateEquipmentStruct) updateFn) {
    updateFn(_equipment);
  }

  List<String> _chatgptimages = [];
  List<String> get chatgptimages => _chatgptimages;
  set chatgptimages(List<String> value) {
    _chatgptimages = value;
  }

  void addToChatgptimages(String value) {
    chatgptimages.add(value);
  }

  void removeFromChatgptimages(String value) {
    chatgptimages.remove(value);
  }

  void removeAtIndexFromChatgptimages(int index) {
    chatgptimages.removeAt(index);
  }

  void updateChatgptimagesAtIndex(
    int index,
    String Function(String) updateFn,
  ) {
    chatgptimages[index] = updateFn(_chatgptimages[index]);
  }

  void insertAtIndexInChatgptimages(int index, String value) {
    chatgptimages.insert(index, value);
  }

  String _STO = '';
  String get STO => _STO;
  set STO(String value) {
    _STO = value;
    prefs.setString('ff_STO', value);
  }

  List<SparePartsCTOStruct> _sparepartCTO = [];
  List<SparePartsCTOStruct> get sparepartCTO => _sparepartCTO;
  set sparepartCTO(List<SparePartsCTOStruct> value) {
    _sparepartCTO = value;
  }

  void addToSparepartCTO(SparePartsCTOStruct value) {
    sparepartCTO.add(value);
  }

  void removeFromSparepartCTO(SparePartsCTOStruct value) {
    sparepartCTO.remove(value);
  }

  void removeAtIndexFromSparepartCTO(int index) {
    sparepartCTO.removeAt(index);
  }

  void updateSparepartCTOAtIndex(
    int index,
    SparePartsCTOStruct Function(SparePartsCTOStruct) updateFn,
  ) {
    sparepartCTO[index] = updateFn(_sparepartCTO[index]);
  }

  void insertAtIndexInSparepartCTO(int index, SparePartsCTOStruct value) {
    sparepartCTO.insert(index, value);
  }

  List<TodoCTOStruct> _todoCTO = [];
  List<TodoCTOStruct> get todoCTO => _todoCTO;
  set todoCTO(List<TodoCTOStruct> value) {
    _todoCTO = value;
  }

  void addToTodoCTO(TodoCTOStruct value) {
    todoCTO.add(value);
  }

  void removeFromTodoCTO(TodoCTOStruct value) {
    todoCTO.remove(value);
  }

  void removeAtIndexFromTodoCTO(int index) {
    todoCTO.removeAt(index);
  }

  void updateTodoCTOAtIndex(
    int index,
    TodoCTOStruct Function(TodoCTOStruct) updateFn,
  ) {
    todoCTO[index] = updateFn(_todoCTO[index]);
  }

  void insertAtIndexInTodoCTO(int index, TodoCTOStruct value) {
    todoCTO.insert(index, value);
  }

  List<InventoryItemsStruct> _CTOInventoryItems = [];
  List<InventoryItemsStruct> get CTOInventoryItems => _CTOInventoryItems;
  set CTOInventoryItems(List<InventoryItemsStruct> value) {
    _CTOInventoryItems = value;
  }

  void addToCTOInventoryItems(InventoryItemsStruct value) {
    CTOInventoryItems.add(value);
  }

  void removeFromCTOInventoryItems(InventoryItemsStruct value) {
    CTOInventoryItems.remove(value);
  }

  void removeAtIndexFromCTOInventoryItems(int index) {
    CTOInventoryItems.removeAt(index);
  }

  void updateCTOInventoryItemsAtIndex(
    int index,
    InventoryItemsStruct Function(InventoryItemsStruct) updateFn,
  ) {
    CTOInventoryItems[index] = updateFn(_CTOInventoryItems[index]);
  }

  void insertAtIndexInCTOInventoryItems(int index, InventoryItemsStruct value) {
    CTOInventoryItems.insert(index, value);
  }

  List<WorksStruct> _CTOWorks = [];
  List<WorksStruct> get CTOWorks => _CTOWorks;
  set CTOWorks(List<WorksStruct> value) {
    _CTOWorks = value;
  }

  void addToCTOWorks(WorksStruct value) {
    CTOWorks.add(value);
  }

  void removeFromCTOWorks(WorksStruct value) {
    CTOWorks.remove(value);
  }

  void removeAtIndexFromCTOWorks(int index) {
    CTOWorks.removeAt(index);
  }

  void updateCTOWorksAtIndex(
    int index,
    WorksStruct Function(WorksStruct) updateFn,
  ) {
    CTOWorks[index] = updateFn(_CTOWorks[index]);
  }

  void insertAtIndexInCTOWorks(int index, WorksStruct value) {
    CTOWorks.insert(index, value);
  }

  

  List<dynamic> _defectCTO = [];
  List<dynamic> get defectCTO => _defectCTO;
  set defectCTO(List<dynamic> value) {
    _defectCTO = value;
  }

  void addToDefectCTO(dynamic value) {
    defectCTO.add(value);
  }

  void removeFromDefectCTO(dynamic value) {
    defectCTO.remove(value);
  }

  void removeAtIndexFromDefectCTO(int index) {
    defectCTO.removeAt(index);
  }

  void updateDefectCTOAtIndex(
    int index,
    dynamic Function(dynamic) updateFn,
  ) {
    defectCTO[index] = updateFn(_defectCTO[index]);
  }

  void insertAtIndexInDefectCTO(int index, dynamic value) {
    defectCTO.insert(index, value);
  }

  CTOCreateStruct _createCTO = CTOCreateStruct();
  CTOCreateStruct get createCTO => _createCTO;
  set createCTO(CTOCreateStruct value) {
    _createCTO = value;
  }

  void updateCreateCTOStruct(Function(CTOCreateStruct) updateFn) {
    updateFn(_createCTO);
  }

    ProcurementStruct _procurementCreate  = ProcurementStruct();
  ProcurementStruct get procurementCreate => _procurementCreate;
  set procurementCreate(ProcurementStruct value) {
    _procurementCreate = value;
  }

  void updateProcurementCreateStruct(Function(ProcurementStruct) updateFn) {
    updateFn(_procurementCreate);
  }

  List<InventoryItemsStruct> _kpInventory = [];
  List<InventoryItemsStruct> get kpInventory => _kpInventory;
  set kpInventory(List<InventoryItemsStruct> value) {
    _kpInventory = value;
  }

  void addToKpInventory(InventoryItemsStruct value) {
    kpInventory.add(value);
  }

  void removeFromKpInventory(InventoryItemsStruct value) {
    kpInventory.remove(value);
  }

  void removeAtIndexFromKpInventory(int index) {
    kpInventory.removeAt(index);
  }

  void updateKpInventoryAtIndex(
    int index,
    InventoryItemsStruct Function(InventoryItemsStruct) updateFn,
  ) {
    kpInventory[index] = updateFn(_kpInventory[index]);
  }

  void insertAtIndexInKpInventory(int index, InventoryItemsStruct value) {
    kpInventory.insert(index, value);
  }

  List<WorksStruct> _kpWork = [];
  List<WorksStruct> get kpWork => _kpWork;
  set kpWork(List<WorksStruct> value) {
    _kpWork = value;
  }

  void addToKpWork(WorksStruct value) {
    kpWork.add(value);
  }

  void removeFromKpWork(WorksStruct value) {
    kpWork.remove(value);
  }

  void removeAtIndexFromKpWork(int index) {
    kpWork.removeAt(index);
  }

  void updateKpWorkAtIndex(
    int index,
    WorksStruct Function(WorksStruct) updateFn,
  ) {
    kpWork[index] = updateFn(_kpWork[index]);
  }

  void insertAtIndexInKpWork(int index, WorksStruct value) {
    kpWork.insert(index, value);
  }

  String _fcmtoken = '';
  String get fcmtoken => _fcmtoken;
  set fcmtoken(String value) {
    _fcmtoken = value;
    prefs.setString('ff_fcmtoken', value);
  }

  List<StructureStruct> _ReglamentDetailed = [];
  List<StructureStruct> get ReglamentDetailed => _ReglamentDetailed;
  set ReglamentDetailed(List<StructureStruct> value) {
    _ReglamentDetailed = value;
  }

  void addToReglamentDetailed(StructureStruct value) {
    ReglamentDetailed.add(value);
  }

  void removeFromReglamentDetailed(StructureStruct value) {
    ReglamentDetailed.remove(value);
  }

  void removeAtIndexFromReglamentDetailed(int index) {
    ReglamentDetailed.removeAt(index);
  }

  void updateReglamentDetailedAtIndex(
    int index,
    StructureStruct Function(StructureStruct) updateFn,
  ) {
    ReglamentDetailed[index] = updateFn(_ReglamentDetailed[index]);
  }

  void insertAtIndexInReglamentDetailed(int index, StructureStruct value) {
    ReglamentDetailed.insert(index, value);
  }

  final _raportManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> raport({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _raportManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRaportCache() => _raportManager.clear();
  void clearRaportCacheKey(String? uniqueKey) =>
      _raportManager.clearRequest(uniqueKey);

  final _columnManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> column({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _columnManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearColumnCache() => _columnManager.clear();
  void clearColumnCacheKey(String? uniqueKey) =>
      _columnManager.clearRequest(uniqueKey);

  final _regionManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> region({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _regionManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearRegionCache() => _regionManager.clear();
  void clearRegionCacheKey(String? uniqueKey) =>
      _regionManager.clearRequest(uniqueKey);

  final _projectManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> project({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _projectManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearProjectCache() => _projectManager.clear();
  void clearProjectCacheKey(String? uniqueKey) =>
      _projectManager.clearRequest(uniqueKey);

  final _equipsManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> equips({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _equipsManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEquipsCache() => _equipsManager.clear();
  void clearEquipsCacheKey(String? uniqueKey) =>
      _equipsManager.clearRequest(uniqueKey);

  final _equipsReglamentManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> equipsReglament({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _equipsReglamentManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearEquipsReglamentCache() => _equipsReglamentManager.clear();
  void clearEquipsReglamentCacheKey(String? uniqueKey) =>
      _equipsReglamentManager.clearRequest(uniqueKey);

  final _formsReglamentManager = FutureRequestManager<ApiCallResponse>();
  Future<ApiCallResponse> formsReglament({
    String? uniqueQueryKey,
    bool? overrideCache,
    required Future<ApiCallResponse> Function() requestFn,
  }) =>
      _formsReglamentManager.performRequest(
        uniqueQueryKey: uniqueQueryKey,
        overrideCache: overrideCache,
        requestFn: requestFn,
      );
  void clearFormsReglamentCache() => _formsReglamentManager.clear();
  void clearFormsReglamentCacheKey(String? uniqueKey) =>
      _formsReglamentManager.clearRequest(uniqueKey);
}

void _safeInit(Function() initializeField) {
  try {
    initializeField();
  } catch (_) {}
}

Future _safeInitAsync(Function() initializeField) async {
  try {
    await initializeField();
  } catch (_) {}
}
